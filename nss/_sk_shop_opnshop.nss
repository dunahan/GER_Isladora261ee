//::///////////////////////////////////////////////
//:: Shop Keeper Dialogue, Open Shop
//:: _sk_shop_opnshop
//:: Copyright (c) 2013 dunahan@schwerterkueste.de
//:://////////////////////////////////////////////
/*
    Beim Shop unter, On Store Open einzufügen
    Öffnet den Händler und läd alle bisher
    abgelegten Daten neu ein.

*/
//:://////////////////////////////////////////////
//:: Created By:  dunahan@schwerterkueste.de
//:: Created On:  23.01.2013
//:://////////////////////////////////////////////

#include "_sk_include"

void main()
{
  string sStore = GetTag(OBJECT_SELF);
  object oStore = GetObjectByTag(SK_PREFIX+sStore);

  DebugMode(GetName(oStore)+", Oeffnen Skript.");

  if (GetLocalInt(oStore, "Reload") == 0)
  {
    DebugMode(GetName(oStore)+" leert sein Inventar.");
    ClearShopFromItems(oStore);
  }

  DebugMode(GetName(oStore)+" laedt sein Inventar.");
  LoadShopItemsFromDB(oStore);
}
