#include "shifter_inc"

void main()
{
    effect eDeath = EffectDeath(FALSE, FALSE);
    object oPC = GetLastPlayerDying();
    if (GetLocalString(oPC,"CREATURE_RESREF")!="") ResetAppearance(oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPC);
}
