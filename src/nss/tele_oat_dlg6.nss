//::///////////////////////////////////////////////
//:: Teleportsystem: Zur Heim Position beamen
//:: tele_oat_dlg6
//:: (C): dunahan@schwerterkueste, 08.01.2013
//:://////////////////////////////////////////////
/*
     Zu setzen unter, On Aktion Taken beim Gespraech
     Beamt den Spieler, sofern vorhanden, zur persistent
     gespeicherten Heimstatt, die er sich erkauft hat

*/
//:://////////////////////////////////////////////
//:: Created By: dunahan@schwerterkueste.de
//:: Created On: 08.01.2013
//:://////////////////////////////////////////////

#include "tele_inc"

void main()
{
  object oPC = GetPCSpeaker();
  location locJumpTo = GetHomeLocation(oPC);

  if ( //GetIsObjectValid(GetAreaFromLocation(locJumpTo)) &&                      // die HomeLoc existiert
       GetAreaFromLocation(locJumpTo) != GetArea(oPC))                          // UND ist nicht die jetzige (GetHomeLocation gibt die aktuelle Position bei Fehlern aus!)
    DelayedJumpToLocation(oPC, locJumpTo);
}
