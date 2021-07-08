//::///////////////////////////////////////////////
//:: Gas Trap
//:: NW_T1_GasStrC.nss
//:://////////////////////////////////////////////
/*
    Creates a  5m poison radius gas cloud that
    lasts for 2 rounds and poisons all creatures
    entering the area with Dark Reaver Powder
*/
//:://////////////////////////////////////////////
//:: Created By: The Krit
//:: Created On: December 10, 2010
//:://////////////////////////////////////////////


#include "tk_trap_inc"


void main()
{
    DoGasTrap(2, "NW_T1_GasStrC0", "NW_T1_GasStrC1");
}

