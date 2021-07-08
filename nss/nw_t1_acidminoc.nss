//::///////////////////////////////////////////////
//:: Minor Acid Blob
//:: NW_T1_AcidMinoC
//:://////////////////////////////////////////////
/*
    Target is hit with a blob of acid that does
    3d6 Damage and holds the target for 2 rounds.
    Can make a Reflex save to avoid the hold effect.
*/
//:://////////////////////////////////////////////
//:: Created By: The Krit
//:: Created On: December 10, 2010
//:://////////////////////////////////////////////


#include "tk_trap_inc"


void main()
{
    DoBlobTrap(d6(3), 2, 15);
}

