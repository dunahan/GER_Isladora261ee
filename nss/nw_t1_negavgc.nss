//::///////////////////////////////////////////////
//:: Average Negative Energy Trap
//:: NW_T1_NegMinC
//:://////////////////////////////////////////////
/*
    Does 2d6 negative energy damage and the target
    must make a Fort save or take 1 point of
    strength damage
*/
//:://////////////////////////////////////////////
//:: Created By: The Krit
//:: Created On: December 10, 2010
//:://////////////////////////////////////////////


#include "tk_trap_inc"


void main()
{
    DoNegativeTrap(d6(3), EffectAbilityDecrease(ABILITY_STRENGTH, 1), 15);
}

