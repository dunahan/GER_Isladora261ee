//::///////////////////////////////////////////////
//:: Deadly Frost Trap
//:: X2_T1_ColdEpicC
//:://////////////////////////////////////////////
/*
    Strikes the entering object with a blast of
    cold for 40d4 damage. Fortitude save to avoid
    being paralyzed for 4 rounds.
*/
//:://////////////////////////////////////////////
//:: Created By: The Krit
//:: Created On: December 10, 2010
//:://////////////////////////////////////////////


#include "tk_trap_inc"


void main()
{
    DoFrostTrap(d4(40), 4, 30);
}

