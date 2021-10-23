//::///////////////////////////////////////////////
//:: FileName sk_horseproof
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 23.10.2009 11:36:15
//:://////////////////////////////////////////////
#include "nw_i0_plot"

int StartingConditional()
{
    if (GetGold(GetPCSpeaker()) < 1200)
        return FALSE;

    else if (HasItem(GetPCSpeaker(), "summonmyhorse") == TRUE)
        return FALSE;

    else
        return TRUE;
}
