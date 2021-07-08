//::///////////////////////////////////////////////
//:: Questsystem per Notizbuch
//:: qsa_quest003
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*  Ein Questsystem per Item.
    Sichtung, Quest wurde angenommen?
    Einzusetzen im Gespräch bei OnTextAppear
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

  // 2++ Lokale Variable sichten
  // 2.1 Prüf ob die Quest hat den Angenommen-Status hat
  if( GetLocalInt(oBook, sQuestname) != QUEST_ANGENOMMEN )
    return FALSE;                                                               // Wenn nein, dann gib Falsch aus

  return TRUE;                                                                  // Ansonsten gib Wahr aus
}
