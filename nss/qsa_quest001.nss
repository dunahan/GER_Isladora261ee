//::///////////////////////////////////////////////
//:: Questsystem per Notizbuch
//:: qsa_quest001
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*  Ein Questsystem per Item, hier Prüfung.
    Sichtung, die Quest wurde bereits angenommen?
    Einsetzbar im Gespräch bei OnTextAppear
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

  // 1.2 Das Questtoken suchen
  object oBook = GetItemPossessedBy(oPC, QUESTBOOK_RESREF);

  // 2++ Auslesen der lokalen Variablen des Questtokens
  // 2.1 Prüfe ob die Quest bereits angenommen wurde,
  if(!(GetLocalInt(oBook, sQuestname) == QUEST_NICHT_ANGENOMMEN))
    return FALSE;                                                               // Sie wurde nicht angenommen, also gib Falsch aus

  return TRUE;                                                                  // Sie wurde bereits angenommen, also gib Wahr aus
}
