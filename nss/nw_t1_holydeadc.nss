//::///////////////////////////////////////////////
//:: Deadly Holy Trap
//:: NW_T1_HolyDeadC
//:://////////////////////////////////////////////
/*
    Strikes the entering undead with a dose of holy
    water for 12d10 damage.
*/
//:://////////////////////////////////////////////
//:: Created By: The Krit
//:: Created On: December 10, 2010
//:://////////////////////////////////////////////


#include "tk_trap_inc"


void main()
{
    DoHolyTrap(d10(12), d4(8));
}

