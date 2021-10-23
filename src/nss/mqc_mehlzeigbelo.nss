//::///////////////////////////////////////////////
//:: FileName: mqc_mehlzeigbelo
//:: Zu setzen unter: Aktion geschieht...
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 02.06.2013 12:10:35
//:://////////////////////////////////////////////
#include "mqc_include"
#include "ll_include"

void main()
{
  object oPlayer = GetPCSpeaker();                        // Der Spieler
  object oModule = GetModule();                           // Das Modul
  string sPlayer = mqc_UniquePC(oPlayer);                 // Interner Spielername
  string sQuest = mqc_Questname();                        // Die Quest
  string sArray = sQuest + sPlayer;                       // Kombiniere Namen und Questbezeichnung
  int nStatus = GetLocalInt(oModule, sArray);             // Der Status der Quest

  // Dem Sprecher EP geben
  //GiveXPToCreature(oPlayer, 25);
  SetXPImproved(oPlayer, GetXP(oPlayer)+25);

  SetLocalInt(oModule, sArray, 2);                        // Der Status der Quest

  string sMessage = "aktiviert. Belohnung fuers Mehl zeigen geben.";
  mqc_Debug("mqc_mehlzeigbelo", sMessage);
}
