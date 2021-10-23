/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name: n_tink_conv
*
* Purpose:  OnConversation script for the DM listener.  This is where all the
*           listening work is done.
*
* Created By: Mistress
* Created On: 3-22-07
*
* Modeled after and adapted from:
*   Sir Elric's Verbal Mob Spawner v1.1
*   http://nwvault.ign.com/View.php?view=Scripts.Detail&id=2686
*   Copyright (c) 2005 Melnibone Corp.
*
*   Beta Testers Toolkit v1.3 by DnC Team
*   http://nwvault.ign.com/View.php?view=Scripts.Detail&id=2673
*
*   CFBMoo1's DM Tools 2.0 by CFBMoo1
*   http://nwvault.ign.com/View.php?view=Scripts.Detail&id=2373
*
* Change Log:
* 3-22-07 Mistress
* - Began ripping apart and tailoring to our needs
* 3-28-07 Mistress
* - Made Nereng's suggested changes to GotoMap
* 3-29-07 Mistress
* - Added commands cleanup, wp, and leader
* 3-31-07 Mistress
* - Added fly away animation to "tink bye" command
* 4-1-07 Mistress
* - Added tink follow
* 4-4-07 Mistress
* - Altered follow code to be toggleable
* 4-11-07 Mistress
* - Added sTrueSaid for use with GotoMap and GotoWaypoint
* 4-12-07 Mistress
* - servermsg use sTrueSaid
* 2-3-08 Mistress
* - Minor adjustment in reporting the change in level when taking a level away
* 2-5-08 Mistress
* - Added AdvanceTimeByHour
* 3-4-08 Mistress
* - Added moving Tink to GotoPlayer, GotoMap, & GotoWaypoint
* 3-31-08 Mistress
* - Added where command
* - Re-issue the follow command to Tink to map, goto and wp commands
* 5-24-08 Mistress
* - Combined our library functions into a single file (l_tink_funcs) for the
*   Tink version to be posted on the vault.
* from 2020
* - added some new (immortal, weather) and expanded functions (map)
* - added the use of a speaking library, for easier translations
* - added the use of a prefix so the commands can't interfere with a chatting systtem
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
#include "l_tink_funcs"         // Access to the reusable scripts
#include "colors_inc"

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/*                          Object Creation Prototypes
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void CreateItem(object oDM, string sSaid);
void CreateMonster(object oDM, string sSaid);
void CreatePlaceable(object oDM, string sResRef);
string GetCreationConfirmationMsg(int nNumToMake, string sObjectName);


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/*                          Player Give and Take Prototypes
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void GiveGPToPlayer(object oDM, string sSaid);
void GiveLevelToPlayer(object oDM, string sTargetName);
void GiveXPToPlayer(object oDM, string sSaid);
void TakeLevelFromPlayer(object oDM, string sSaid);
void TakeGPFromPlayer(object oDM, string sSaid);
void TakeXPFromPlayer(object oDM, string sSaid);


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/*                          Player Transportation Prototypes
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void BringPlayer(object oDM, string sSaid);
void GotoPlayer(object oDM, string sSaid);


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/*                          Player Punishment Prototypes
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void BootPlayer(object oDM, string sTargetName);
void FreezePlayer(object oDM, string sTargetName);


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/*                          Misc Player Prototypes
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void ExaminePlayer(object oDM, string sTargetName);
void FullHealPlayer(object oDM, string sTargetName);
void GetPlayerEquipmentList(object oDM, string sTargetName);
void GetPlayerFeats(object oDM, string sTargetName);
void GetPlayerPs(object oDM, string sTargetName);
void GetPlayerSkills(object oDM, string sTargetName);
void HealPlayer(object oDM, string sTargetName);
void GetWherePlayer(object oDM, string sTargetName);
void SetImmortalPlayer(object oDM, string sTargetName);

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/*                          Transportation Prototypes
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void GotoMap(object oDM, string sSaid);
void GotoWaypoint(object oDM, string sSaid);


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/*                          Misc Prototypes
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void AdvanceTimeByHour(object oDM, string sSaid);
void ChangeWeather(object oDM, string sSaid);

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/*                          Support Prototypes
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void RemoveNegativeEffects(object oTarget);


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/*                          The Big Cheese Function
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void main()
{
    // Uses settings in n_tink_spwn script
    int nMatch = GetListenPatternNumber();
    int nDMCheck = TRUE, nCounciCheck = TRUE, nPos;

    // Who is talking
    object oDM = GetLastSpeaker();

    // What was said
    string sSaid;

    // Backup of what was said before making any adjustments to it.
    string sTrueSaid;

    if(nMatch == 3000 && GetIsObjectValid(oDM))
    {
        if (GetStringLeft(GetMatchedSubstring(0), 2) == TINK_BASE_PREFIX)
        {
            // If oDM isn't a DM or a Counci we are done
            if (!is_a_DM(oDM))                  nDMCheck = FALSE;

            if (!nDMCheck & !is_a_Counci(oDM))  nCounciCheck = FALSE;

            if (!nCounciCheck && !nDMCheck)
            {
                SendServerMessageToPC(oDM, TINK_SPEAK_NODM);
                return;
            }
            sSaid = UndoColoring(GetMatchedSubstring(0));
        }
        else
            return;
        // Save a copy of sSaid before converting to all lowercase.  GotoMap
        // and GotoWaypoint need this
        sTrueSaid = sSaid;

        // Make the string lowercase so it doesn't matter how the user types it in
        sSaid = GetStringLowerCase(sSaid);

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/*                          Tink Control    for Counci and DMs
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
        // Tell her to start listening for instructions
        if(sSaid == TINK_BASE_PREFIX+TINK_BASE_NAMES+TINK_BASE_START)
        {
            DeleteLocalInt(OBJECT_SELF, "VOICE_OFF");
            SendServerMessageToPC(oDM, TINK_SPEAK_REDY);
            return;
        }
        // Tell her to stop listening but do not destroy her
        else if(sSaid == TINK_BASE_PREFIX+TINK_BASE_NAMES+TINK_BASE_STOPS)
        {
            SendServerMessageToPC(oDM, TINK_SPEAK_IGNR);
            SetLocalInt(OBJECT_SELF, "VOICE_OFF", 1);
            return;
        }
        // Tell her we are done and she can go.
        else if(sSaid == TINK_BASE_PREFIX+TINK_BASE_NAMES+TINK_BASE_GOHOM)
        {
            SendServerMessageToPC(oDM, TINK_SPEAK_GOES);
            // fly away animation
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDisappear(), OBJECT_SELF);
            DelayCommand(1.0f, DestroyObject(OBJECT_SELF));
            return;
        }
        // Have her follow us
        else if(sSaid == TINK_BASE_PREFIX+TINK_BASE_NAMES+TINK_BASE_FOLLW)
        {
            // If she isn't following, follow
            if(FALSE == GetLocalInt(OBJECT_SELF, "TINK_IS_FOLLOWING"))
            {
                SendServerMessageToPC(oDM, TINK_SPEAK_FLW1);
                AssignCommand(OBJECT_SELF, ActionForceFollowObject(oDM, 0.75f));
                SetLocalInt(OBJECT_SELF, "TINK_IS_FOLLOWING", TRUE);
                return;
            }
            // Else stop following
            else
            {
                SendServerMessageToPC(oDM, TINK_SPEAK_FLW2);
                AssignCommand(OBJECT_SELF, ClearAllActions());
                SetLocalInt(OBJECT_SELF, "TINK_IS_FOLLOWING", FALSE);
                return;
            }
        }
        // Have her list out the commands - this will be visible to only users
        else if(sSaid == TINK_BASE_PREFIX+TINK_BASE_NAMES+TINK_BASE_HELPS)
        {
            // Send the right help msg's
            if(is_a_Counci(oDM))
              SendServerMessageToPC(oDM, TINK_VERSION+TINK_SPEAK_BASE+TINK_SPEAK_CCOM);
            else
              SendServerMessageToPC(oDM, TINK_VERSION+TINK_SPEAK_BASE+TINK_SPEAK_DMCM);
                
            return;
        }
        
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/*                          Object Creation
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
        // Create an item on the DM
        else if (GetSubString(sSaid, TBL, TCL(TINK_CMD_CREITM)) == TINK_CMD_CREITM)
        {
            if (is_a_Counci(oDM))                     // Stop if oDM is a Counci
              return;

            // Cut off the "item " part of sSaid
            nPos = TBL+TCL(TINK_CMD_CREITM)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            CreateItem(oDM, sNewSaid);
            return;
        }

        // Create a placeable next to the DM - No stack size on this one
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_CREPLC)) == TINK_CMD_CREPLC)
        {
            if (is_a_Counci(oDM))                     // Stop if oDM is a Counci
              return;

            // Cut off the "place " part of sSaid
            nPos = TBL+TCL(TINK_CMD_CREPLC)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            CreatePlaceable(oDM, sNewSaid);
            return;
        }

        // Spawn up a monster
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_CREMON)) == TINK_CMD_CREMON)
        {
            if (is_a_Counci(oDM))                     // Stop if oDM is a Counci
              return;

            // Cut off the "spawn " part of sSaid
            nPos = TBL+TCL(TINK_CMD_CREMON)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            CreateMonster(oDM, sNewSaid);
            return;
        }


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/*                          Transportation
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
        // Bring a player to your side
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_BRINGS)) == TINK_CMD_BRINGS)
        {
            // Cut off the "bring " part of sSaid
            nPos = TBL+TCL(TINK_CMD_BRINGS)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            BringPlayer(oDM, sNewSaid);
            return;
        }

        // Move yourself to a player
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_GOTOPL)) == TINK_CMD_GOTOPL)
        {
            // Cut off the "goto " part of sSaid
            nPos = TBL+TCL(TINK_CMD_GOTOPL)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            GotoPlayer(oDM, sNewSaid);
            return;
        }

        // Move yourself to a map using its tag or if using info, print list of maps+tags
        else if(GetSubString(sTrueSaid, TBL, TCL(TINK_CMD_MVTMAP)) == TINK_CMD_MVTMAP)
        {
            if (is_a_Counci(oDM))                     // Stop if oDM is a Counci
              return;

            // Cut off the "map " part of sSaid
            nPos = TBL+TCL(TINK_CMD_MVTMAP)+1;
            string sNewSaid = GetSubString(sTrueSaid, nPos, GetStringLength(sTrueSaid) - nPos);

            GotoMap(oDM, sNewSaid);
            return;
        }


        // Goto the first waypoint with the matching tag
        else if(GetSubString(sTrueSaid, TBL, TCL(TINK_CMD_MOVTWP)) == TINK_CMD_MOVTWP)
        {
            if (is_a_Counci(oDM))                     // Stop if oDM is a Counci
              return;

            // Cut off the "wp " part of sSaid
            nPos = TBL+TCL(TINK_CMD_MOVTWP)+1;
            string sNewSaid = GetSubString(sTrueSaid, nPos, GetStringLength(sTrueSaid) - nPos);

            GotoWaypoint(oDM, sNewSaid);
            return;
        }

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/*                          Give and Take
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
        // Give gold to player
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_GIVEGP)) == TINK_CMD_GIVEGP)
        {
            if (is_a_Counci(oDM))                     // Stop if oDM is a Counci
              return;

            // Cut off the "give gp " part of sSaid
            nPos = TBL+TCL(TINK_CMD_GIVEGP)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            GiveGPToPlayer(oDM, sNewSaid);
            return;
        }

        // Give enough XP for the player to reach the next level
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_GIVELV)) == TINK_CMD_GIVELV)
        {
            if (is_a_Counci(oDM))                     // Stop if oDM is a Counci
              return;

            // Cut off the "give level " part of sSaid
            nPos = TBL+TCL(TINK_CMD_GIVELV)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            GiveLevelToPlayer(oDM, sNewSaid);
            return;
        }

        // Give XP to player
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_GIVEXP)) == TINK_CMD_GIVEXP)
        {
            if (is_a_Counci(oDM))                     // Stop if oDM is a Counci
              return;

            // Cut off the "give xp " part of sSaid
            nPos = TBL+TCL(TINK_CMD_GIVEXP)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            GiveXPToPlayer(oDM, sNewSaid);
            return;
        }

        // Take gold from player
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_TAKEGP)) == TINK_CMD_TAKEGP)
        {
            if (is_a_Counci(oDM))                     // Stop if oDM is a Counci
              return;

            // Cut off the "take gp " part of sSaid
            nPos = TBL+TCL(TINK_CMD_TAKEGP)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            TakeGPFromPlayer(oDM, sNewSaid);
            return;
        }

        // Take level from player
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_TAKELV)) == TINK_CMD_TAKELV)
        {
            if (is_a_Counci(oDM))                     // Stop if oDM is a Counci
              return;

            // Cut off the "take level " part of sSaid
            nPos = TBL+TCL(TINK_CMD_TAKELV)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            TakeLevelFromPlayer(oDM, sNewSaid);
            return;
        }

        // Take XP from player
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_TAKEXP)) == TINK_CMD_TAKEXP)
        {
            if (is_a_Counci(oDM))                     // Stop if oDM is a Counci
              return;

            // Cut off the "take xp " part of sSaid
            nPos = TBL+TCL(TINK_CMD_TAKEXP)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            TakeXPFromPlayer(oDM, sNewSaid);
            return;
        }

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/*                          Player Punishment Prototypes
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
        // Boot a player from the server
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_BOOTPC)) == TINK_CMD_BOOTPC)
        {
            if (is_a_Counci(oDM))                     // Stop if oDM is a Counci
              return;

            // Cut off the "boot " part of sSaid
            nPos = TBL+TCL(TINK_CMD_BOOTPC)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            BootPlayer(oDM, sNewSaid);
            return;
        }

        // Freeze a player in place by setting them uncommandable
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_FREEZE)) == TINK_CMD_FREEZE)
        {
            if (is_a_Counci(oDM))                     // Stop if oDM is a Counci
              return;

            // Cut off the "freeze " part of sSaid
            nPos = TBL+TCL(TINK_CMD_FREEZE)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            FreezePlayer(oDM, sNewSaid);
            return;
        }

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/*                          Misc Player Functions
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
        // Examines player - gives lotsa info on them
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_EXAMIN)) == TINK_CMD_EXAMIN)
        {
            if (is_a_Counci(oDM))                     // Stop if oDM is a Counci
              return;

            // Cut off the "exa " part of sSaid
            nPos = TBL+TCL(TINK_CMD_EXAMIN)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            ExaminePlayer(oDM, sNewSaid);
            return;
        }

        // Displays the player's feats
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_FEATIN)) == TINK_CMD_FEATIN)
        {
            if (is_a_Counci(oDM))                     // Stop if oDM is a Counci
              return;

            // Cut off the "feats " part of sSaid
            nPos = TBL+TCL(TINK_CMD_FEATIN)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            GetPlayerFeats(oDM, sNewSaid);
            return;
        }

        // Displays the player's p's - gp and xp
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_GETHPS)) == TINK_CMD_GETHPS)
        {
            if (is_a_Counci(oDM))                     // Stop if oDM is a Counci
              return;

            // Cut off the "getps " part of sSaid
            nPos = TBL+TCL(TINK_CMD_GETHPS)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            GetPlayerPs(oDM, sNewSaid);
            return;
        }

        // Display a list of names of the player's equipped gear
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_EQUIPS)) == TINK_CMD_EQUIPS)
        {
            if (is_a_Counci(oDM))                     // Stop if oDM is a Counci
              return;

            // Cut off the "equips " part of sSaid
            nPos = TBL+TCL(TINK_CMD_EQUIPS)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            GetPlayerEquipmentList(oDM, sNewSaid);
            return;
        }

        // Combination of cure, heal, and res
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_FULHEA)) == TINK_CMD_FULHEA)
        {
            if (is_a_Counci(oDM))                     // Stop if oDM is a Counci
              return;

            // Cut off the "fullheal " part of sSaid
            nPos = TBL+TCL(TINK_CMD_FULHEA)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            FullHealPlayer(oDM, sNewSaid);
            return;
        }

        // Simply heals the player
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_HEALPC)) == TINK_CMD_HEALPC)
        {
            // Cut off the "heal " part of sSaid
            nPos = TBL+TCL(TINK_CMD_HEALPC)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            HealPlayer(oDM, sNewSaid);
            return;
        }

        // Sets the Target to Immortal (can't be killed and does not loose any hp)
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_SETIMO)) == TINK_CMD_SETIMO)
        {
            if (is_a_Counci(oDM))                     // Stop if oDM is a Counci
              return;

            // Cut off the "heal " part of sSaid
            nPos = TBL+TCL(TINK_CMD_SETIMO)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            SetImmortalPlayer(oDM, sNewSaid);
            return;
        }

        // Displays the player's skills
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_SKILLS)) == TINK_CMD_SKILLS)
        {
            if (is_a_Counci(oDM))                     // Stop if oDM is a Counci
              return;

            // Cut off the "skills " part of sSaid
            nPos = TBL+TCL(TINK_CMD_SKILLS)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            GetPlayerSkills(oDM, sNewSaid);
            return;
        }

        // Reports back the location of all players or a specific player
        else if(GetSubString(sTrueSaid, TBL, TCL(TINK_CMD_WHERES)) == TINK_CMD_WHERES)
        {
            // Cut off the "where" part of sSaid
            nPos = TBL+TCL(TINK_CMD_WHERES)+1;
            string sNewSaid = GetSubString(sTrueSaid, nPos, GetStringLength(sTrueSaid) - nPos);

            GetWherePlayer(oDM, sNewSaid);
            return;
        }

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
/*                          Misc DM Functions
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
        // Advance time in hours
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_STHOUR)) == TINK_CMD_STHOUR)
        {
            if (is_a_Counci(oDM))                     // Stop if oDM is a Counci
              return;
              
            // Cut off the "hour " part of sSaid
            nPos = TBL+TCL(TINK_CMD_STHOUR)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            AdvanceTimeByHour(oDM, sNewSaid);
            return;
        }

        // Change the weather in single/all area/s
        else if(GetSubString(sSaid, TBL, TCL(TINK_CMD_CNGWEA)) == TINK_CMD_CNGWEA)
        {
            // Cut off the "weather " part of sSaid
            nPos = TBL+TCL(TINK_CMD_CNGWEA)+1;
            string sNewSaid = GetSubString(sSaid, nPos, GetStringLength(sSaid) - nPos);

            ChangeWeather(oDM, sNewSaid);
            return;
        }
        
        else
            SendServerMessageToPC(oDM, TINK_CMD_BASER0);
    } // if(nMatch == 3000 && GetIsObjectValid(oDM))
}


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* File Name:  CreateItem
*
* Purpose:  Creates XX number if items of the specified resref.  Identifies
*           the items if needed.  Requires the item's exact resref.
*
* DESIGN NOTE:  This will not always make the requested number of items.  It is
*               limited to the max stack size specified in the baseitems 2da
*               file.  For example, equipped gear will make a max stack size
*               of one since they do not stack.  Arrows can make a stack size
*               of 99.
*
* Created By: Mistress
* Created On: 3-22-07
*
* Modeled after and adapted from:
*   Sir Elric's Verbal Mob Spawner v1.1
*   http://nwvault.ign.com/View.php?view=Scripts.Detail&id=2686
*   Copyright (c) 2005 Melnibone Corp.
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void CreateItem(object oDM, string sSaid)
{
    // Built in help
    if("" == sSaid)
    {
        SendServerMessageToPC(oDM, TINK_CMD_ITMSY1+TINK_CMD_ITMSY2);
        return;
    }

    // Crop off the last 3 characters to isolate the resref
    string sResRef = GetStringLeft(sSaid, GetStringLength(sSaid) - 3);

    // Crop the last 2 characters to get the number of items to create
    string sNumToMake = GetStringRight(sSaid, 2);

    // Convert the string version of the number into an integer
    int nNumToMake = StringToInt(sNumToMake);

    // The item we are making
    object oItem;

    // Create the requested number of items
    oItem = CreateItemOnObject(sResRef, oDM, nNumToMake);
    if(FALSE == GetIsObjectValid(oItem))
    {
        SendServerMessageToPC(oDM, TINK_CMD_CREER1 + sResRef + TINK_CMD_CREER2+TINK_CMD_ITMSY1);
        return;
    }

    // Set the items we just made to identified
    SetIdentified(oItem, TRUE);

    // Generate the feedback message
    string sFeedbackMsg = GetCreationConfirmationMsg(GetItemStackSize(oItem), GetName(oItem));
    if("ERROR" == sFeedbackMsg)
      sFeedbackMsg = TINK_CMD_CREER3;

    SendServerMessageToPC(oDM, sFeedbackMsg);
} // void CreateItem(object oDM, string sSaid)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* File Name:  CreateMonster
*
* Purpose:  Creates XX number if monsters at your location.  Requires monster's
*           exact resref.
*
* Created By: Mistress
* Created On: 3-22-07
*
* Modeled after and adapted from:
*   Sir Elric's Verbal Mob Spawner v1.1
*   http://nwvault.ign.com/View.php?view=Scripts.Detail&id=2686
*   Copyright (c) 2005 Melnibone Corp.
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void CreateMonster(object oDM, string sSaid)
{
    // Built in help
    if("" == sSaid)
    {
        SendServerMessageToPC(oDM, TINK_CMD_MONSY1+TINK_CMD_MONSY2);
        return;
    }

    // Crop off the last 3 characters to isolate the resref
    string sResRef = GetStringLeft(sSaid, GetStringLength(sSaid) - 3);

    // Crop the last 2 characters to get the number of mobs to spawn
    string sNumToMake = GetStringRight(sSaid, 2);

    // Convert the string version of the number into an integer
    int nNumToMake = StringToInt(sNumToMake);

    // The monster we are making
    object oMob;

    // Create the requested number of creatures
    int i = 0;
    for(i = 0; i < nNumToMake; i++)
    {
        oMob = CreateObject(OBJECT_TYPE_CREATURE, sResRef, GetLocation(oDM));
        if(FALSE == GetIsObjectValid(oMob))
        {
            SendServerMessageToPC(oDM, TINK_CMD_CREER1 + sResRef + TINK_CMD_CREER2+TINK_CMD_MONSY1);
            return;
        }
    } // for(i = 0; i < nNumToMake; i++)

    // Generate the feedback message - Use the actual stack size here not what was
    // requested.
    string sFeedbackMsg = GetCreationConfirmationMsg(nNumToMake, GetName(oMob));
    if("ERROR" == sFeedbackMsg)
      sFeedbackMsg = TINK_CMD_CREER3;

    SendServerMessageToPC(oDM, sFeedbackMsg);
}  // void CreateMonster(object oDM, string sSaid)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* File Name:  CreatePlaceable
*
* Purpose:  Create the requested placeable.  No stack size.  Uses oDM's
*           position and facing when creating the placeable.  Requires
*           placeable's exact resref.
*
* Created By: Mistress
* Created On: 3-23-07
*
* Modeled after and adapted from:
*   Sir Elric's Verbal Mob Spawner v1.1
*   http://nwvault.ign.com/View.php?view=Scripts.Detail&id=2686
*   Copyright (c) 2005 Melnibone Corp.
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void CreatePlaceable(object oDM, string sResRef)
{
    // Built in help
    if("" == sResRef)
    {
        SendServerMessageToPC(oDM, TINK_CMD_PLCSY1+TINK_CMD_PLCSY2);
        return;
    }

    // The placeable we are making
    object oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, GetLocation(oDM));
    if(FALSE == GetIsObjectValid(oPlaceable))
    {
        SendServerMessageToPC(oDM, TINK_CMD_CREER1 + sResRef + TINK_CMD_CREER2+TINK_CMD_PLCSY1);
        return;
    }

    // Generate the feedback message
    string sFeedbackMsg = GetCreationConfirmationMsg(1, GetName(oPlaceable));
    if("ERROR" == sFeedbackMsg)
    {
        sFeedbackMsg = TINK_CMD_CREER3;
    }

    SendServerMessageToPC(oDM, sFeedbackMsg);
}  // void CreatePlaceable(object oDM, string sSaid)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  GetCreationConfirmationMsg
*
* Purpose:  Generates feedback message that the requested object(s) have been
*           created.
*
* Created By: Mistress
* Created On: 2-23-07
*
* Modeled after and adapted from:
*   Sir Elric's Verbal Mob Spawner v1.1
*   http://nwvault.ign.com/View.php?view=Scripts.Detail&id=2686
*   Copyright (c) 2005 Melnibone Corp.
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
string GetCreationConfirmationMsg(int nNumToMake, string sObjectName)
{
    string sConfirmMsg = "";

    // Generate a feedback message that the requested monster(s) have been created.
    switch(nNumToMake)
    {
        // Problem!  Something went wrong - return ERROR so a custom message
        // can be generated at the calling function
        case 0:
            sConfirmMsg = "Fehler";
            break;

        case 1:
            sConfirmMsg = "DM erschuf:  " + IntToString(nNumToMake) + " " + sObjectName + ".";
            break;

        default:
            sConfirmMsg = "DM erschuf:  " + IntToString(nNumToMake) + " " + sObjectName + "s.";
            break;
    } // switch(nNumToMake)

    return sConfirmMsg;
}  // string GetCreationConfirmationMsg(int nNumToMake, string sObjectName)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  GiveGPToPlayer
*
* Purpose:  Give specified amount of gold to the target player no matter what
*           map they are on.
*
* Created By: Mistress
* Created On: 3-23-07
*
* Modeled after and adapted from:
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void GiveGPToPlayer(object oDM, string sSaid)
{
    // Built in help
    if("" == sSaid)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GGOSY1+TINK_CMD_GGOSY2);
        return;
    }

    // Find the space between the amount of gold to give and the player name
    int nSpaceIndex = FindSubString(sSaid, " ");

    // Crop the amount off the front
    string sAmount = GetStringLeft(sSaid, nSpaceIndex);

    if(sAmount == "")
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER4);
        return;
    }

    int nAmount = StringToInt(sAmount);

    // Crop the player name off the back
    string sTargetName = GetStringRight(sSaid, GetStringLength(sSaid) - (nSpaceIndex + 1));

    // First see if we can find the player
    object oTarget = GetPlayerByName(sTargetName);
    if(OBJECT_INVALID == oTarget)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER1 + sTargetName + TINK_CMD_GIVER2);
        return;
    }

    // Only Players get gold
    if(FALSE == GetIsPC(oTarget))
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER3);
        return;
    }

    // Give them the gold
    GiveGoldToCreature(oTarget, nAmount);

    // Notify the DM
    SendServerMessageToPC(oDM, TINK_CMD_BASNT1 + IntToString(nAmount) +
                               TINK_CMD_GGONT2 + sTargetName +
                               TINK_CMD_BASNT3 + IntToString(GetGold(oTarget)) +
                               TINK_CMD_BASNT4);
}  // void GiveGPToPlayer(object oDM, string sSaid)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  GiveLevelToPlayer
*
* Purpose:  Give the player enough XP to level ONE level.
*
* Created By: Mistress
* Created On: 3-24-07
*
* Modeled after and adapted from:
*   Beta Testers Toolkit v1.3 by DnC Team
*   http://nwvault.ign.com/View.php?view=Scripts.Detail&id=2673
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void GiveLevelToPlayer(object oDM, string sTargetName)
{
    // Built in help
    if("" == sTargetName)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GLVSY1+TINK_CMD_GLVSY2);
        return;
    }

    // First see if we can find the player
    object oTarget = GetPlayerByName(sTargetName);
    if(OBJECT_INVALID == oTarget)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER1 + sTargetName + TINK_CMD_GIVER2);
        return;
    }

    // Only Players get gold
    if(FALSE == GetIsPC(oTarget))
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER3);

        return;
    }

    // What is their current level?
    int nCurrentLevel = GetHitDice(oTarget);

    // Give them the XP
    SetXPImproved(oTarget, nCurrentLevel * (nCurrentLevel + 1) * 500);
    //SetXP(oTarget, nCurrentLevel * (nCurrentLevel + 1) * 500);

    // Notify the DM
    SendServerMessageToPC(oDM, TINK_CMD_BASNT1+TINK_CMD_GLVNT1 + GetName(oTarget) + 
                               TINK_CMD_GLVNT2 + IntToString(nCurrentLevel) +
                               TINK_CMD_GLVNT3 + IntToString(nCurrentLevel + 1) +
                               TINK_CMD_GLVNT4);
}  // void GiveLevelToPlayer(object oDM, string sTargetName)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  GiveXPToPlayer
*
* Purpose:  Give specified amount of XP to the target player no matter what
*           map they are on.
*
* Created By: Mistress
* Created On: 3-23-07
*
* Modeled after and adapted from:
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void GiveXPToPlayer(object oDM, string sSaid)
{
    // Built in help
    if("" == sSaid)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GXPSY1+TINK_CMD_GXPSY2);
        return;
    }

    // Find the space between the amount of XP to give and the player name
    int nSpaceIndex = FindSubString(sSaid, " ");

    // Crop the amount off the front
    string sAmount = GetStringLeft(sSaid, nSpaceIndex);

    if(sAmount == "")
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER4);
        return;
    }

    int nAmount = StringToInt(sAmount);

    // Crop the player name off the back
    string sTargetName = GetStringRight(sSaid, GetStringLength(sSaid) - (nSpaceIndex + 1));

    // First see if we can find the player
    object oTarget = GetPlayerByName(sTargetName);
    if(OBJECT_INVALID == oTarget)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER1 + sTargetName + TINK_CMD_GIVER2);
        return;
    }

    // Only Players get XP.
    if(FALSE == GetIsPC(oTarget))
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER3);
        return;
    }

    // Give them the XP
    //GiveXPToCreature(oTarget, nAmount);
    SetXPImproved(oTarget, GetXP(oTarget)+nAmount);

    // Notify the DM
    SendServerMessageToPC(oDM, TINK_CMD_BASNT1 + sTargetName +
                               TINK_CMD_GXPNT2 + IntToString(nAmount) +
                               TINK_CMD_BASNT3 + IntToString(GetXP(oTarget)) +
                               TINK_CMD_BASNT5);
}  // void GiveXPToPlayer(object oDM, string sSaid)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  TakeGPFromPlayer
*
* Purpose:  Take specified amount of gold to the target player no matter what
*           map they are on.
*
* Created By: Mistress
* Created On: 3-23-07
*
* Modeled after and adapted from:
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void TakeGPFromPlayer(object oDM, string sSaid)
{
    // Built in help
    if("" == sSaid)
    {
        SendServerMessageToPC(oDM, TINK_CMD_TGOSY1 + TINK_CMD_TGOSY2);
        return;
    }

    // Find the space between the amount of gold to give and the player name
    int nSpaceIndex = FindSubString(sSaid, " ");

    // Crop the amount off the front
    string sAmount = GetStringLeft(sSaid, nSpaceIndex);

    if(sAmount == "")
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER4);
        return;
    }

    int nAmount = StringToInt(sAmount);

    // Crop the player name off the back
    string sTargetName = GetStringRight(sSaid, GetStringLength(sSaid) - (nSpaceIndex + 1));

    // First see if we can find the player
    object oTarget = GetPlayerByName(sTargetName);
    if(OBJECT_INVALID == oTarget)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER1 + sTargetName + TINK_CMD_GIVER2);
        return;
    }

    // Only Players
    if(FALSE == GetIsPC(oTarget))
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER3);
        return;
    }

    // How much gold do they currently have?
    int nCurrentGold = GetGold(oTarget);

    // Can't take more than they have
    if(nAmount > nCurrentGold)
    {   nAmount = nCurrentGold;     }

    // if they have nothing - then we can't take anything can we?
    if(0 == nAmount)
    {
        SendServerMessageToPC(oDM, TINK_CMD_BASNT0 + GetName(oTarget) + TINK_CMD_TAKER1);
        return;
    }

    // Take the gold and destroy it
    TakeGoldFromCreature(nAmount, oTarget, TRUE);

    // Notify the DM
    SendServerMessageToPC(oDM, TINK_CMD_BASNT2 + IntToString(nAmount) +
                               TINK_CMD_TGONT1 + GetName(oTarget) + 
                               TINK_CMD_BASNT3 + IntToString(GetGold(oTarget)) + 
                               TINK_CMD_BASNT4);
}  // void TakeGPFromPlayer(object oDM, string sSaid)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  TakeLevelFromPlayer
*
* Purpose:  Take specified enough XP from the target player to drop them down
*           one level.  Does not matter what map they are on.
*
* Created By: Mistress
* Created On: 3-26-07
*
* Modeled after and adapted from:
*
* Change Log:
* 2-3-08 Mistress
* - Minor adjustment in reporting the change in level
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void TakeLevelFromPlayer(object oDM, string sTargetName)
{
    // Built in help
    if("" == sTargetName)
    {
        SendServerMessageToPC(oDM, TINK_CMD_TLVSY1 + TINK_CMD_TLVSY2);
        return;
    }

    // First see if we can find the player
    object oTarget = GetPlayerByName(sTargetName);
    if(OBJECT_INVALID == oTarget)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER1 + sTargetName + TINK_CMD_GIVER2);
        return;
    }

    // Only Players
    if(FALSE == GetIsPC(oTarget))
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER3);
        return;
    }

    // if they are already level one - then we can't take anything can we?
    if(1 == GetHitDice(oTarget))
    {
        SendServerMessageToPC(oDM, TINK_CMD_BASNT0 + GetName(oTarget) + TINK_CMD_TAKER2);
        return;
    }

    // Little bit of a light show
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE), oTarget);

    int nXP = GetXP(oTarget);
    int nHD = GetHitDice(oTarget) - 1;
    int nMin = ((nHD * (nHD - 1)) / 2) * 1000;
    SetXPImproved(oTarget, nMin);
    //SetXP(oTarget, nMin);

    FloatingTextStringOnCreature(TINK_CMD_TLVNT1, oTarget, FALSE);

    // Notify the DM
    SendServerMessageToPC(oDM, TINK_CMD_BASNT2+TINK_CMD_TLVNT2 + sTargetName +
                               TINK_CMD_TLVNT3 + IntToString(nHD + 1) +
                               TINK_CMD_TLVNT4 + IntToString(nHD) + 
                               TINK_CMD_TLVNT5);
}  // void TakeLevelFromPlayer(object oDM, string sSaid)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  TakeXPFromPlayer
*
* Purpose:  Take specified amount of XP to the target player no matter what
*           map they are on.
*
* Created By: Mistress
* Created On: 3-23-07
*
* Modeled after and adapted from:
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void TakeXPFromPlayer(object oDM, string sSaid)
{
    // Built in help
    if("" == sSaid)
    {
        SendServerMessageToPC(oDM, TINK_CMD_TXPSY1 + TINK_CMD_TXPSY2);
        return;
    }

    // Find the space between the amount of XP to give and the player name
    int nSpaceIndex = FindSubString(sSaid, " ");

    // Crop the amount off the front
    string sAmount = GetStringLeft(sSaid, nSpaceIndex);

    if(sAmount == "")
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER4);
        return;
    }

    int nAmount = StringToInt(sAmount);

    // Crop the player name off the back
    string sTargetName = GetStringRight(sSaid, GetStringLength(sSaid) - (nSpaceIndex + 1));

    // First see if we can find the player
    object oTarget = GetPlayerByName(sTargetName);
    if(OBJECT_INVALID == oTarget)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER1 + sTargetName + TINK_CMD_GIVER2);
        return;
    }

    // Only Players
    if(FALSE == GetIsPC(oTarget))
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER3);
        return;
    }

    // How many do they have?
    int nCurrXP = GetXP(oTarget);

    // Can't take more than they have
    if(nAmount > nCurrXP)
    {   nAmount = nCurrXP;     }

    // if they have nothing - then we can't take anything can we?
    if(0 == nAmount)
    {
        SendServerMessageToPC(oDM, TINK_CMD_BASNT0 + GetName(oTarget) + TINK_CMD_TAKER3);
        return;
    }

    // Notify the DM
    SendServerMessageToPC(oDM, TINK_CMD_BASNT2 + IntToString(nAmount) +
                               TINK_CMD_TXPNT1 + sTargetName +
                               TINK_CMD_BASNT3 + IntToString(nCurrXP - nAmount) +
                               TINK_CMD_BASNT5);

    nAmount = nCurrXP - nAmount;

    // Take the XP
    SetXPImproved(oTarget, nAmount);
    //SetXP(oTarget, nAmount);
}  // void TakeXPFromPlayer(object oDM, string sSaid)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  BringPlayer
*
* Purpose:  Find the player and move them to the DM's side.
*
* Created By: Mistress
* Created On: 3-24-07
*
* Modeled after and adapted from:
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void BringPlayer(object oDM, string sTargetName)
{
    // Built in help
    if("" == sTargetName)
    {
        SendServerMessageToPC(oDM, TINK_CMD_BRPSY1 + TINK_CMD_BRPSY2);
        return;
    }

    // First see if we can find the player
    object oTarget = GetPlayerByName(sTargetName);
    if(OBJECT_INVALID == oTarget)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER1 + sTargetName + TINK_CMD_GIVER2);
        return;
    }

    // Only Players
    if(FALSE == GetIsPC(oTarget))
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER3);
        return;
    }

    // Warn the player they are being pulled
    SendServerMessageToPC(oTarget, TINK_CMD_BRPNT1);
    AssignCommand(oTarget, SpeakString(TINK_CMD_BRPNT2));

    // special effect to hide the move
    effect eSmoke = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSmoke, oTarget);

    // sass em a bit
    AssignCommand(oDM, SpeakString(GetName(oTarget) + TINK_CMD_BRPNT3));

    // where they are going
    location lDest = GetLocation(oDM);

    // Move them
    AssignCommand(oTarget, ActionJumpToLocation(lDest));

    // More smoke to hide them popping up
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSmoke, lDest);
} // void BringPlayer(object oDM, string sSaid)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  GotoPlayer
*
* Purpose:  Find the player and move the DM to the player's side
*
* Created By: Mistress
* Created On: 3-24-07
*
* Modeled after and adapted from:
*
* Change Log:
* 3-4-08 Mistress
* - Added moving Tink
* 3-31-08 Mistress
* - Re-issue the follow command to Tink
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void GotoPlayer(object oDM, string sTargetName)
{
    // Built in help
    if("" == sTargetName)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GTPSY1 + TINK_CMD_GTPSY2);
        return;
    }

    // First see if we can find the player
    object oTarget = GetPlayerByName(sTargetName);
    if(OBJECT_INVALID == oTarget)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER1 + sTargetName + TINK_CMD_GIVER2);
        return;
    }

    // Only Players
    if(FALSE == GetIsPC(oTarget))
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER3);
        return;
    }

    // Warn the people around the DM that they are leaving
    AssignCommand(oDM, SpeakString(TINK_CMD_BRPNT2));

    // special effect to hide the move
    effect eSmoke = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSmoke, oDM);

    // where they are going
    location lDest = GetLocation(oTarget);

    // Move them
    AssignCommand(oDM, ActionJumpToLocation(lDest));

    // More smoke to hide them popping up
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSmoke, lDest);

    // Move Tink and re-issue follow command
    AssignCommand(OBJECT_SELF, ClearAllActions());
    AssignCommand(OBJECT_SELF, ActionJumpToLocation(lDest));
    AssignCommand(OBJECT_SELF, ActionForceFollowObject(oDM, 0.75f));
}  // void GotoPlayer(object oDM, string sTargetName)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  BootPlayer
*
* Purpose:  Boot a player from the server
*
* Created By: Mistress
* Created On: 3-27-07
*
* Modeled after and adapted from:
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void BootPlayer(object oDM, string sTargetName)
{
    // Built in help
    if("" == sTargetName)
    {
        SendServerMessageToPC(oDM, TINK_CMD_BTPSY1 + TINK_CMD_BTPSY2);
        return;
    }

    // First see if we can find the player
    object oTarget = GetPlayerByName(sTargetName);
    if(OBJECT_INVALID == oTarget)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER1 + sTargetName + TINK_CMD_GIVER2);
        return;
    }

    // Only Players
    if(FALSE == GetIsPC(oTarget))
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER3);
        return;
    }

    // No booting a DM
    if(TRUE == is_a_DM(oTarget))
    {
        SendServerMessageToPC(oDM, TINK_CMD_BTPNT1);
        SendServerMessageToPC(oTarget, TINK_CMD_BTPNT2 + GetName(oDM) + TINK_CMD_BTPNT3);
        return;
    }

    // Save the player file
    ExportSingleCharacter(oTarget);

    // Add a message to the log file
    WriteTimestampedLogEntry(GetName(oDM) + TINK_CMD_BTPNT4 + GetName(oTarget) + TINK_CMD_BTPNT5);
    SendServerMessageToPC(oDM, GetName(oTarget) + TINK_CMD_BTPNT6);

    // Send a message to the player
    SendServerMessageToPC(oTarget, TINK_CMD_BTPNT7);

    // Wait a few seconds to give the player time to read the message then boot them.
    DelayCommand(6.0, BootPC(oTarget));
}  // void BootPlayer(object oDM, string sTargetName)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  FreezePlayer
*
* Purpose:  Toggles a player's commandable flag.
*
* Created By: Mistress
* Created On: 3-24-07
*
* Modeled after and adapted from:
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void FreezePlayer(object oDM, string sTargetName)
{
    // Built in help
    if("" == sTargetName)
    {
        SendServerMessageToPC(oDM, TINK_CMD_FZPSY1 + TINK_CMD_FZPSY2);
        return;
    }

    // First see if we can find the player
    object oTarget = GetPlayerByName(sTargetName);
    if(OBJECT_INVALID == oTarget)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER1 + sTargetName + TINK_CMD_GIVER2);
        return;
    }

    // Only Players
    if(FALSE == GetIsPC(oTarget))
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER3);
        return;
    }

    // TRUE = Not frozen
    // FALSE = Frozen

    // If it is on, turn it off
    if(TRUE == GetCommandable(oTarget))
    {
        // Visual effect - blue lights
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_IMP_FROST_L), oTarget, 1.0f);

        // clear their action queue
        AssignCommand(oTarget, ClearAllActions());

        // Freeze them
        SetCommandable(FALSE, oTarget);

        // Notify oTarget
        SendServerMessageToPC(oTarget, TINK_CMD_FZPNT1);

        // Confirm with the DM
        SendServerMessageToPC(oDM, TINK_CMD_BASNT0 + GetName(oTarget) + TINK_CMD_FZPNT2);
    }
    else
    {
        // Visual effect - dispel
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_IMP_BREACH), oTarget, 1.0f);

        // clear their action queue
        AssignCommand(oTarget, ClearAllActions());

        // unFreeze them
        SetCommandable(TRUE, oTarget);

        // Notify oTarget
        SendServerMessageToPC(oTarget, TINK_CMD_FZPNT3);

        // Confirm with the DM
        SendServerMessageToPC(oDM, TINK_CMD_BASNT0 + GetName(oTarget) + TINK_CMD_FZPNT4);
    }
}// void FreezePlayer(object oDM, string sTargetName)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  GetPlayerEquipmentList
*
* Purpose:  Displays a list of the player's equipped gear and how much it is all
*           worth.
*
* Created By: Mistress
* Created On: 3-27-07
*
* Modeled after and adapted from:
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void GetPlayerEquipmentList(object oDM, string sTargetName)
{
    // Built in help
    if("" == sTargetName)
    {
        SendServerMessageToPC(oDM, TINK_CMD_EQUSY1 + TINK_CMD_EQUSY2);
        return;
    }

    // First see if we can find the player
    object oTarget = GetPlayerByName(sTargetName);
    if(OBJECT_INVALID == oTarget)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER1 + sTargetName + TINK_CMD_GIVER2);
        return;
    }

    // Only Players
    if(FALSE == GetIsPC(oTarget))
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER3);
        return;
    }

    // Running list of the gear
    string sGear = "";

    // Running total of the value of the gear
    int nGearValue = 0;

    // Current equipped item being looked at
    object oGear;

    // Cycle throught the equipment slots
    int iSlotNum = 0;
    for(iSlotNum = 0; iSlotNum < 14; iSlotNum++)
    {
        oGear = GetItemInSlot(iSlotNum, oTarget);
        if(OBJECT_INVALID != oGear)
        {
            sGear = sGear + "   " + GetName(oGear) + "  (" + IntToString(GetGoldPieceValue(oGear)) + " GM)\n";

            nGearValue = nGearValue + GetGoldPieceValue(oGear);
        }
    }

    SendServerMessageToPC(oDM, TINK_CMD_BASNT0 + GetName(oTarget) + " trägt:\n" + sGear);
    SendServerMessageToPC(oDM, "   insg. Wert:  " + IntToString(nGearValue));
} // void GetPlayerEquipmentList(object oDM, string sTargetName)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  ExaminePlayer
*
* Purpose:  Examine player
*
* Created By: Mistress
* Created On: 3-23-07
*
* Modeled after and adapted from:
*   CFBMoo1's DM Tools 2.0 by CFBMoo1
*   http://nwvault.ign.com/View.php?view=Scripts.Detail&id=2373
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void ExaminePlayer(object oDM, string sTargetName)
{
    // Built in help
    if("" == sTargetName)
    {
        SendServerMessageToPC(oDM, TINK_CMD_EXASY1 + TINK_CMD_EXASY2);
        return;
    }

    // First see if we can find the player
    object oTarget = GetPlayerByName(sTargetName);
    if(OBJECT_INVALID == oTarget)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER1 + sTargetName + TINK_CMD_GIVER2);
        return;
    }

    // Only Players
    if(FALSE == GetIsPC(oTarget))
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER3);
        return;
    }

    string sTemp = "";
    // Build the character sheet
    string sCS = TINK_SPACERS+
                 "Character:  " + GetName(oTarget) + "\n" +
                 "Account:  " + GetPCPlayerName(oTarget) + "\n" +
                 "Public CDKey:  " + GetPCPublicCDKey(oTarget) + "\n" +
                 "IP Address:  " + GetPCIPAddress(oTarget) + "\n" +
                 TINK_SPACERS+
                 "Map:  " + GetName(GetArea(oTarget)) + "\n" +
                 "Age: " + IntToString(GetAge(oTarget)) + "\n" +
                 "Deity:  ";
                 if   ("" != GetDeity(oTarget))   sCS = sCS + GetDeity(oTarget) + "\n";
                 else                             sCS = sCS + "None\n";

                 sCS = sCS + "Race:  " + GetRaceName(GetRacialType(oTarget)) + "\n" +
                 "Weight:  " + IntToString(GetWeight(oTarget)/10) + "\n" +
                 TINK_SPACERS+
                 "Class 1:  " + GetClassName(GetClassByPosition(1, oTarget)) + " (" +
                 IntToString(GetLevelByPosition(1, oTarget)) + ")\n";

                 sTemp = GetClassName(GetClassByPosition(2, oTarget));
                 if("Keine" != sTemp)
                 {
                     sCS = sCS + "Class 2:  " + GetClassName(GetClassByPosition(2, oTarget)) + " (" +
                     IntToString(GetLevelByPosition(2, oTarget)) + ")\n";
                 }

                 sTemp = GetClassName(GetClassByPosition(3, oTarget));
                 if("Keine" != sTemp)
                 {
                     sCS = sCS + "Class 3:  " + GetClassName(GetClassByPosition(3, oTarget)) + " (" +
                     IntToString(GetLevelByPosition(3, oTarget)) + ")\n";
                 }

                 sCS = sCS + TINK_SPACERS +
                 "AC:  " + IntToString(GetAC(oTarget)) + "\n"+
                 "HP:  " + IntToString(GetCurrentHitPoints(oTarget)) + " / " +
                    IntToString(GetMaxHitPoints(oTarget)) +"\n"+
                 "Alignment:  " + GetAlignment(oTarget) + "\n"+
                 "BAB:  " + IntToString(GetBaseAttackBonus(oTarget)) + "\n"+
                 "Resistance:  " + IntToString(GetSpellResistance(oTarget)) + "\n" +
                 "Spell failure:  " + IntToString(GetArcaneSpellFailure(oTarget)) + "\n" +
                 TINK_SPACERS+

                 "Fort:  " + IntToString(GetFortitudeSavingThrow(oTarget)) + "\n" +
                 "Refl:  " + IntToString(GetReflexSavingThrow(oTarget)) + "\n" +
                 "Will:  " + IntToString(GetWillSavingThrow(oTarget)) + "\n" +
                 TINK_SPACERS+
                 
                 "STR:  " + IntToString(GetAbilityScore(oTarget, ABILITY_STRENGTH)) + "  (+" + IntToString(GetAbilityModifier(ABILITY_STRENGTH, oTarget)) + ")\n"+
                 "DEX:  " + IntToString(GetAbilityScore(oTarget, ABILITY_DEXTERITY)) + "  (+" + IntToString(GetAbilityModifier(ABILITY_DEXTERITY, oTarget)) + ")\n"+
                 "CON:  " + IntToString(GetAbilityScore(oTarget, ABILITY_CONSTITUTION)) + "  (+" + IntToString(GetAbilityModifier(ABILITY_CONSTITUTION, oTarget)) + ")\n"+
                 "INT:  " + IntToString(GetAbilityScore(oTarget, ABILITY_INTELLIGENCE)) + "  (+" + IntToString(GetAbilityModifier(ABILITY_INTELLIGENCE, oTarget)) + ")\n"+
                 "WIS:  " + IntToString(GetAbilityScore(oTarget, ABILITY_WISDOM)) + "  (+" + IntToString(GetAbilityModifier(ABILITY_WISDOM, oTarget)) + ")\n"+
                 "CHA:  " + IntToString(GetAbilityScore(oTarget, ABILITY_CHARISMA)) + "  (+" + IntToString(GetAbilityModifier(ABILITY_CHARISMA, oTarget)) + ")\n"+
                 TINK_SPACERS;

                 if(OBJECT_INVALID != GetLastAttacker(oTarget))
                   sCS = sCS + "Last Attacked by:  " + GetName(GetLastAttacker(oTarget)) + "\n";

                 sCS = sCS + TINK_SPACERS+
                 "Head:  " + IntToString(GetCreatureBodyPart(CREATURE_PART_HEAD, oTarget)) + "\n" +
                 "Portrait:  " + GetPortraitResRef(oTarget) + "\n";

                 sCS = sCS + TINK_SPACERS;
    SendServerMessageToPC(oDM, sCS);
} // void ExaminePlayer(object oDM, string sTargetName)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  FullHealPlayer
*
* Purpose:  Combination removes all negative effects, heals hit points, res if
*               needed.
*
* Created By: Mistress
* Created On: 3-23-07
*
* Modeled after and adapted from:
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void FullHealPlayer(object oDM, string sTargetName)
{
    // Built in help
    if("" == sTargetName)
    {
        SendServerMessageToPC(oDM, TINK_CMD_FHPSY1 + TINK_CMD_FHPSY2);
        return;
    }

    // First see if we can find the player
    object oTarget = GetPlayerByName(sTargetName);
    if(OBJECT_INVALID == oTarget)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER1 + sTargetName + TINK_CMD_GIVER2);
        return;
    }

    // Only Players
    if(FALSE == GetIsPC(oTarget))
    {

        SendServerMessageToPC(oDM, TINK_CMD_GIVER3);
        return;
    }

    // Cure them of any negative effects
    RemoveNegativeEffects(oTarget);

    // Heal any missing HP
    int nHealAmount = GetMaxHitPoints(oTarget) - GetCurrentHitPoints(oTarget);
    if(nHealAmount > 0)
    {
        effect eHeal = EffectHeal(nHealAmount);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    }

    // Res 'em if needed
    if(TRUE == GetIsDead(oTarget))
    {
        //Declare major variables
        int nHealed = GetMaxHitPoints(oTarget);
        effect eRaise = EffectResurrection();
        effect eHeal = EffectHeal(nHealed + 10);
        effect eVis = EffectVisualEffect(VFX_IMP_RAISE_DEAD);

        //Apply the heal, raise dead and VFX impact effect
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
    }

    SendServerMessageToPC(oTarget, TINK_CMD_FHPNT1);
    SendServerMessageToPC(oDM, TINK_CMD_BASNT0 + GetName(oTarget) + TINK_CMD_FHPNT2);
} // void FullHealPlayer(object oDM, string sTargetName)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  GetPlayerFeats
*
* Purpose:  Return a list of what feats the player has.
*
* Created By: Mistress
* Created On: 3-26-07
*
* Modeled after and adapted from:
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void GetPlayerFeats(object oDM, string sTargetName)
{
    // Built in help
    if("" == sTargetName)
    {
        SendServerMessageToPC(oDM, TINK_CMD_FEASY1 + TINK_CMD_FEASY2);
        return;
    }

    // First see if we can find the player
    object oTarget = GetPlayerByName(sTargetName);
    if(OBJECT_INVALID == oTarget)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER1 + sTargetName + TINK_CMD_GIVER2);
        return;
    }

    // Only Players
    if(FALSE == GetIsPC(oTarget))
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER3);
        return;
    }

    SendServerMessageToPC(oDM, TINK_CMD_BASNT0 + GetName(oTarget) + TINK_CMD_FEANT1 + GetFeatList(oTarget));
}


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  GetPlayerPs
*
* Purpose:  Return a list of what skills the player has.
*
* Created By: Mistress
* Created On: 3-26-07
*
* Modeled after and adapted from:
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
// ADD: Value of equiped gear and inventory
void GetPlayerPs(object oDM, string sTargetName)
{
    // Built in help
    if("" == sTargetName)
    {
        SendServerMessageToPC(oDM, TINK_CMD_PXGSY1 + TINK_CMD_PXGSY2);
        return;
    }
    // First see if we can find the player
    object oTarget = GetPlayerByName(sTargetName);
    if(OBJECT_INVALID == oTarget)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER1 + sTargetName + TINK_CMD_GIVER2);
        return;
    }

    // Only Players
    if(FALSE == GetIsPC(oTarget))
    {

        SendServerMessageToPC(oDM, TINK_CMD_GIVER3);
        return;
    }

    // Use this version of the name so things are caps right.
    string sName = GetName(oTarget);

    // Total amount of XP
    int nXP = GetXP(oTarget);
    SendServerMessageToPC(oDM, sName + TINK_CMD_PXGNT1 + IntToString(nXP) + TINK_CMD_BASNT5);

    // Total amount of GP
    nXP = GetGold(oTarget);
    SendServerMessageToPC(oDM, "");
    SendServerMessageToPC(oDM, sName + TINK_CMD_PXGNT1 + IntToString(nXP) + TINK_CMD_BASNT4);
}


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  GetPlayerSkills
*
* Purpose:  Return a list of what skills the player has.
*
* Created By: Mistress
* Created On: 3-26-07
*
* Modeled after and adapted from:
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void GetPlayerSkills(object oDM, string sTargetName)
{
    // Built in help
    if("" == sTargetName)
    {
        SendServerMessageToPC(oDM, TINK_CMD_SKLSY1 + TINK_CMD_SKLSY2);
        return;
    }

    // First see if we can find the player
    object oTarget = GetPlayerByName(sTargetName);
    if(OBJECT_INVALID == oTarget)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER1 + sTargetName + TINK_CMD_GIVER2);
        return;
    }

    // Only Players
    if(FALSE == GetIsPC(oTarget))
    {

        SendServerMessageToPC(oDM, TINK_CMD_GIVER3);
        return;
    }

    SendServerMessageToPC(oDM, TINK_CMD_BASNT0 + GetName(oTarget) + TINK_CMD_SKLNT1 + GetSkillList(oTarget));
}  // void GetPlayerSkills(object oDM, string sTargetName)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  HealPlayer
*
* Purpose:  Heal any missing HP
*
* Created By: Mistress
* Created On: 3-23-07
*
* Modeled after and adapted from:
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void HealPlayer(object oDM, string sTargetName)
{
    // Built in help
    if("" == sTargetName)
    {
        SendServerMessageToPC(oDM, TINK_CMD_HLPSY1 + TINK_CMD_HLPSY2);
        return;
    }

    // First see if we can find the player
    object oTarget = GetPlayerByName(sTargetName);
    if(OBJECT_INVALID == oTarget)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER1 + sTargetName + TINK_CMD_GIVER2);
        return;
    }

    // Only Players
    if(FALSE == GetIsPC(oTarget))
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER3);
        return;
    }

    // Heal any missing HP
    int nHealAmount = GetMaxHitPoints(oTarget) - GetCurrentHitPoints(oTarget);
    if(nHealAmount > 0)
    {
        effect eHeal = EffectHeal(nHealAmount);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);

        SendServerMessageToPC(oTarget, TINK_CMD_HLPNT1);
    }

    SendServerMessageToPC(oDM, TINK_CMD_BASNT0 + GetName(oTarget) + TINK_CMD_HLPNT2);
} // void HealPlayer(object oDM, string sTargetName)

void SetImmortalPlayer(object oDM, string sTargetName)
{
    // Built in help
    if("" == sTargetName)
    {
        SendServerMessageToPC(oDM, TINK_CMD_IMOSY1 + TINK_CMD_IMOSY2);
        return;
    }

    // First see if we can find the player
    object oTarget = GetPlayerByName(sTargetName);
    if(OBJECT_INVALID == oTarget)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER1 + sTargetName + TINK_CMD_GIVER2);
        return;
    }

    // Only Players
    if(FALSE == GetIsPC(oTarget))
    {
        SendServerMessageToPC(oDM, TINK_CMD_GIVER3);
        return;
    }

    if (GetPlotFlag(oTarget) == FALSE)
    {
      SetPlotFlag(oTarget, TRUE);
      SendServerMessageToPC(oDM, sTargetName+TINK_CMD_IMONT1);
    }
    else
    {
      SetPlotFlag(oTarget, FALSE);
      SendServerMessageToPC(oDM, sTargetName+TINK_CMD_IMONT2);
    }
} // void HealPlayer(object oDM, string sTargetName)



/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  GotoMap
*
* Purpose:  Goes to the first map with the specified tag
*
* Created By: Mistress with help from Nereng
* Created On: 3-26-07
*
* Modeled after and adapted from:
*
* Change Log:
* 3-4-08 Mistress
* - Added moving Tink
* 3-31-08 Mistress
* - Re-issue the follow command to Tink
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void GotoMap(object oDM, string sMapTag)
{
    // Built in help
    if("" == sMapTag)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GTMSY1 + TINK_CMD_GTMSY2);
        return;
    }

    object oItem = GetItemPossessedBy(oDM, "i_dm_tink");
    if (TINK_CMD_GTMSY3 == sMapTag)                     // prints all mapdata from item
      SendServerMessageToPC(oDM, GetMapList(oItem));
      
    else if (TINK_CMD_GTMSY4 == sMapTag)
    {
      object oArea = GetArea(oDM);
      SendServerMessageToPC(oDM, TINK_SPACERS +
                                 TINK_CMD_GTMNT1 + GetName(oArea) +
                                 TINK_CMD_GTMNT3 + TINK_CMD_GTMNT0 +
                                 TINK_SPACERS);
      ExploreAreaForPlayer(oArea, oDM);
      int nTriggers = ShowTriggersOnMap(oArea);      SendServerMessageToPC(oDM, "Triggers: "+IntToString(nTriggers));
      int nCNR_Plcs = ShowCNRPlaceablesOnMap(oArea); SendServerMessageToPC(oDM, "CNR_Plcs: "+IntToString(nCNR_Plcs));
      int nSpawnPnt = ShowSpawnPointsOnMap(oArea);   SendServerMessageToPC(oDM, "SpawnPoints: "+IntToString(nCNR_Plcs));
    }
    else if ("clear" == sMapTag)
      DeleteLocalString(oItem, "TINK_MAP_FULL");
    
    else
    {
      // First see if we can find the map
      object oMap = GetObjectByTag(sMapTag);
      if(OBJECT_INVALID == oMap)
      {
          SendServerMessageToPC(oDM, TINK_CMD_GTMER1 + sMapTag + TINK_CMD_GIVER2);
          return;
      }

      // Once we know the map is valid, find the first object in the area as our
      // jump to target
      object oJumpTarget = GetFirstObjectInArea(oMap);
      if(OBJECT_INVALID == oJumpTarget)
      {
          SendServerMessageToPC(oDM, TINK_CMD_GTMER2 + GetName(oMap) + TINK_CMD_GTMER3);
          return;
      }

      // Warn the people around the DM that they are leaving
      AssignCommand(oDM, SpeakString(TINK_CMD_BRPNT2));

      // special effect to hide the move
      effect eSmoke = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eSmoke, oDM);

      // Move them
      AssignCommand(oDM, ClearAllActions());
      AssignCommand(oDM, JumpToObject(oJumpTarget));

      // More smoke to hide them popping up
      ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSmoke, GetLocation(oJumpTarget));

      // Move Tink
      AssignCommand(OBJECT_SELF, ClearAllActions());
      AssignCommand(OBJECT_SELF, JumpToObject(oJumpTarget));
      AssignCommand(OBJECT_SELF, ActionForceFollowObject(oDM, 0.75f));
    }
} // void GotoMap(object oDM, string sMapTag)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  GotoWaypoint
*
* Purpose:  Goes to the first waypoint with the matching tag
*
* Created By: Mistress
* Created On: 3-29-07
*
* Modeled after and adapted from:
*
* Change Log:
* 3-4-08 Mistress
* - Added moving Tink
* 3-31-08 Mistress
* - Re-issue the follow command to Tink
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void GotoWaypoint(object oDM, string sWPTag)
{
    // Built in help
    if("" == sWPTag)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GWPSY1 + TINK_CMD_GWPSY2);
        return;
    }

    // First see if we can find the waypoint
    object oWaypoint = GetWaypointByTag(sWPTag);
    if(OBJECT_INVALID == oWaypoint)
    {
        SendServerMessageToPC(oDM, TINK_CMD_GWPER1 + sWPTag + TINK_CMD_GIVER2);
        return;
    }

    // Warn the people around the DM that they are leaving
    AssignCommand(oDM, SpeakString(TINK_CMD_BRPNT2));

    // special effect to hide the move
    effect eSmoke = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSmoke, oDM);

    // Move them
    AssignCommand(oDM, ClearAllActions());
    AssignCommand(oDM, JumpToObject(oWaypoint));

    // More smoke to hide them popping up
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSmoke, GetLocation(oWaypoint));

    // Move Tink
    AssignCommand(OBJECT_SELF, ClearAllActions());
    AssignCommand(OBJECT_SELF, JumpToObject(oWaypoint));
    AssignCommand(OBJECT_SELF, ActionForceFollowObject(oDM, 0.75f));
    // Tell Tink to keep on following us
}  // void GotoWaypoint(object oDM, string sWPTag)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name: RemoveNegativeEffects
*
* Purpose: Remove all negative spell effects from oTarget.  Used in fullheal
*           command
*
* Created By: Mistress
* Created On: 11-26-03
*
* Modeled after and adapted from:
*    Temple Cast Heal by Bioware (NW_D1_TEMPLEHEAL)
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void RemoveNegativeEffects(object oTarget)
{
    effect eBadness = GetFirstEffect(oTarget);

    //Search for negative effects
    while(GetIsEffectValid(eBadness))
    {
        if(GetEffectType(eBadness) == EFFECT_TYPE_ABILITY_DECREASE ||
           GetEffectType(eBadness) == EFFECT_TYPE_AC_DECREASE ||
           GetEffectType(eBadness) == EFFECT_TYPE_ATTACK_DECREASE ||
           GetEffectType(eBadness) == EFFECT_TYPE_DAMAGE_DECREASE ||
           GetEffectType(eBadness) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
           GetEffectType(eBadness) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
           GetEffectType(eBadness) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
           GetEffectType(eBadness) == EFFECT_TYPE_SKILL_DECREASE ||
           GetEffectType(eBadness) == EFFECT_TYPE_TURN_RESISTANCE_DECREASE ||

           GetEffectType(eBadness) == EFFECT_TYPE_BLINDNESS ||
           GetEffectType(eBadness) == EFFECT_TYPE_CHARMED ||
           GetEffectType(eBadness) == EFFECT_TYPE_CONFUSED ||
           GetEffectType(eBadness) == EFFECT_TYPE_CURSE ||
           GetEffectType(eBadness) == EFFECT_TYPE_DARKNESS ||
           GetEffectType(eBadness) == EFFECT_TYPE_DAZED ||
           GetEffectType(eBadness) == EFFECT_TYPE_DEAF ||
           GetEffectType(eBadness) == EFFECT_TYPE_DISEASE ||
           GetEffectType(eBadness) == EFFECT_TYPE_DOMINATED ||
           GetEffectType(eBadness) == EFFECT_TYPE_ENTANGLE ||
           GetEffectType(eBadness) == EFFECT_TYPE_FRIGHTENED ||
           GetEffectType(eBadness) == EFFECT_TYPE_NEGATIVELEVEL  ||
           GetEffectType(eBadness) == EFFECT_TYPE_PARALYZE ||
           GetEffectType(eBadness) == EFFECT_TYPE_PETRIFY ||
           GetEffectType(eBadness) == EFFECT_TYPE_POISON ||
           GetEffectType(eBadness) == EFFECT_TYPE_SILENCE ||
           GetEffectType(eBadness) == EFFECT_TYPE_SLEEP ||
           GetEffectType(eBadness) == EFFECT_TYPE_SLOW ||
           GetEffectType(eBadness) == EFFECT_TYPE_STUNNED)
        {
            //Remove effect if it is negative.
            RemoveEffect(oTarget, eBadness);
        }

        eBadness = GetNextEffect(oTarget);
    } // while(GetIsEffectValid(eBad))

    // Now deal with fear
    effect eFear;

    // Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_REMOVE_FEAR, FALSE));
    eFear = GetFirstEffect(oTarget);

    //Get the first effect on the current target
    while(GetIsEffectValid(eFear))
    {
        if (GetEffectType(eFear) == EFFECT_TYPE_FRIGHTENED)
        {
            //Remove any fear effects and apply the VFX impact
            RemoveEffect(oTarget, eFear);
        }
        //Get the next effect on the target
        eFear = GetNextEffect(oTarget);
    }
} // END of void void RemoveNegativeEffects(object oTarget)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name: GetWherePlayer
*
* Purpose: Reports back the location of all players or a single player
*
* Created By: Mistress
* Created On: 3-31-08
*
* Modeled after and adapted from:
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void GetWherePlayer(object oDM, string sTargetName)
{
    // Built in help
    if("" == sTargetName)
    {
        SendServerMessageToPC(oDM, TINK_CMD_WHRSY1 + TINK_CMD_WHRSY2);
        return;
    }

    // Show them all
    if("all" == sTargetName)
    {
        SendServerMessageToPC(oDM, TINK_CMD_WHRNT1);

        // Get the first PC on the server
        object oTemp = GetFirstPC();

        // Cycle through all players until we find the one we want
        while(TRUE == GetIsObjectValid(oTemp))
        {
            SendServerMessageToPC(oDM, GetName(oTemp) + " - " + GetName(GetArea(oTemp)) + " (" + GetTag(GetArea(oTemp))+")" );

            // Update loop control variables
            oTemp = GetNextPC();
        }
    }

    // Else we are looking for a specific player
    else
    {
        // First see if we can find the player
        object oTarget = GetPlayerByName(sTargetName);
        if(OBJECT_INVALID == oTarget)
        {
            SendServerMessageToPC(oDM, TINK_CMD_GIVER1 + sTargetName + TINK_CMD_GIVER2);
            return;
        }

        // Only Players
        if(FALSE == GetIsPC(oTarget))
        {
            SendServerMessageToPC(oDM, TINK_CMD_GIVER3);
            return;
        }

        // Notify the DM
        SendServerMessageToPC(oDM, GetName(oTarget) + TINK_CMD_WHRNT2 + GetName(GetArea(oTarget))+ " (" + GetTag(GetArea(oTarget))+")" );
    } // else
} // END of void GetWherePlayer(object oDM, string sTargetName)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  AdvanceTimeByHour
*
* Purpose:  Moves the hour forward for the whole server.
*
* Created By: Mistress
* Created On: 8-5-08
*
* Modeled after and adapted from:
*   void dmwand_AdvanceTime(int nDay) in the DMFI wand
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
void AdvanceTimeByHour(object oDM, string sSaid)
{
    // Built in help
    if("" == sSaid)
    {
        SendServerMessageToPC(oDM, TINK_CMD_SHRSY1 + TINK_CMD_SHRSY2 + TINK_CMD_SHRSY3 +
                                   IntToString(GetTimeHour()) + TINK_CMD_SHRSY4);
        return;
    }

    int nHour = StringToInt(sSaid);

    if (nHour <= 0)
    {
        SendServerMessageToPC(oDM, TINK_CMD_SHRNT1);
        return;
    }

    int nCurrentHour = GetTimeHour();
    int nCurrentMinute = GetTimeMinute();
    int nCurrentSecond = GetTimeSecond();
    int nCurrentMilli = GetTimeMillisecond();

    string sMsg = TINK_CMD_SHRNT2 + IntToString(nCurrentHour) + TINK_CMD_SHRNT3;

    nCurrentHour += nHour;
    SetTime(nCurrentHour, nCurrentMinute, nCurrentSecond, nCurrentMilli);

    // Notify the DM
    SendServerMessageToPC(oDM, TINK_CMD_BASNT0+ sMsg + TINK_CMD_SHRNT4 + IntToString(nCurrentHour) + TINK_CMD_GLVNT4);
}  //  void AdvanceTimeByHour(object oDM, string sSaid)


void ChangeWeather(object oDM, string sSaid)
{
  // Built in help
  if("" == sSaid)
  {
      SendServerMessageToPC(oDM, TINK_CMD_WEASY1+TINK_CMD_WEASY2);
      return;
  }
  
  if (sSaid == TINK_CMD_WEASY3)
  {
    object oArea = GetArea(oDM);
    if (GetIsAreaAboveGround(oArea) == AREA_ABOVEGROUND
    &&  GetIsAreaInterior(oArea)    == FALSE )
    {
      SetWeather(oArea, WEATHER_CLEAR);
      SetSkyBox(SKYBOX_GRASS_CLEAR, oArea);
      SendServerMessageToPC(oDM, TINK_CMD_WEANT1+IntToString(GetWeather(oArea))+"/"+IntToString(GetSkyBox(oArea)));
    }
  }
  else  // change in all areas?
  {
    SendServerMessageToPC(oDM, TINK_CMD_WEANT2);
    
    object oArea = GetFirstArea();
    while (GetIsObjectValid(oArea))
    {
      if (GetIsAreaAboveGround(oArea) == AREA_ABOVEGROUND         // only above ground and not interior
      &&  GetIsAreaInterior(oArea)    == FALSE )
      {
        DelayCommand(6.0, SetWeather(oArea, WEATHER_CLEAR));      // delayed due stop spamming with TMI
        DelayCommand(6.0, SetSkyBox(SKYBOX_GRASS_CLEAR, oArea));
      }
      
      oArea = GetNextArea();
    }
  }
}
