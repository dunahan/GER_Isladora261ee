// Henchmen Always Bleed to Death
// By Demetrious, OldManWhistler and IntrepidCW
//
// PLEASE READ "habd_include" FOR MORE INFORMATION.
//
// OnPlayerDeath event handler.

#include "habd_include"
#include "shifter_inc"
#include "_isla_inc"
#include "NW_I0_GENERIC"

// ****************************************************************************


// USER DEFINED FUNCTION
// Called when the PC is properly death.
void HABDUserDefinedPCDeathNow(object oPC)
{
    int nTode = GetLocalInt(oPC, "DEATH_COUNT") + 1;
    SetLocalInt(oPC, "DEATH_COUNT", nTode);

    int nOffset;

    if (nTode < 3) {
        SetLocalInt(oPC, "DEATH_TIME_LEFT", 0);
    } else if (nTode < 4) {
        SetLocalInt(oPC, "DEATH_TIME_LEFT", 60 * 5);
    } else if (nTode < 5) {
        SetLocalInt(oPC, "DEATH_TIME_LEFT", 60 * 10);
    } else if (nTode < 6) {
        SetLocalInt(oPC, "DEATH_TIME_LEFT", 60 * 30);
    } else {
        SetLocalInt(oPC, "DEATH_TIME_LEFT", 60 * 60);
    }



  /*
  //example aplication
  object oMod = GetModule();
  string sID = GetPCPlayerName(oPC)+GetName(oPC);
  if (GetLocalInt(GetModule(), HABD_MINHPLASTBLEED+sID)<=-20 )
      HABDSetCustomVar(oPC, "Permadeath_Hell_N1");
  else
  if (GetLocalInt(GetModule(), HABD_MINHPLASTBLEED+sID)<=-40 )
      HABDSetCustomVar(oPC, "Permadeath_Hell_N2");
  else
      HABDSetCustomVar(oPC, "");
 */
}
// ***************************************************************************


// Report that a player died. OBJECT_SELF is the dead player.
void ReportPlayerDeath();
void ReportPlayerDeath()
{
    object oPC = OBJECT_SELF;

    // Abort is not a player
    if (!GetIsPC(oPC)) return;

    int iHPs = GetCurrentHitPoints(oPC);
    // Abort if player isn't dying
    if (iHPs > 0) return;

    // Display notification.
    if(HABD_USERLANGUAGE==0)
      FloatingTextStringOnCreature(GetName(oPC)+" HAS DIED!", oPC);

    else if(HABD_USERLANGUAGE==1)
      FloatingTextStringOnCreature(GetName(oPC)+" HA MUERTO!", oPC);

    else if(HABD_USERLANGUAGE==2)
      FloatingTextStringOnCreature(GetName(oPC)+" starb!", oPC);

    // Vocal notification.
    AssignCommand(oPC, PlayVoiceChat(VOICE_CHAT_DEATH, oPC));
    if (HABD_DM_NOTIFICATION_ON_DEATH)
    {
        if(HABD_USERLANGUAGE==0)
          SendMessageToAllDMs( ColorString( "DEAD: "+GetName(oPC)+" HAS DIED!", 0, 0, 255 ) );

        else if(HABD_USERLANGUAGE==1)
          SendMessageToAllDMs( ColorString( "MUERTO: "+GetName(oPC)+" HA MUERTO!", 0, 0, 255 ) );

        else if(HABD_USERLANGUAGE==2)
          SendMessageToAllDMs( ColorString( "Spielertod: "+GetName(oPC)+" starb!", 0, 0, 255 ) );
    }

    if(HABD_USERLANGUAGE==0)
      DelayCommand( 0.2, FloatingTextStringOnCreature( ColorString( "Server: YOU HAVE JUST DIED, SO BE QUIET UNTIL YOU ARE RAISED. -DM", 255, 0, 0 ) , oPC, FALSE ) );

    else if(HABD_USERLANGUAGE==1)
      DelayCommand( 0.2, FloatingTextStringOnCreature( ColorString( "Server: HAS MUERTO, ASI QUE TU PJ NO PUEDE HABLAR HASTA QUE SEA RESUCITADO. -DM", 255, 0, 0 ) , oPC, FALSE ) );

    else if(HABD_USERLANGUAGE==2)
      DelayCommand( 0.2, FloatingTextStringOnCreature( ColorString( "Server: Du bist gerade gestorben. Um das RP reell zu halten, verhalte Dich Bitte still.", 255, 0,0 ) , oPC, FALSE));
}

// ****************************************************************************

// Recover a player from instant death. This is one of the key functions of
// this death system. Instant death isn't possible, you always bleed.
//   oPC - the player who instantly died.
void RecoverInstantDeath(object oPC);

void RecoverInstantDeath(object oPC)
{
    // Should regeneration items be removed from bleeding players?
    if (HABD_NERF_REGENERATION_ITEMS)
    {
        AssignCommand(oPC, HABDRegenerationItemsUnequip(oPC));
    }

    // Bring the player back from death and make them bleed.
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);

    int iCap = HABD_BLEEDING_START_LIMIT;
        if (iCap>-1) iCap = -1;
            if (iCap<=-10) iCap = -9;
    /*eg, if HABD_BLEEDING_START_LIMIT was -5   int iBleed = 6+Random(4);*/
    int iBleed = - iCap + 1 + Random(10+iCap-1);
        if (iBleed >=10) iBleed = 9;
            if (iBleed<=0) iBleed = 1;

    SetPlotFlag(oPC, FALSE);
    //eg Will leave player at -6 to -9, if HABD_BLEEDING_START_LIMIT was -5
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(iBleed, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE), oPC);
    SetPlotFlag(oPC, TRUE);

    if(HABD_USERLANGUAGE==0)
      FloatingTextStringOnCreature( ColorString( "You nearly died! Bleeding starts at -"+IntToString(iBleed), 255, 0, 0 ), oPC, FALSE);

    else if(HABD_USERLANGUAGE==1)
      FloatingTextStringOnCreature( ColorString( "Casi mueres! El desangramiento empieza a -"+IntToString(iBleed), 255, 0, 0 ), oPC, FALSE);

    else if(HABD_USERLANGUAGE==2)
      FloatingTextStringOnCreature( ColorString( "Du bist fast gestorben. Verbluten startet bei -"+IntToString(iBleed), 255, 0, 0 ), oPC, FALSE);

}


// ****************************************************************************

// Warn player that they will auto-respawn in fTime seconds.
//   oPC - the dead player.
//   fTime - the amount of time until auto-respawn.
void AutoRespawnWarning(object oPC, float fTime);

void AutoRespawnWarning(object oPC, float fTime)
{
    // If the player is no longer dead then kill the warning.
    if (!GetIsDead(oPC)) return;
    if ( HABDGetHABD_PLAYER_STATE("", oPC) != HABD_STATE_PLAYER_DEAD) return;
    // Store  -no longer used, can cause problems
    //SetLocalInt(GetModule(), HABD_RESPAWN_TIMER+GetPCPlayerName(oPC)+GetName(oPC), FloatToInt(fTime));
    // Warn the player.
    if(fTime > 1.0)
    {

      if(HABD_USERLANGUAGE==0)
        FloatingTextStringOnCreature("Server: "+GetName(oPC)+" will automatically respawn in "+FloatToString(fTime,4,1)+" seconds.", oPC, TRUE);

      else if(HABD_USERLANGUAGE==1)
        FloatingTextStringOnCreature("Server: "+GetName(oPC)+" respawnara automaticamente en "+FloatToString(fTime,4,1)+" segundos.", oPC, TRUE);

      else if(HABD_USERLANGUAGE==2)
        FloatingTextStringOnCreature("Server: "+GetName(oPC)+" kann automatisch in "+FloatToString(fTime,4,1)+" Sekunden wieder einsteigen.", oPC, TRUE);

    }
    return;
}

// ****************************************************************************

// Warn player that they will auto-raise in fTime seconds.
//   oPC - the dead player.
//   fTime - the amount of time until auto-raise.
void AutoRaiseWarning(object oPC, float fTime);

void AutoRaiseWarning(object oPC, float fTime)
{
    // If the player is no longer dead then kill the warning.
    if (!GetIsDead(oPC)) return;
    if (HABDGetHABD_PLAYER_STATE("", oPC) != HABD_STATE_PLAYER_DEAD)
        return;
    // Store  -no longer used, can cause problems
    //SetLocalInt(GetModule(), HABD_RAISE_TIMER+GetPCPlayerName(oPC)+GetName(oPC), FloatToInt(fTime));
    // Warn the player.
    if(fTime > 1.0)
    {

        if(HABD_USERLANGUAGE==0)
          FloatingTextStringOnCreature("Server: "+GetName(oPC)+" will automatically raise in "+FloatToString(fTime,4,1)+" seconds.", oPC, TRUE);

        else if(HABD_USERLANGUAGE==1)
          FloatingTextStringOnCreature("Server: "+GetName(oPC)+" resucitara automaticamente en "+FloatToString(fTime,4,1)+" segundos.", oPC, TRUE);

        else if(HABD_USERLANGUAGE==2)
          FloatingTextStringOnCreature("Server: "+GetName(oPC)+" wird automatisch in "+FloatToString(fTime,4,1)+" Sekunden Wiederbelebt.", oPC, TRUE);

    }
    return;
}

// ****************************************************************************


// Check if a player has spontaneously come back to life.
//   oPC - the dead player.
//   fTime - the duration to wait until the next health check.

void CheckForDMHeal(object oPC, float fTime)
{
    object oMod = GetModule();
    string sID = GetPCPlayerName(oPC)+GetName(oPC);
    // Check to see if the player is still alive.
    int iState = HABDGetHABD_PLAYER_STATE(sID, oPC);
    if (
        (iState == HABD_STATE_RESPAWNED_GHOST) ||
        (iState == HABD_STATE_PLAYER_ALIVE) ||
        (iState == HABD_STATE_PC_PERMADEATH)
        ) return;

    // Quick little timer to check that PCs recover from a DM heal properly.
    if (GetIsDead(oPC))
    {
        DelayCommand(fTime, CheckForDMHeal(oPC, fTime));
    } else {
        // Player has been DM healed.
        SetPlotFlag(oPC, FALSE);
        HABDSetHABD_PLAYER_STATE(HABD_STATE_PLAYER_ALIVE, sID, oPC);
        //Save info to DB (and maybe export PC) to avoid server crash problems,
        //now that we are sure the PC is Alive.
        if ( HABD_SMART_SAVETODB == TRUE )
            HABDSetDBString(oPC);
    }
}

// ****************************************************************************

// This is the OnPlayerDeath event handler.

void main()
{
    object oMod = GetModule();
    object oPC = GetLastPlayerDied();
    int iNPC = GetLocalInt(OBJECT_SELF, HABD_NPC_BLEED);
    if (iNPC == 1) oPC = OBJECT_SELF;
    string sID = GetPCPlayerName(oPC)+GetName(oPC);

    // If an NPC is running this script, then set up its master. The master was
    // automatically wiped out when the henchman died.
    if (iNPC)
    {
        if (!GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_HENCHMAN, GetLocalObject(OBJECT_SELF, HABD_NPC_MASTER))))
            AddHenchman(GetLocalObject(OBJECT_SELF, HABD_NPC_MASTER), oPC);
        //if HABD Death is disabled for Henchmen
        if ( HABD_HENCHMEN_DEATH == FALSE )
            return;
    }

    //Register minimun hit points
    SetLocalInt(GetModule(), HABD_MINHPLASTBLEED+sID,GetCurrentHitPoints(oPC) );

    int iState = HABDGetHABD_PLAYER_STATE(sID, oPC);
    if ( iState == HABD_STATE_PC_PERMADEATH )
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(1 - (GetCurrentHitPoints(oPC))), oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPC);
        HABDJumpToPermaDeathPoint(oPC, HABD_EVENTDEATHSIGNAL);
        return;
    }

    if (HABD_DEBUG) //DEBUG: Not Translated to Spanish
    SpeakString("DEBUG: HABD OnDeath, "+GetName(oPC)+", HP: "+IntToString(GetCurrentHitPoints(oPC))+", master: "+GetName(GetMaster(oPC))+", state:"+HABDGetPlayerStateName(oPC), TALKVOLUME_SHOUT);

    int iSafeArea = HABD_GetIsSafeArea(oPC);
    int iKillingHit = FALSE;
        if ( HABD_KILLING_HIT > GetCurrentHitPoints(oPC) && HABD_KILLING_HIT<0)
            iKillingHit = TRUE;

    // Check to see if they have bled at all - if not then give them a chance to bleed.
    if ( iNPC == FALSE || iNPC == TRUE && HABD_HENCHMEN_BLEED !=3 )
    if ( HABD_ALLOW_INSTANT_DEATH != TRUE || iSafeArea == TRUE ||
        GetHitDice(oPC) < HABD_NO_DEATH_UNTIL_LEVEL )
    if ( HABD_GetIsHardArea(oPC) == FALSE )
    if ( HABDCoupDeGraceAloneInArea(oPC) == FALSE || iSafeArea == TRUE ||
        GetHitDice(oPC) < HABD_NO_DEATH_UNTIL_LEVEL )
    if (iKillingHit == FALSE || GetHitDice(oPC) < HABD_NO_DEATH_UNTIL_LEVEL)
    if (HABDGetHABD_PLAYER_STATE(sID, oPC) != HABD_STATE_PLAYER_DEAD)
    {
        // Player died without going through bleeding.

        // Keep the player from taking additional damage while bleeding.
        SetPlotFlag(oPC, TRUE);
        // Special state for this circumstance.
        HABDSetHABD_PLAYER_STATE(HABD_STATE_PLAYER_INSTANT_DEATH, sID, oPC);
        // Bring the player to near-death.
        AssignCommand(oPC, RecoverInstantDeath(oPC));
        // Force friendly to hostile faction.
        if (!GetLocalInt(oPC, HABD_OLD_FACTION_SET))
        {
            SetLocalInt(oPC, HABD_OLD_FACTION, GetStandardFactionReputation(STANDARD_FACTION_HOSTILE, oPC));
            SetLocalInt(oPC, HABD_OLD_FACTION_SET, 1);
        }
        SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 100, oPC);
        // stop nearby attackers
        HABDStopNearbyAttackers(oPC);
        return;
    }
    // If Restored from Instant Death code below there will not be executed

    //:: If that part of the script runs: Player has properly died.

    // Check for a DM Heal.
    AssignCommand(oPC, DelayCommand(6.0, CheckForDMHeal(oPC, 6.0)));

    // Ensure that plot is not still set.
    SetPlotFlag(oPC, FALSE);
    // Set playerstate to dead not dying.
    HABDSetHABD_PLAYER_STATE(HABD_STATE_PLAYER_DEAD, sID, oPC);


    //AddOn fuer Isladora eingefuegt
    object oDeathScribe = GetObjectByTag("Grabstein"); // Objekt auf dem die Daten gespeichert sind

    // Token, nachdem gesucht werden soll, bzw. das bei Ableben gespeichert wurde
    // string sID = GetPCPlayerName(oPC)+GetName(oPC);
    // TokenString in dem Gesucht/Gespeichert/Gelöscht wird
    string sDeathScribe = GetLocalString(oDeathScribe, "The_Dead");

    // Check if Token is in string. If FALSE, add it
    if (GetIsTokenInString(sID, sDeathScribe)==FALSE)
    AddTokenToString(sDeathScribe, sID);

    // Alert that the player died.
    AssignCommand(oPC, ReportPlayerDeath());

    //Save info to DB (and maybe export PC) to avoid server crash problems,
    //now that we are sure the PC is death.
    if ( HABD_SMART_SAVETODB == TRUE )
        HABDSetDBString(oPC);

    int iDrop = FALSE;
    if ( GetLocalInt(oPC, HABD_PERSISTANT_REAPPLY) != 1 )
        iDrop = TRUE;

    // Check if we are re-entering this state from persistence.
    if (GetLocalInt(oPC, HABD_PERSISTANT_REAPPLY) != 1)
    {
        if (iNPC == FALSE) //Player Character
        {
            // Set the auto-respawn/raise timers to maximum (not entering form persist).
            SetLocalInt(oMod, HABD_RESPAWN_TIMER+sID, FloatToInt(HABD_FORCE_RESPAWN_TIMER));
            if ((HABD_SOLO_FORCE_RAISE_TIMER > 0.0) && (HABDPlayerIsSolo(oPC)==TRUE)  )
            {
                SetLocalInt(oMod, HABD_RAISE_TIMER+sID, FloatToInt(HABD_SOLO_FORCE_RAISE_TIMER));
            } else {
                SetLocalInt(oMod, HABD_RAISE_TIMER+sID, FloatToInt(HABD_FORCE_RAISE_TIMER));
            }
            // Increment the counters.
            SetLocalInt(oMod, HABD_CURRENT_DEATH_COUNT+sID, GetLocalInt(oMod, HABD_CURRENT_DEATH_COUNT+sID) + 1);
            SetLocalInt(oMod, HABD_DEATH_COUNT+sID, GetLocalInt(oMod, HABD_DEATH_COUNT+sID) + 1);
        }
        else if (iNPC == TRUE) //NPC (henchman)
        {
            // Set the auto-respawn/raise timers to maximum (not entering form persist).
            //SetLocalInt(oMod, HABD_RESPAWN_TIMER+sID, FloatToInt(HABD_NPC_FORCE_RESPAWN_TIMER));
            SetLocalInt(oPC, HABD_RESPAWN_TIMER, FloatToInt(HABD_NPC_FORCE_RESPAWN_TIMER));
            SetLocalInt(oPC, HABD_RAISE_TIMER, FloatToInt(HABD_NPC_FORCE_RAISE_TIMER));
            // Increment the counters.
            SetLocalInt(oMod, HABD_CURRENT_DEATH_COUNT+sID, GetLocalInt(oMod, HABD_CURRENT_DEATH_COUNT+sID) + 1);
            SetLocalInt(oMod, HABD_DEATH_COUNT+sID, GetLocalInt(oMod, HABD_DEATH_COUNT+sID) + 1);
        }
    } else {
        // State was reapplied, do not increment the counters.
        DeleteLocalInt(oPC, HABD_PERSISTANT_REAPPLY);
        // Autoraise timers will use their persistent values.
    }

    // Should we reequip any regeneraton items?
    if (HABD_NERF_REGENERATION_ITEMS)
    {
        AssignCommand(oPC, HABDRegenerationItemsReEquip(oPC));
    }

    // Drop items
    if (iDrop == TRUE)
        AssignCommand(oPC, HABDDropItems(oPC));

    // Respawn option by PC using the GUI panel can be disabled.
    if (HABD_RESPAWN_ALLOWED)
    {
        PopUpDeathGUIPanel (oPC, HABD_INSTANT_RESPAWN_ALLOWED, TRUE); //, 0, "Press the Respawn button to respawn as a DM controlled ghost. "+IntToString(HABD_RESPAWN_XP_LOSS)+"% XP & "+IntToString(HABD_RESPAWN_GP_LOSS)+"% GP penalty applies.");
    } else
    {

        if(HABD_USERLANGUAGE==0)
          FloatingTextStringOnCreature("Server: Respawn is turned off. You must wait for your party to help you, DM intervention or automatic respawn/raise.", oPC, FALSE);

        else if(HABD_USERLANGUAGE==1)
          FloatingTextStringOnCreature("Server: Respawn esta desactivado. Debes esperar a que tu equipo de PJs te ayude, a la intervencion del DM o a respawn/resurreccion automaticas.", oPC, FALSE);

        else if(HABD_USERLANGUAGE==2)
          FloatingTextStringOnCreature("Server: Wiedereinstieg ist deaktiviert. Du musst warten bis Dir Deine Gruppe hilft, ein SL agiert oder Du automatisch wiederbelebt wirst.", oPC, FALSE);

    }

    //User defined function
    HABDUserDefinedPCDeathNow(oPC);

    // Handle the auto-respawn and auto-raise timers.
    float fRespawn = 0.0;
    float fRaise = 0.0;
    if (iNPC)    //NPC/Henchman
    {
        fRespawn = IntToFloat(GetLocalInt(oPC, HABD_RESPAWN_TIMER));
        fRaise = IntToFloat(GetLocalInt(oPC, HABD_RAISE_TIMER));
        // The respawn timer must be less than the raise timer for it to execute.
        if ((fRespawn > 0.0) && ((fRespawn < fRaise) || (fRaise == 0.0)))
        {
            AssignCommand(oPC, DelayCommand(HABD_NPC_FORCE_RESPAWN_TIMER, HABDForceAutoRespawn(oPC)));
        }
        if (fRaise > 0.0)
        {
            if (HABD_FORCE_RAISE_USES_SCROLLS)
            {
                if (HABDCheckForRaiseRezScrolls(oPC) <= 0)
                {
                    return;
                }
            }
            AssignCommand(oPC, DelayCommand(HABD_NPC_FORCE_RAISE_TIMER, HABDForceAutoRaise(oPC)));
        }
    }
    else    //Player character
    {
        fRespawn = IntToFloat(GetLocalInt(oMod, HABD_RESPAWN_TIMER+sID));
        fRaise = IntToFloat(GetLocalInt(oMod, HABD_RAISE_TIMER+sID));
        // The respawn timer must be less than the raise timer for it to execute.
        if ((fRespawn > 0.0) && ((fRespawn < fRaise) || (fRaise == 0.0)))
        {
            AssignCommand(oPC, AutoRespawnWarning(oPC, fRespawn));
            AssignCommand(oPC, DelayCommand(0.5 * fRespawn, AutoRespawnWarning(oPC, 0.5 * fRespawn)));
            AssignCommand(oPC, DelayCommand(0.75*fRespawn, AutoRespawnWarning(oPC, 0.25*fRespawn)));
            AssignCommand(oPC, DelayCommand(9*fRespawn, AutoRespawnWarning(oPC, 0.1*fRespawn)));
            //AssignCommand(oPC, DelayCommand(fRespawn, ForceAutoRespawn(oPC)));
            AssignCommand(oPC, DelayCommand(IntToFloat(HABD_AUTOTIMERS_UPDATE), HABDAutoRespawnTimerUpdater(oPC, FloatToInt(fRespawn))));
        }
        if (fRaise > 0.0)
        {
            if (HABD_FORCE_RAISE_USES_SCROLLS)
            {
                if (HABDCheckForRaiseRezScrolls(oPC) <= 0)
                {

                    if(HABD_USERLANGUAGE==0)
                      FloatingTextStringOnCreature("Server: Out of scrolls. You have to wait for help.", oPC, FALSE);

                    else if(HABD_USERLANGUAGE==1)
                      FloatingTextStringOnCreature("Server: Sin Pergaminos. Tendras que esperar a que llegue ayuda.", oPC, FALSE);

                    else if(HABD_USERLANGUAGE==2)
                      FloatingTextStringOnCreature("Server: Du hast keine nützlichen Schriftrollen bei Dir. Du musst auf Hilfe warten.", oPC, FALSE);

                    return;
                }
            }
            AssignCommand(oPC, AutoRaiseWarning(oPC, fRaise));
            AssignCommand(oPC, DelayCommand(0.5 * fRaise, AutoRaiseWarning(oPC, 0.5 * fRaise)));
            AssignCommand(oPC, DelayCommand(0.75*fRaise, AutoRaiseWarning(oPC, 0.25*fRaise)));
            AssignCommand(oPC, DelayCommand(9*fRaise, AutoRaiseWarning(oPC, 0.1*fRaise)));
            //AssignCommand(oPC, DelayCommand(fRaise, HABDForceAutoRaise(oPC)));
            AssignCommand(oPC, DelayCommand(IntToFloat(HABD_AUTOTIMERS_UPDATE), HABDAutoRaiseTimerUpdater(oPC,FloatToInt(fRaise)) )  );
        }

    }
    // DO NOT ADD ANY CODE HERE. IT MIGHT NOT BE EXECUTED.
}
