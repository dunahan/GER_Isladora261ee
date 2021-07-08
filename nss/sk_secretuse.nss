#include "_isla_inc"

void main()
{

    // Letzer Nutzer erfassen
    object oPC = GetLastUsedBy();

    // Naechsten Waypoints erfassen
    object oTag = GetNearestObject(OBJECT_TYPE_TRIGGER);

    // Tag des Waypoints erfassen
    string sTag = GetTag(oTag);

    // Waypoint erfassen
    object oTarget = GetWaypointByTag("DST_" + sTag);

    // Umgebung des Waypoints erfassen
    location locTarget = GetLocation(oTarget);

    //Verzoegerung notwendig?
    float fDelay = GetLocalFloat(OBJECT_SELF, "DelayedJump");

// - - - - - - - - - - - - - eigentliches Skript - - - - - - - - - - - - - - - -

    if (!GetIsPC(oPC)) return;

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

        if (GetAreaFromLocation(locTarget)==OBJECT_INVALID) return;

        DelayedJumpToObject(oPC, oTarget, fDelay);
}

