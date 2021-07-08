//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: rac_setrockgnome
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Sonderrassen
    Stelle Steingnom ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  if   ( GetRacialType(oRacePC) == 2 ) { SetSubRace(oRacePC, "Steingnom"); }

  else                             { SendServerMessageToPC(oRacePC,
                                     "Du musst ein Gnom sein, um diese Sonderrasse auszuwählen"); }

}
