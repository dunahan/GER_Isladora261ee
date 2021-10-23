//::///////////////////////////////////////////////
//:: Shop Keeper Dialogue, Set Max Store Buy Price
//:: _sk_oat_buyprice
//:: Copyright (c) 2013 dunahan@schwerterkueste.de
//:://////////////////////////////////////////////
/*
    Beim Dialog unter, On Action Taken einfügen
    Gibt dem SL die Möglichkeit den maximalen Kauf-
    preis des Händlers zu beeinflussen

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

  if (GetStoreMaxBuyPrice(oStore) == -1)
  {
    SetStoreMaxBuyPrice(oStore, SK_MAXBUYPRICE);
    DebugMode("Setze max Kaufpreis: "+IntToString(GetStoreMaxBuyPrice(oStore)));
    SendMessageToAllDMs("Händler "+GetName(oStore)+" kauft nun bis zu einem Preis von "+IntToString(GetStoreGold(oStore))+" Gold.");
  }
  else                                                                          // unbegrenzt
  {
    SetStoreMaxBuyPrice(oStore, -1);
    DebugMode("Setze max Kaufpreis: "+IntToString(GetStoreMaxBuyPrice(oStore)));
    SendMessageToAllDMs("Händler "+GetName(oStore)+" kauft Items ohne Beschränkung.");
  }
}
