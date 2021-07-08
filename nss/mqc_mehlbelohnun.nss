//:://////////////////////////////////////////////
//:: FileName: mqc_mehlbelohnun
//:: Zu setzen unter: Aktion geschieht...
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 03.06.2013 14:21:58
//:://////////////////////////////////////////////
#include "mqc_include"

void main()
{
  // Dem Sprecher die Gegenstände geben
  CreateItemOnObject(mqc_Belohnung(), GetPCSpeaker(), 1);

  string sMessage = "mqc_mehlbelohnun aktiviert von "+GetName(GetPCSpeaker());
  mqc_Debug("mqc_mehlbelohnun.nss", sMessage);
}
