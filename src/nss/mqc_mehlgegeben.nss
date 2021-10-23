//:://////////////////////////////////////////////
//:: FileName: mqc_mehlgegeben
//:: Zu setzen unter: Aktion geschieht...
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 03.06.2013 14:21:58
//:://////////////////////////////////////////////
#include "mqc_include"

void main()
{
  object oModule = GetModule();                  // Das Modul
  object oPlayer = GetPCSpeaker();               // Der Spieler
  object oArea = GetArea(OBJECT_SELF);           // Die Map
  string sPlayer = mqc_UniquePC(oPlayer);        // Der Name des Spielers
  string sQuest = mqc_Questname();               // Die Quest
  string sArray = sQuest + sPlayer;              // Kombiniere Namen und Questbezeichnung
  int nStatus = GetLocalInt(oModule, sArray);    // Der Status der Quest

  // Der Spieler macht die Auslieferung des Mehls mit, kann aber nicht x-beliebig viele Mehle ausliefern
  nStatus++;
  SetLocalInt(oModule, sArray, nStatus); // Der Status der Quest
  SetLocalInt(oArea, sArray, 1);         // Der Status des NSC's

  string sMessage = "mqc_mehlgegeben aktviert. Stati wurde vergeben.";
  mqc_Debug("mqc_mehlgegeben.nss", sMessage);
}
