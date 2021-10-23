//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: rac_settiefling
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Sonderrassen
    Stelle Tiefling ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  if   ( GetRacialType(oRacePC) == 6 ) { SetSubRace(oRacePC, "Tiefling");
  object oItem = GetItemPossessedBy(oRacePC, "itm_questbuch");
  SetLocalInt(oItem, "ECL", 1);
  LoadSubraceOnPC(oRacePC, "Tiefling"); }

  else                             { SendServerMessageToPC(oRacePC,
                                     "Du musst ein Mensch sein, um diese Sonderrasse auszuwählen"); }

}
