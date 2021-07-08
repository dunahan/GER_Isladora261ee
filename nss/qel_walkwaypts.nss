//::///////////////////////////////////////////////
//:: Resume Waypoint Walking
//:: Qel_WalkWayPts.nss
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Assigned to the normal and abnormal end
    conversation events to have the creature
    resume walking waypoints.
    This now uses my Walk Waypoints function.
*/
//:://////////////////////////////////////////////
//:: Created By: Neil Flynn
//:: Created On: July 19, 2002
//:://////////////////////////////////////////////
//:: Modified by Jasperre
//:: Included in Nordock by Q'el, 27 June 2003
//::
//:: Created to make the creature walk the waypoints again.
//:: Uses my slightly modified version.
//:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

int NW_FLAG_DAY_NIGHT_POSTING               = 0x00100000;
int NW_FLAG_STEALTH                         = 0x00000004;
int NW_FLAG_SEARCH                          = 0x00000008;
// This will store thier starting location, and then move back there after combat
// Will turn off if there are waypoints.
int RETURN_TO_SPAWN_LOCATION                = 0x10000000;
// Run the circuit.
void RunCircuit(int nTens, int nNum, int nRun = FALSE, float fPause = 1.0);
// Base for moving round thier waypoints
void WalkWayPoints(int nRun = FALSE, float fPause = 1.0);
// Used in walk waypoints
void RunNextCircuit(int nRun = FALSE, float fPause = 1.0);
// Checks which waypoint they are on, if any valid. TRUE if got any waypoints in range.
int CheckWayPoints(object oWalker = OBJECT_SELF);
//Returns true if the object is walking any waypoints.
int GetIsPostOrWalking(object oWalker = OBJECT_SELF);
// Returns the string to use - depending on day or night.
string GetStringPrefix(string sPrefix, object oWalker = OBJECT_SELF);
//Gets the spawn in condition.Can set things to different ints if you like.
int GetSpawnInCondition(int nCondition, string sName = "NW_GENERIC_MASTER");
// This sets a spawn in condition.
void SetSpawnInCondition(int nCondition, int bValid = TRUE, string sName = "NW_GENERIC_MASTER");

void SetSpawnInCondition(int nCondition, int bValid, string sName)
{
    int nPlot = GetLocalInt(OBJECT_SELF, sName);
    if(bValid == TRUE)
    {
        nPlot = nPlot | nCondition;
        SetLocalInt(OBJECT_SELF, sName, nPlot);
    }
    else if (bValid == FALSE)
    {
        nPlot = nPlot & ~nCondition;
        SetLocalInt(OBJECT_SELF, sName, nPlot);
    }
}
int GetSpawnInCondition(int nCondition, string sName)
{
    int nPlot = GetLocalInt(OBJECT_SELF, sName);
    if(nPlot & nCondition)
    {
        return TRUE;
    }
    return FALSE;
}

//***************************
//***************************
//
//WAY POINT WALK FUNCTIONS
//
//***************************
//***************************
//::///////////////////////////////////////////////
//:: Walk Way Point Path
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Allows specified person walk a waypoint path
*/
//:://////////////////////////////////////////////
//:: Created By: Aidan Scanlan
//:: Created On: July 10, 2001
//:://////////////////////////////////////////////
void WalkWayPoints(int nRun = FALSE, float fPause = 1.0)
{
    // Do we have any? any at all?
    if(CheckWayPoints())
    {
        // If yes, do everything...and first clear all actions.
        ClearAllActions();
        // We check out waypoints...and set day/night appropriately.
        string NightWayString;
        string NightPostString;
        object oWayNP = GetWaypointByTag("NIGHT_" + GetTag(OBJECT_SELF));
        object oWayNW = GetWaypointByTag("WN_" + GetTag(OBJECT_SELF) + "_01");
        if(GetIsObjectValid(oWayNP) || GetIsObjectValid(oWayNW))
        {
            NightWayString = "WN_";
            NightPostString = "NIGHT_";
        }
        else
        {
            NightWayString = "WP_";
            NightPostString = "POST_";
        }
        // We will set what strings to use.
        SetLocalString(OBJECT_SELF, "NW_GENERIC_WALKWAYS_DAY", "WP_");
        SetLocalString(OBJECT_SELF, "NW_GENERIC_WALKWAYS_NIGHT", NightWayString);
        SetLocalString(OBJECT_SELF, "NW_GENERIC_POSTING_DAY", "POST_");
        SetLocalString(OBJECT_SELF, "NW_GENERIC_POSTING_NIGHT", NightPostString);
        //I have now determined what the prefixs for the current walkways and postings are and will use them instead
        // of POST_ and WP_
        if(GetSpawnInCondition(NW_FLAG_STEALTH))
        {
            // Will hide all the time, when they walk
            ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
        }
        // animations 2 = immobile
        else if(GetSpawnInCondition(NW_FLAG_SEARCH) || GetLocalInt(OBJECT_SELF, "ANIMATIONS") == 2)
        {
            // Will search all the time, when they walk, or if we are not going to move.
            ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
        }
        // Which shall we use? Day or night?
        string sWay = GetStringPrefix("NW_GENERIC_WALKWAYS");
        // Gets if there is a waypoint first...
        string sWayTag = GetTag(OBJECT_SELF);
        sWayTag = sWay + sWayTag + "_01";
        object oWay1 = GetNearestObjectByTag(sWayTag);
        // Get the object, if nearest (IE in area one) is not valid.
        if(!GetIsObjectValid(oWay1))
        {
            oWay1 = GetObjectByTag(sWayTag);
        }
        // If we are going to walk some waypoints, we cannot have animations.
        // This script is only activated ONCE, so these are never re-deleted or locations set twice.
        if(GetIsObjectValid(oWay1))
        {
            if(GetLocalInt(OBJECT_SELF, "AI_ANIMATIONS") > 0)
            {
                //turn off the ambient animations if the creature should walk way points.
                DeleteLocalInt(OBJECT_SELF, "AI_ANIMATIONS");
            }
            if(GetSpawnInCondition(RETURN_TO_SPAWN_LOCATION))
            {
                //turn off returning to spawn point.
                SetSpawnInCondition(RETURN_TO_SPAWN_LOCATION, FALSE);
            }
            // Way point valid! starta walking
            int nNth = 1;
            int nTens, nNum;
            string sNearestTag, sTens;
            object oNearest = GetNearestObject(OBJECT_TYPE_WAYPOINT, OBJECT_SELF, nNth);
            while(GetIsObjectValid(oNearest))
            {
                sNearestTag = GetTag(oNearest);
                //removes the first 3 and last three characters from the waypoint's tag
                //and checks it against his own tag.  Waypoint tag format is WP_MyTag_XX.
                if(GetSubString(sNearestTag, 3, GetStringLength(sNearestTag) - 6) == GetTag(OBJECT_SELF))
                {
                    sTens = GetStringRight(sNearestTag, 2);
                    nTens = StringToInt(sTens)/10;
                    nNum = StringToInt(GetStringRight(sNearestTag, 1));
                    oNearest = OBJECT_INVALID;
                }
                else
                {
                    nNth++;
                    oNearest = GetNearestObject(OBJECT_TYPE_WAYPOINT, OBJECT_SELF, nNth);
                }
            }
            // Changed internally, to run circuits and so on. Use return; not return TRUE etc.
            RunCircuit(nTens, nNum, nRun, fPause);
            ActionWait(fPause);
            ActionDoCommand(RunNextCircuit(nRun, fPause));
        }
        else  // Else go to the post we have set.
        {
            sWayTag = GetStringPrefix("NW_GENERIC_POSTING") + GetTag(OBJECT_SELF);
            oWay1 = GetNearestObjectByTag(sWayTag);
            if(!GetIsObjectValid(oWay1))
            {
                oWay1 = GetObjectByTag(sWayTag);
            }
            if(GetIsObjectValid(oWay1) && GetDistanceToObject(oWay1) > 0.0)
            {
                ActionForceMoveToObject(oWay1, nRun, 1.0, 60.0);
                float fFacing = GetFacing(oWay1);
                ActionDoCommand(SetFacing(fFacing));
                // If it is only a night post, or something, who knows, maybe we want to
                // start again?
                DelayCommand(100.0, WalkWayPoints());
            }
        }
    }
}
// This just carries on walking around and around...
void RunNextCircuit(int nRun, float fPause)
{
    RunCircuit(0, 1, nRun, fPause);
    ActionWait(fPause);
    ActionDoCommand(RunNextCircuit(nRun, fPause));
}
//::///////////////////////////////////////////////
//:: Run Circuit
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Calculates the proper path to follow along a
    predetermined set of way points
*/
//:://////////////////////////////////////////////
//:: Created By: Aidan Scanlan
//:: Created On: July 10, 2001
//:://////////////////////////////////////////////
// Added things from Two's verion - Jasperre
void RunCircuit(int nTens, int nNum, int nRun, float fPause)
{
    // starting at a given way point, move sequentialy through incrementally
    // increasing points until there are no more valid ones.
    // We will check for day/night in these instead of heartbeats.
    string sWay = GetStringPrefix("NW_GENERIC_WALKWAYS");
    string sNewString;
    object oTargetPoint = GetWaypointByTag(sWay + GetTag(OBJECT_SELF) + "_" + IntToString(nTens) + IntToString(nNum));
    while(GetIsObjectValid(oTargetPoint))
    {
        ActionWait(fPause);
        ActionMoveToObject(oTargetPoint, nRun);
        nNum++;
        if (nNum > 9)
        {
            nTens++;
            nNum = 0;
        }
        // Maybe change string prefix to use.
        sNewString = GetStringPrefix("NW_GENERIC_WALKWAYS");
        if(sNewString != sWay)
        {
            sWay == sNewString;
        }
        oTargetPoint = GetWaypointByTag(sWay + GetTag(OBJECT_SELF) + "_" + IntToString(nTens) + IntToString(nNum));
    }
    // changes by two.
    // once there are no more waypoints available, check if we are at our post
    object oCurrentWP = oTargetPoint;
    string sWayTag = GetStringPrefix("NW_GENERIC_POSTING") + GetTag(OBJECT_SELF);
    oTargetPoint = GetNearestObjectByTag(sWayTag);
    if(!GetIsObjectValid(oTargetPoint))
    {
        oTargetPoint = GetObjectByTag(sWayTag);
    }
    if(GetIsObjectValid(oTargetPoint) && GetDistanceToObject(oTargetPoint) > 0.0)
    {
        ActionForceMoveToObject(oTargetPoint, nRun, 1.0, 60.0);
        float fFacing = GetFacing(oTargetPoint);
        ActionDoCommand(SetFacing(fFacing));
        return;
    }
    // no post, lets check if I shall walk in circles or walk back
    else
    {
        sNewString = GetStringPrefix("NW_GENERIC_WALKWAYS");
        if(sNewString != sWay)
        {
            sWay == sNewString;
        }
        sWayTag = sWay + GetTag(OBJECT_SELF) + "_01";
        oTargetPoint = GetNearestObjectByTag(sWayTag);
        if(!GetIsObjectValid(oTargetPoint))
        {
            oTargetPoint = GetObjectByTag(sWayTag);
        }
        if(GetIsObjectValid(oTargetPoint))
        {
            // If the first waypoint is actually nearby...return true to walk it again!
            if(GetDistanceBetween(oTargetPoint, oCurrentWP) < 3.0 && GetDistanceBetween(oTargetPoint, oCurrentWP) >= 0.0)
            {
                return;// Stop and don't walk backwards.
            }
            else
            {
                nNum--;
                if(nNum < 0)
                {
                    nTens--;
                    nNum = 9;
                }
                // start the cycle again going back to point 01
                oTargetPoint = GetWaypointByTag(sWay + GetTag(OBJECT_SELF) + "_" + IntToString(nTens) +IntToString(nNum));
                while(GetIsObjectValid(oTargetPoint))
                {
                    ActionWait(fPause);
                    ActionMoveToObject(oTargetPoint, nRun);
                    nNum--;
                    if (nNum < 0)
                    {
                        nTens--;
                        nNum = 9;
                    }
                    oTargetPoint = GetWaypointByTag(sWay + GetTag(OBJECT_SELF) + "_" + IntToString(nTens) +IntToString(nNum));
                }
            }
        }
    }
}
//::///////////////////////////////////////////////
//:: Check Walkways
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This function checks the passed in object to
    see if they are supposed to be walking to
    day or night postings.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Feb 26, 2002
//:://////////////////////////////////////////////
int CheckWayPoints(object oWalker)
{
    object oWay1;
    object oWay2;
    object oWay3;
    object oWay4;
    string sTag = GetTag(oWalker);
    oWay2 = GetWaypointByTag("NIGHT_" + sTag);
    oWay4 = GetWaypointByTag("WN_" + sTag + "_01");
    oWay1 = GetWaypointByTag("POST_" + sTag);
    oWay3 = GetWaypointByTag("WP_" + sTag + "_01");
    if(GetIsObjectValid(oWay1) || GetIsObjectValid(oWay3))
    {
        return TRUE;
    }
    return FALSE;
}
// Returns the string to use - depending on day or night.
string GetStringPrefix(string sPrefix, object oWalker)
{
    if(GetIsDay() || GetIsDawn())
    {
        return GetLocalString(OBJECT_SELF, sPrefix + "_DAY");
    }
    else
    {
        return GetLocalString(OBJECT_SELF, sPrefix + "_NIGHT");
    }
}

