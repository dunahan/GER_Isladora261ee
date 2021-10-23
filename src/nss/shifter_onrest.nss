// Check shifter wildform reset

#include "shifter_inc"

void main()
{
    object oPC = GetLastPCRested();
    if (GetLocalString(oPC,"CREATURE_RESREF")!="")
    {
        ResetAppearance(oPC);
    }
}

