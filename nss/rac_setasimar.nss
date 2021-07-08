//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: rac_setaasimar
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Sonderrassen
    Stelle Aasimar ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  if   ( GetRacialType(oRacePC) == 6 ) { SetSubRace(oRacePC, "Aasimar");
  object oItem = GetItemPossessedBy(oRacePC, "itm_questbuch");
  SetLocalInt(oItem, "ECL", 1); LoadSubraceOnPC(oRacePC, "Aasimar"); }

  else                             { SendServerMessageToPC(oRacePC,
                                     "Du musst ein Mensch sein, um diese Sonderrasse auszuwählen"); }

}
