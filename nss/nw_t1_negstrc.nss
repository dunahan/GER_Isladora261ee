//::///////////////////////////////////////////////
//:: Strong Negative Energy Trap
//:: NW_T1_NegStrC
//:://////////////////////////////////////////////
/*
    Does 5d6 negative energy damage and the target
    must make a Fort save or take 2 points of
    strength damage
*/
//:://////////////////////////////////////////////
//:: Created By: The Krit
//:: Created On: December 10, 2010
//:://////////////////////////////////////////////
    

#include "tk_trap_inc"


void main()
{
    DoNegativeTrap(d6(5), EffectAbilityDecrease(ABILITY_STRENGTH, 2), 18);
}

