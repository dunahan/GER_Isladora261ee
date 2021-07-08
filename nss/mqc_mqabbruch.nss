//::///////////////////////////////////////////////
//:: FileName: mqc_mqabbruch
//:: Zu setzen unter: Aktion geschieht...
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 02.06.2013 12:54:58
//:://////////////////////////////////////////////
#include "mqc_include"

void main()
{
  // Gegenstände aus dem Gepäck des Spielers entfernen
  object oPlayer = GetPCSpeaker();                        // Der Spieler
  object oModule = GetModule();                           // Das Modul
  string sPlayer = mqc_UniquePC(oPlayer);                 // Interner Spielername
  string sQuest = mqc_Questname();                        // Die Quest
  string sArray = sQuest + sPlayer;                       // Kombiniere Namen und Questbezeichnung
  int nStatus = GetLocalInt(oModule, sArray);             // Der Status der Quest
  object oItemToTake = GetItemPossessedBy(GetPCSpeaker(), mqc_Notwendig());

  if (GetIsObjectValid(oItemToTake) == TRUE)
    mqc_AnzahlItemsNehmen(oPlayer, mqc_Notwendig(), 7);

  SetLocalInt(oModule, sArray, 10);                       // Der Status der Quest

  string sMessage = "mqc_mqabbruch aktiviert. Da der Spieler die Mehle nicht verteilen.";
  mqc_Debug("mqc_mqabbruch", sMessage);
}
