//::///////////////////////////////////////////////
//:: Questsystem per Notizbuch
//:: qsa_quest004
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*  Ein Questsystem per Item.
    Sichtung, Questitem vorhanden oder Questmonster besiegt?
    Einzufuegen im Gespraech bei OnTextAppear
    - Aktualisieren des Headers */
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 05.12.2009
//:: Last Modified On: 15.04.2013
//:://////////////////////////////////////////////
#include "qsa_include"

int StartingConditional()
{
  // 1++ Deklariere die wichtigsten Variablen, Objekte usw
  object oPC  = GetPCSpeaker();    // der Ansprecher
  object oData = OBJECT_SELF;
  object oSpawn = GetWaypointByTag(GetResRef(oData));
  if (GetIsObjectValid(oSpawn))  oData = oSpawn;

  // 1.1 Quest auslesen
  string sQuestname = GetLocalString(oData, "Questname");

  // 1.2 Werden Items abverlangt oder als Belohnung gegeben?
  string sItemToTake = GetLocalString(oData, "Questitem");                      // ResRef des Questgegenstandes

  // 2++ Prüf ob der Spieler das gesuchte Item hat ODER
  //     ob er die Questbedingung bereits läuft?
  if  ( (GetItemPossessedBy(oPC, sItemToTake) == OBJECT_INVALID ) ||
        (GetLocalInt(oPC, sQuestname) == QUEST_LAUFEND) )
    return FALSE;                                                               // Er hat das Item nicht ODER die Quest läuft noch, gib Falsch aus

  return TRUE;                                                                  // Ansonsten gib Wahr aus.
}
