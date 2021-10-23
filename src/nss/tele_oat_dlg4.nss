//::///////////////////////////////////////////////
//:: Teleportsystem: Zum dritten Dorf beamen
//:: tele_oat_dlg4
//:: (C): dunahan@schwerterkueste, 08.01.2013
//:://////////////////////////////////////////////
/*
     Zu setzen unter, On Aktion Taken beim Gespraech
     Beamt den Spieler, sofern vorhanden, zur dritten
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
  object oJumpTo = GetObjectByTag(CITY003);

  DelayedJumpToObject(oPC, oJumpTo);
}
