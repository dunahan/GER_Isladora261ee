//::///////////////////////////////////////////////
//:: Questsystem per Notizbuch
//:: qsa_quest006
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*  Ein Questsystem per Item.
    Ein Placeable vergibt ein gewünschtes Questitem.
    Einsetzbar im Gespräch bei OnActionTaken
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

  // 1.2 Werden Items abverlangt oder als Belohnung gegeben?
  string sItemToTake = GetLocalString(oData, "Questitem");                      // ResRef des Questgegenstandes
  object oItemToTake = GetItemPossessedBy(oPC, sItemToTake);                    // Suche dieses Item bei Spieler

  // 1.3 Quest auslesen
  string sQuestname = GetLocalString(oData, "Questname");

  // 1.4 Zeitraum in der die Quest wiederholt werden kann
  int nDelay = GetLocalInt(oData, "Delay");

  // 2++ Handle die Übergabe des Items ab
  // 2.1 Lese die ID des Spielers auf dem NSC/Placeables aus
  int nQuestitem = GetLocalInt(oData, sID);

  // 2.2 Prüf ob der Spieler das Questitem von Placeable/NSC erhalten hat
  if  ( (nQuestitem == 0) &&                                                    // SC hat NSC/Placeable noch nicht angesprochen UND
        (!GetIsObjectValid(oItemToTake)) ) {                                    // hat das Item noch nicht
    CreateItemOnObject(sItemToTake, oPC);                                       // erschaffe das Item im Inv des PC's und
    SetLocalInt(oData, sID, 1);                                                 // setze Int auf Ja, da PC den SC und PC angesprochen hat

    if ( GetLocalInt(oData, "Reset") ) {                                        // Kann die Quest wiederholt werden?
      if ( nDelay == 0 )    nDelay = 300;                                       // wurde ein Delay gesetzt?
      int nElapsedTime = kL_GetIntervalElapsed(sQuestname, oPC);

      if (nElapsedTime >= nDelay) {
        DeleteLocalInt(oData, sID);
      }
    }

  // 2.3 Der/das NSC/Placeable wurde bereits benutzt UND Item existiert im Inventar
  //     teile dies dem Spieler mit
  } else
    SendServerMessageToPC(oPC, GetName(OBJECT_SELF) + " hat dir den Gegenstand bereits gegeben.");

} // end main
