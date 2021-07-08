//::///////////////////////////////////////////////
//:: HABD fuer Isladora
//:: sk_habd_soulst
//:: Copyright (c) 2011 dunahan@isladora
//:://////////////////////////////////////////////
/*
    Hat der Spieler einen Seelenstein
*/
//:://////////////////////////////////////////////
//:: Created By: dunahan@schwerterkueste.de
//:: Created On: 04.05.2011
//:://////////////////////////////////////////////
#include "_isla_inc"

int StartingConditional()
{
  object oRespawn = GetPCSpeaker();                                             // Der Gestorbene, der wieder zurück will
  object oDeathScribe = GetWaypointByTag("bookofdead");                         // Wegpunkt auf dem die Daten gespeichert sind
  object oSoul = GetItemPossessedBy(oRespawn, "itm_soulstone");                 //Suche nach den Seelensteinen im Inv

  // Token, nachdem gesucht werden soll, bzw. das bei Ableben gespeichert wurde
  string sResapwnName = GetPCPlayerName(oRespawn)+GetName(oRespawn);
  // TokenString in dem Gesucht/Gespeichert/Gelöscht wird
  string sDeathScribe = GetLocalString(oDeathScribe, "The_Dead");

  // Hat noch Seelensteine UND ist Name ist auf Wegpunkt
  if (GetIsObjectValid(oSoul)==TRUE &&
      GetIsTokenInString(sDeathScribe, sResapwnName)==TRUE)
  { return TRUE; }
  else
  { return FALSE; }

}
