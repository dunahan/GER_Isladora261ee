//::///////////////////////////////////////////////
//:: Teleportsystem: Zum Rassen Position beamen
//:: tele_taw_dlg5
//:: (C): dunahan@schwerterkueste, 08.01.2013
//:://////////////////////////////////////////////
/*
     Zu setzen unter, On Text Appears When beim Gespraech
     Fragt ab, ob eine Rassen Position besteht.
     Wenn ja, dann gibt es die Option frei

*/
//:://////////////////////////////////////////////
//:: Created By: dunahan@schwerterkueste.de
//:: Created On: 08.01.2013
//:://////////////////////////////////////////////

#include "tele_inc"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int nResult = FALSE;

  if (GetIsObjectValid(GetRacialWaypoint(oPC)) == TRUE)
    nResult = TRUE;

  if (GetSubRace(oPC) != "" && GetIsObjectValid(GetSubRacialWaypoint(oPC)) == TRUE)
    nResult = TRUE;

  if (GetIsObjectValid(GetFactioalWaypoint(oPC)) == TRUE)
    nResult = TRUE;

  return nResult;
}
