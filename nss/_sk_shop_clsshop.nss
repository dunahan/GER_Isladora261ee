//::///////////////////////////////////////////////
//:: Shop Keeper Dialogue, Close Shop
//:: _sk_shop_clsshop
//:: Copyright (c) 2013 dunahan@schwerterkueste.de
//:://////////////////////////////////////////////
/*
    Beim Shop unter, On Store Closed einzufügen
    Schließt den Händler und speichert alle bisher
    abgelegten Daten ab.

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

  DebugMode(GetName(oStore)+", Schliessen Skript.");

  DebugMode(GetName(oStore)+" speichert sein Inventar.");
  //SaveShopItemsToDB(oStore);
}
