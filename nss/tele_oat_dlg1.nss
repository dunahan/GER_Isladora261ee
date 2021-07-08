//::///////////////////////////////////////////////
//:: Teleportsystem: Zur letzten bekannten persistenten Position beamen
//:: tele_oat_dlg1
//:: (C): dunahan@schwerterkueste, 08.01.2013
//:://////////////////////////////////////////////
/*
     Zu setzen unter, On Aktion Taken beim Gespraech
     Beamt den Spieler, sofern vorhanden, zur letzten bekannten
     persistent gespeicherten Position, die er selbst
     (oder automatisch) bestimmt hat
*/
//:://////////////////////////////////////////////
//:: Created By: dunahan@schwerterkueste.de
//:: Created On: 08.01.2013
//:://////////////////////////////////////////////

#include "tele_inc"

void main()
{
  object oPC = GetPCSpeaker();
  object oItem = GetItemPossessedBy(oPC, ITEMFORPOSITIONS);

  location locJumpTo = GetLocalLocationOverride(oPC, TELEARRAY, oItem);

  DelayedJumpToLocation(oPC, locJumpTo);
}
