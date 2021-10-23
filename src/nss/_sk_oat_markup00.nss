//::///////////////////////////////////////////////
//:: Shop Keeper Dialogue, Set Mark Up Value
//:: _sk_oat_markup00
//:: Copyright (c) 2013 dunahan@schwerterkueste.de
//:://////////////////////////////////////////////
/*
    Beim Dialog unter, On Action Taken einfügen
    Gibt dem SL die Möglichkeit den Kaufpreis um X%
    über 100% zu erhöhen.

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

  int nUp, nNow = GetLocalInt(oStore, "BonusUp");
  DebugMode("Kaufabschlag "+IntToString(nUp)+" für Händler "+GetName(oStore)+" gesetzt.");

  nUp = nNow + SK_MARKUPVALUE;

  SetLocalInt(oStore, "BonusUp", nUp);
  DebugMode("Kaufabschlag "+IntToString(nUp)+" für Händler "+GetName(oStore)+" gesetzt.");

  SendMessageToAllDMs("Kaufabschlag "+IntToString(nUp)+" für Händler "+GetName(oStore)+" gesetzt.");
}
