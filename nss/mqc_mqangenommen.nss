//:://////////////////////////////////////////////
//:: FileName: mqc_mqangenommen
//:: Zu setzen unter: Text erscheint...
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 03.06.2013 14:19:54
//:://////////////////////////////////////////////
#include "mqc_include"

int StartingConditional()
{
  object oPlayer = GetPCSpeaker();                        // Der Spieler
  object oModule = GetModule();                           // Das Modul
  string sPlayer = mqc_UniquePC(oPlayer);                 // Interner Spielername
  string sQuest = mqc_Questname();                        // Die Quest
  string sArray = sQuest + sPlayer;                       // Kombiniere Namen und Questbezeichnung
  int nStatus = GetLocalInt(oModule, sArray);             // Der Status der Quest

  if (nStatus >= 1)
    return FALSE;      // die Quest wurde bereits abgeschlossen = Annahme deaktivieren

  return TRUE;         // Anderenfalls = Annahme aktivieren
}
