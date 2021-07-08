//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: rac_setwoodelf
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Sonderrassen
    Stelle Waldelf ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  if   ( GetRacialType(oRacePC) == 1 ) { SetSubRace(oRacePC, "Waldelf");
                                         LoadSubraceOnPC(oRacePC, "Waldelf"); }

  else                             { SendServerMessageToPC(oRacePC,
                                     "Du musst ein Elf sein, um diese Sonderrasse auszuwählen"); }

}
