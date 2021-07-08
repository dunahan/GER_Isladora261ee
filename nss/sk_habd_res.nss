//::///////////////////////////////////////////////
//:: HABD fuer Isladora
//:: sk_habd_res
//:: Copyright (c) 2011 dunahan@isladora
//:://////////////////////////////////////////////
/*
    Spieler wurde wiedererweckt?
*/
//:://////////////////////////////////////////////
//:: Created By: dunahan@schwerterkueste.de
//:: Created On: 04.05.2011
//:://////////////////////////////////////////////
#include "_isla_inc"

int StartingConditional()
{
  object oRespawn = GetPCSpeaker();                      // Der Gestorbene, der wieder zurück will
  object oDeathScribe = GetWaypointByTag("bookofdead");  // Wegpunkt auf dem die Daten gespeichert sind

  // Token, nachdem gesucht werden soll, bzw. das bei Ableben gespeichert wurde
  string sResapwnName = GetPCPlayerName(oRespawn)+GetName(oRespawn);
  // TokenString in dem Gesucht/Gespeichert/Gelöscht wird
  string sDeathScribe = GetLocalString(oDeathScribe, "The_Dead");

  // Sollte der Name noch vermerkt sein, nicht belebt => return FALSE
  if (GetIsTokenInString(sDeathScribe, sResapwnName)==TRUE)
  { return FALSE; }
  else
  { return TRUE; }  // Der Name ist nicht mehr vermerkt, wiederbelebt => TRUE

}
