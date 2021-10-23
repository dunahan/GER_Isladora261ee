//::///////////////////////////////////////////////
//:: Electrical Trap
//:: NW_T1_ElecMinoC.nss
//:://////////////////////////////////////////////
/*
    The creature setting off the trap is struck by
    a strong electrical current that arcs to 3 other
    targets doing 8d6 damage.  Can make a Reflex
    save for half damage.
*/
//:://////////////////////////////////////////////
//:: Created By: The Krit
//:: Created On: December 10, 2010
//:://////////////////////////////////////////////


#include "tk_trap_inc"


void main()
{
    DoElectricalTrap(8, 3, 19);
}

