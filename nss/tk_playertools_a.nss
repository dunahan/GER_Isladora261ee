//::///////////////////////////////////////////////
//:: tk_playertools, advanced version
//:://////////////////////////////////////////////
/*
    Assigns player tools to the object running
    this script, based on the contents of
    tk_playertools.2da.

    This should only be executed by PCs.
*/
//:://////////////////////////////////////////////
//:: Created By: The Krit
//:: Created On: 2008-04-29
//:://////////////////////////////////////////////

/*************************************************
 * USE:
 * ---
 * This script should be executed from a module's
 * OnClientEnter and OnPlayerLevelUp events, but
 * this script should *not* be the event handler.
 * The event handlers should call
 *
    ExecuteScript("tk_playertools_a", oPC);
 *
 * where oPC has been assigned the return value of
 * either GetEnteringObject() (in the OnClientEnter
 * event) or GetPCLevellingUp() (in the OnPlayerLevelUp
 * event). The name of the variable is not important.
 *************************************************/
#include "x3_inc_skin"
#include "_debugisla"

// -----------------------------------------------------------------------------
// CONSTANTS

// This script assumes the player tool item property constants are sequential,
// as well as the player tool feat constants.
// To aid this, we use two constants to which the player tool number will be added:
const int FEAT_PLAYER_TOOL_BASE = 1105;
const int IP_CONST_FEAT_PLAYER_TOOL_BASE = 52;

// The .2da to consult.
const string PTOOL_CONFIG_FILE = "tk_playertools";
// The number of player tools.
const int PTOOL_COUNT = 10;


// -----------------------------------------------------------------------------
// PROTOTYPES

// Implements the check to see if we have the skills, feats, or classes required
// for player tool number nTool.
int CheckQualifyForTool(int nTool);

// Retrieves the indicated column from the player tool .2da, and returns it
// as an integer, with a minimum of 1.
int GetToolMinimum(string sColumn, int nRow);

// Removes a permanent item property on oItem that grants the bonus feat nIPFeat.
// nIPFeat must be an IP_CONST_FEAT_* constant.
void RemoveIPFeat(object oItem, int nIPFeat);


// -----------------------------------------------------------------------------
void main()
{
    // Get our skin object.
    object oSkin = SKIN_SupportGetSkin(OBJECT_SELF);
    if ( GetObjectType(oSkin) != OBJECT_TYPE_ITEM )
        // Something went wrong (possibly oPC is not a PC). Abort.
        return;

    // Loop through the player tools.
    int nTool = 0;
    while ( nTool++ < PTOOL_COUNT )
    {
        // Boolean flags.
        int bAddTool = FALSE;
        int bRemoveTool = FALSE;

        // Here we assume the player tool feats are sequentially indexed.
        if ( !GetHasFeat(FEAT_PLAYER_TOOL_BASE + nTool) )
            // Determine if we qualify for this player tool.
            bAddTool = CheckQualifyForTool(nTool);
        else
        {
            // Determine if this player tool should be removed.
            string sData = Get2DAString(PTOOL_CONFIG_FILE, "AutoRemove", nTool);
            if ( StringToInt(sData)  ||  GetStringLowerCase(sData) == "yes" )
                bRemoveTool = !CheckQualifyForTool(nTool);
        }

        // Add or remove the player tool as appropriate.
        if ( bAddTool )
            AddItemProperty(DURATION_TYPE_PERMANENT,
                            ItemPropertyBonusFeat(IP_CONST_FEAT_PLAYER_TOOL_BASE + nTool),
                            oSkin);
        else if ( bRemoveTool )
            RemoveIPFeat(oSkin, IP_CONST_FEAT_PLAYER_TOOL_BASE + nTool);
    }
}

// -----------------------------------------------------------------------------
// Implements the check to see if we have the skills, feats, or classes required
// for player tool number nTool.
// (Something of a monster function. Sorry.)
int CheckQualifyForTool(int nTool)
{
    object oMe = OBJECT_SELF;
    string sData = "";
    int bRaceRequirementFound = FALSE;

    // See if everyone gets this tool.
    sData = Get2DAString(PTOOL_CONFIG_FILE, "Everyone", nTool);
    if ( StringToInt(sData)  ||  GetStringLowerCase(sData) == "yes" )
        return TRUE;

    // Check the race restrictions.
    sData = Get2DAString(PTOOL_CONFIG_FILE, "Race1", nTool);
    if ( sData != "" )
    {
        bRaceRequirementFound = TRUE;
        int bRacePass = FALSE;
        int nMyRace = GetRacialType(oMe);

        // Loop through the 2da columns with data.
        int nCol = 1;
        while ( sData != ""  &&  !bRacePass )
        {
            // Are we the right race?
            bRacePass = StringToInt(sData) == nMyRace;
            // Next column.
            sData = Get2DAString(PTOOL_CONFIG_FILE, "Race" + IntToString(++nCol), nTool);
        }
        // No good if we did not meet a racial requirement.
        if ( !bRacePass )
            return FALSE;
    }

    // See how the remaining qualifications get put together.
    sData = Get2DAString(PTOOL_CONFIG_FILE, "Join", nTool);
    int bJoinAnd = GetStringLowerCase(sData) == "and";

    // Qualification trackers.
    // (Default values are used if no conditions are found.)
    int bSkillPass = bJoinAnd;
    int bFeatPass = bJoinAnd;
    int bClassPass = bJoinAnd;
    int bConditionFound = FALSE;

    // -----------------------------------------------------
    // Check the qualifying skills.
    sData = Get2DAString(PTOOL_CONFIG_FILE, "Skill1", nTool);
    // Is there a skill requirement?
    if ( sData != "" )
    {
        bConditionFound = TRUE;

        // Determine if we need all or just one of the skills.
        if ( GetStringLowerCase(Get2DAString(PTOOL_CONFIG_FILE, "SkillJoin", nTool))
             == "and" )
        {
            // We need all the skills.
            bSkillPass = TRUE;
            // Loop through the 2da columns with data.
            int nCol = 1;
            while ( sData != ""  &&  bSkillPass )
            {
                // We need a minimum number of ranks in the indicated skill.
                bSkillPass = GetSkillRank(StringToInt(sData), oMe, TRUE) >=
                             GetToolMinimum("Rank" + IntToString(nCol), nTool);
                // Next column.
                sData = Get2DAString(PTOOL_CONFIG_FILE, "Skill" + IntToString(++nCol), nTool);
            }
        }
        else
        {
            // We need one of the skills.
            bSkillPass = FALSE;
            // Loop through the 2da columns with data.
            int nCol = 1;
            while ( sData != ""  &&  !bSkillPass )
            {
                // We need a minimum number of ranks in the indicated skill.
                bSkillPass = GetSkillRank(StringToInt(sData), oMe, TRUE) >=
                             GetToolMinimum("Rank" + IntToString(nCol), nTool);
                // Next column.
                sData = Get2DAString(PTOOL_CONFIG_FILE, "Skill" + IntToString(++nCol), nTool);
            }
        }
    }

    // -----------------------------------------------------
    // Check the qualifying feats.
    sData = Get2DAString(PTOOL_CONFIG_FILE, "Feat1", nTool);
    // Is there a feat requirement?
    if ( sData != "" )
    {
        bConditionFound = TRUE;

        // Determine if we need all or just one of the feats.
        if ( GetStringLowerCase(Get2DAString(PTOOL_CONFIG_FILE, "FeatJoin", nTool))
             == "and" )
        {
            // We need all the feats.
            bFeatPass = TRUE;
            // Loop through the 2da columns with data.
            int nCol = 1;
            while ( sData != ""  &&  bFeatPass )
            {
                bFeatPass = GetHasFeat(StringToInt(sData), oMe);
                // Next column.
                sData = Get2DAString(PTOOL_CONFIG_FILE, "Feat" + IntToString(++nCol), nTool);
            }
        }
        else
        {
            // We need one of the feats.
            bFeatPass = FALSE;
            // Loop through the 2da columns with data.
            int nCol = 1;
            while ( sData != ""  &&  !bFeatPass )
            {
                bFeatPass = GetHasFeat(StringToInt(sData), oMe);
                // Next column.
                sData = Get2DAString(PTOOL_CONFIG_FILE, "Feat" + IntToString(++nCol), nTool);
            }
        }
    }

    // -----------------------------------------------------
    // Check the qualifying classes.
    sData = Get2DAString(PTOOL_CONFIG_FILE, "Class1", nTool);
    // Is there a class requirement?
    if ( sData != "" )
    {
        bConditionFound = TRUE;

        // Determine if we need all or just one of the classes.
        if ( GetStringLowerCase(Get2DAString(PTOOL_CONFIG_FILE, "ClassJoin", nTool))
             == "and" )
        {
            // We need all the classes.
            bClassPass = TRUE;
            // Loop through the 2da columns with data.
            int nCol = 1;
            while ( sData != ""  &&  bClassPass )
            {
                // We need a minimum number of class levels to qualify.
                bClassPass = GetLevelByClass(StringToInt(sData), oMe) >=
                             GetToolMinimum("Level" + IntToString(nCol), nTool);
                // Next column.
                sData = Get2DAString(PTOOL_CONFIG_FILE, "Class" + IntToString(++nCol), nTool);
            }
        }
        else
        {
            // We need one of the classes.
            bClassPass = FALSE;
            // Loop through the 2da columns with data.
            int nCol = 1;
            while ( sData != ""  &&  !bClassPass )
            {
                // We need a minimum number of class levels to qualify.
                bClassPass = GetLevelByClass(StringToInt(sData), oMe) >=
                             GetToolMinimum("Level" + IntToString(nCol), nTool);
                // Next column.
                sData = Get2DAString(PTOOL_CONFIG_FILE, "Class" + IntToString(++nCol), nTool);
            }
        }
    }

    // If no conditions were found, then no tool.
    // (If just a racial requirement was found, then we passed the only check.)
    if ( !bConditionFound )
        return bRaceRequirementFound;

    // Join the qualifications.
    if ( bJoinAnd )
        return bSkillPass  &&  bFeatPass  &&  bClassPass;
    else
        return bSkillPass  ||  bFeatPass  ||  bClassPass;
}

// -----------------------------------------------------------------------------
// Retrieves the indicated column from the player tool .2da, and returns it
// as an integer, with a minimum of 1.
int GetToolMinimum(string sColumn, int nTool)
{
    int nMinimum = StringToInt(Get2DAString(PTOOL_CONFIG_FILE, sColumn, nTool));

    if ( nMinimum < 1 )
        return 1;
    else
        return nMinimum;
}

// -----------------------------------------------------------------------------
// Removes a permanent item property on oItem that grants the bonus feat nIPFeat.
// nIPFeat must be an IP_CONST_FEAT_* constant.
void RemoveIPFeat(object oItem, int nIPFeat)
{
    // Loop through the item properties on oItem.
    itemproperty ipLoop = GetFirstItemProperty(oItem);
    while ( GetIsItemPropertyValid(ipLoop) )
    {
        // See if ipLoop is a permanent item property granting feat nIPFeat.
        if ( GetItemPropertyDurationType(ipLoop) == DURATION_TYPE_PERMANENT  &&
             GetItemPropertyType(ipLoop) == ITEM_PROPERTY_BONUS_FEAT         &&
             GetItemPropertySubType(ipLoop) == nIPFeat )
        {
            // Remove this property.
            RemoveItemProperty(oItem, ipLoop);
            // Done. (Only remove one item property.)
            return;
        }
        // Update the loop.
        ipLoop = GetNextItemProperty(oItem);
    }
}