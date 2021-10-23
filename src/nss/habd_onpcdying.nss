// Henchmen Always Bleed to Death
// By Demtrious, OldManWhistler and IntrepidCW
//
// PLEASE READ "habd_include" FOR MORE INFORMATION.
//
// OnPlayerDying event handler.

#include "habd_include"
#include "shifter_inc"
#include "_isla_inc"
#include "NW_I0_GENERIC"

// ****************************************************************************

// This function plays a random bleeding VoiceChat on a player.
//   oPC - the player to make play a bleed voice.
void PlayBleedVoice (object oPC);

void PlayBleedVoice (object oPC)
{
    int iplay = FALSE;
    //PlayingVoices activated?
    if ( HABD_PLAY_BLEED_VOICE ==TRUE && HABD_PLAY_BLEED_VOICE<2)
        iplay = TRUE;
    if ( HABD_PLAY_BLEED_VOICE >1 && HABD_PLAY_BLEED_VOICE<=100 )
        if ( d100(1) >= HABD_PLAY_BLEED_VOICE )
            iplay = TRUE;

    if (iplay == TRUE)
    switch (d6())
    {
        case 1: PlayVoiceChat (VOICE_CHAT_PAIN1, oPC); break;
        case 2: PlayVoiceChat (VOICE_CHAT_PAIN2, oPC); break;
        case 3: PlayVoiceChat (VOICE_CHAT_PAIN3, oPC); break;
        case 4: PlayVoiceChat (VOICE_CHAT_HEALME, oPC); break;
        case 5: PlayVoiceChat (VOICE_CHAT_NEARDEATH, oPC); break;
        case 6: PlayVoiceChat (VOICE_CHAT_HELP, oPC); break;
    }
    return;
}

// ****************************************************************************


// Returns the delay in seconds that must be applied to the player healing
// after estabilization.
float DelayToHeal(object oPC);

float DelayToHeal(object oPC)
{
    float ftime = 1.0;
    if (HABD_DELAY_TOHEAL == 0.0 || GetCurrentHitPoints(oPC)>=1)
        ftime = 1.0;  //the old HABD value
    else
        {
        ftime = HABD_DELAY_TOHEAL * IntToFloat(1- GetCurrentHitPoints(oPC) );
        if (ftime < 1.0)    ftime = 1.0;
        }
    return ftime;
}
// ****************************************************************************


// Heals players to 1 hp and to removes negative effects. In also calls the
// user defined bleed stabilization function.
//   oPC - the player to heal.
void HealTo1HP(object oPC, int iIgnoreDelayVar = FALSE);

void HealTo1HP(object oPC, int iIgnoreDelayVar = FALSE)
{
    object oMod = GetModule();
    string sID = GetPCPlayerName(oPC)+GetName(oPC);

    if (GetLocalInt(oMod, HABD_DELAYTOHEAL_CONTROL+sID) == FALSE &
        iIgnoreDelayVar == FALSE)
            return;
    DeleteLocalInt(oMod, HABD_DELAYTOHEAL_CONTROL+sID);

    // If player is already alive then abort.
    if (HABDGetHABD_PLAYER_STATE(sID, oPC) == HABD_STATE_PLAYER_ALIVE) return;
    int iNPC = GetLocalInt(OBJECT_SELF, HABD_NPC_BLEED);

    // Give the player a chance to run away
    if (HABD_POST_BLEED_INVIS_DUR > 0.0) ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectInvisibility(INVISIBILITY_TYPE_NORMAL), oPC, HABD_POST_BLEED_INVIS_DUR);
    if (HABD_POST_BLEED_CONCEAL_DUR > 0.0 && HABD_POST_BLEED_INVIS_DUR > 0.0)
        if (HABD_POST_BLEED_CONCEAL_DUR >= HABD_POST_BLEED_INVIS_DUR )
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectConcealment(100,MISS_CHANCE_TYPE_NORMAL), oPC, HABD_POST_BLEED_INVIS_DUR);
        if (HABD_POST_BLEED_INVIS_DUR > HABD_POST_BLEED_CONCEAL_DUR )
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectConcealment(100,MISS_CHANCE_TYPE_NORMAL), oPC, HABD_POST_BLEED_CONCEAL_DUR);

    // Turn the plot flag off after a specific period of time.
    SetPlotFlag(oPC, FALSE);
    // Raises the player to 1 hp.
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(1 - (GetCurrentHitPoints(oPC))), oPC);
    HABDSetHABD_PLAYER_STATE(HABD_STATE_PLAYER_ALIVE, sID, oPC); //set player state to alive

    /*Set the delayed Ressuruction of the PC
    int    nCharLVL = GetCharacterLevel( oPC ); float fDeathReset;
    switch (nCharLVL)
    {
        case  1: fDeathReset = HABD_WAITINGTIME_LVL_01; break; case  2: fDeathReset = HABD_WAITINGTIME_LVL_02; break;
        case  3: fDeathReset = HABD_WAITINGTIME_LVL_03; break; case  4: fDeathReset = HABD_WAITINGTIME_LVL_04; break;
        case  5: fDeathReset = HABD_WAITINGTIME_LVL_05; break; case  6: fDeathReset = HABD_WAITINGTIME_LVL_06; break;
        case  7: fDeathReset = HABD_WAITINGTIME_LVL_07; break; case  8: fDeathReset = HABD_WAITINGTIME_LVL_08; break;
        case  9: fDeathReset = HABD_WAITINGTIME_LVL_09; break; case 10: fDeathReset = HABD_WAITINGTIME_LVL_10; break;
        case 11: fDeathReset = HABD_WAITINGTIME_LVL_11; break; case 12: fDeathReset = HABD_WAITINGTIME_LVL_12; break;
        case 13: fDeathReset = HABD_WAITINGTIME_LVL_13; break; case 14: fDeathReset = HABD_WAITINGTIME_LVL_14; break;
        case 15: fDeathReset = HABD_WAITINGTIME_LVL_15; break; case 16: fDeathReset = HABD_WAITINGTIME_LVL_16; break;
        case 17: fDeathReset = HABD_WAITINGTIME_LVL_17; break; case 18: fDeathReset = HABD_WAITINGTIME_LVL_18; break;
        case 19: fDeathReset = HABD_WAITINGTIME_LVL_19; break; case 20: fDeathReset = HABD_WAITINGTIME_LVL_20; break;
        case 21: fDeathReset = HABD_WAITINGTIME_LVL_21; break; case 22: fDeathReset = HABD_WAITINGTIME_LVL_22; break;
        case 23: fDeathReset = HABD_WAITINGTIME_LVL_23; break; case 24: fDeathReset = HABD_WAITINGTIME_LVL_24; break;
        case 25: fDeathReset = HABD_WAITINGTIME_LVL_25; break; case 26: fDeathReset = HABD_WAITINGTIME_LVL_26; break;
        case 27: fDeathReset = HABD_WAITINGTIME_LVL_27; break; case 28: fDeathReset = HABD_WAITINGTIME_LVL_28; break;
        case 29: fDeathReset = HABD_WAITINGTIME_LVL_29; break; case 30: fDeathReset = HABD_WAITINGTIME_LVL_30; break;
        case 31: fDeathReset = HABD_WAITINGTIME_LVL_31; break; case 32: fDeathReset = HABD_WAITINGTIME_LVL_32; break;
        case 33: fDeathReset = HABD_WAITINGTIME_LVL_33; break; case 34: fDeathReset = HABD_WAITINGTIME_LVL_34; break;
        case 35: fDeathReset = HABD_WAITINGTIME_LVL_35; break; case 36: fDeathReset = HABD_WAITINGTIME_LVL_36; break;
        case 37: fDeathReset = HABD_WAITINGTIME_LVL_37; break; case 38: fDeathReset = HABD_WAITINGTIME_LVL_38; break;
        case 39: fDeathReset = HABD_WAITINGTIME_LVL_39; break; case 40: fDeathReset = HABD_WAITINGTIME_LVL_40; break;
    }
      //Check if the PC isn't already raised or alive
      //if ( HABDGetHABD_PLAYER_STATE(sID, oPC) == HABD_STATE_RESPAWNED_GHOST ) //Player wasn' set alive, so after certain time set him alive!
      //{
        AssignCommand(oMod, DelayCommand( fDeathReset , HABDSetHABD_PLAYER_STATE(HABD_STATE_PLAYER_ALIVE, sID, oPC)));
      //}*/
    // If this is a henchmen, then take them out of the busy state.
    if (iNPC)
    {
        HABDAssociateNotBusy();
    }

    // Keep the player from being attacked, stop nearby attackers
    AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectInvisibility(INVISIBILITY_TYPE_NORMAL), oPC, 6.0));
    // Make the player hostile again.
    SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, GetLocalInt(oPC, HABD_OLD_FACTION), oPC);
    DeleteLocalInt(oPC, HABD_OLD_FACTION_SET);
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 5.0));

    // Notify the player that they were healed.
    DelayCommand(0.5, SendServerMessageToPC(oPC, "Du wurdest geheilt."));

    // Apply user defined penalties.
    AssignCommand(oPC, HABDUserDefinedBleed());

    //Give a little visual effect for flare.
    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oPC);

    // If regeneration items were removed then reequip them.
    if (HABD_NERF_REGENERATION_ITEMS)
    {
        AssignCommand(oPC, HABDRegenerationItemsReEquip(oPC));
    }

    //Save info to DB (and maybe export PC) to avoid server crash problems,
    //now that we are sure the PC is Alive.
    if ( HABD_SMART_SAVETODB == TRUE )
        HABDSetDBString(oPC);

    // Fixes the inital respawn issue with monsters not reattacking.
    //object oMonster = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oPC, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    //DelayCommand(9.0, AssignCommand(oMonster, ActionAttack(oPC)));
}

// ****************************************************************************

// Returns TRUE if the player has stabilized by gaining any HP since the last
// time they bled.
int CheckForStabilization(object oPC);

int CheckForStabilization(object oPC)
{
    object oMod = GetModule();
    string sID = GetPCPlayerName(oPC)+GetName(oPC);
    //Section deals with possibility for healing by other players
    int lastHP = 0;
    if (GetIsPC(oPC) && GetIsDMPossessed(oPC) == FALSE)//PC
        lastHP = GetLocalInt(oMod, HABD_LAST_HP+sID);
    else    //NPC
        lastHP = GetLocalInt(oPC, HABD_LAST_HP);
    if (GetCurrentHitPoints(oPC) > lastHP)  //if hitpoint have increased
    {
        float ftime = DelayToHeal(oPC);
        DelayCommand(ftime, HealTo1HP(oPC));
            if (FloatToInt(ftime)>1)
            {

                if(HABD_USERLANGUAGE==0)
                  FloatingTextStringOnCreature(GetName(oPC)+" will heal to 1 HP in: "+IntToString(FloatToInt(ftime))+" seconds.", oPC, TRUE);

                else if (HABD_USERLANGUAGE==1)
                  FloatingTextStringOnCreature(GetName(oPC)+" se curara a 1 PG en: "+IntToString(FloatToInt(ftime))+" segundos.", oPC, TRUE);

                else if (HABD_USERLANGUAGE==2)
                  FloatingTextStringOnCreature(GetName(oPC)+" Wird in "+IntToString(FloatToInt(ftime))+" Sekunden auf 1 TP heilen.", oPC, TRUE);

            }
        SetLocalInt(oMod, HABD_DELAYTOHEAL_CONTROL+sID, TRUE);
        return TRUE;
    }
    return FALSE;
}

// ****************************************************************************

// Report the bleed count for OBJECT_SELF.
void ReportPlayerBleed();

void ReportPlayerBleed()
{
    object oPC = OBJECT_SELF;
    object oMod = GetModule();
    string sID = GetPCPlayerName(oPC)+GetName(oPC);
    int iHPs = GetCurrentHitPoints(oPC);
    int iNPC = GetLocalInt(OBJECT_SELF, HABD_NPC_BLEED);
    if (iNPC) iHPs = iHPs - 10;

    if (
        (HABDGetHABD_PLAYER_STATE(sID, oPC) != HABD_STATE_PLAYER_BLEEDING) || // check if player is still bleeding
        (iHPs > 0) || // player has healed
        (iHPs <= -10) || // player is a goner, let the death script kick in
        (CheckForStabilization(oPC)) // check if player has gained any HP
        )
    {
        DeleteLocalInt(oPC, HABD_REPORT_BLEED_RUNNING);
        return;
    }
    // The delay will effect how often players are vocal about bleeding.
    DelayCommand(6.0, AssignCommand(oPC, ReportPlayerBleed()));

    // Prevent calling this function multiple times
    SetLocalInt(oPC, HABD_REPORT_BLEED_RUNNING, 1);

    string sbleedmsg = GetName(oPC)+" is bleeding to death! At "+IntToString(iHPs)+" hitpoints.";

    if(HABD_USERLANGUAGE==0)
      sbleedmsg = GetName(oPC)+" is bleeding to death! At "+IntToString(iHPs)+" hitpoints.";

    else if(HABD_USERLANGUAGE==1)
      sbleedmsg = GetName(oPC)+" esta muriendose! A "+IntToString(iHPs)+" puntos de golpe.";

    else if(HABD_USERLANGUAGE==2)
      sbleedmsg = GetName(oPC)+" verblutet! Momentan bei "+IntToString(iHPs)+" Trefferpunkten.";


    DelayCommand(0.1, FloatingTextStringOnCreature(sbleedmsg, oPC));
    if (HABD_DM_NOTIFICATION_ON_BLEED) SendMessageToAllDMs(sbleedmsg);
    PlayBleedVoice(oPC);
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 6.0));
}

// ****************************************************************************

// This function exists to fix the problem that occurs in bleeding scripts
// when the summoned familiar is being possessed by the player (sorc or wiz).
// That creates a condition where GetIsPC returns true for the familiar.
// What usually happens is that when the possessed familiar dies, the player
// is trapped in its body until the DM manually kills the player.
// While stuck in the dead familiar, the player is unable to run the unpossess
// action and the bleed count on the familiar usually does not work properly.

// Whistler didnt take in mind that a player can possess the familiar even
// when he is bleeding!!! it ruins all the timers. I havent found a fix that
// doesnt kill the pet.
// This function DOES NOT kill the familiar when the player is bleeding if the player
// is not possessing the familiar. The familiar will be able to continue fighting
// for its unconcious and bleeding master.
// 1.65 has changed the familiar functions, but none of them seems to affect us
//   oTarget - the possibly "possessed" player.
int KillPet(object oTarget, int nEffect = TRUE, int nVisualEffectId = VFX_IMP_UNSUMMON);

int KillPet(object oTarget, int nEffect = TRUE, int nVisualEffectId = VFX_IMP_UNSUMMON)
{
    // Usage: place in your bleeding script with a call that looks something like
    // if (KillPet(oPC)) return; // abort from the bleed script, oPC no longer exists

    effect eDeath = EffectDeath(FALSE, FALSE);
    effect eVis = EffectVisualEffect(nVisualEffectId);
    object oCreature = oTarget;
    if(GetIsObjectValid(oCreature))
    {
        object oMaster = GetMaster(oCreature);
        if(GetIsObjectValid(oMaster))
        {
            //Is the creature a summoned associate
            if(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oMaster) == oCreature)
            {
                //Apply the VFX and delay the destruction of the summoned monster so
                //that the script and VFX can play.
                if(nEffect)
                    DelayCommand(0.001,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eVis,GetLocation(oCreature),1.0f));
                SetPlotFlag(oCreature, FALSE);

                string skillpetmessage = GetName(oMaster)+" HAS LOST FAMILIAR '"+GetName(oCreature)+"'";

                if(HABD_USERLANGUAGE==0)
                  skillpetmessage = GetName(oMaster)+" HAS LOST FAMILIAR '"+GetName(oCreature)+"'";

                else if(HABD_USERLANGUAGE==1)
                  skillpetmessage = GetName(oMaster)+" HA PERDIDO SU FAMILIAR '"+GetName(oCreature)+"'";

                else if(HABD_USERLANGUAGE==2)
                  skillpetmessage = GetName(oMaster)+" verlor seinen Vertrauten '"+GetName(oCreature)+"'";

                DelayCommand(0.002,FloatingTextStringOnCreature(skillpetmessage, oCreature));
                if (HABD_DM_NOTIFICATION_ON_BLEED) SendMessageToAllDMs(skillpetmessage);
                DelayCommand(0.003, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDeath, oCreature));
                return TRUE;
            }
        }
    }
    return FALSE;
}

// ****************************************************************************


// It will kill any familiar of the PC. Take in mind that a player can possess
// the familiar even when he is bleeding!!! it ruins all the timers. I havent
// found a fix that doesnt kill the pet.
// Facts: if you are alone in the server and posses a familiar, GetFirstPC()
// doesnt seem to return something that is not usefull.
void DestroyFamiliar(object oPC);

void DestroyFamiliar(object oPC)
{
    int i = 1;
    object oPet = GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC,i);
    effect eDeath = EffectDeath(FALSE, FALSE);
    while( oPet != OBJECT_INVALID )
    {

        if(HABD_USERLANGUAGE==0)
          SendServerMessageToPC(oPC, "Server: Your familiar died.");

        else if(HABD_USERLANGUAGE==1)
          SendServerMessageToPC(oPC, "Server: Tu familiar ha muerto.");

        else if(HABD_USERLANGUAGE==2)
          SendServerMessageToPC(oPC, "Server: Dein Vertrauter starb.");

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDeath, oPet);
        i=i+1;
        oPet = GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC,i);
    }
}


// ****************************************************************************

// Applies -1 HP to the player and checks for stabilization.
//   fBleedTimer - the time duration between bleeding -1 HP.
void BleedToDeath(float fBleedTimer, object oPC, int iCoupDeGrace, object oFamiliar = OBJECT_INVALID)
{
    object oMod = GetModule();
    //object oPC = OBJECT_SELF;

    // whistler: if this is a player in a possessed familiar, then just kill it.
    // IntrepidCW: However, calling it in the BleedToDeath function will ruin the
    // bleeding chain. So we also restore the bleeding chain
    // Known Bug: If the plater possess the familiar when he has stabilized
    // but the 1 HP healing has not still been applied, he will remain at ground
    // (logout/login could solve the problem)
    if (HABD_FAMILIAR_EXPLOIT <=1)
    if ( GetIsPC(oFamiliar) || GetIsPossessedFamiliar(oFamiliar) )
        {
        KillPet(oFamiliar);
        AssignCommand(oMod, DelayCommand(fBleedTimer, BleedToDeath(fBleedTimer, oPC, iCoupDeGrace, OBJECT_INVALID )));
        return;
        }

    string sID = GetPCPlayerName(oPC)+GetName(oPC);
    int iNPC = GetLocalInt(OBJECT_SELF, HABD_NPC_BLEED);
    if (HABD_DEBUG) SpeakString("DEBUG: HABD OnBleed, "+GetName(oPC)+", HP: "+IntToString(GetCurrentHitPoints(oPC))+", master: "+GetName(GetMaster(oPC))+", state:"+HABDGetPlayerStateName(oPC), TALKVOLUME_SHOUT);
     //DEBUG: Not translated to spanish
    int iPlayerState = HABDGetHABD_PLAYER_STATE(sID, oPC);
    if (iPlayerState != HABD_STATE_PLAYER_BLEEDING) return;

    // Deals with a exploit that happens when you level up while bleeding
    if ( GetLocalInt(oPC, HABD_LAST_LEVEL) != 0 )
    {
        if ( GetHitDice(oPC) > GetLocalInt(oPC, HABD_LAST_LEVEL) )
        {
        SetLocalInt(oPC, HABD_LAST_LEVEL, GetHitDice(oPC) );
            //Kill the PC
            if ( HABD_LEVELUPBLEED_EXPLOIT_KILLS == TRUE )
            {

                if(HABD_USERLANGUAGE==0)
                {
                SendServerMessageToPC(oPC,"You have died, because you used the exploit to level up when Bleeding. If error, alert DMs with full details.");
                SendMessageToAllDMs(GetName(oPC)+" (Player:"+GetPCPlayerName(oPC)+" has died, because you used the exploit to level up when Bleeding.");
                }

                else if(HABD_USERLANGUAGE==1)
                {
                SendServerMessageToPC(oPC,"Has muerto, por que usaste la trampa de subir de nivel mientras morias. En caso de error, alerta a los DMs con detalles completos.");
                SendMessageToAllDMs(GetName(oPC)+" (El Jugador:"+GetPCPlayerName(oPC)+" ha muerto, por que uso la trampa de subir de nivel mientras moria.");
                }

                else if(HABD_USERLANGUAGE==2)
                {
                SendServerMessageToPC(oPC,"Du bist gestorben, da Du versucht hast zu leveln, während Du verblutet bist. Sollte dies ein Fehler sein, melde Dich bitte im Forum mit allen Details.");
                SendMessageToAllDMs(GetName(oPC)+" (El Jugador:"+GetPCPlayerName(oPC)+" ha muerto, por que uso la trampa de subir de nivel mientras moria.");
                }

            WriteTimestampedLogEntry(GetName(oPC)+" (Player:"+GetPCPlayerName(oPC)+") has died, because you used the exploit to level up when Bleeding.");
            // Ensure that plot is not still set.
            SetPlotFlag(oPC, FALSE);
            // Drop him to -10 HPs
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDamage(GetCurrentHitPoints(oPC)+10,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_PLUS_FIVE), oPC);
            // Set up the hostile faction again.
            SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, GetLocalInt(oPC, HABD_OLD_FACTION), oPC);
            DeleteLocalInt(oPC, HABD_OLD_FACTION_SET);
            // Set playerstate to dead not dying
            HABDSetHABD_PLAYER_STATE(HABD_STATE_PLAYER_DEAD, sID, oPC);
            // OnPlayerDead script will be called after this.
            // BleedToDeath will be called one more time, but it will instantly
            // abort because the player is not in the bleeding state.
            return;
            }
             else
              {

                if(HABD_USERLANGUAGE==0)
                {
                    SendServerMessageToPC(oPC,"You used the exploit to level up when Bleeding, DMs will know it. If error, alert DMs with full details.");
                    SendMessageToAllDMs(GetName(oPC)+" (Player:"+GetPCPlayerName(oPC)+" Used the exploit to level up when Bleeding.");
                }

                else if(HABD_USERLANGUAGE==1)
                {
                    SendServerMessageToPC(oPC,"Has usado la trampa de subir de nivel mientras morias, los DMs han sido avisados y lo sabran leyendo el Log. En caso de error, alerta a los DMs con detalles completos.");
                    SendMessageToAllDMs(GetName(oPC)+" (El Jugador:"+GetPCPlayerName(oPC)+" Uso la trampa de subir de nivel mientras moria.");
                }

                else if(HABD_USERLANGUAGE==2)
                {
                    SendServerMessageToPC(oPC,"Du bist gestorben, da Du versucht hast zu leveln, während Du verblutet bist. Es wurde ein Sl informiert. Sollte dies ein Fehler sein, melde Dich bitte im Forum mit allen Details.");
                    SendMessageToAllDMs(GetName(oPC)+" (Spieler:"+GetPCPlayerName(oPC)+" hat versucht zu leveln, während er verblutet ist.");
                }

                WriteTimestampedLogEntry(GetName(oPC)+" (Player:"+GetPCPlayerName(oPC)+" Used the exploit to level up when Bleeding.");
              }
        }
        //else SetLocalInt(oPC, HABD_LAST_LEVEL, GetHitDice(oPC) );
    }
    else SetLocalInt(oPC, HABD_LAST_LEVEL, GetHitDice(oPC) );
    // - end of antiexploit code

    //Coup de Grace for PCs alone in area feature
    if ( iCoupDeGrace == TRUE)
    if ( GetHitDice(oPC) > HABD_NO_DEATH_UNTIL_LEVEL )
    if ( HABD_GetIsSafeArea(oPC) == FALSE)
    {
            //kill the PC

            if(HABD_USERLANGUAGE==0)
              SendServerMessageToPC(oPC,"You have died, due to coup of grace.");

            else if(HABD_USERLANGUAGE==1)
              SendServerMessageToPC(oPC,"Has muerto, debido a un golpe de gracia.");

            else if(HABD_USERLANGUAGE==2)
              SendServerMessageToPC(oPC,"Du bist durch einen Todesschlag gestorben.");

            // Ensure that plot is not still set.
            SetPlotFlag(oPC, FALSE);
            // Drop him to -10 HPs
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDamage(GetCurrentHitPoints(oPC)+10,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_PLUS_FIVE), oPC);
            // Set up the hostile faction again.
            SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, GetLocalInt(oPC, HABD_OLD_FACTION), oPC);
            DeleteLocalInt(oPC, HABD_OLD_FACTION_SET);
            // Set playerstate to dead not dying
            HABDSetHABD_PLAYER_STATE(HABD_STATE_PLAYER_DEAD, sID, oPC);
            // OnPlayerDead script will be called after this.
            // BleedToDeath will be called one more time, but it will instantly
            // abort because the player is not in the bleeding state.
            return;
    }
    //-

    //Check if someone has healed at least one hp to the PC.
    if (CheckForStabilization(oPC)) return;

    // if you get here - you are dying and have not been healed
    // so you need to roll to see if you stabilize. Default d10.
    int nSavingRoll = Random(HABD_STABILIZATION_DICE)+1;

    // See what you must roll to self-stabilized
    int iNeededSavingRoll = HABD_GLOBAL_STABILIZATION_NUMBER;
    if ( HABDPlayerIsSolo(oPC) )
        iNeededSavingRoll = HABD_SOLO_STABILIZATION_NUMBER;

    // Death can be disabled before a certain level by "faking" the stabilization
    // check. Do not let the players know that death is disabled because it will
    // only encourage them to be idiots.
    if ((HABD_NO_DEATH_UNTIL_LEVEL) && (GetHitDice(oPC) < HABD_NO_DEATH_UNTIL_LEVEL))
    {
        switch (GetCurrentHitPoints(oPC))
        {
            case 10:
            case -1: nSavingRoll = nSavingRoll + 2*HABD_STABILIZATION_DICE/10; break;
            case 9:
            case -2: nSavingRoll = nSavingRoll + 3*HABD_STABILIZATION_DICE/10; break;
            case 8:
            case -3: nSavingRoll = nSavingRoll + 4*HABD_STABILIZATION_DICE/10; break;
            case 7:
            case -4: nSavingRoll = nSavingRoll + 5*HABD_STABILIZATION_DICE/10; break;
            case 6:
            case -5: nSavingRoll = nSavingRoll + 6*HABD_STABILIZATION_DICE/10; break;
            case 5:
            case -6: nSavingRoll = nSavingRoll + 7*HABD_STABILIZATION_DICE/10; break;
            case 4:
            case -7: nSavingRoll = nSavingRoll + 8*HABD_STABILIZATION_DICE/10; break;
            case 3:
            case -8: nSavingRoll = nSavingRoll + 9*HABD_STABILIZATION_DICE/10; break;
            case 2:
            case -9:
            default: nSavingRoll = nSavingRoll + HABD_STABILIZATION_DICE; break;
        }
    }

    //Default 10 for 3E - lower for easier stabilization
    int iStabilized = FALSE;
    if (nSavingRoll >= iNeededSavingRoll)
        iStabilized = TRUE;
        else
            if (HABD_GetIsSafeArea(oPC) == TRUE)
                iStabilized = TRUE;

    //Stabilized
    if (iStabilized == TRUE)
    {
        float ftime = DelayToHeal(oPC);
        DelayCommand(ftime, HealTo1HP(oPC));    //call heal subroutine
            if (FloatToInt(ftime)>1)
            {

                if(HABD_USERLANGUAGE==0)
                  FloatingTextStringOnCreature(GetName(oPC)+" will heal to 1 HP in: "+IntToString(FloatToInt(ftime))+" seconds.", oPC, TRUE);

                else if(HABD_USERLANGUAGE==1)
                  FloatingTextStringOnCreature(GetName(oPC)+" se curara a 1 PG en: "+IntToString(FloatToInt(ftime))+" segundos.", oPC, TRUE);

                else if(HABD_USERLANGUAGE==2)
                  FloatingTextStringOnCreature(GetName(oPC)+" wird in "+IntToString(FloatToInt(ftime))+" Sekunden auf 1 TP heilen.", oPC, TRUE);

            }
        SetLocalInt(GetModule(), HABD_DELAYTOHEAL_CONTROL+sID, TRUE);

        // Always make it look like they rolled a 10 to stabilize

        if(HABD_USERLANGUAGE==0)
        {
          SendServerMessageToPC(oPC,"Saving Roll to stop bleeding (at "+IntToString(GetCurrentHitPoints(oPC))+") = 10");
          FloatingTextStringOnCreature(GetName(oPC)+" has self-stabilized.", oPC);
          DelayCommand(6.0, SendServerMessageToPC(oPC, "In a life or death effort you have survived, alive but barely."));
        }

        else if(HABD_USERLANGUAGE==1)
        {
          SendServerMessageToPC(oPC,"Tirada de Estabilizacion (a "+IntToString(GetCurrentHitPoints(oPC))+") = 10");
          FloatingTextStringOnCreature(GetName(oPC)+" se ha auto-estabilizado.", oPC);
          DelayCommand(6.0, SendServerMessageToPC(oPC, "En un esfuerzo a vida o muerte has sobrevivido, vivo pero herido."));
        }

        else if(HABD_USERLANGUAGE==2)
        {
          SendServerMessageToPC(oPC,"Du verblutest nicht mehr (bei "+IntToString(GetCurrentHitPoints(oPC))+") = 10");
          FloatingTextStringOnCreature(GetName(oPC)+" hat sich stabilisiert.", oPC);
          DelayCommand(6.0, SendServerMessageToPC(oPC, "In Deinem Todeskampf hast Du erfolgreich gewehrt. Du bist gerade so am Leben."));
        }

        return;
    }

    //if you get here, you have not been healed and did not successfully stabilize
    else
    {
        // Most important, keep the bleeding chain going.
        AssignCommand(oMod, DelayCommand(fBleedTimer, BleedToDeath(fBleedTimer, oPC, iCoupDeGrace, oFamiliar)));

        if(HABD_USERLANGUAGE==0)
          SendServerMessageToPC(oPC,"Saving Roll to stop bleeding (at "+IntToString(GetCurrentHitPoints(oPC))+") = " +IntToString(nSavingRoll));

        else if(HABD_USERLANGUAGE==1)
          SendServerMessageToPC(oPC,"Tirada de Estabilizacion (a "+IntToString(GetCurrentHitPoints(oPC))+") = " +IntToString(nSavingRoll));

        else if(HABD_USERLANGUAGE==2)
          SendServerMessageToPC(oPC,"Du verblutest nicht mehr (bei "+IntToString(GetCurrentHitPoints(oPC))+") = " +IntToString(nSavingRoll));

        SetPlotFlag(oPC, FALSE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDamage(1,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_PLUS_FIVE), oPC);
        SetPlotFlag(oPC, TRUE);
        // Update local variable with hitpoints for healing option.
        if (GetIsPC(oPC) && GetIsDMPossessed(oPC) == FALSE) //PC
            SetLocalInt(oMod,HABD_LAST_HP+sID, GetCurrentHitPoints(oPC));
        else    //NPC
            SetLocalInt(oPC,HABD_LAST_HP, GetCurrentHitPoints(oPC));

        // if this is true then the player has died.
        if (GetCurrentHitPoints(oPC) <= -10)
        {

            if(HABD_USERLANGUAGE==0)
              SendServerMessageToPC(oPC,"You have died.");

            else if(HABD_USERLANGUAGE==1)
              SendServerMessageToPC(oPC,"Has muerto.");

            else if(HABD_USERLANGUAGE==2)
              SendServerMessageToPC(oPC,"Du bist gestorben.");

            // Ensure that plot is not still set.
            SetPlotFlag(oPC, FALSE);
            // Set up the hostile faction again.
            SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, GetLocalInt(oPC, HABD_OLD_FACTION), oPC);
            DeleteLocalInt(oPC, HABD_OLD_FACTION_SET);
            // Set playerstate to dead not dying
            HABDSetHABD_PLAYER_STATE(HABD_STATE_PLAYER_DEAD, sID, oPC);
            // OnPlayerDead script will be called after this.
            // BleedToDeath will be called one more time, but it will instantly
            // abort because the player is not in the bleeding state.
            return;
        }
    }
}

// ****************************************************************************

// OnPlayerDying event handler.
void main()
{
    object oMod = GetModule();
    object oPC = GetLastPlayerDying();
    int iNPC = GetLocalInt(OBJECT_SELF, HABD_NPC_BLEED);
    if (iNPC == 1) oPC = OBJECT_SELF;
    string sID = GetPCPlayerName(oPC)+GetName(oPC);

    // If SC is a Shifter, execute this before all!
    // ExecuteScript("shifter_ondying", oPC);  // included skript
    // script now here included!
    // effect eDeath = EffectDeath(FALSE, FALSE);
    // object oPC = GetLastPlayerDying();
    if (GetLocalString(oPC,"CREATURE_RESREF")!="") ResetAppearance(oPC);
    // ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPC);

    //to properly deal with the levelling up while bleeding exploit.
    SetLocalInt(oPC, HABD_LAST_LEVEL, GetHitDice(oPC) );

    // If an NPC is running this script, then set up its master. The master was
    // automatically wiped out when the henchman died.
    if (iNPC)
    {
        if (!GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_HENCHMAN, GetLocalObject(OBJECT_SELF, HABD_NPC_MASTER))))
            AddHenchman(GetLocalObject(OBJECT_SELF, HABD_NPC_MASTER), oPC);
        //if HABD bleeding is disabled for Henchmen
        if ( HABD_HENCHMEN_BLEED == FALSE || HABD_HENCHMEN_BLEED == 2 )
            return;
    }
                  //DEBUG: Not translated to Spanish
    if (HABD_DEBUG) SpeakString("DEBUG: HABD OnDying, "+GetName(oPC)+", HP: "+IntToString(GetCurrentHitPoints(oPC))+", master: "+GetName(GetMaster(oPC))+", state:"+HABDGetPlayerStateName(oPC), TALKVOLUME_SHOUT);

    // Check if bleeding is running on DM or DM possessed, then abort.
    if(GetIsDM(oPC) || GetIsDM(GetMaster(oPC))) return;

    // whistler: if this is a player in a possessed familiar, then just kill it.
    // Familiar penalties will kick in when familiar dies.
    if (KillPet(oPC)) return;
    // Intrepid: Damn, player can possess a familiar when they are bleeding, which
    // ruins all the bleeding thing (at least in NWN 1.64 patch). The only fix
    // 100% relliable I have now is to kill all familiars.
    if (HABD_FAMILIAR_EXPLOIT == 0)
        DestroyFamiliar(oPC);

    int iState = HABDGetHABD_PLAYER_STATE(sID, oPC);
    if ((iState == HABD_STATE_PLAYER_DEAD) || (iState == HABD_STATE_RESPAWNED_GHOST))
        return;

    if ( iState == HABD_STATE_PC_PERMADEATH )
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(1 - (GetCurrentHitPoints(oPC))), oPC);
        HABDJumpToPermaDeathPoint(oPC, HABD_EVENTDYINGSIGNAL);
        return;
    }

    //coup de grace feature
    int CoupDeGrace = HABDCoupDeGraceAloneInArea(oPC);

    // Most important, issue the commands to start the bleeding chain.
    float fBleedTimer = HABDGetBleedTimer(oPC);

    //start the bleeding chain
    AssignCommand(oMod, DelayCommand(fBleedTimer, BleedToDeath(fBleedTimer, oPC, CoupDeGrace, GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC,1) )));
    if (GetLocalInt(oPC, HABD_REPORT_BLEED_RUNNING) == 0) DelayCommand(6.0, AssignCommand(oPC, ReportPlayerBleed()));

    int iHPs = GetCurrentHitPoints(oPC);
    SetPlotFlag(oPC, TRUE);
    // Force friendly to hostile faction.
    if (!GetLocalInt(oPC, HABD_OLD_FACTION_SET))
    {
        SetLocalInt(oPC, HABD_OLD_FACTION, GetStandardFactionReputation(STANDARD_FACTION_HOSTILE, oPC));
        SetLocalInt(oPC, HABD_OLD_FACTION_SET, 1);
    }
    SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 100, oPC);
    // Keep the player from being attacked, stop nearby attackers
    HABDStopNearbyAttackers(oPC);


    // CAP TO NEGATIVE HPs
    // Allow a good chance for healing - will limit HP to -5 on a bleed level hit.
    // Actually configurable via constant HABD_BLEEDING_START_LIMIT
    if ( HABD_BLEEDING_START_LIMIT > -10)
    if ( HABD_GetIsHardArea(oPC) == FALSE)
    if (
        (iHPs < HABD_BLEEDING_START_LIMIT) &&
        (iState == HABD_STATE_PLAYER_ALIVE)
        )
    {
        //should heal player to -5 (if default)
        int nHeal = HABD_BLEEDING_START_LIMIT - iHPs;
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(nHeal), oPC);
    }
    else //PC hasn't enough HitPoints
    {
      effect eDeath = EffectDeath(FALSE, FALSE);
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPC);
    }

    // Set the state variables.
    iHPs = GetCurrentHitPoints(oPC);
    HABDSetHABD_PLAYER_STATE(HABD_STATE_PLAYER_BLEEDING, sID, oPC);
    if (GetIsPC(oPC) && GetIsDMPossessed(oPC) == FALSE) //PC
            SetLocalInt(oMod,HABD_LAST_HP+sID, GetCurrentHitPoints(oPC));
        else    //NPC
            SetLocalInt(oPC,HABD_LAST_HP, GetCurrentHitPoints(oPC));

    // Check if we are re-entering this state from persistence.
    if (GetLocalInt(oPC, HABD_PERSISTANT_REAPPLY) != 1)
    {
        // Increment the counters.
        SetLocalInt(oMod, HABD_CURRENT_BLEED_COUNT+sID, GetLocalInt(oMod, HABD_CURRENT_BLEED_COUNT+sID) + 1);
        SetLocalInt(oMod, HABD_BLEED_COUNT+sID, GetLocalInt(oMod, HABD_BLEED_COUNT+sID) + 1);
    } else {
        DeleteLocalInt(oPC, HABD_PERSISTANT_REAPPLY);
    }

    // Nerf regeneration items.
    if (HABD_NERF_REGENERATION_ITEMS)
    {
        AssignCommand(oPC, HABDRegenerationItemsUnequip(oPC));
    }

    // Notify that bleeding has started.
    if (iNPC) iHPs = iHPs - 10;
    string sMsg = GetName(oPC)+" is bleeding to death! At "+IntToString(iHPs)+" hitpoints. Will die in "+FloatToString((10 + iHPs)*fBleedTimer, 3, 0)+" seconds.";

     if(HABD_USERLANGUAGE==0)
        sMsg = GetName(oPC)+" is bleeding to death! At "+IntToString(iHPs)+" hitpoints. Will die in "+FloatToString((10 + iHPs)*fBleedTimer, 3, 0)+" seconds.";

     else if(HABD_USERLANGUAGE==1)
         sMsg = GetName(oPC)+" esta muriendose! A "+IntToString(iHPs)+" puntos de golpe. Morira en "+FloatToString((10 + iHPs)*fBleedTimer, 3, 0)+" segundos.";

     else if(HABD_USERLANGUAGE==2)
         sMsg = GetName(oPC)+" verblutet! Momentan bei "+IntToString(iHPs)+" Trefferpunkten. Stirbt in "+FloatToString((10 + iHPs)*fBleedTimer, 3, 0)+" Sekunden.";

    if (HABD_DM_NOTIFICATION_ON_BLEED) SendMessageToAllDMs(sMsg);
    FloatingTextStringOnCreature(sMsg, oPC);

    //Save info to DB (and maybe export PC) to avoid server crash problems,
    //now that we are sure the PC is bleeding.
    if ( HABD_SMART_SAVETODB == TRUE )
        HABDSetDBString(oPC);

}
