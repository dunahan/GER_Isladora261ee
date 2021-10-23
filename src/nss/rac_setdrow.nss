//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: rac_setdrow
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Sonderrassen
    Stelle Drow ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  if   ( GetRacialType(oRacePC) == 1 ) { SetSubRace(oRacePC, "Drow");
  object oItem = GetItemPossessedBy(oRacePC, "itm_questbuch");
  SetLocalInt(oItem, "ECL", 2);
  LoadSubraceOnPC(oRacePC, "Drow"); }

  else                             { SendServerMessageToPC(oRacePC,
                                     "Du musst ein Elf sein, um diese Sonderrasse auszuwählen"); }

}
