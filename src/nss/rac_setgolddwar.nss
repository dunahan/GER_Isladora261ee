//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: rac_setgolddwar
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Sonderrassen
    Stelle Goldzwerg ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  if   ( GetRacialType(oRacePC) == 0 ) { SetSubRace(oRacePC, "Goldzwerg"); }

  else                             { SendServerMessageToPC(oRacePC,
                                     "Du musst ein Zwerg sein, um diese Sonderrasse auszuwählen"); }

}
