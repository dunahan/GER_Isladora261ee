//::///////////////////////////////////////////////
//:: Teleportsystem: Zur Heim Position beamen
//:: tele_oat_dlg6
//:: (C): dunahan@schwerterkueste, 08.01.2013
//:://////////////////////////////////////////////
/*
     Zu setzen unter, On Text Appears When beim Gespraech
     Fragt ab, ob eine Heim Position besteht.
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
  location locJumpTo = GetHomeLocation(oPC);

  if ( //GetIsObjectValid(GetAreaFromLocation(locJumpTo)) &&                      // die HomeLoc existiert UND
       GetAreaFromLocation(locJumpTo) != GetArea(oPC))                          // ist nicht die jetzige (GetHomeLocation gibt die aktuelle Position bei Fehlern aus!)
    return TRUE;

  else
    return FALSE;
}
