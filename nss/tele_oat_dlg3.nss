//::///////////////////////////////////////////////
//:: Teleportsystem: Zum zweiten Dorf beamen
//:: tele_oat_dlg3
//:: (C): dunahan@schwerterkueste, 08.01.2013
//:://////////////////////////////////////////////
/*
     Zu setzen unter, On Aktion Taken beim Gespraech
     Beamt den Spieler, sofern vorhanden, zur zweiten
     Dorf Position (vordefinierter Wegpunkt)

*/
//:://////////////////////////////////////////////
//:: Created By: dunahan@schwerterkueste.de
//:: Created On: 08.01.2013
//:://////////////////////////////////////////////

#include "tele_inc"

void main()
{
  object oPC = GetPCSpeaker();
  object oJumpTo = GetObjectByTag(CITY002);

  DelayedJumpToObject(oPC, oJumpTo);
}
