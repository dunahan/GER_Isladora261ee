//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: rac_setstronghea
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Sonderrassen
    Stelle Starkherz ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  if   ( GetRacialType(oRacePC) == 3 ) { SetSubRace(oRacePC, "Starkherz"); }

  else                             { SendServerMessageToPC(oRacePC,
                                     "Du musst ein Halbling sein, um diese Sonderrasse auszuwählen"); }

}
