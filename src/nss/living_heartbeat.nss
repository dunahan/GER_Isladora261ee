#include "nw_i0_generic"

/* Living Towns 1.1
   09/2006 Emmental */

// Maximum distance from a destination to be recognised as having reached that destination
const float CONFIG_DESTINATION_DISTANCE = 1.0;
// Maximum social interaction distance
const float CONFIG_SOCIAL_DISTANCE = 4.0;

/* Function to replace a a substring in a string with another */
string EtlReplaceString(string sSource, string sReplaceThis, string sReplaceWith)
{
    string sNewString = "";
    int iPos = FindSubString(sSource, sReplaceThis);
    if (iPos != -1)
    {
        sNewString = GetSubString(sSource, 0, iPos);
        sNewString += sReplaceWith;
        sNewString += GetSubString(sSource, iPos + GetStringLength(sReplaceThis), GetStringLength(sSource) - iPos - GetStringLength(sReplaceThis));
    }
    return sNewString;
}

void main()
{
    // Variables
    int iLoop;
    int iCurrentHour;
    int iLampNumber;

    // Set the run flag now since it's used in more than one place
    int bRun = Random(100) + 1 <= GetLocalInt(OBJECT_SELF, "L_RUN_CHANCE");

    /* Most of the living actions are ignored if the NPC is "at home" as part of
       a nightly action. */

    // Check for a return command
    if (GetLocalInt(OBJECT_SELF, "L_TEMP_RETURN"))
    {
        // Set destination
        SetLocalString(OBJECT_SELF, "L_TEMP_MOVINGTO", "*LASTLOCATION");
        // Ignore flags while moving
        SetLocalInt(OBJECT_SELF, "L_TEMP_IGNOREFLAGS", 1);
        // Delete the temporary flag
        DeleteLocalInt(OBJECT_SELF, "L_TEMP_RETURN");
    }

    // Check for a post (similar to POST_ for walking waypoints, but always spawn-in location. Used to return after lamps since there's no fixed end time)
    if (!GetLocalInt(OBJECT_SELF, "L_TEMP_ATHOME") && !GetLocalInt(OBJECT_SELF, "L_TEMP_DOINGLAMPS") && !GetLocalInt(OBJECT_SELF, "L_TEMP_IGNOREFLAGS") && GetLocalInt(OBJECT_SELF, "L_FLAG_POST"))
    {
        // Store the current location if not already done
        if (!GetLocalInt(OBJECT_SELF, "L_TEMP_LOCATIONSTORED"))
        {
            SetLocalLocation(OBJECT_SELF, "L_TEMP_POSTLOCATION", GetLocation(OBJECT_SELF));
            SetLocalFloat(OBJECT_SELF, "L_TEMP_POSTFACING", GetFacing(OBJECT_SELF));
            SetLocalInt(OBJECT_SELF, "L_TEMP_LOCATIONSTORED", 1);
        }
        SetLocalString(OBJECT_SELF, "L_TEMP_MOVINGTO", "*POST");
    }

    // Check for random walking
    if (!GetLocalInt(OBJECT_SELF, "L_TEMP_ATHOME") && !GetLocalInt(OBJECT_SELF, "L_TEMP_DOINGLAMPS") && !GetLocalInt(OBJECT_SELF, "L_TEMP_IGNOREFLAGS") && GetLocalInt(OBJECT_SELF, "L_FLAG_RANDOMWALK"))
    {
        SetLocalString(OBJECT_SELF, "L_TEMP_MOVINGTO", "*RANDOMWALK");
        // Flag the fact that this action will need a clear to be interrupted
        SetLocalInt(OBJECT_SELF, "L_TEMP_NEEDSCLEAR", 1);
    }

    // Check for random walking while at home
    if (GetLocalInt(OBJECT_SELF, "L_TEMP_ATHOME") && !GetLocalInt(OBJECT_SELF, "L_TEMP_IGNOREFLAGS") && GetLocalInt(OBJECT_SELF, "L_FLAG_RANDOMWALK_ATHOME"))
    {
        SetLocalString(OBJECT_SELF, "L_TEMP_MOVINGTO", "*RANDOMWALK");
        // Flag the fact that this action will need a clear to be interrupted
        SetLocalInt(OBJECT_SELF, "L_TEMP_NEEDSCLEAR", 1);
    }

    // Check for waypoint walking
    if (!GetLocalInt(OBJECT_SELF, "L_TEMP_ATHOME") && !GetLocalInt(OBJECT_SELF, "L_TEMP_DOINGLAMPS") && !GetLocalInt(OBJECT_SELF, "L_TEMP_DOINGLAMPS") && !GetLocalInt(OBJECT_SELF, "L_TEMP_IGNOREFLAGS")  && GetLocalInt(OBJECT_SELF, "L_FLAG_WALKWAYPOINTS"))
    {
        SetLocalString(OBJECT_SELF, "L_TEMP_MOVINGTO", "*WALKWAYPOINTS");
        // Flag the fact that this action will need a clear to be interrupted
        SetLocalInt(OBJECT_SELF, "L_TEMP_NEEDSCLEAR", 1);
    }

    // Check for random waypoint walking
    if (!GetLocalInt(OBJECT_SELF, "L_TEMP_ATHOME") && !GetLocalInt(OBJECT_SELF, "L_TEMP_DOINGLAMPS") && !GetLocalInt(OBJECT_SELF, "L_TEMP_IGNOREFLAGS")  && GetLocalInt(OBJECT_SELF, "L_FLAG_RANDOMWAYPOINTS"))
    {
        // See if we're going to move this time
        if (Random(100) + 1 <= GetLocalInt(OBJECT_SELF, "L_RANDOM_CHANCE"))
        {
            // Count the waypoints
            string sRandomTag = GetLocalString(OBJECT_SELF, "L_RANDOM_TAG");
            iLoop = 1;
            int iRandomCount = 0;
            object sRandomWP = GetObjectByTag(sRandomTag + IntToString(iLoop));
            while (GetIsObjectValid(sRandomWP))
            {
                iRandomCount++;
                iLoop++;
                sRandomWP = GetObjectByTag(sRandomTag + IntToString(iLoop));
            }
            // Pick one
            int iRandomNumber = Random(iRandomCount) + 1;
            // Go there
            SetLocalString(OBJECT_SELF, "L_TEMP_MOVINGTO", sRandomTag + IntToString(iRandomNumber));
        }
    }

    // Check for ambient animations (OK when at home)
    if (!GetIsInCombat() && !IsInConversation(OBJECT_SELF) && !GetLocalInt(OBJECT_SELF, "L_TEMP_DOINGLAMPS") && !GetLocalInt(OBJECT_SELF, "L_TEMP_IGNOREFLAGS") && GetLocalInt(OBJECT_SELF, "L_FLAG_AMBIENT"))
    {
        //Check chance
        if (Random(100) + 1 <= GetLocalInt(OBJECT_SELF, "L_AMBIENT_CHANCE"))
        {
            // The delays are needed to allow and worlk properly with walking
            DelayCommand(3.5, ClearAllActions());
            int iAnimation;
            switch (Random(6))
            {
                case 0:
                {
                    iAnimation = ANIMATION_LOOPING_PAUSE_TIRED;
                    break;
                }
                case 1:
                {
                    iAnimation = ANIMATION_FIREFORGET_HEAD_TURN_LEFT;
                    break;
                }
                case 2:
                {
                    iAnimation = ANIMATION_FIREFORGET_HEAD_TURN_RIGHT;
                    break;
                }
                case 3:
                {
                    iAnimation = ANIMATION_FIREFORGET_PAUSE_BORED;
                    break;
                }
                case 4:
                {
                    iAnimation = ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD;
                    break;
                }
                case 5:
                {
                    iAnimation = ANIMATION_LOOPING_LOOK_FAR;
                    break;
                }
            }
            // Play it
            DelayCommand(4.0, ActionPlayAnimation(iAnimation, 1.0, 1.5));
        }
    }

    // Check for sitting (different chairs for home and not)
    if (!GetIsInCombat() && !IsInConversation(OBJECT_SELF) && !GetLocalInt(OBJECT_SELF, "L_TEMP_DOINGLAMPS") && !GetLocalInt(OBJECT_SELF, "L_TEMP_IGNOREFLAGS") && GetLocalInt(OBJECT_SELF, "L_FLAG_SIT"))
    {
        // Get the chair, depending on where we are
        object oChair;
        if (GetLocalInt(OBJECT_SELF, "L_TEMP_ATHOME"))
            oChair = GetObjectByTag(GetLocalString(OBJECT_SELF, "L_SIT_HOMECHAIR"));
        else
            oChair = GetObjectByTag(GetLocalString(OBJECT_SELF, "L_SIT_CHAIR"));
        // Check it exists and nobody else is on it (including self so don't keep spamming the sit command)
        if (GetIsObjectValid(oChair) && !GetIsObjectValid(GetSittingCreature(oChair)))
        {
            ClearAllActions();
            ActionSit(oChair);
            // Flag the fact that this action will need a clear to be interrupted
            SetLocalInt(OBJECT_SELF, "L_TEMP_NEEDSCLEAR", 1);
        }
    }

    // Check for lamp lighting
    if (GetLocalInt(OBJECT_SELF, "L_FLAG_LAMPS"))
    {
        // Set the lamp state
        iCurrentHour = GetTimeHour();
        int iLampState = -1;
        if (iCurrentHour == GetLocalInt(OBJECT_SELF, "L_LAMPS_HOUR1"))
            iLampState = 1;
        else if (iCurrentHour == GetLocalInt(OBJECT_SELF, "L_LAMPS_HOUR2"))
            iLampState = 2;
        // Check if it's time to start, and not the same as last completed state, or already doing it
        int iDoingLamps = GetLocalInt(OBJECT_SELF, "L_TEMP_DOINGLAMPS");
        if ((iLampState != -1 && iLampState != GetLocalInt(OBJECT_SELF, "L_TEMP_LAMPCOMPLETION")) || iDoingLamps)
        {
            // Get the lamp number from the NPC
            iLampNumber = GetLocalInt(OBJECT_SELF, "L_TEMP_LAMPNUMBER");
            // Check if this is the start of this state
            if (iLampNumber == 0)
            {
                // Set and store the lamp number
                iLampNumber = 1;
                SetLocalInt(OBJECT_SELF, "L_TEMP_LAMPNUMBER", 1);
                // Store location
                SetLocalLocation(OBJECT_SELF, "L_TEMP_LASTLOCATION", GetLocation(OBJECT_SELF));
                SetLocalFloat(OBJECT_SELF, "L_TEMP_LASTFACING", GetFacing(OBJECT_SELF));
            }
            // Store the lamp state on the NPC, unless already doing it
            if (!iDoingLamps)
                SetLocalInt(OBJECT_SELF, "L_TEMP_LAMPSTATE", iLampState);
            // Go to the lamp
            SetLocalString(OBJECT_SELF, "L_TEMP_MOVINGTO", GetLocalString(OBJECT_SELF, "L_LAMPS_TAG") + IntToString(iLampNumber));
            // Flag that we're doing lamps (may take longer than the specified hour)
            SetLocalInt(OBJECT_SELF, "L_TEMP_DOINGLAMPS", 1);
        }
    }

    // Check if we should go home at night
    if (GetLocalInt(OBJECT_SELF, "L_FLAG_NIGHTHOME"))
    {
        // Read the variables
        int iHomeHour = GetLocalInt(OBJECT_SELF, "L_HOME_HOMEHOUR");
        int iLeaveHour = GetLocalInt(OBJECT_SELF, "L_HOME_LEAVEHOUR");
        string sHomeWP = GetLocalString(OBJECT_SELF, "L_HOME_WAYPOINT");
        iCurrentHour = GetTimeHour();
        // Check if it's time to go home, and not already there
        if (iCurrentHour == iHomeHour && !GetLocalInt(OBJECT_SELF, "L_TEMP_ATHOME"))
        {
            // Store location
            SetLocalLocation(OBJECT_SELF, "L_TEMP_LASTLOCATION", GetLocation(OBJECT_SELF));
            SetLocalFloat(OBJECT_SELF, "L_TEMP_LASTFACING", GetFacing(OBJECT_SELF));
            // Set a destination
            SetLocalString(OBJECT_SELF, "L_TEMP_MOVINGTO", sHomeWP);
            // Set the "at home" flag
            SetLocalInt(OBJECT_SELF, "L_TEMP_ATHOME", 1);
            // Ignore flags while moving
            SetLocalInt(OBJECT_SELF, "L_TEMP_IGNOREFLAGS", 1);
        }
        // Check if it's time to leave, and not already left
        if (iCurrentHour == iLeaveHour && GetLocalInt(OBJECT_SELF, "L_TEMP_ATHOME"))
        {
            // Clear the "at home" flag
            DeleteLocalInt(OBJECT_SELF, "L_TEMP_ATHOME");
            // Unock their door, if any
            if (GetLocalInt(OBJECT_SELF, "L_HOME_LOCK"))
                SetLocked(GetObjectByTag(GetLocalString(OBJECT_SELF, "L_HOME_DOOR")), 0);
            // Set flag to return
            SetLocalInt(OBJECT_SELF, "L_TEMP_RETURN", 1);
        }
    }

    // Check for social interaction if not in conversation or combat
    if (!GetIsInCombat() && !IsInConversation(OBJECT_SELF) && GetLocalInt(OBJECT_SELF, "L_FLAG_SOCIABLE"))
    {
        // Variables
        int bDoneSocial = 0;
        int iSocialCount;
        string sSocialString;
        // Token variables
        string sDayNight;
        string sSirMaam;
        string sMisterMiss;
        // Enumnerate nearby creatures
        int iSocialGroup = GetLocalInt(OBJECT_SELF, "L_SOCIAL_GROUP");
        object oSocialTarget = GetFirstObjectInShape(SHAPE_SPHERE, CONFIG_SOCIAL_DISTANCE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        while (!bDoneSocial && GetIsObjectValid(oSocialTarget) && !GetIsDM(oSocialTarget))
        {
            // Check if we are only interested in PCs or if any will do
            if (iSocialGroup >= 0 || (iSocialGroup == -1 && GetIsPC(oSocialTarget)))
            {
                // Check our social chance
                if (Random(100) + 1 <= GetLocalInt(OBJECT_SELF, "L_SOCIAL_CHANCE"))
                {
                    // Check the social group, and not self
                    if (oSocialTarget != OBJECT_SELF && (iSocialGroup == 0 || iSocialGroup == -1 || iSocialGroup == GetLocalInt(oSocialTarget, "L_SOCIAL_GROUP")))
                    {
                        // Count how many social strings we have
                        iLoop = 1;
                        iSocialCount = 0;
                        sSocialString = GetLocalString(OBJECT_SELF, "L_SOCIAL_STRING" + IntToString(iLoop));
                        while (sSocialString != "")
                        {
                            iSocialCount++;
                            iLoop++;
                            sSocialString = GetLocalString(OBJECT_SELF, "L_SOCIAL_STRING" + IntToString(iLoop));
                        }
                        // Pick one
                        int iSocialStringNumber = Random(iSocialCount) + 1;
                        sSocialString = GetLocalString(OBJECT_SELF, "L_SOCIAL_STRING" + IntToString(iSocialStringNumber));
                        // Set special token variables
                        if (GetIsDay())
                            sDayNight = "day";
                        else
                            sDayNight = "night";
                        if (GetGender(oSocialTarget) == GENDER_FEMALE)
                        {
                            sSirMaam = "ma'am";
                            sMisterMiss = "mister";
                        }
                        else
                        {
                            sSirMaam = "miss";
                            sMisterMiss = "mister";
                        }
                        // Replace special tokens
                        while (FindSubString(sSocialString, "%name%") != -1)
                            sSocialString = EtlReplaceString(sSocialString, "%name%", GetName(oSocialTarget));
                        while (FindSubString(sSocialString, "%daynight%") != -1)
                            sSocialString = EtlReplaceString(sSocialString, "%daynight%", sDayNight);
                        while (FindSubString(sSocialString, "%sirmaam%") != -1)
                            sSocialString = EtlReplaceString(sSocialString, "%sirmaam%", sSirMaam);
                        while (FindSubString(sSocialString, "%mistermiss%") != -1)
                            sSocialString = EtlReplaceString(sSocialString, "%mistermiss%", sMisterMiss);
                        // Check for and remove emote flags
                        int iAnimation = -1;
                        while (FindSubString(sSocialString, ":bow:") != -1)
                        {
                            sSocialString = EtlReplaceString(sSocialString, ":bow:", "");
                            iAnimation = ANIMATION_FIREFORGET_BOW;
                        }
                        while (FindSubString(sSocialString, ":greet:") != -1)
                        {
                            sSocialString = EtlReplaceString(sSocialString, ":greet:", "");
                            iAnimation = ANIMATION_FIREFORGET_GREETING;
                        }
                        while (FindSubString(sSocialString, ":salute:") != -1)
                        {
                            sSocialString = EtlReplaceString(sSocialString, ":salute:", "");
                            iAnimation = ANIMATION_FIREFORGET_SALUTE;
                        }
                        while (FindSubString(sSocialString, ":bored:") != -1)
                        {
                            sSocialString = EtlReplaceString(sSocialString, ":bored:", "");
                            iAnimation = ANIMATION_FIREFORGET_PAUSE_BORED;
                        }
                        while (FindSubString(sSocialString, ":scratch:") != -1)
                        {
                            sSocialString = EtlReplaceString(sSocialString, ":scratch:", "");
                            iAnimation = ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD;
                        }
                        while (FindSubString(sSocialString, ":drunk:") != -1)
                        {
                            sSocialString = EtlReplaceString(sSocialString, ":drunk:", "");
                            iAnimation = ANIMATION_LOOPING_PAUSE_DRUNK;
                        }
                        while (FindSubString(sSocialString, ":tired:") != -1)
                        {
                            sSocialString = EtlReplaceString(sSocialString, ":tired:", "");
                            iAnimation = ANIMATION_LOOPING_PAUSE_TIRED;
                        }
                        while (FindSubString(sSocialString, ":laugh:") != -1)
                        {
                            sSocialString = EtlReplaceString(sSocialString, ":laugh:", "");
                            iAnimation = ANIMATION_LOOPING_TALK_LAUGHING;
                        }
                        while (FindSubString(sSocialString, ":angry:") != -1)
                        {
                            sSocialString = EtlReplaceString(sSocialString, ":angry:", "");
                            iAnimation = ANIMATION_LOOPING_TALK_FORCEFUL;
                        }
                        while (FindSubString(sSocialString, ":plead:") != -1)
                        {
                            sSocialString = EtlReplaceString(sSocialString, ":plead:", "");
                            iAnimation = ANIMATION_LOOPING_TALK_PLEADING;
                        }
                        while (FindSubString(sSocialString, ":taunt:") != -1)
                        {
                            sSocialString = EtlReplaceString(sSocialString, ":taunt:", "");
                            iAnimation = ANIMATION_FIREFORGET_TAUNT;
                        }
                        while (FindSubString(sSocialString, ":read:") != -1)
                        {
                            sSocialString = EtlReplaceString(sSocialString, ":read:", "");
                            iAnimation = ANIMATION_FIREFORGET_READ;
                        }
                        while (FindSubString(sSocialString, ":victory1:") != -1)
                        {
                            sSocialString = EtlReplaceString(sSocialString, ":victory1:", "");
                            iAnimation = ANIMATION_FIREFORGET_VICTORY1;
                        }
                        while (FindSubString(sSocialString, ":victory2:") != -1)
                        {
                            sSocialString = EtlReplaceString(sSocialString, ":victory2:", "");
                            iAnimation = ANIMATION_FIREFORGET_VICTORY1;
                        }
                        while (FindSubString(sSocialString, ":victory3:") != -1)
                        {
                            sSocialString = EtlReplaceString(sSocialString, ":victory3:", "");
                            iAnimation = ANIMATION_FIREFORGET_VICTORY1;
                        }
                        while (FindSubString(sSocialString, ":listen:") != -1)
                        {
                            sSocialString = EtlReplaceString(sSocialString, ":listen:", "");
                            iAnimation = ANIMATION_LOOPING_LISTEN;
                        }
                        while (FindSubString(sSocialString, ":lookfar:") != -1)
                        {
                            sSocialString = EtlReplaceString(sSocialString, ":lookfar:", "");
                            iAnimation = ANIMATION_LOOPING_LOOK_FAR;
                        }
                        // Do the emote, if any, and if within the chance
                        if (iAnimation != -1 && (Random(100) + 1 <= GetLocalInt(OBJECT_SELF, "L_SOCIAL_EMOTECHANCE")))
                        {
                            ClearAllActions();
                            // Face the target
                            ActionDoCommand(SetFacingPoint(GetPosition(oSocialTarget)));
                            // Animate
                            ActionPlayAnimation(iAnimation, 1.0, 1.5);
                        }
                        // Say it
                        SpeakString(sSocialString);
                        // Flag that we've been sociable once this heartbeat
                        bDoneSocial = 1;
                    }
                }
            }
            oSocialTarget = GetNextObjectInShape(SHAPE_SPHERE, CONFIG_SOCIAL_DISTANCE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }

    /* The actual movement is done here. The NPC is instructed to move as long
       as its destination variable is set. The variable is cleared once the NPC
       gets within 1 metre of it. This allows for the travel to be interrupted
       temporarily by PCs talking to the NPC or by combat. */

    // Check for a destination
    string sDestination = GetLocalString(OBJECT_SELF, "L_TEMP_MOVINGTO");
    if (sDestination != "")
    {
        // Attempt to move if not in combat or conversation
        if (!GetIsInCombat() && !IsInConversation(OBJECT_SELF))
        {
            // Random walk
            if (sDestination == "*RANDOMWALK")
                ActionRandomWalk();
            // Walk waypoints
            else if (sDestination == "*WALKWAYPOINTS")
                WalkWayPoints();
            // Specific destination
            else
            {
                // Clear the action queue if needed
                if (GetLocalInt(OBJECT_SELF, "L_TEMP_NEEDSCLEAR"))
                {
                    ClearAllActions();
                    DeleteLocalInt(OBJECT_SELF, "L_TEMP_NEEDSCLEAR");
                }
                // Move
                location lLocation;
                float fFacing;
                object oWaypoint;
                // Check if it's a return to last location
                if (sDestination == "*LASTLOCATION")
                {
                    lLocation = GetLocalLocation(OBJECT_SELF, "L_TEMP_LASTLOCATION");
                    fFacing  = GetLocalFloat(OBJECT_SELF, "L_TEMP_LASTFACING");
                }
                // Check if it's a return to post
                else if (sDestination == "*POST")
                {
                    lLocation = GetLocalLocation(OBJECT_SELF, "L_TEMP_POSTLOCATION");
                    fFacing = GetLocalFloat(OBJECT_SELF, "L_TEMP_POSTFACING");
                }
                else
                {
                    lLocation = GetLocation(GetWaypointByTag(sDestination));
                    oWaypoint = GetWaypointByTag(sDestination);
                    fFacing = GetFacing(oWaypoint);
                }
                // Move
                ActionMoveToLocation(lLocation, bRun);
                // Clear the destination if close enough
                float fDistance = GetDistanceBetweenLocations(lLocation, GetLocation(OBJECT_SELF));
                if (fDistance >= 0.0 & fDistance <= CONFIG_DESTINATION_DISTANCE)
                {
                    // See if we were sent home
                    if (GetLocalInt(OBJECT_SELF, "L_TEMP_ATHOME"))
                    {
                        // Lock the door, if any
                        if (GetLocalInt(OBJECT_SELF, "L_HOME_LOCK"))
                            SetLocked(GetObjectByTag(GetLocalString(OBJECT_SELF, "L_HOME_DOOR")), 1);
                        // Set the facing if not set to random walk at home
                        if (!GetLocalInt(OBJECT_SELF, "L_FLAG_RANDOMWALK_ATHOME"))
                            ActionDoCommand(SetFacing(fFacing));
                    }
                    // See if we're doing lamps
                    if (GetLocalInt(OBJECT_SELF, "L_TEMP_DOINGLAMPS"))
                    {
                        // Set the facing
                        ActionDoCommand(SetFacing(GetFacing(oWaypoint)));
                        // Play animation (there's a whole heartbeat before we move again)
                        ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 2.0);
                        // Swap the lamp placeable
                        string sLampState = IntToString(GetLocalInt(OBJECT_SELF, "L_TEMP_LAMPSTATE"));
                        object oLamp = GetNearestObjectByTag(GetLocalString(oWaypoint, "L_LAMPS_TAG" + sLampState));
                        location lLampLocation = GetLocation(oLamp);
                        DestroyObject(oLamp);
                        oLamp = CreateObject(OBJECT_TYPE_PLACEABLE, GetLocalString(oWaypoint, "L_LAMPS_RESREF" + sLampState), lLampLocation);
                        // Get the next lamp
                        iLampNumber = GetLocalInt(OBJECT_SELF, "L_TEMP_LAMPNUMBER");
                        iLampNumber++;
                        string sLampTag = GetLocalString(OBJECT_SELF, "L_LAMPS_TAG") + IntToString(iLampNumber);
                        oWaypoint = GetObjectByTag(sLampTag);
                        // If it exists then continue
                        if (GetIsObjectValid(oWaypoint))
                            // Store the lamp number
                            SetLocalInt(OBJECT_SELF, "L_TEMP_LAMPNUMBER", iLampNumber);
                        // Otherwise end
                        else
                        {
                            // Store the last completed lamp state on the NPC (so we don't go do it again if we're still in the same hour)
                            SetLocalInt(OBJECT_SELF, "L_TEMP_LAMPCOMPLETION", GetLocalInt(OBJECT_SELF, "L_TEMP_LAMPSTATE"));
                            // Delete variables
                            DeleteLocalInt(OBJECT_SELF, "L_TEMP_DOINGLAMPS");
                            DeleteLocalInt(OBJECT_SELF, "L_TEMP_LAMPNUMBER");
                            DeleteLocalInt(OBJECT_SELF, "L_TEMP_LAMPSTATE");
                            // Set flag to return
                            SetLocalInt(OBJECT_SELF, "L_TEMP_RETURN", 1);
                        }

                    }
                    // Set the facing if we were returning or to post and none of the walking flags set
                    if (GetLocalString(OBJECT_SELF, "L_TEMP_MOVINGTO") == "*LASTLOCATION" || GetLocalString(OBJECT_SELF, "L_TEMP_MOVINGTO") == "*POST")
                    {
                        if (!GetLocalInt(OBJECT_SELF, "L_FLAG_RANDOMWALK") && !GetLocalInt(OBJECT_SELF, "L_FLAG_WALKWAYPOINTS") && !GetLocalInt(OBJECT_SELF, "L_FLAG_RANDOMWAYPOINTS"))
                            ActionDoCommand(SetFacing(fFacing));
                        // Delete temporary variables
                        DeleteLocalLocation(OBJECT_SELF, "L_TEMP_LASTLOCATION");
                        ActionDoCommand(DeleteLocalFloat(OBJECT_SELF, "L_TEMP_LASTFACING")); // So that the variable doesn't get deleted before we've used it
                    }
                    // Clear variables
                    DeleteLocalString(OBJECT_SELF, "L_TEMP_MOVINGTO");
                    DeleteLocalInt(OBJECT_SELF, "L_TEMP_IGNOREFLAGS");
                }
            }
        }
    }
}

