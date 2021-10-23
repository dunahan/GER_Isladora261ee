//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: rac_setduergar
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Sonderrassen
    Stelle Duergar ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  if   ( GetRacialType(oRacePC) == 0 ) { SetSubRace(oRacePC, "Duergar");
  object oItem = GetItemPossessedBy(oRacePC, "itm_questbuch");
  SetLocalInt(oItem, "ECL", 2);
  LoadSubraceOnPC(oRacePC, "Duergar"); }

  else                             { SendServerMessageToPC(oRacePC,
                                     "Du musst ein Zwerg sein, um diese Sonderrasse auszuwählen"); }

}
