//::///////////////////////////////////////////////
//:: Shop Keeper Dialogue, Set Item Infinitive
//:: _sk_oat_infinity
//:: Copyright (c) 2013 dunahan@schwerterkueste.de
//:://////////////////////////////////////////////
/*
    Beim Dialog unter, On Action Taken einfügen
    Option für SL, Stelle ein ausgewähltes Item
    als unendlich erhältlich ein bzw aus

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
  object oItem  = GetLocalObject(oStore, "Target");

  if (GetInfiniteFlag(oItem) == TRUE )                                          // Ist dieser Gegenstand unendlich vorhanden?
  {                                                                             // Ja, dann begrenzen.
    SetInfiniteFlag(oItem, FALSE);
    DebugMode("Setze Verfuegbarkeit: "+IntToString(GetInfiniteFlag(oItem)));
    SendServerMessageToPC(GetPCSpeaker(), GetName(oItem)+" wurde begrenzt.");
  }
  else                                                                          // Nein, dann unendlich stellen.
  {
    SetInfiniteFlag(oItem, TRUE);
    DebugMode("Setze Verfuegbarkeit: "+IntToString(GetInfiniteFlag(oItem)));
    SendServerMessageToPC(GetPCSpeaker(), GetName(oItem)+" wurde Unendlich gestellt.");
  }
}

