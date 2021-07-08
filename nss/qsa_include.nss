//::///////////////////////////////////////////////
//:: Questsystem per Notizbuch
//:: qsa_include
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*  Ein Questsystem per Item.
    Die bestimmende Include! */
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 05.12.2009
//:://////////////////////////////////////////////
#include "x0_i0_partywide"

#include "ll_include"
#include "_isla_inc"
#include "kevls_timerinc"

// Gesamte Questseiten für Abfrage der Seitenanzahl
const int    QUESTBOOK_PAGES = 2;
const string QUESTBOOK_RESREF = "itm_questbuch";
const float  TEAM_DIST = 5.0;
const int    QSA_DBG = FALSE;

// Queststati
// Stati per SetLocalInt gesetzt         Bezeichnung per SetLocalString gesetzt
const int QUEST_NICHT_ANGENOMMEN = 0;    const string QUEST_STRING_NANG = "Unbekannt";
const int QUEST_ANGENOMMEN       = 1;    const string QUEST_STRING_ANGN = "Angenommen";
const int QUEST_LAUFEND          = 2;    const string QUEST_STRING_LAUF = "Laufend";
const int QUEST_ABGESCHLOSSEN    = 3;    const string QUEST_STRING_ABGS = "Fertig";

const string QUEST_PARTYMSG_ABGS = "Du hast eine Quest mit deiner Gruppe bestritten.";

// Questnamen folgend
// Noch nicht erstellte Quests
const string QUEST_000 = "Unbekannt";

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

//Bereits eingebaute Quests
// Seite 1                               Seite 2
const string QUEST_001 = "Beluca";       const string QUEST_006 = "Sharto";
const string QUEST_002 = "Krabat";       const string QUEST_007 = "Unbekannt";
const string QUEST_003 = "Remmen";       const string QUEST_008 = "Chana";
const string QUEST_004 = "Soirry";       const string QUEST_009 = "Unbekannt";
const string QUEST_005 = "Bolgurt";      const string QUEST_010 = "Unbekannt";

// Seite 3                               Seite 4
const string QUEST_011 = "Unbekannt";    const string QUEST_016 = "Unbekannt";
const string QUEST_012 = "Unbekannt";    const string QUEST_017 = "Unbekannt";
const string QUEST_013 = "Unbekannt";    const string QUEST_018 = "Unbekannt";
const string QUEST_014 = "Bael'ath'nis"; const string QUEST_019 = "Unbekannt";
const string QUEST_015 = "Unbekannt";    const string QUEST_020 = "Unbekannt";


////////////////////////////////////////////////////////////////////////////////////
// Lokale Int-Variable auf Item zur Variabelbezeichnung auslesen
// oItem = zu prüfender Gegenstand, sLocVar = zu prüfende Variable
// sStatus = liefert den Status als const string; Unbekannt, wenn nicht vorhanden.
string GetQuestStatus(object oItem, string sLocVar);

////////////////////////////////////////////////////////////////////////////////////
// Schickt allen PartyMembers des abschließenden Spielers eine Nachricht
// oPC = der Spieler, der die Quest abgeschlossen hat
// sMsg = Nachricht, die alle seine anderen PartyMembers bekommen sollen
void SendMessageToPartyMembers(object oPC, string sMsg);


string GetQuestStatus(object oItem, string sLocVar)
{
  // 1++ Wichtiges erfassen
  // 1.1 Deklariere wichtige Variablen
  string sStatus;                                             // zu liefender Status zur Bezeichnung
  // 1.2 Status einer bestimmten Variable auslesen
  int nStatus = GetLocalInt(oItem, sLocVar);
  // 2++ Stati auslesen und ausgeben
  // 2.1 Wenn nStauts ungleich 0, dann
  if ( nStatus != 0 )
  {
    // 2.1.1 Status per Switch-Anweisung in String abbilden
    switch (nStatus) {
      case 1:  sStatus = QUEST_STRING_ANGN; break;
      case 2:  sStatus = QUEST_STRING_LAUF; break;
      case 3:  sStatus = QUEST_STRING_ABGS; break;
    } // Ende switch (nStatus)
    // 2.1.2 Status dann ausgeben
    return sStatus;
  }
  // 2.2 Ansonsten ist der Status Unbekannt
  return sStatus = QUEST_STRING_NANG;
}

void SendMessageToPartyMembers(object oPC, string sMsg)
{
  // 1++ Wenn nur ein Spieler in der Party ist, dann brich ab
  if (GetNumberPartyMembers(oPC) <= 1)   return;
  // 2++ Ansonsten rotiere durch alle PartyMembers durch
  object oPartyMember = GetFirstFactionMember(oPC, TRUE);                       // Erster PartyMember erfassen
  while(GetIsObjectValid(oPartyMember) == TRUE) {                               // Ende wenn alle PartyMember erfasst
    SendServerMessageToPC(oPC, sMsg);
    oPartyMember = GetNextFactionMember(oPC, TRUE);
  }
}

void qsa_GiveXPToAllEqually(object oPC, int nXP)
{
  int nEqualAmt = nXP/GetNumberPartyMembers(oPC);

  object oPartyMem = GetFirstFactionMember(oPC, TRUE);
  while (GetIsObjectValid(oPartyMem)) {
      SetXPImproved(oPartyMem, GetXP(oPartyMem) + nEqualAmt);
      oPartyMem = GetNextFactionMember(oPC, TRUE);
  }
}

void qsa_GiveXPToAll(object oPC, int nXP)
{
  object oPartyMem = GetFirstFactionMember(oPC, TRUE);
  while (GetIsObjectValid(oPartyMem)) {
      SetXPImproved(oPartyMem, GetXP(oPartyMem) + nXP);
      oPartyMem = GetNextFactionMember(oPC, TRUE);
  }
}

string qsa_PrintDebug(object oObject = OBJECT_SELF)
{
  object o = GetWaypointByTag(GetResRef(oObject));                              // wenn ein WP mit gleichem ResRef gefunden wurde (Spawnpoit)
  if (GetIsObjectValid(o)) oObject = o;                                         // lese die Daten von dort aus, somit funktionieren dann auch Aenderungen

  string sItemToTake = GetLocalString(oObject, "Questitem");
  string sQuestBel = GetLocalString(oObject, "QuestBelohnung");
  return "Data:"+GetName(oObject)+"/"+GetTag(oObject)+"\n-*-*-*-*-*-*-\n"+
         "Quest: "+GetLocalString(oObject, "Questname")+"\n"+
         "Item: "+GetObjectName(sItemToTake)+" ("+sItemToTake+")\n"+
         "Reward: "+GetObjectName(sQuestBel)+" ("+sQuestBel+")\n"+
         "XP: "+IntToString(GetLocalInt(oObject, "EP_Belohnung"))+"\n"+
         "GP: "+IntToString(GetLocalInt(oObject, "Gold_Belohnung"))+"\n"+
         "Reset: "+IntToString(GetLocalInt(oObject, "Delay"))+" Sekunden.\n"+
         "XP/GP teilen: "+IntToString(GetLocalInt(oObject, "DivideXPGP"))+"\n"+
         "Partymembers: "+IntToString(GetNumberPartyMembers(GetPCSpeaker()))+"."+
         "\n-*-*-*-*-*-*-\n";
}

void qsa_CopyVars(object oTarget, object oObject = OBJECT_SELF)
{
  if (GetIsObjectValid(oTarget) && GetLocalInt(oTarget, "init")==0) {
    SetLocalString(oTarget, "40000", GetLocalString(oObject, "40000"));
    SetLocalString(oTarget, "40001", GetLocalString(oObject, "40001"));
    SetLocalString(oTarget, "40002", GetLocalString(oObject, "40002"));
    SetLocalString(oTarget, "40003", GetLocalString(oObject, "40003"));
    SetLocalString(oTarget, "40004", GetLocalString(oObject, "40004"));
    SetLocalString(oTarget, "40005", GetLocalString(oObject, "40005"));
    SetLocalString(oTarget, "40010", GetLocalString(oObject, "40010"));
    SetLocalString(oTarget, "40011", GetLocalString(oObject, "40011"));
    SetLocalString(oTarget, "40012", GetLocalString(oObject, "40012"));
    SetLocalString(oTarget, "40020", GetLocalString(oObject, "40020"));
    SetLocalString(oTarget, "40021", GetLocalString(oObject, "40021"));
    SetLocalString(oTarget, "40022", GetLocalString(oObject, "40022"));
    SetLocalString(oTarget, "40030", GetLocalString(oObject, "40030"));
    SetLocalString(oTarget, "40031", GetLocalString(oObject, "40031"));

    SetLocalString(oTarget, "Questitem", GetLocalString(oObject, "Questitem"));
    SetLocalString(oTarget, "QuestBelohnung", GetLocalString(oObject, "QuestBelohnung"));
    SetLocalString(oTarget, "Questname", GetLocalString(oObject, "Questname"));
    SetLocalInt(oTarget, "EP_Belohnung", GetLocalInt(oObject, "EP_Belohnung"));
    SetLocalInt(oTarget, "Gold_Belohnung", GetLocalInt(oObject, "Gold_Belohnung"));
    SetLocalInt(oTarget, "DivideXPGP", GetLocalInt(oObject, "DivideXPGP"));
    SetLocalInt(oTarget, "Delay", GetLocalInt(oObject, "Delay"));
    SetLocalInt(oTarget, "Reset", GetLocalInt(oObject, "Reset"));

    SetLocalInt(oTarget, "init", 1);
  }
}
