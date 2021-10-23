//::///////////////////////////////////////////////
//:: Shop Keeper Dialogue, Reload Shop
//:: _sk_oat_reload
//:: Copyright (c) 2013 dunahan@schwerterkueste.de
//:://////////////////////////////////////////////
/*
    Läd alle Modul vorgegebene Daten
    für den Shop ein

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

  DebugMode(GetName(oStore)+" wird nach Modulreset zurueck gesetzt.");

  SendMessageToAllDMs(GetName(oStore)+" wird nach Modulreset zurueck gesetzt.");

  SetLocalInt(oStore, "Reload", 1);

}

