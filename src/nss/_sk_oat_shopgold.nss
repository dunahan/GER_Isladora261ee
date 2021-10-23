//::///////////////////////////////////////////////
//:: Shop Keeper Dialogue, Set Max Store Gold
//:: _sk_oat_shopgold
//:: Copyright (c) 2013 dunahan@schwerterkueste.de
//:://////////////////////////////////////////////
/*
    Beim Dialog unter, On Action Taken einfügen
    Gibt dem SL die Möglichkeit das maximale Gold
    des Händlers unendlich zu setzen bzw zu begrenzen

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

  DebugMode("Shop gefunden: "+GetName(OBJECT_SELF));
  DebugMode("Lese Gold aus: "+IntToString(GetStoreGold(oStore)));

  if (GetStoreGold(oStore) == -1)
  {
    SetStoreGold(oStore, SK_MAXSHOPGOLD);
    DebugMode("Lese Gold aus: "+IntToString(GetStoreGold(oStore)));
    SendMessageToAllDMs("Händler "+GetName(oStore)+" hat nun insg. "+IntToString(GetStoreGold(oStore))+" Gold zu Verfügung.");
  }
  else
  {
    SetStoreGold(oStore, -1);             // unbegrenzt
    DebugMode("Lese Gold aus: "+IntToString(GetStoreGold(oStore)));
    SendMessageToAllDMs("Händler "+GetName(oStore)+" hat nun unendlich Gold zu Verfügung.");
  }
}

