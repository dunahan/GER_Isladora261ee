//::///////////////////////////////////////////////
//:: Questsystem per Notizbuch
//:: qsa_quest002
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*  Ein Questsystem per Item.
    Vergabe, Quest wurde angenommen.
    Einzusetzen im Gespräch bei OnActionTaken
    - Aktualisieren des Headers */
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 05.12.2009
//:: Last Modified On: 15.04.2013
//:://////////////////////////////////////////////
#include "qsa_include"

void main()
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
  string sPacket = GetLocalString(oData, "Packet");

  // 2.1 Prüfe, ob ein Paket geliefert werden soll,
  // 2.1.1 Kein Paket wird geliefert, aktiviere die Quest wie normal
  if ( sPacket != "" )
    CreateItemOnObject(GetLocalString(oData, "Packet"), oPC);                   // Erschaffe und übergib das Paket

  SetLocalInt(oBook, sQuestname, QUEST_ANGENOMMEN);                             // Annehmen der Quest
  SendServerMessageToPC(oPC, "Quest: " + sQuestname + " angenommen");                 // Teile dies dem Spieler mit
}
