//::///////////////////////////////////////////////
//:: Teleportsystem: On Client Enter
//:: tele_onclent_mod
//:: (C): dunahan@schwerterkueste, 13.02.2013
//:://////////////////////////////////////////////
/*
     Zu setzen unter, On Client Enter (MODUL)
     Setzt ein sofortiges Speichern an

*/
//:://////////////////////////////////////////////
//:: Created By: dunahan@schwerterkueste.de
//:: Created On: 13.02.2013
//:://////////////////////////////////////////////

#include "tele_inc"

void main()
{
  object oPC = GetEnteringObject();
  object oItem = GetItemPossessedBy(oPC, ITEMFORPOSITIONS);

  DelayedSavePosition(oPC, oItem);
}
