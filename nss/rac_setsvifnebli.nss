//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: rac_setsvirfnebli
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Sonderrassen
    Stelle Svirfneblin ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  if   ( GetRacialType(oRacePC) == 2 ) { SetSubRace(oRacePC, "Svirfneblin");
  object oItem = GetItemPossessedBy(oRacePC, "itm_questbuch");
  SetLocalInt(oItem, "ECL", 2);
  LoadSubraceOnPC(oRacePC, "Svirfneblin"); }

  else                             { SendServerMessageToPC(oRacePC,
                                     "Du musst ein Gnom sein, um diese Sonderrasse auszuwählen"); }

}
