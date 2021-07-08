//::///////////////////////////////////////////////
//:: Questsystem per Notizbuch
//:: qsa_quest005
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*  Ein Questsystem per Item.
    Abschluss der Quest und Vergabe der Belohnungen.
    Einzufuegen im Gespräch bei OnActionTaken
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

  // 1.2 Werden Items abverlangt oder als Belohnung gegeben?
  string sItemToTake = GetLocalString(oData, "Questitem");                      // ResRef des Questgegenstandes
  object oItemToTake = GetItemPossessedBy(oPC, sItemToTake);                    // Suche dieses Item bei Spieler
  string sQuestBel = GetLocalString(oData, "QuestBelohnung");                   // ResRef der Belohnung
  object oQuestBel = GetItemPossessedBy(oPC, sQuestBel);                        // Suche dieses Item bei Spieler

  // 1.3 Belohnungen Auslesen
  int nXP   = GetLocalInt(oData, "EP_Belohnung");                               // EP-Wert auslesen
  int nGold = GetLocalInt(oData, "Gold_Belohnung");                             // Goldmenge auslesen

  // 1.4 Das Questtoken suchen
  object oBook = GetItemPossessedBy(oPC, QUESTBOOK_RESREF);

  // 2++ Abschließende Prüfungen zur Quest
  // 2.1 Wenn Items benötigt werden, nimm sie dem SC ab und schliesse die Quest ab
  if (GetIsObjectValid(oItemToTake) != 0)
    DestroyObject(oItemToTake);                                                 // Nimm das Item ab

  SetLocalInt(oBook, sQuestname, QUEST_ABGESCHLOSSEN);                          // Abschliessen der Quest
  SendServerMessageToPC(oPC, "Quest: " + sQuestname + " abgeschlossen");              // Teile dies mit

  // 3++ Vergib EP, Gold und/oder Gegenstand (entweder an alle gleichwertig oder aufgeteilt)
  if (GetLocalInt(oData, "DivideXPGP")) {                                       // Wenn teilen vorgesehen (nicht Standard)
    GiveGoldToAllEqually(oPC, nGold);
    qsa_GiveXPToAllEqually(oPC, nXP);

  } else {
    GiveGoldToAll(oPC, nGold);
    qsa_GiveXPToAll(oPC, nXP);
  }

  // 3.1 Vergib den Belohnungsgegenstand nur ein einziges mal!
  if (!GetIsObjectValid(oQuestBel) && !GetLocalInt(oPC, sQuestBel) ) {
    CreateItemOnObject(sQuestBel, oPC);
    SetLocalInt(oPC, sQuestBel, TRUE);
  }

  SendMessageToPartyMembers(oPC, QUEST_PARTYMSG_ABGS);
} //end main
