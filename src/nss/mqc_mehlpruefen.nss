//::///////////////////////////////////////////////
//:: FileName: mqc_mehlpruefen
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
  object oPlayer = GetPCSpeaker();
  object oItem = GetItemPossessedBy(oPlayer, mqc_Notwendig()); // Suche in seinem Inv nach dem Mehl
  object oModule = GetModule();                                // Modul auf dem der Status der Quest abgespeichert wird
  string sPlayer = mqc_UniquePC(oPlayer);                      // Dessen Name
  string sQuest = mqc_Questname();                             // Die Quest
  string sArray = sQuest + sPlayer;                            // Kombiniere Namen und Questbezeichnung
  int nStatus = GetLocalInt(oModule, sArray);                  // Der Status der Quest

  if (nStatus < 10 && nStatus >= 2)
  {
    // Sicherstellen, dass der SC-Sprecher diese Gegenstände in seinem Gepäck trägt
    if (GetIsObjectValid(oItem) == TRUE)
      return TRUE;
  }

  return FALSE;
}
