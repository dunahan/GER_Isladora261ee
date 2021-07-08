//::///////////////////////////////////////////////
//:: Teleportsystem: Allgemeine Texte einlesen
//:: tele_taw_dlg0
//:: (C): dunahan@schwerterkueste, 08.01.2013
//:://////////////////////////////////////////////
/*
     Zu setzen unter, On Text Appears When beim Gespraech
     Liesst vorgegebene Texte ein.


*/
//:://////////////////////////////////////////////
//:: Created By: dunahan@schwerterkueste.de
//:: Created On: 08.01.2013
//:://////////////////////////////////////////////

#include "tele_inc"

int StartingConditional()
{
  object oNSC = OBJECT_SELF;
  object oPC = GetPCSpeaker();
  object oItem = GetItemPossessedBy(oPC, ITEMFORPOSITIONS);

  SetCustomToken(60000, GetLocalString(oNSC, "60000"));  // Anfangstext Zeile 1
  SetCustomToken(60001, GetLocalString(oNSC, "60001"));  // Anfangstext Zeile 2

  location PersPosition = GetLocalLocationOverride(oPC, TELEARRAY, oItem);
  object oArea = GetAreaFromLocation(PersPosition); string sAreaPosition;
  if (GetIsObjectValid(oArea) == TRUE) sAreaPosition = GetName(oArea);
  else                                 sAreaPosition = "Unbekannt";
  SetCustomToken(60002, sAreaPosition);                                         // Persistente Position, Name der Map

  SetCustomToken(60003, GetName(GetArea(GetObjectByTag(CITY001))));             // Moegliche Startorte, Name der Map
  SetCustomToken(60004, GetName(GetArea(GetObjectByTag(CITY002))));             // Moegliche Startorte, Name der Map
  SetCustomToken(60005, GetName(GetArea(GetObjectByTag(CITY003))));             // Moegliche Startorte, Name der Map

  object RacialPos = GetRacialWaypoint(oPC); string sAreaRace;
  if (GetIsObjectValid(RacialPos) == FALSE) RacialPos = GetSubRacialWaypoint(oPC);
  if (GetIsObjectValid(RacialPos) == FALSE) RacialPos = GetFactioalWaypoint(oPC);
  if (GetName(GetArea(RacialPos)) == "")    sAreaRace = "Unbekannt";
  else                                      sAreaRace = GetName(GetArea(RacialPos));
  SetCustomToken(60006, sAreaRace);  // (Sub)Rassen Teleport, Name der Map

  location HomePositions = GetHomeLocation(oPC);
  object oHomeArea = GetAreaFromLocation(HomePositions); string sHomeArea;
  if (GetIsObjectValid(oHomeArea) == TRUE)  sHomeArea = GetName(oHomeArea);
  else                                      sHomeArea = "Unbekannt";
  SetCustomToken(60007, sHomeArea);  // Heimat Position, Name der Map

  return TRUE;  //generell Wahr wiedergeben. Es soll keine Pruefung erfolgen
}
