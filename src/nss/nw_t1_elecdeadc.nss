//::///////////////////////////////////////////////
//:: Electrical Trap
//:: NW_T1_ElecDeadC.nss
//:://////////////////////////////////////////////
/*
    The creature setting off the trap is struck by
    a strong electrical current that arcs to 6 other
    targets doing 30d6 damage.  Can make a Reflex
    save for half damage.
*/
//:://////////////////////////////////////////////
//:: Created By: The Krit
//:: Created On: December 10, 2010
//:://////////////////////////////////////////////


#include "tk_trap_inc"


void main()
{
    DoElectricalTrap(30, 6, 28);
}

