//::///////////////////////////////////////////////
//:: FileName sk_nohorse
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 23.10.2009 12:01:16
//:://////////////////////////////////////////////
#include "nw_i0_plot"

int StartingConditional()
{
    // Sicherstellen, dass der SC-Sprecher diese Gegenst�nde in seinem Gep�ck tr�gt
    if (HasItem(GetPCSpeaker(), "summonmyhorse") == TRUE)
        return FALSE;

    else
        return TRUE;
}
