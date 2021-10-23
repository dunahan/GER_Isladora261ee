//::///////////////////////////////////////////////
//:: FileName: mqc_mqausliefern
//:: Zu setzen unter: Aktion geschieht...
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On: 13.06.2013
//:://////////////////////////////////////////////
#include "mqc_include"

void main()
{
  object oPlayer = GetPCSpeaker();                        // Der Spieler
  object oModule = GetModule();                           // Das Modul
  string sPlayer = mqc_UniquePC(oPlayer);                 // Interner Spielername
  string sQuest = mqc_Questname();                        // Die Quest
  string sArray = sQuest + sPlayer;                       // Kombiniere Namen und Questbezeichnung
  int nStatus = GetLocalInt(oModule, sArray);             // Der Status der Quest

  // Der Spieler macht die Auslieferung des Mehls mit
  SetLocalInt(oModule, sArray, 2);                        // Der Status der Quest

  string sMessage = "mqc_mqausliefern aktiviert. Spieler liefert die Mehle aus.";
  mqc_Debug("mqc_mqausliefern", sMessage);
}
