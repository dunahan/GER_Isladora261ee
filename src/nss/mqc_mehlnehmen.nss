//::///////////////////////////////////////////////
//:: FileName: mqc_mehlnehmen
//:: Zu setzen unter: Aktion geschieht...
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 03.06.2013 14:19:54
//:://////////////////////////////////////////////
#include "mqc_include"

void main()
{
  object oPC = GetPCSpeaker();

  // Gegenst�nde aus dem Gep�ck des Spielers entfernen
  mqc_AnzahlItemsNehmen(oPC, mqc_Notwendig(), 1);

  string sMessage = "mqc_mehlnehmen aktiviert. Mehl wird gesucht und genommen.";
  mqc_Debug("mqc_mehlnehmen", sMessage);
}
