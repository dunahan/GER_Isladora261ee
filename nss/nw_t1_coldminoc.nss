//::///////////////////////////////////////////////
//:: Minor Frost Trap
//:: NW_T1_ColdMinC
//:://////////////////////////////////////////////
/*
    Strikes the entering object with a blast of
    cold for 2d4 damage. Fortitude save to avoid
    being paralyzed for 1 round.
*/
//:://////////////////////////////////////////////
//:: Created By: The Krit
//:: Created On: December 10, 2010
//:://////////////////////////////////////////////


#include "tk_trap_inc"


void main()
{
    DoFrostTrap(d4(2), 1, 12);
}

