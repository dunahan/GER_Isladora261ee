//::///////////////////////////////////////////////
//:: Strong Tangle Trap
//:: NW_T1_TangStrC
//:://////////////////////////////////////////////
/*
    Targets within 10ft of the entering character
    are slowed unless they make a reflex save with
    a DC of 30.  Effect lasts for 4 Rounds
*/
//:://////////////////////////////////////////////
//:: Created By: The Krit
//:: Created On: December 10, 2010
//:://////////////////////////////////////////////


#include "tk_trap_inc"


void main()
{
    DoTangleTrap(4, RADIUS_SIZE_MEDIUM, 30);
}

