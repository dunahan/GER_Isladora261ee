//::///////////////////////////////////////////////
//:: Questsystem per Notizbuch
//:: qsa_quest007
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*  Ein Questsystem per Item.
    Zurücksetzen der Quest, da wiederholbar
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

  // 1.1 ID generieren
  string sID = GetName(oPC)+"_"+GetPCPlayerName(oPC);

  // 1.2 Quest auslesen
  string sQuestname = GetLocalString(oData, "Questname");

  // 1.3 Zeitraum in der die Quest wiederholt werden kann
  int nDelay = GetLocalInt(oData, "Delay");

  // 1.4 Das Questtoken suchen
  object oBook = GetItemPossessedBy(oPC, QUESTBOOK_RESREF);

  // 2++ Evtl. Zurücksetzen der Quest
  // 2.1 Prüf ob ein Reset möglich ist. Wenn dieser Möglich ist, dann
  if ( GetLocalInt(oData, "Reset") ) {
    // 2.1.1 Prüfe ob ein Timer eingestellt ist. Wenn Nein, dann gib 5 Min vor
    if ( nDelay == 0 )    nDelay = 300;
    int nElapsedTime = kL_GetIntervalElapsed(sQuestname, oPC);
    if ( nElapsedTime == -1)
      kL_SetIntervalStart(sQuestname, oPC);
    else if (nElapsedTime >= nDelay) {
      DeleteLocalInt(oBook, sQuestname);
      kL_ClearInterval(sQuestname, oPC);
    }
  // 2.2 Es ist kein Reset möglich, also
  } else
    SendServerMessageToPC(oPC, "Die Quest wurde bereits abgeschlossen.");             // Teile dies mit

}
