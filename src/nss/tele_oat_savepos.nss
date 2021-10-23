//::///////////////////////////////////////////////
//:: Teleportsystem: Die Aktuelle Position speichern
//:: tele_oat_savepos
//:: (C): dunahan@schwerterkueste, 08.01.2013
//:://////////////////////////////////////////////
/*
     Zu setzen unter, On Aktion Taken beim Gespraech
     Speichert die aktuelle Positon des Spielers ab,
     damit diese spaeter genutzt werden kann.

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

  if (GetLocalInt(GetArea(oPC), "NoSave") == 0)
  {
    SetLocalLocationOverride(oPC, TELEARRAY, oItem);
    SetLocalInt(oPC, "SaveOnExit", 1);
    SendServerMessageToPC(oPC, "Deine Positon in "
    +GetName(GetAreaFromLocation(GetLocalLocationOverride(oPC, TELEARRAY, oItem)))+
    " wurde gespeichert und Speichern beim LogOff deaktiviert.\n"+
    "Willst Du Speichern beim LogOff aktivieren, dann steige jetzt aus und wieder ein.\n"+
    "Beim Wiedereinstieg wird diese Option wieder aktiviert.");
  }

  else
    SendServerMessageToPC(oPC, "Speichern der Position nicht erlaubt!");
}
