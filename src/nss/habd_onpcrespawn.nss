// Henchmen Always Bleed to Death
// By Demtrious, OldManWhistler and IntrepidCW
//
// PLEASE READ "habd_include" FOR MORE INFORMATION.
//
// OnPlayerRespawn event handler.

/* Clarifications about HABD states:
NWN original has only Two states: Death (-10 or less hps), Dying (0 to -10 hps),
and Alive (0+ hps). But death and dying are similar: you are out.
HABD 'fakes' a new state and changes the rules, we have 5 states: Alive - Bleeding
- Death -Respawn -Permadeath
  For NWN, HABD_Alive and HABD_Respawn are 'alive'. HABD_Bleeding is NWN Dying
  and HABD_Death is NWN Death.
  In this order, a player starts Alive. Then he drops to Bleeding and triggers the
  OnDying Event. He could drop to Death after Instant Kill or after Bleeding.
  When Death the PC remains on the ground until Respawned. Respawned is NOT Alive
  , respawned is the state of a Ghost or a PC soul that can not leave a 'Hell'
  area. When Raised, the PC becomes really Alive.
*/

/* Notes about JumpToLocation (important if you modify this code)
JumptoLocation Does not affect creatures that are dead; they must have HP above
0 for this function to work properly.
Unfortunatelly the Effect Heal is not instantaneous... healing needs some time,
and what is worst, this time depends of the amount of hps to be healed.
It is often needed to call ClearAllActions() to use jumptoloc.
More important, if you set the PC NOT comandable, just after calling the Jump it
will not work, you must delay a bit the set commandable FALSE.
Some things cannot be done when the player travels to another area, as working
with inventory or equipment.
*/

#include "habd_include"
#include "_isla_inc"
#include "ll_include"

#include "NW_I0_GENERIC"

// Change this value if it is causing server lag.
// Ghost processes (check status, follow master, etc..) are done only when
// GHOST_LOOP_TIMER seconds have passed (repeteadly). Less than 6 seconds will
// make it more fluid, but most CPU costly (and maybe laggy).
const float GHOST_LOOP_TIMER = 6.0f;

// ****************************************************************************

// Set to TRUE to activate the function HABDUserDefinedRespawnFinished, otherwise
// it will never run.
const int USE_RespawnFinished_Function = FALSE;
// USER DEFINED FUNCTION
// When called, we are sure the PC is an Area (not jumping to another), and set
// to NOT commandable, with PlotFlag. If you make he commandable or NO-Plot,
// you should return to not commandable and Plot at the end of the script.
// If you use jumping to a 'hell' i counsel to use a script in OnEnter of the
// Hell Area, because someone closing the NWN Client when moving to another
// area could cause a problem.
// Furthermore, we are sure the rest of the respawn script is finished.
void HABDUserDefinedRespawnFinished(object oPC)
{

}
// ***************************************************************************




// ::  PERMADEATH  :: CUSTOM FUNCTION :: MODIFY TO CONFIGURE PERMADEATH //
int HABDUserDefinedPermadeath( object oPC)
{
/* You MUST script the conditions that lead to permadeath AND the effects of
PERMADEATH (some effects should be better scripted in the respawn script).
Take in mind that this function is called from the RESPAWN script.
This function MUST return TRUE or FALSE. True if it is permadeath, False if no
permadeath. Note that, when returning true, the respawn script will no longer
run, and no respawn effect/penalties will be applied.
Note: habd_utils, has code for a raising portal that raises Permadeath PCs, as a
safety measure you can place the portal in a Non-accesible part of the area...
or into a DM exclusive use area.
*/
    int iPermadeath = FALSE;
    object oMod = GetModule();
    string sID = GetPCPlayerName(oPC)+GetName(oPC);
    //usefull player stats that help to determine when we apply permadeath.
    int DeathCount = GetLocalInt(oMod, HABD_DEATH_COUNT+sID); //number of times the PC has died
    //int BleedCount = GetLocalInt(oMod, HABD_BLEED_COUNT+sID); //idem with bleeding
    //int LostXPCount = GetLocalInt(oMod, HABD_LOST_XP_COUNT+sID); //Total XP lost
    //int LosGPCount = GetLocalInt(oMod, HABD_LOST_GP_COUNT+sID);  //Total GP lost
    //int PCLevel = GetHitDice (oPC);
    //int PC_Con = GetAbilityScore(oPC, ABILITY_CONSTITUTION);
    //int PC_AloneInArea = HABDPlayerAloneInArea(oPC);

    //Now, script the condition that drops the player to Permadeath.
    // if ( DeathCount > 3*PCLevel )   { iPermadeath = TRUE; } //example

    /*  //correct negative hitpoints reached when you died due to instant death
        if (GetLocalInt(GetModule(), HABD_MINHPLASTBLEED+sID)<=-30)
        { iPermadeath = TRUE; } //example
    */

    //The custom-use variable can help you to script complex and persistent
    //permadeath effects and conditions
    // string scvar = HABDGetCustomVar(oPC);
    // if (PCLevel >10) HABDSetCustomVar(oPC, "Permadeath_Hell_N10"); //example

    //No Permadeath
    if ( iPermadeath == FALSE )
        return FALSE;
    //PERMADEATH !!!!
    else
    {
        SendServerMessageToPC(oPC, "OOC: Permadeath. Moving to Fugue Plane.");
        HABDSetHABD_PLAYER_STATE(HABD_STATE_PC_PERMADEATH, sID, oPC);
        HABDApplyPenalty(oPC, HABD_RESPAWN_XP_LOSS, HABD_RESPAWN_GP_LOSS, HABD_EVENTRESPAWNSIGNAL);
        //Save info to DB (and maybe export PC) to avoid server crash problems,
        //now that we are sure the PC is Permadeath.
        if ( HABD_SMART_SAVETODB == TRUE )
            HABDSetDBString(oPC);
        SetCommandable(TRUE, oPC);
        // "Raise" the player (only effect), MANDATORY!!
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPC);
        HABDJumpToPermaDeathPoint(oPC);
        return TRUE;
    }
}
// ***************************************************************************





// This function acts as a player heartbeat while the player is under the
// "respawn effect".
//   oOldFollow - is the last object the player was told to follow.

void Ghost(object oOldFollow = OBJECT_INVALID)
{
    object oMod = GetModule();
    object oPC = OBJECT_SELF;
    string sID = GetPCPlayerName(oPC)+GetName(oPC);
                        //DEBUG: Not translated to spanish
    if (HABD_DEBUG) SpeakString("DEBUG: HABD OnGhostHB, "+GetName(oPC)+", PlotFlag:"+IntToString(GetPlotFlag(OBJECT_SELF))+", CommandableFlag:"+IntToString(GetCommandable())+", HP: "+IntToString(GetCurrentHitPoints(oPC))+", master: "+GetName(GetMaster(oPC))+", state:"+HABDGetPlayerStateName(oPC), TALKVOLUME_SHOUT);

    int iState = HABDGetHABD_PLAYER_STATE(sID, oPC);

    if (
        (GetPlotFlag(OBJECT_SELF)) &&
        (iState == HABD_STATE_RESPAWNED_GHOST)
        )
    {
        // Is there someone to follow?
        object oFollow = GetLocalObject(oPC, HABD_GHOST_AUTOFOLLOW);
        HABDAssociateBusy();
        SetCommandable(TRUE);
        // Most important, schedule the next iteration of the heartbeat.
        DelayCommand(GHOST_LOOP_TIMER, Ghost(oFollow));
        if (GetIsObjectValid(oFollow))
        {
            if (oFollow != oOldFollow) FloatingTextStringOnCreature(GetName(OBJECT_SELF)+" is now following "+ GetName(oFollow), oPC, TRUE);
            if (GetArea(OBJECT_SELF) != GetArea(oFollow))
            {
                if ( HABD_GHOST_COMMANDABLE == FALSE)
                {

                if(HABD_USERLANGUAGE==0)
                  SendServerMessageToPC(oPC, "Jumping to "+GetName(oFollow));

                else if(HABD_USERLANGUAGE==1)
                  SendServerMessageToPC(oPC, "Saltando hacia "+GetName(oFollow));

                else if(HABD_USERLANGUAGE==2)
                  SendServerMessageToPC(oPC, "Teleportiere zu "+GetName(oFollow));

                // Not in same area, jump them there
                ClearAllActions();
                ActionJumpToObject(oFollow);
                }
            } else {
                // In same area, move them there
                ClearAllActions();
                DelayCommand(0.5, ActionForceFollowObject(oFollow, 6.0f));
            }
        }
         // Apply effects to make them a ghost.
         // Don't set the concealment too high just incase they find a way to abuse the system.
         effect eBad = EffectConcealment(1);
         eBad = EffectLinkEffects(EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR), eBad);
         eBad = EffectLinkEffects(EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE), eBad);
         if ( HABD_GHOST_EFFECTS_ON == TRUE)
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBad, oPC, GHOST_LOOP_TIMER+2.0f);
        // Remove their ability to control themselves
        if ( HABD_GHOST_COMMANDABLE == FALSE)
        SetCommandable(FALSE);
    }
        else
        // make sure that the ghost effects on/off doesnot raise players -avoid
        // the exploit caused by using the PlotFag as condition (see the if conds)
        if ( HABD_GHOST_EFFECTS_ON==TRUE || iState != HABD_STATE_RESPAWNED_GHOST )
        {
        HABDFinishRespawnGhost(oPC);

        // heal the respawned pc
        int nHPMax = GetMaxHitPoints(oPC);
        int nHPNow = GetCurrentHitPoints(oPC);
        int nToHeal = nHPMax - nHPNow;

        effect eHeal = EffectHeal(nToHeal);

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
        }
}

// ****************************************************************************

// This function checks that the player is not jumping to another area, it will
// trigger a function HABDUserDefinedRespawnFinished when finished the travel.
// It makes sure that we are in known circunstances.

void CheckGhostIsJumping(object ofPC)
{
    if ( GetArea(ofPC)!= OBJECT_INVALID )
        HABDUserDefinedRespawnFinished(ofPC);
    else
        DelayCommand(0.1,CheckGhostIsJumping(ofPC));
}
// ***************************************************************************


// This function checks that the player is not jumping to another area, it will
// make the player jump to the respawn point when finished the travel. It fixes
// some problems when jumping when we come from persistence.
void JumpToRespawnPoint(object oPC)
{
 if ( GetArea(oPC) != OBJECT_INVALID )
  {
  if ( HABDRespawnWPTag(oPC) != "")
    {
        object oRespPoint = GetWaypointByTag(HABDRespawnWPTag(oPC));
        if ( GetIsObjectValid (oRespPoint) ) //check the waypoint existes
        {
          location lRespLoc = GetLocation( oRespPoint );
          SetCommandable(TRUE, oPC);    //make sure the PC is commandable to jump
          if (GetCurrentHitPoints(oPC)<=0)
          {
            effect eHealto1HP = EffectHeal(1-GetCurrentHitPoints(oPC));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealto1HP  , oPC );
          }
          AssignCommand (oPC,ClearAllActions(TRUE));
          AssignCommand (oPC, JumpToLocation (lRespLoc) );
          DelayCommand ( 0.001, SetCommandable(FALSE, oPC) );
        }
    }
  }
 else DelayCommand ( 1.0, JumpToRespawnPoint(oPC) );
}
// ***************************************************************************


//searchs the nearest DeathBag of the PC
object SearchDeathBag(object oPC);
object SearchDeathBag(object oPC)
{
    object oBag = OBJECT_INVALID;
    int i=1;
    oBag = GetNearestObjectByTag(HABD_PLACEABLE_BAG, oPC, i);
    while ( oBag!=OBJECT_INVALID && i>0)
    {
        oBag = GetNearestObjectByTag(HABD_PLACEABLE_BAG, oPC, i);
        if ( GetLocalObject(oBag, HABD_BAG_OWNER) == oPC )
            i = -1000;
            else
            i=i+1;
    }
    return oBag;
}


//Creates the miscelaneous item Corpse of the oPC, into the object oBag Inventory,
//or the location lDrop if oBag is INVALID or is not found.
//oPC must be logged in!!
object CreateCorpse (object oPC, location lDrop, object oBag = OBJECT_INVALID );
object CreateCorpse (object oPC, location lDrop, object oBag = OBJECT_INVALID )
{
    object corpse = OBJECT_INVALID;
    string sResRef = "";
    if( GetGender(oPC) == GENDER_FEMALE )
        sResRef = HABD_CORPSEITEM_FEM_RESREF;
        else
        sResRef = HABD_CORPSEITEM_MALE_RESREF;

    string sID = GetPCPlayerName(oPC) + GetName(oPC);

    if (oBag != OBJECT_INVALID)
    {
      //create item on the bag
      corpse = CreateItemOnObject(sResRef, oBag, 1);
      //store info in the corpse
      SetLocalString(corpse, HABD_CORPSE_OWNER_PLAYERNAME, GetPCPlayerName(oPC) );
      SetLocalString(corpse, HABD_CORPSE_OWNER_PCNAME, GetName(oPC) );
    }
    else
    {
      //create item on the location
      corpse = CreateObject(OBJECT_TYPE_ITEM, sResRef, lDrop);
      //store info in the corpse
      SetLocalString(corpse, HABD_CORPSE_OWNER_PLAYERNAME, GetPCPlayerName(oPC) );
      SetLocalString(corpse, HABD_CORPSE_OWNER_PCNAME, GetName(oPC) );
    }
    //store in the PC, the corpse item object ID, it will help us to delete the
    //corpse when the PC is raised
    if (corpse != OBJECT_INVALID)
    {
        SetLocalObject(GetModule(), HABD_PC_CORPSE_OBJECT_ID + sID, corpse);
    }
    return corpse;
}
// ***************************************************************************


// OnPlayerRespawn event handler.

void main()
{
    // Check to see if the system is supposed to run this script, otherwise
    // it may be configured improperly.
    if (HABD_RESPAWN_SCRIPT != "habd_onpcrespawn")
    {
        ExecuteScript(HABD_RESPAWN_SCRIPT, OBJECT_SELF);
        return;
    }

    object oPC; //lets see who is the death guy
    // Catch if the script was forced to executed.
    // usually when coming from persistence, or timeforced respawn
    if (GetLocalInt(OBJECT_SELF, HABD_FORCED_RESPAWN) == 1)
    {
        oPC = OBJECT_SELF;
        HABDAssociateBusy();
    } else {
        oPC = GetLastRespawnButtonPresser();
    }

    LegendaryLevelsRecalculate(oPC);
//  LegendaryLevelsTempHP(oPC);

    object oMod = GetModule();
    string sID = GetPCPlayerName(oPC)+GetName(oPC);
                               //DEBUG: Not translated to Spanish
    if (HABD_DEBUG) SpeakString("DEBUG: HABD OnRespawn, "+GetName(oPC)+", HP: "+IntToString(GetCurrentHitPoints(oPC))+", master: "+GetName(GetMaster(oPC))+", state:"+HABDGetPlayerStateName(oPC), TALKVOLUME_SHOUT);

    //Dinamically change the Respawn configuration, when the PC is carrying
    //some special items
    object oDinamicItem = OBJECT_INVALID;
    int Dinamic = 0;
    if (HABD_DINAMICRESPAWN1!=0)
        {
        int iolddinamic = GetLocalInt(oPC,HABD_DINAMIC_OPTION1);
        //if no item is found, config variable is reset to 0
        oDinamicItem = HABDSetDinamicRespawnByItem(oPC,0);
        Dinamic = GetLocalInt(oPC,HABD_DINAMIC_OPTION1);
        if (HABD_DINAMICRESPAWN1==2)
            if (oDinamicItem!= OBJECT_INVALID)
                DestroyObject(oDinamicItem);
        }

    // CHECK FIRST IF IT IS PERMADEATH
    if ( HABDUserDefinedPermadeath(oPC) == TRUE )
        {
        return;
        }

    // Set the player state to respawn.
    HABDSetHABD_PLAYER_STATE(HABD_STATE_RESPAWNED_GHOST, sID, oPC);

    // Make it look like something happened.
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DOOM), oPC);
    // Raise the player (only effect)
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPC);

    // Most important, schedule the ghost heartbeat.
    AssignCommand(oPC, DelayCommand(3.0, Ghost()));

    // If they have a master, set up the master as the autofollow.
    if (GetIsObjectValid(GetMaster(oPC))) SetLocalObject(oPC, HABD_GHOST_AUTOFOLLOW, GetMaster(oPC));
    else
    {
        // Remove any old autofollow objects.
        DeleteLocalObject(oPC, HABD_GHOST_AUTOFOLLOW);
    }

    // Apply the user defined effects.
    AssignCommand(oPC, HABDUserDefinedRespawn());

    // Check if we are re-entering this state from persistence.
    if (GetLocalInt(oPC, HABD_PERSISTANT_REAPPLY) != 1)
    {
        //determine the penalty to be applied
        int xp_penalty = HABD_RESPAWN_XP_LOSS;
        int gp_penalty = HABD_RESPAWN_GP_LOSS;
        //Bindstone Respawn feature
        if (HABD_BINDSTONE_USEWHENRESPAWNED == TRUE
            && HABD_BINDSTONE_RESPAWNPENALTY == TRUE)
            {
                object oBWP = HABDGetBindStoneWP(oPC);
                int i = 0;
                i = GetLocalInt(oBWP, HABD_BINDSTONEWP_XPPENALTY);
                if ( i != 0)
                    {
                    if (i<0) xp_penalty = 0;
                    else     xp_penalty = i;
                    }
                i = GetLocalInt(oBWP, HABD_BINDSTONEWP_GPPENALTY);
                if ( i != 0)
                    {
                    if (i<0) gp_penalty = 0;
                    else     gp_penalty = i;
                    }
            }
        //Dinamic config feature
        if (HABD_DINAMICRESPAWN1!=0)
        if ( Dinamic>0 )
            {
            xp_penalty = HABDDinamicRespawnXP(Dinamic, xp_penalty);
            gp_penalty = HABDDinamicRespawnGP(Dinamic, gp_penalty);
            }

        // Apply the respawn penalty.
        HABDApplyPenalty(oPC, xp_penalty, gp_penalty, HABD_EVENTRESPAWNSIGNAL);
    }

    // Make them invulnerable
    if ( HABD_GHOST_EFFECTS_ON == TRUE)
    SetPlotFlag(oPC, TRUE);
        else    SetPlotFlag(oPC, FALSE);

    // Make them ignored by hostiles
    if (!GetLocalInt(oPC, HABD_OLD_FACTION_SET))
    {
        SetLocalInt(oPC, HABD_OLD_FACTION, GetStandardFactionReputation(STANDARD_FACTION_HOSTILE, oPC));
        SetLocalInt(oPC, HABD_OLD_FACTION_SET, 1);
    }
    SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 100, oPC);

    // Apply effects to make them a ghost.
    // Don't set the concealment too high just incase they find a way to abuse the system.
    effect eBad = EffectConcealment(1);
    eBad = EffectLinkEffects(EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR), eBad);
    eBad = EffectLinkEffects(EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE), eBad);
    if ( HABD_GHOST_EFFECTS_ON == TRUE)
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBad, oPC, GHOST_LOOP_TIMER+2.0f);
    //the ghost function reaplies the temporal effects (temporal to avoid logout
    // bugs)

    //Drop a corpse if needed, never when we apply respawn from persistence
    //do it before the guy is moved from the area where the loot bag was placed!
    if (HABD_DROP_CORPSE_ITEM == TRUE)
    if (GetLocalInt(oPC, HABD_PERSISTANT_REAPPLY) != 1 )
    {
        object oLootBag = SearchDeathBag(oPC);
        location lBag = GetLocation(oPC);
        //if death bag is found, use location of death bag placeable
        if (oLootBag!=OBJECT_INVALID)
            lBag = GetLocation(oLootBag);
        //we should create a corpse placeable if we dont
        //found the placeable! Otherwise the corpse will be created at PC location
        if (oLootBag==OBJECT_INVALID)
        {
            oLootBag = HABDCreateDeathBag(oPC);
            if (oLootBag!=OBJECT_INVALID)
                lBag = GetLocation(oLootBag);
        }
        object oICorpse = CreateCorpse(oPC, lBag, oLootBag);
    }

    //jump to waypoint when respawn.
    //dont jump when coming from logout or persistence
    if (GetLocalInt(oPC, HABD_PERSISTANT_REAPPLY) != 1 ||
        GetLocalInt(oPC, HABD_FORCEJUMPTORESPAWNPOINT) == 1)
    {
        //Dinamic config feature
        int irjold = -1;HABDRespawnTeleportNumber();
        int irjnew = -1;HABDDinamicRespawnTeleport(Dinamic, irjold);

        if (HABD_DINAMICRESPAWN1==0)
        {
        if (HABD_BINDSTONE_USEWHENRESPAWNED == TRUE )
            HABDJumpToBindStonePoint (oPC);
          else
              JumpToRespawnPoint (oPC);
        }
        else
        //Dinamic config feature
        {
            irjold = HABDRespawnTeleportNumber();
            irjnew = HABDDinamicRespawnTeleport(Dinamic, irjold);
            if (irjnew == 2)
                HABDJumpToBindStonePoint (oPC);
                else if (irjnew == 1)
                JumpToRespawnPoint (oPC);
        }
    }
    //See JumpToLocation Notes if you add code
    if ( GetLocalInt(oPC, HABD_FORCEJUMPTORESPAWNPOINT) == 1 )
        DeleteLocalInt(oPC, HABD_FORCEJUMPTORESPAWNPOINT);


    if (GetLocalInt(oPC, HABD_PERSISTANT_REAPPLY) == TRUE)
        DeleteLocalInt(oPC, HABD_PERSISTANT_REAPPLY);

    if(HABD_USERLANGUAGE==0)
      FloatingTextStringOnCreature("Server: You are a ghost. Do not interact with the other players.", oPC, FALSE);

    else if(HABD_USERLANGUAGE==1)
      FloatingTextStringOnCreature("Server: Eres un fantasma. Tu PJ no puede interactuar con otros jugadores.", oPC, FALSE);

    else if(HABD_USERLANGUAGE==2)
      FloatingTextStringOnCreature("Server: Du bist ein Geist. Du kannst mit anwesenden Spielern nicht agieren.", oPC, FALSE);

    //the delay is only needed to let the JumpToLocation work properly
    if ( HABD_GHOST_COMMANDABLE == FALSE)
    DelayCommand ( 0.001, SetCommandable(FALSE, oPC) );

    //It will check if the PC is jumping to another area, when the PC finish his
    //travel, a code for final instructions will be triggered. The function
    //executed will be 'safe', we'll be sure that the PC is not travelling to another
    //and the PC is not Commmandable
    if ( USE_RespawnFinished_Function == TRUE )
    DelayCommand ( 0.1, CheckGhostIsJumping(oPC) );

    //We are mostly sure the PC is Respawned, but see below

    //HardCore Respawn Feature, first check the function only if needed
    //Dinamic Respawn Feature..
    int iHardC = FALSE;
    int idr = -1;
    int AutoraiseHCOff = FALSE;
    if (HABD_DINAMICRESPAWN1!=0)
     {
        idr = HABDDinamicRespawnAutoRaise(Dinamic);
        if ( idr == 0 || idr ==1 )
        if ( HABD_HARDCORE_RESPAWN1 == TRUE)
            if ( HABDHardCoreRespawn(oPC)==TRUE )
                iHardC = TRUE;
     }
    else
        {
        if ( HABD_HARDCORE_RESPAWN1 == TRUE)
            if ( HABDHardCoreRespawn(oPC)==TRUE )
                iHardC = TRUE;
        }

    //Dinamic Respawn Feature, disallow Timer AutoRaise if needed.
    //HardCore Respawn Feature, disallow Timer AutoRaise if needed
    if (HABD_DINAMICRESPAWN1!=0)
        {
        if ( idr == 2)
            {
            if (GetIsPC(oPC) == TRUE && GetIsDMPossessed(oPC) == FALSE)
                DeleteLocalInt(GetModule(), HABD_RAISE_TIMER+sID);
            else
                DeleteLocalInt(oPC, HABD_RAISE_TIMER);
            AutoraiseHCOff = TRUE;
            }
        else
        if ( (iHardC == TRUE) && (idr == 0 || idr ==1) )
            {
            if (GetIsPC(oPC) == TRUE && GetIsDMPossessed(oPC) == FALSE)
                DeleteLocalInt(GetModule(), HABD_RAISE_TIMER+sID);
            else
                DeleteLocalInt(oPC, HABD_RAISE_TIMER);
            AutoraiseHCOff = TRUE;
            }
        }
    else
        if ( iHardC == TRUE)
            {
            if (GetIsPC(oPC) == TRUE && GetIsDMPossessed(oPC) == FALSE)
                DeleteLocalInt(GetModule(), HABD_RAISE_TIMER+sID);
            else
                DeleteLocalInt(oPC, HABD_RAISE_TIMER);
            AutoraiseHCOff = TRUE;
            }


    //HardCore feature message
    if (AutoraiseHCOff == TRUE){

        if(HABD_USERLANGUAGE==0)
          FloatingTextStringOnCreature("Server: AutoRaise disabled by HardCore rule. You can only be raised by other PCs or DMs.", oPC, FALSE);

        else if(HABD_USERLANGUAGE==1)
          FloatingTextStringOnCreature("Server: AutoResurrecion desactivada por reglas HardCore. Tan solo podras ser resucitado por otro PJ o un DM.", oPC, FALSE);

        else if(HABD_USERLANGUAGE==2)
          FloatingTextStringOnCreature("Server: Automatisches Wiederbeleben deaktiviert. Du kannst nur mit Hilfe eines Spielers oder SL's Wiederbelebt werden.", oPC, FALSE);

    }

    //Instantly Raises Respawned PC
    if (HABD_RESPAWN_IS_RAISE==TRUE)
        {
            if (HABD_DINAMICRESPAWN1==0)
                if (iHardC = FALSE)
                    {
                    HABDForceAutoRaise(oPC);
                    return;
                    }
            //Dinamic configs
            else
                if ( (iHardC == FALSE && idr <= 0 ) || idr == 3 )
                    HABDForceAutoRaise(oPC);
        }

    //We are 100% sure the PC is a ghost

    // Handle the auto-raise timer ONLY when coming from logout or persistence
    // otherwise AutoRaise & AutoRespawn are handled by OnPCDeath script..
    // Note, it doesnt work with Henchmans, I dont know if it was needed because
    // i cant test with henchmans.
    float fRespawn = 0.0;
    float fRaise = 0.0;
    if (GetIsPC(oPC) == TRUE && GetIsDMPossessed(oPC) == FALSE)
    {
        fRespawn = IntToFloat(GetLocalInt(oMod, HABD_RESPAWN_TIMER+sID));
        fRaise = IntToFloat(GetLocalInt(oMod, HABD_RAISE_TIMER+sID));
    }
    else
    {
        fRespawn = IntToFloat(GetLocalInt(oPC, HABD_RESPAWN_TIMER));
        fRaise = IntToFloat(GetLocalInt(oPC, HABD_RAISE_TIMER));
    }
        // Autoraise timers will use their persistent values.
        // Except if these values does not exist ;) because were deleted due to another autoraise
        if (GetIsPC(oPC) == TRUE && GetIsDMPossessed(oPC) == FALSE)
        {
        if ( GetLocalInt(oMod, HABD_RESPAWN_TIMER+sID) <= 0 )
            SetLocalInt(oMod, HABD_RESPAWN_TIMER+sID, FloatToInt(HABD_FORCE_RESPAWN_TIMER));
        if(AutoraiseHCOff == FALSE)
        {
         if ( GetLocalInt(oMod, HABD_RAISE_TIMER+sID) <= 0 )
         if ((HABD_SOLO_FORCE_RAISE_TIMER > 0.0) && (HABDPlayerIsSolo(oPC)==TRUE)  )
         {
             SetLocalInt(oMod, HABD_RAISE_TIMER+sID, FloatToInt(HABD_SOLO_FORCE_RAISE_TIMER));
         } else {
             SetLocalInt(oMod, HABD_RAISE_TIMER+sID, FloatToInt(HABD_FORCE_RAISE_TIMER));
                }
         }
        }
        else    //Henchmen
        {
        if ( GetLocalInt(oPC, HABD_RESPAWN_TIMER) <= 0 )
            SetLocalInt(oPC, HABD_RESPAWN_TIMER, FloatToInt(HABD_NPC_FORCE_RESPAWN_TIMER));
        if(AutoraiseHCOff == FALSE)
         if ( GetLocalInt(oPC, HABD_RAISE_TIMER) <= 0 )
             SetLocalInt(oPC, HABD_RAISE_TIMER, FloatToInt(HABD_NPC_FORCE_RAISE_TIMER));
        }
        //---

    //Autoraise OnEnter
    if (GetLocalInt(oPC, HABD_RESTORE_AUTO_RAISE) == 1   )
    {
        DeleteLocalInt(oPC, HABD_RESTORE_AUTO_RAISE);
        int iMakeAutoRaise = TRUE;
        if (fRaise > 0.0)
        {
            if (HABD_FORCE_RAISE_USES_SCROLLS)
            {
                if (HABDCheckForRaiseRezScrolls(oPC) <= 0)
                {

                    if(HABD_USERLANGUAGE==0)
                      FloatingTextStringOnCreature("Server: Out of scrolls. You have to wait for help.", oPC, FALSE);

                    else if(HABD_USERLANGUAGE==1)
                      FloatingTextStringOnCreature("Server: Sin pergaminos. Debes esperar a que llegue ayuda.", oPC, FALSE);

                    else if(HABD_USERLANGUAGE==2)
                      FloatingTextStringOnCreature("Server: Du hast keine nützlichen Spruchrollen bei Dir. Du musst auf Hilfe warten.", oPC, FALSE);

                    iMakeAutoRaise = FALSE;
                }
            }
            if (iMakeAutoRaise == TRUE)
            {
              //warn the player
              if(fRaise > 1.0)
              {

                if(HABD_USERLANGUAGE==0)
                  FloatingTextStringOnCreature("Server: "+GetName(oPC)+" will automatically raise in "+FloatToString(fRaise,4,1)+" seconds. AutoRaise for Respawned PC restored due to log-in, you wont receive further messages.", oPC, TRUE);

                else if(HABD_USERLANGUAGE==1)
                  FloatingTextStringOnCreature("Server: "+GetName(oPC)+" resucitara automaticamente en "+FloatToString(fRaise,4,1)+" segundos. AutoResurreccion para PJ Respawnado restaurada debido a que saliste y entraste del server, no recibiras mas mensajes.", oPC, TRUE);

                else if(HABD_USERLANGUAGE==2)
                  FloatingTextStringOnCreature("Server: "+GetName(oPC)+" Wird automatisch in "+FloatToString(fRaise,4,1)+" Sekunden wiederbelebt. Automatischer Wiedereinstieg durch Einloggen, Du erhälst keine weitere Nachrichten.", oPC, TRUE);

              }
              //AutoRaise
              //AssignCommand(oPC, DelayCommand(fRaise, HABDForceAutoRaise(oPC)));
                AssignCommand(oPC, DelayCommand(IntToFloat(HABD_AUTOTIMERS_UPDATE), HABDAutoRaiseTimerUpdater(oPC, FloatToInt(fRaise))));
            }
        }
    }
    //End of Autoraise restoration OnEnter

    //Save info to DB (and maybe export PC) to avoid server crash problems,
    //now that we are sure the PC is Respawned.
    if ( HABD_SMART_SAVETODB == TRUE )
        HABDSetDBString(oPC);
}

