//:://////////////////////////////////////////////
//:: FileName: mqc_mehlgegeben
//:: Zu setzen unter: Aktion geschieht...
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 03.06.2013 14:21:58
//:://////////////////////////////////////////////
#include "mqc_include"

int StartingConditional()
{
  object oPlayer = GetPCSpeaker();                        // Der Spieler
  object oArea = GetArea(OBJECT_SELF);                    // Das Modul
  string sPlayer = mqc_UniquePC(oPlayer);                 // Interner Spielername
  string sQuest = mqc_Questname();                        // Die Quest
  string sArray = sQuest + sPlayer;                       // Kombiniere Namen und Questbezeichnung
  int nStatus = GetLocalInt(oArea, sArray);               // Der Status der Quest

  if (nStatus >= 1)
    return FALSE;

  return TRUE;
}
