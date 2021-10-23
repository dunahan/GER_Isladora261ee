//::///////////////////////////////////////////////
//:: Strong Acid Blob
//:: NW_T1_AcidStrC
//:://////////////////////////////////////////////
/*
    Target is hit with a blob of acid that does
    12d6 Damage and holds the target for 4 rounds.
    Can make a Reflex save to avoid the hold effect.
*/
//:://////////////////////////////////////////////
//:: Created By: The Krit
//:: Created On: December 10, 2010
//:://////////////////////////////////////////////


#include "tk_trap_inc"


void main()
{
    DoBlobTrap(d6(12), 4, 25);
}

