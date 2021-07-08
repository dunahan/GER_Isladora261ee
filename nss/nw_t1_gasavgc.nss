//::///////////////////////////////////////////////
//:: Gas Trap
//:: NW_T1_GasAvgC.nss
//:://////////////////////////////////////////////
/*
    Creates a  5m poison radius gas cloud that
    lasts for 2 rounds and poisons all creatures
    entering the area with Death Blade.
*/
//:://////////////////////////////////////////////
//:: Created By: The Krit
//:: Created On: December 10, 2010
//:://////////////////////////////////////////////


#include "tk_trap_inc"


void main()
{
    DoGasTrap(2, "NW_T1_GasAvgC0", "NW_T1_GasAvgC1");
}

