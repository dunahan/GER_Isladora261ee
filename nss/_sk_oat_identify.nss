//::///////////////////////////////////////////////
//:: Shop Keeper Dialogue, Activate Identify
//:: _sk_oat_identify
//:: Copyright (c) 2013 dunahan@schwerterkueste.de
//:://////////////////////////////////////////////
/*
    Beim Dialog unter, On Action Taken einfügen
    Gibt dem SL die Möglichkeit das Identifizieren
    des Händlers ein- oder auszuschalten

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

  if (GetStoreIdentifyCost(oStore) <= 0)                                        // Identifiziert der Shop?
  {                                                                             // Ja, dann ausschalten
    SetStoreIdentifyCost(oStore, SK_COSTIDENTFY);
    DebugMode("Setze Identifizieren: "+IntToString(GetStoreIdentifyCost(oStore)));
    SendMessageToAllDMs(GetName(oStore)+" identifiziert nicht mehr.");
  }
  else
  {                                                                             // Nein, dann einschalten
    SetStoreIdentifyCost(oStore, -1);
    DebugMode("Setze Identifizieren: "+IntToString(GetStoreIdentifyCost(oStore)));
    SendMessageToAllDMs(GetName(oStore)+" identifiziert nun für "+IntToString(SK_COSTIDENTFY) );
  }
}

