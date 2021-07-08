//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: rac_dwarf
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Sonderrassen
    Ist der SC Mensch?
    0 = "Zwerg" 1 = "Elf" 2 = "Gnom" 3 = "Halbling"
    4 = "Halbelf" 5 = "Halbork" 6 = "Mensch"
*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

int StartingConditional()
{
  if (nRace == 0) return TRUE;
  else return FALSE;
}
