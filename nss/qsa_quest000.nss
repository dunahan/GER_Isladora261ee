//::///////////////////////////////////////////////
//:: Questsystem per Notizbuch
//:: qsa_quest000
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*  Ein Questsystem per Item, hier Prüfung
    Sichtung, existiert für die Quest eine Vorbedinung?
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

  // 1.1 Das Questtoken suchen
  object oBook = GetItemPossessedBy(oPC, QUESTBOOK_RESREF);

  // 2++ Auslesen der lokalen Variablen des NSC's
  // 2.1 Wird eine Quest davor benötigt?
  string sQuestbedingung = GetLocalString(oData, "Questbedingung");

  // 2.1.1 Es wird keine Quest davor benötigt, sie kann also jederzeit gemacht werden
  if ( GetStringLowerCase(sQuestbedingung) == "kein" || sQuestbedingung == "")
    return TRUE;                                                                // Gib Wahr zurück und aktiviere den Gesprächsstrang

  // 2.1.2 Es wird eine Quest davor benötigt und der Spieler hat diese bereits erledigt
  else if ( GetLocalInt(oBook, sQuestbedingung) == QUEST_ABGESCHLOSSEN )
    return TRUE;                                                                // Gib Wahr zurück und aktiviere den Gesprächsstrang

  return FALSE;                                                                 // Ansonsten gib Falsch zurück, damit ist der Gesprächsstrang nicht aktiv
}
