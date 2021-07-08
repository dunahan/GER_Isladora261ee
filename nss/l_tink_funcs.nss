/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* File Name:  l_tink_funcs
*
* Purpose:  Function library for Tink.  These functions split from her convo
*           file (n_tink_conv) so they can be used elsewhere.
*
*   SET UP INSTRUCTIONS:  You ***MUST*** add all DM accounts that Tink should
*           listen and respond to to the is_a_DM function.
*
* Created By: Mistress
* Created On: 5-25-08
*
* Modeled after and adapted from:
*   CFBMoo1's DM Tools 2.0 by CFBMoo1
*   http://nwvault.ign.com/View.php?view=Scripts.Detail&id=2373
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
#include "l_tink_speak"
#include "ll_include"
#include "_debugisla"

// Purpose:  Determine if the passed in player object is a DM account.
// Parameters:
//      oPlayer:  The player to test against the known list of DM ids.
// Return Values:
//      Success:  TRUE
//      Failure:  FALSE
int is_a_DM(object oPlayer);


// Purpose:  Determine if the passed in player object is an Counci account.
// Parameters:
//      oPlayer:  The player to test against the known list of Counci ids.
// Return Values:
//      Success:  TRUE
//      Failure:  FALSE
int is_a_Counci(object oPlayer);


// Purpose:  Converts the ALIGNMENT_* constant into a readable alignment name
//           and reports the value.
// Parameters:
//      oPC:  The player's whose alignment to convert
// Return Values:
//      Success: Readable version of ALIGNMENT_*
//      Failure: null string
string GetAlignment(object oPC);


// Purpose:  Converts the CLASS_TYPE_* constant into the readable class name.
// Parameters:
//      nClass:  CLASS_TYPE_* constant to be converted
// Return Values:
//      Success:  Readable version of CLASS_TYPE_* constant
//      Failure:  No Class
string GetClassName(int nClass);


// Purpose:  Returns the list of feats that oPlayer has.
// Parameters:
//      oPlayer: The player's whose feats we want to know
// Return Value:
//      Success:  List of oPlayer's feats
//      Failure:  ERROR
string GetFeatList(object oPlayer);


// Purpose:  Cycle through the PCs logged in, looking for the one whose name
//      matches sTargetName.
//
//      DESIGN NOTE: sTargetName will come in from Tink as all lowercase.  There
//      is therefore a SMALL chance for error if there is a player named "Bob"
//      and another one named "bob".
// Parameters:
//      sTargetName:  The name of the player we want to find
//  Return Values:
//      Success:  The FIRST player object matching lowercase sTargetName
//      Failure:  OBJECT_INVALID - no match found
object GetPlayerByName(string sTargetName);


// Purpose:  Converts the RACIAL_TYPE_* constant into the readable race name.
// Parameters:
//      nRace:  RACIAL_TYPE_* constant to be converted
// Return Values:
//      Success:  Readable version of RACIAL_TYPE_* constant
//      Failure:  ERROR
string GetRaceName(int nRace);


// Purpose:  Returns the list of ranks that oPlayer has in each skill.  Includes
//           bonuses given by ability scores, feats, etc.
// Parameters:
//      oPlayer: The player's whose skills we want to know
// Return Value:
//      Success:  List of oPlayer's skill
//      Failure:  ERROR
string GetSkillList(object oPlayer);

// Purpose:  Returns the list of Maps and their tags
// Parameters:
//      oItem: where the list is saved (usually on tinks item
//      nModus: which list is accessed, all=0, interior=1, undergrund=2
// Return Value:
//      Success:  List of Map Names and the Tag
//      Failure:  ERROR
string GetMapList(object oItem);


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name: is_a_DM
*
* Purpose: Determine if the passed in player object is a DM account.  This
*           allows Tink to respond to a DM player if they are logged in as
*           a "mortal" (not using the DM client).
*
* Created By: Mistress
* Created On: 5-1-03
*
* Modeled after and adapted from:
*
* Change Log
* 2-11-04 Mistress
* - Added use of CD key in is_a_DM
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
int is_a_DM(object oPlayer)
{
    // Get the login id of the player
    string sUserID = GetPCPlayerName(oPlayer);

    // CD key
    string sUserCDKey = GetPCPublicCDKey(oPlayer);

    // List of valid DM login IDs - YOU MUST ADD YOUR LOGIN ID AND CD KEY HERE
    // FOR TINK TO LISTEN AND RESPOND TO YOU!!  REPLACE "XXX" WITH YOUR LOGIN
    // ID AND "YYY" WITH YOUR CD KEY.  THE KEY IS 8 CHARACTERS LONG.

    // To add more DM ids, copy this line
    //      (sUserID == "XXX" && sUserCDKey == "YYY") ||
    // an put it below line 126

    // To have only ONE DM id, delete lines 125 and 126.

    // AFTER you have tailored the DM list, you must recompile the script.
    if(
       (sUserID == "dunahan"     && sUserCDKey == "UPW9NCE4") ||
       (sUserID == "dun_android" && sUserCDKey == "UPRC7UHQ") ||
       (sUserID == "Antoss"      && sUserCDKey == "UXFFHRPN") ||
       (sUserID == "Draghetto"   && sUserCDKey == "UPEPJH6L")
      )
    {
        // This is a DM id.
        return TRUE;
    }

    // Not a DM id, no prize for you.
    return FALSE;
} // END of int is_a_DM(object oPlayer)

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name: is_a_Counci
*
* Purpose: Determine if the passed in player object is a Counci account.  This
*           allows Tink to respond to a Counci player.
*
* Created By: Mistress
* Created On: 5-1-03
*
* Modeled after and adapted from: Dunahan@schwerterkueste.de
*
* Change Log
* 2-11-04 Mistress
* - Added use of CD key in is_a_DM
* - Rewritten for the use of Councils
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
int is_a_Counci(object oPlayer)
{
    // Get the login id of the player
    string sUserID = GetPCPlayerName(oPlayer);

    // CD key
    string sUserCDKey = GetPCPublicCDKey(oPlayer);

    // List of valid Counci login IDs - YOU MUST ADD YOUR LOGIN ID AND CD KEY HERE
    // FOR TINK TO LISTEN AND RESPOND TO YOU!!  REPLACE "XXX" WITH YOUR LOGIN
    // ID AND "YYY" WITH YOUR CD KEY.  THE KEY IS 8 CHARACTERS LONG.

    // To add more DM ids, copy this line
    //      (sUserID == "XXX" && sUserCDKey == "YYY") ||
    // an put it below line 183

    // To have only ONE Counci id, delete lines 184 and 185.

    // AFTER you have tailored the list, you must recompile the script.
    if(
       (sUserID == "Joe" && sUserCDKey == "QR6XVUHU")
      )
    {
        // This is a Counci id.
        return TRUE;
    }

    // Not a DM id, no prize for you.
    return FALSE;
} // END of int is_a_DM(object oPlayer)

object GetMyDM(object oTink = OBJECT_SELF)
{
  object oDM = GetNearestObject(OBJECT_TYPE_CREATURE, oTink, 1);
  if (is_a_Counci(oDM) || is_a_DM(oDM))
    return oDM;

  return OBJECT_INVALID;
}

void ReAssignTink(object oDM, object oTink = OBJECT_SELF)
{
  AssignCommand(oTink, ClearAllActions());
  AssignCommand(oTink, JumpToObject(oDM));
  AssignCommand(oTink, ActionForceFollowObject(oDM, 0.75f));
}

void FollowYourDM(object oTink = OBJECT_SELF, float nCheckAgain = 60.0);
void FollowYourDM(object oTink = OBJECT_SELF, float nCheckAgain = 60.0)
{
  object oMyDM = GetLocalObject(oTink, "TINK_MY_DM");
  object oDM = GetFirstPC();
   while (GetIsObjectValid(oDM))
   {
      if (oDM == oMyDM)
      {
        if (GetArea(oDM) != GetArea(oTink) || 5.0 >= GetDistanceBetween(oDM, oTink))   // if the dm changed locations or tink is blocked
          ReAssignTink(oDM, oTink);
      }
      oDM = GetNextPC();
   }
   DelayCommand(nCheckAgain, FollowYourDM());
}

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
*    DO NOT EDIT PAST THIS POINT UNLESS YOU REALLY KNOW WHAT YOU ARE DOING
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name: GetAlignment
*
* Purpose: Converts the ALIGNMENT_* constant into a readable alignment name
*          and reports the value.
*
* Created By: Mistress
* Created On: 1-31-04
*
* Modeled after and adapted from:
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
string GetAlignment(object oPC)
{
    string sAlignment = "";
    int nAlignmentType = GetAlignmentGoodEvil(oPC);

    // Find out evil, neutral, or good
    if(ALIGNMENT_EVIL == nAlignmentType)
    {   sAlignment = "Böse";    }
    else if(ALIGNMENT_GOOD == nAlignmentType)
    {   sAlignment = "Gut";    }
    else
    {   sAlignment = "Neutral";     }

    // Add the value to the name
    sAlignment = "G/N/B:  " + sAlignment + "[" + IntToString(GetGoodEvilValue(oPC)) + "]\n";

    sAlignment = sAlignment + "R/N/C:  ";

    // Find out Lawful, Neutral or Chaotic
    nAlignmentType = GetAlignmentLawChaos(oPC);
    if(ALIGNMENT_LAWFUL == nAlignmentType)
    {   sAlignment = sAlignment + "Rechtschaffen";    }
    else if(ALIGNMENT_CHAOTIC == nAlignmentType)
    {   sAlignment = sAlignment + "Chaotisch";    }
    else
    {   sAlignment = sAlignment + "Neutral";    }

    // Add the value to the name
    sAlignment = sAlignment + "[" + IntToString(GetLawChaosValue(oPC)) + "]\n";

    return sAlignment;
}  // string GetAlignment(object oPC)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  GetClassName
*
* Purpose:  Converts the CLASS_TYPE_* constant into the readable class name.
*
* Created By: Mistress
* Created On: 3-24-07
*
* Modeled after and adapted from:
*   CFBMoo1's DM Tools 2.0 by CFBMoo1
*   http://nwvault.ign.com/View.php?view=Scripts.Detail&id=2373
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
string GetClassName(int nClass)
{
    switch (nClass)
    {
        case  0:     return "Barbar";
        case  1:     return "Barde";
        case  2:     return "Kleriker";
        case  3:     return "Druide";
        case  4:     return "Kämpfer";
        case  5:     return "Mönch";
        case  6:     return "Paladin";
        case  7:     return "Waldläufer";
        case  8:     return "Schurke";
        case  9:     return "Hexenmeister";
        case 10:     return "Magier";
        case 11:     return "Aberration";
        case 12:     return "Tier";
        case 13:     return "Konstrukt";
        case 14:     return "Humanoider";
        case 15:     return "Monströs";
        case 16:     return "Element";
        case 17:     return "Fey";
        case 18:     return "Drache";
        case 19:     return "Untoter";
        case 20:     return "Bürgerlicher";
        case 21:     return "Biest";
        case 22:     return "Riese";
        case 23:     return "Magisches Biest";
        case 24:     return "Extenare";
        case 25:     return "Gestaltwandler";
        case 26:     return "Ungeziefer";
        case 27:     return "Schattentänzer";
        case 28:     return "Harfner";
        case 29:     return "Arkaner Bogenschütze";
        case 30:     return "Assassin";
        case 31:     return "Finsterer Streiter";
        case 32:     return "Vorkämpfer der Götter";
        case 33:     return "Waffenmeister";
        case 34:     return "Bleicher Meister";
        case 35:     return "Wahrer Wandler";
        case 36:     return "Zwergischer Verteidiger";
        case 37:     return "Drachendisziplin";
        case 38:     return "Schleim";
        case 39:     return "Auge des Gruumsh";
        case 40:     return "Shou Disziplin";
        case 41:     return "Ritter des Purpurdrachens";
        case 42:     return "Nachtschatten";
    }

    return "Keine";
} // string GetClassName(int nClass)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  GetFeatList
*
* Purpose:  Returns the list of feats that oPlayer has.
*
* Created By: Mistress
* Created On: 3-26-07
*
* Modeled after and adapted from:
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
string GetFeatList(object oPlayer)
{
    // Validate oPlayer
    if(FALSE == GetIsObjectValid(oPlayer))
    {   return "ERROR"; }

    string sFeatList = "";

    // Variables for looking up the feat name
    string sStrRef = "";
    string sFeatName = "";

    int nFeatNum = FALSE;
    for(nFeatNum = 0; nFeatNum < 1072; nFeatNum++)
    {
        if(TRUE == GetHasFeat(nFeatNum, oPlayer))
        {
            // Look up the StrRef as a string in feat.2da
            sStrRef = Get2DAString("feat", "FEAT", nFeatNum);

            // Look up the name in the dialog.tlk file
            sFeatName = GetStringByStrRef(StringToInt(sStrRef));

            // Add it to the list
            sFeatList = sFeatList + sFeatName + "\n";
        }
    }

    return sFeatList;
} // string GetFeatList(object oPlayer)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  GetPlayerByName
*
* Purpose:  Cycle through the PCs logged in, looking for the one whose name
*           matches sTargetName.  Return the match or OBJECT_INVALID if no
*           match is found.
*
*           DESIGN NOTE: sTargetName will come in from Tink as all lowercase.
*           There is therefore a SMALL chance for error if there is a player
*           named "Bob" and another one named "bob".
*
* Created By: Mistress
* Created On: 3-23-07
*
* Modeled after and adapted from:
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
object GetPlayerByName(string sTargetName)
{
    // Get the first PC on the server
    object oPC = GetFirstPC();

    // Cycle through all players until we find the one we want
    while(TRUE == GetIsObjectValid(oPC))
    {
        // BING!  We have a match
        if(GetStringLowerCase(GetName(oPC)) == sTargetName)
        {   return oPC;     }

        // Update loop control variables
        oPC = GetNextPC();
    }   // while (TRUE == GetIsObjectValid(oTarget)...

    return OBJECT_INVALID;
}


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  GetRaceName
*
* Purpose:  Converts the RACIAL_TYPE_* constant into the readable class name.
*
* Created By: Mistress
* Created On: 3-26-07
*
* Modeled after and adapted from:
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
string GetRaceName(int nRace)
{
    switch (nRace)
    {
        case  0:     return "Zwerg";
        case  1:     return "Elf";
        case  2:     return "Gnom";
        case  3:     return "Halbling";
        case  4:     return "Halbelf";
        case  5:     return "Halbork";
        case  6:     return "Mensch";
        case  7:     return "Aberration";
        case  8:     return "Biest";
        case  9:     return "Konstrukt";
        case 10:     return "Magier";
        case 11:     return "Drache";
        case 12:     return "Humanoid - Goblin ";
        case 13:     return "Humanoid - Monströs";
        case 14:     return "Humanoid - Ork";
        case 15:     return "Humanoid - Reptil";
        case 16:     return "Element";
        case 17:     return "Fey";
        case 18:     return "Riese";
        case 19:     return "Magisches Biest";
        case 20:     return "Extenar";
        case 23:     return "Gestaltwandler";
        case 24:     return "Untoter";
        case 25:     return "Ungeziefer";
        case 29:     return "Schleim";
        case 51:     return "Halbriese";
        case 52:     return "Titan";
    }

    return "ERROR";
} // string GetRaceName(int nRace)


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Function Name:  GetSkillList
*
* Purpose:  Returns the list of skills that oPlayer has.
*
* Created By: Mistress
* Created On: 3-26-07
*
* Modeled after and adapted from:
*
* Change Log:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
string GetSkillList(object oPlayer)
{
    // Validate oPlayer
    if(FALSE == GetIsObjectValid(oPlayer))
        return "ERROR";

    string sSkillList = "";

    // Figure out the skill ranks
    int nSkillRank = 0;
    string sSkillName = "";
    string sStrRef = "";

    int nSkillNum = 0;
    for(nSkillNum = 0; nSkillNum < 27; nSkillNum++)
    {
        // If they have a rank in the skill
        nSkillRank = GetSkillRank(nSkillNum, oPlayer);

        if(0 != nSkillRank)
        {
            // Look up the StrRef as a string in skills 2da
            sStrRef = Get2DAString("skills", "Name", nSkillNum);

            // Look up the name in the dialog.tlk file
            sSkillName = GetStringByStrRef(StringToInt(sStrRef));

            // Add it to the list
            sSkillList = sSkillList + sSkillName + ":  " + IntToString(nSkillRank) + "\n";
        }
    }

    return sSkillList;
} // string GetSkillList(object oPlayer)

string GetMapList(object oItem)
{
  string s;
  if (GetLocalString(oItem, "TINK_MAP_FULL") == "")
  {
    s = "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n";
    object oArea = GetFirstArea();
    while (GetIsObjectValid(oArea))
    {
      s = s+"\n"+GetName(oArea)+" | "+GetTag(oArea);
      oArea = GetNextArea();
    }
    s = s+"\n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n";
    SetLocalString(oItem, "TINK_MAP_FULL", s);
  }
  else
    return GetLocalString(oItem, "TINK_MAP_FULL");

  return "ERROR";
}

void Creations(int nType, string sTag_ResRef, location lLoc, int nUseVisuals=FALSE, string sNewTag="")
{
  CreateObject(nType, sTag_ResRef, lLoc, nUseVisuals, sNewTag);
}

int ShowSpawnPointsOnMap(object oArea)
{
  object oObject = GetFirstObjectInArea(oArea);
  int nResult = 0;
  while(GetIsObjectValid(oObject))
  {
    if (GetObjectType(oObject) == OBJECT_TYPE_WAYPOINT && GetStringLeft(GetName(oObject), 3) == "SP_")
    {
      DebugMode("l_tink_funcs: ShowWaypoints "+GetName(oObject));
      //if (!GetIsObjectValid(GetNearestObject(OBJECT_TYPE_WAYPOINT, oObject)))
      {
        DelayCommand(6.0, Creations(OBJECT_TYPE_WAYPOINT, "TINK_MAPNOTE", GetLocation(oObject), FALSE, GetTag(oObject)));
        nResult++;
      }
    }

    oObject = GetNextObjectInArea(oArea);
  }

  return nResult;
}

int ShowTriggersOnMap(object oArea)
{
  object oObject = GetFirstObjectInArea(oArea);
  int nResult = 0;
  while(GetIsObjectValid(oObject))
  {
    if (GetObjectType(oObject) == OBJECT_TYPE_TRIGGER)
    {
      DebugMode("l_tink_funcs: ShowTriggers"+GetName(oObject));
      //if (!GetIsObjectValid(GetNearestObject(OBJECT_TYPE_WAYPOINT, oObject)))
      {
        DelayCommand(6.0, Creations(OBJECT_TYPE_WAYPOINT, "TINK_MAPNOTE", GetLocation(oObject), FALSE, GetTag(oObject)));
        nResult++;
      }
    }

    oObject = GetNextObjectInArea(oArea);
  }

  return nResult;
}

int ShowCNRPlaceablesOnMap(object oArea)
{
  object oObject = GetFirstObjectInArea(oArea);
  int nResult = 0;
  while(GetIsObjectValid(oObject))
  {
    if (GetObjectType(oObject) == OBJECT_TYPE_PLACEABLE && GetStringLeft(GetTag(oObject), 3) == "cnr")
    {
      DebugMode("l_tink_funcs: ShowCnrPlaceables"+GetName(oObject));
      //if (!GetIsObjectValid(GetNearestObject(OBJECT_TYPE_WAYPOINT, oObject)))
      {
        DelayCommand(6.0, Creations(OBJECT_TYPE_WAYPOINT, "TINK_RESNOTE", GetLocation(oObject), FALSE, GetTag(oObject)));
        nResult++;
      }
    }
    oObject = GetNextObjectInArea(oArea);
  }
  return nResult;
}
