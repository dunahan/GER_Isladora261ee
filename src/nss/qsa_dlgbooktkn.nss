//::///////////////////////////////////////////////
//:: Questsystem per Notizbuch
//:: qsa_dlgbooktkn
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/* Ein Questsystem per Item, hier für das Item.
    Einsetzbar bei einem Gespräch bei OnTextAppear
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

  // 1.1 Das Questtoken suchen
  object oBook = GetItemPossessedBy(oPC, QUESTBOOK_RESREF);

  // 1.2 Lese die Seitenanzahl und aktuelle Seite aus
  int nFullPage = GetLocalInt(oBook, "nFullPages");  // Gesamtzahl der Seiten

  // 1.2.1 Sollte die Int = 0 sein, auf die Seitenanzahl setzen
  if (nFullPage == 0)   SetLocalInt(oBook, "nFullPages", QUESTBOOK_PAGES );

  // 1.2.2 Aktualisierung, sollte es mehr Seiten geben
  if (nFullPage != QUESTBOOK_PAGES)   SetLocalInt(oBook, "nFullPages", QUESTBOOK_PAGES );

  // 1.2.3 Aktuelle Seitenzahl
  int nPage = GetLocalInt(oBook, "nPage");

  // 1.2.4 Sollte die Int = 0 sein, auf Eins setzen
  if (nPage <= 0)   SetLocalInt(oBook, "nPage", 1);

  // 1.2.5 Momentane Seite anzeigen und in Token schreiben
  SetCustomToken(40046, IntToString(nPage) + " / " + IntToString(QUESTBOOK_PAGES));  // Akutelle Seite / Gesamte Seitenzahl (aus inc)

  // 1.3 Feste Variablen pro Seite deklarieren
  string sQuestgeber1, sQuestgeber2, sQuestgeber3, sQuestgeber4, sQuestgeber5, sStatus1, sStatus2, sStatus3, sStatus4, sStatus5;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  // 2++ switch-Anweisung für die Seiten und Info über die Quests
  switch ( nPage ) {
    case 1: { // Beginn Seite Eins
      string sStatus1 = GetQuestStatus(oBook, QUEST_001); // Quest Beluca auslesen
      int nStatus1 = GetLocalInt(oBook, QUEST_001);
      if (nStatus1 >= 1)   sQuestgeber1 = QUEST_001;
      else                 sQuestgeber1 = QUEST_STRING_NANG;

      string sStatus2 = GetQuestStatus(oBook, QUEST_002); // Quest Krabat auslesen
      int nStatus2 = GetLocalInt(oBook, QUEST_002);
      if (nStatus2 >= 1)   sQuestgeber2 = QUEST_002;
      else                 sQuestgeber2 = QUEST_STRING_NANG;

      string sStatus3 = GetQuestStatus(oBook, QUEST_003); // Quest Remmet auslesen
      int nStatus3 = GetLocalInt(oBook, QUEST_003);
      if (nStatus3 >= 1)   sQuestgeber3 = QUEST_003;
      else                 sQuestgeber3 = QUEST_STRING_NANG;

      string sStatus4 = GetQuestStatus(oBook, QUEST_004); // Quest Soirry auslesen
      int nStatus4 = GetLocalInt(oBook, QUEST_004);
      if (nStatus4 >= 1)   sQuestgeber4 = QUEST_004;
      else                 sQuestgeber4 = QUEST_STRING_NANG;

      string sStatus5 = GetQuestStatus(oBook, QUEST_005); // Quest Bolgurt auslesen
      int nStatus5 = GetLocalInt(oBook, QUEST_005);
      if (nStatus5 >= 1)   sQuestgeber5 = QUEST_005;
      else                 sQuestgeber5 = QUEST_STRING_NANG;

      // Token der aktuellen Seite eintragen
      SetCustomToken(40041, "Quest: "+ sQuestgeber1 +", Status: " + sStatus1);
      SetCustomToken(40042, "Quest: "+ sQuestgeber2 +", Status: " + sStatus2);
      SetCustomToken(40043, "Quest: "+ sQuestgeber3 +", Status: " + sStatus3);
      SetCustomToken(40044, "Quest: "+ sQuestgeber4 +", Status: " + sStatus4);
      SetCustomToken(40045, "Quest: "+ sQuestgeber5 +", Status: " + sStatus5);
    break;  } //Ende Seite Eins
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case 2: { // Beginn Seite Zwei
      string sStatus1 = GetQuestStatus(oBook, QUEST_006); // Quest Sharto auslesen
      int nStatus1 = GetLocalInt(oBook, QUEST_006);
      if (nStatus1 >= 1)   sQuestgeber1 = QUEST_006;
      else                 sQuestgeber1 = QUEST_STRING_NANG;

      string sStatus2 = GetQuestStatus(oBook, QUEST_007); // Quest Miliz auslesen
      int nStatus2 = GetLocalInt(oBook, QUEST_007);
      if (nStatus2 >= 1)   sQuestgeber2 = QUEST_007;
      else                 sQuestgeber2 = QUEST_STRING_NANG;

      string sStatus3 = GetQuestStatus(oBook, QUEST_008); // Quest Leer auslesen
      int nStatus3 = GetLocalInt(oBook, QUEST_008);
      if (nStatus3 >= 1)   sQuestgeber3 = QUEST_008;
      else                 sQuestgeber3 = QUEST_STRING_NANG;

      string sStatus4 = GetQuestStatus(oBook, QUEST_009); // Quest Leer auslesen
      int nStatus4 = GetLocalInt(oBook, QUEST_009);
      if (nStatus4 >= 1)   sQuestgeber4 = QUEST_009;
      else                 sQuestgeber4 = QUEST_STRING_NANG;

      string sStatus5 = GetQuestStatus(oBook, QUEST_010); // Quest Leer auslesen
      int nStatus5 = GetLocalInt(oBook, QUEST_010);
      if (nStatus5 >= 1)   sQuestgeber5 = QUEST_010;
      else                 sQuestgeber5 = QUEST_STRING_NANG;

      // Token der aktuellen Seite eintragen
      SetCustomToken(40041, "Quest: "+ sQuestgeber1 +", Status: " + sStatus1);
      SetCustomToken(40042, "Quest: "+ sQuestgeber2 +", Status: " + sStatus2);
      SetCustomToken(40043, "Quest: "+ sQuestgeber3 +", Status: " + sStatus3);
      SetCustomToken(40044, "Quest: "+ sQuestgeber4 +", Status: " + sStatus4);
      SetCustomToken(40045, "Quest: "+ sQuestgeber5 +", Status: " + sStatus5);
    break;  } //Ende Seite Zwei
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case 3: { // Beginn Seite Drei
      string sStatus1 = GetQuestStatus(oBook, QUEST_011); // Quest Leer auslesen
      int nStatus1 = GetLocalInt(oBook, QUEST_011);
      if (nStatus1 >= 1)   sQuestgeber1 = QUEST_011;
      else                 sQuestgeber1 = QUEST_STRING_NANG;

      string sStatus2 = GetQuestStatus(oBook, QUEST_012); // Quest Leer auslesen
      int nStatus2 = GetLocalInt(oBook, QUEST_012);
      if (nStatus2 >= 1)   sQuestgeber2 = QUEST_012;
      else                 sQuestgeber2 = QUEST_STRING_NANG;

      string sStatus3 = GetQuestStatus(oBook, QUEST_013); // Quest Leer auslesen
      int nStatus3 = GetLocalInt(oBook, QUEST_013);
      if (nStatus3 >= 1)   sQuestgeber3 = QUEST_013;
      else                 sQuestgeber3 = QUEST_STRING_NANG;

      string sStatus4 = GetQuestStatus(oBook, QUEST_014); // Quest Leer auslesen
      int nStatus4 = GetLocalInt(oBook, QUEST_014);
      if (nStatus4 >= 1)   sQuestgeber4 = QUEST_014;
      else                 sQuestgeber4 = QUEST_STRING_NANG;

      string sStatus5 = GetQuestStatus(oBook, QUEST_015); // Quest Leer auslesen
      int nStatus5 = GetLocalInt(oBook, QUEST_015);
      if (nStatus5 >= 1)   sQuestgeber5 = QUEST_015;
      else                 sQuestgeber5 = QUEST_STRING_NANG;

      // Token der aktuellen Seite eintragen
      SetCustomToken(40041, "Quest: "+ sQuestgeber1 +", Status: " + sStatus1);
      SetCustomToken(40042, "Quest: "+ sQuestgeber2 +", Status: " + sStatus2);
      SetCustomToken(40043, "Quest: "+ sQuestgeber3 +", Status: " + sStatus3);
      SetCustomToken(40044, "Quest: "+ sQuestgeber4 +", Status: " + sStatus4);
      SetCustomToken(40045, "Quest: "+ sQuestgeber5 +", Status: " + sStatus5);
    break;  } //Ende Seite Drei
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case 4: { // Beginn Seite Vier
      string sStatus1 = GetQuestStatus(oBook, QUEST_016); // Quest Leer auslesen
      int nStatus1 = GetLocalInt(oBook, QUEST_016);
      if (nStatus1 >= 1)   sQuestgeber1 = QUEST_016;
      else                 sQuestgeber1 = QUEST_STRING_NANG;

      string sStatus2 = GetQuestStatus(oBook, QUEST_017); // Quest Leer auslesen
      int nStatus2 = GetLocalInt(oBook, QUEST_017);
      if (nStatus2 >= 1)   sQuestgeber2 = QUEST_017;
      else                 sQuestgeber2 = QUEST_STRING_NANG;

      string sStatus3 = GetQuestStatus(oBook, QUEST_018); // Quest Leer auslesen
      int nStatus3 = GetLocalInt(oBook, QUEST_018);
      if (nStatus3 >= 1)   sQuestgeber3 = QUEST_018;
      else                 sQuestgeber3 = QUEST_STRING_NANG;

      string sStatus4 = GetQuestStatus(oBook, QUEST_019); // Quest Leer auslesen
      int nStatus4 = GetLocalInt(oBook, QUEST_019);
      if (nStatus4 >= 1)   sQuestgeber4 = QUEST_019;
      else                 sQuestgeber4 = QUEST_STRING_NANG;

      string sStatus5 = GetQuestStatus(oBook, QUEST_020); // Quest Leer auslesen
      int nStatus5 = GetLocalInt(oBook, QUEST_020);
      if (nStatus5 >= 1)   sQuestgeber5 = QUEST_020;
      else                 sQuestgeber5 = QUEST_STRING_NANG;

      // Token der aktuellen Seite eintragen
      SetCustomToken(40041, "Quest: "+ sQuestgeber1 +", Status: " + sStatus1);
      SetCustomToken(40042, "Quest: "+ sQuestgeber2 +", Status: " + sStatus2);
      SetCustomToken(40043, "Quest: "+ sQuestgeber3 +", Status: " + sStatus3);
      SetCustomToken(40044, "Quest: "+ sQuestgeber4 +", Status: " + sStatus4);
      SetCustomToken(40045, "Quest: "+ sQuestgeber5 +", Status: " + sStatus5);
    break;  } //Ende Seite Vier
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    default: { // Default Switch-Anweisung, sollte etwas nicht stimmen!
      SetCustomToken(40041, "Fehler!");
      SetCustomToken(40042, "Fehler!");
      SetCustomToken(40043, "Fehler!");
      SetCustomToken(40044, "Fehler!");
      SetCustomToken(40045, "Fehler!");
    break;   }
  }
  return TRUE;  // Immer einen Wert zurueckgeben.
}
