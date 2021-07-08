//::///////////////////////////////////////////////
//:: Teleportsystem: Zum Rassen Position beamen
//:: tele_oat_dlg5
//:: (C): dunahan@schwerterkueste, 08.01.2013
//:://////////////////////////////////////////////
/*
     Zu setzen unter, On Aktion Taken beim Gespraech
     Beamt den Spieler, sofern moeglich, zur Rassen
     Position (vordefinierter Wegpunkt)

*/
//:://////////////////////////////////////////////
//:: Created By: dunahan@schwerterkueste.de
//:: Created On: 08.01.2013
//:://////////////////////////////////////////////

#include "tele_inc"

void main()
{
  object oPC = GetPCSpeaker();
  object oJumpTo = GetRacialWaypoint(oPC);

  if (GetIsObjectValid(oJumpTo) == FALSE)
    oJumpTo = GetSubRacialWaypoint(oPC);

  if (GetIsObjectValid(oJumpTo) == FALSE)
    oJumpTo = GetFactioalWaypoint(oPC);

  DelayedJumpToObject(oPC, oJumpTo);
}
