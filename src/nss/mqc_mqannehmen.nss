//:://////////////////////////////////////////////
//:: FileName: mqc_mqannehmen
//:: Zu setzen unter: Aktion geschieht...
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 03.06.2013 14:19:54
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

  SetLocalInt(oModule, sArray, 1);                        // Der Status der Quest

  string sMessage = "mqc_mqannehmen aktiviert. Vermerkt, dass Quest begonnen.";
  mqc_Debug("mqc_mqannehmen", sMessage);
}
