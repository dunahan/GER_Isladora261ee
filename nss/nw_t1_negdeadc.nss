//::///////////////////////////////////////////////
//:: Deadly Negative Energy Trap
//:: NW_T1_NegDeadC
//:://////////////////////////////////////////////
/*
    Does 8d6 negative energy damage and the target
    must make a Fort save or take 1 negative level
*/
//:://////////////////////////////////////////////
//:: Created By: The Krit
//:: Created On: December 10, 2010
//:://////////////////////////////////////////////


#include "tk_trap_inc"


void main()
{
    DoNegativeTrap(d6(8), EffectNegativeLevel(1), 21);
}

