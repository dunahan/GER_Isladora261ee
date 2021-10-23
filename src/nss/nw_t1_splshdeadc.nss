//::///////////////////////////////////////////////
//:: Deadly Acid Splash Trap
//:: NW_T1_SplshStrC
//:://////////////////////////////////////////////
/*
    Strikes the entering object with a blast of
    cold for 8d8 damage. Reflex save to take
    1/2 damage.
*/
//:://////////////////////////////////////////////
//:: Created By: The Krit
//:: Created On: December 10, 2010
//:://////////////////////////////////////////////


#include "tk_trap_inc"


void main()
{
    DoSplashTrap(d8(8), 20);
}

