//::///////////////////////////////////////////////
//:: FileName: mqc_mehlzeigen
//:: Zu setzen unter: Text erscheint...
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 02.06.2013 12:07:57
//:://////////////////////////////////////////////
#include "mqc_include"

int StartingConditional()
{
  // Gegenstände aus dem Gepäck des Spielers entfernen
  object oPlayer = GetPCSpeaker();                        // Der Spieler
  object oModule = GetModule();                           // Das Modul
  object oItem = GetItemPossessedBy(oPlayer, mqc_Notwendig());      // Suche in seinem Inv nach dem Mehl
  string sPlayer = mqc_UniquePC(oPlayer);                 // Interner Spielername
  string sQuest = mqc_Questname();                        // Die Quest
  string sArray = sQuest + sPlayer;                       // Kombiniere Namen und Questbezeichnung
  int nStatus = GetLocalInt(oModule, sArray);             // Der Status der Quest

  if (nStatus == 1)
  {
    // Sollte der Spieler im Stack mindestens 7 oder mehr Items dessen haben gib Wahr aus!
    if (GetItemStackSize(oItem) >= 7)
        return TRUE;
   }
  // Ansonsten, Aufgabe noch nicht erfuellt, so Falsch!
  return FALSE;
}
