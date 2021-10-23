//::///////////////////////////////////////////////
//:: Teleportsystem: Behälter wird verändert
//:: tele_dist_chest
//:: (C): dunahan@schwerterkueste, 08.01.2013
//:://////////////////////////////////////////////
/*
     Zu setzen unter, On Disturbed bei der Kiste
     Verändert die Variablen, wenn der Inhalt des
     Schlüsselbehälters geändert wird und speichert
     das Objekt dann persistent ab
*/
//:://////////////////////////////////////////////
//:: Created By: dunahan@schwerterkueste.de
//:: Created On: 08.01.2013
//:://////////////////////////////////////////////
#include "tele_inc"

void main()
{
  object oLastUser = GetLastDisturbed();
  int nDisturbType = GetInventoryDisturbType();
  location locChest = GetLocation(oLastUser);
  object oItem = GetInventoryDisturbItem();

  switch (nDisturbType) {
    case INVENTORY_DISTURB_TYPE_ADDED:
    {
      SetLocalLocation(oItem, TELEARRAY+"_HOME", locChest);
      SetLocalLocationOverride(OBJECT_SELF, TELEARRAY+"_HOME", oItem);
    }
    break;

    case INVENTORY_DISTURB_TYPE_REMOVED:
    {
      DeleteLocalLocation(oItem, TELEARRAY+"_HOME");
      DeleteLocalLocationOverride(TELEARRAY+"_HOME", oItem);
    }
    break;

    case INVENTORY_DISTURB_TYPE_STOLEN:
    {
      DeleteLocalLocation(oItem, TELEARRAY+"_HOME");
      DeleteLocalLocationOverride(TELEARRAY+"_HOME", oItem);
    }
    break;
  }
}
