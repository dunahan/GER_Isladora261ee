//::///////////////////////////////////////////////
//:: Shop Keeper Dialogue, Set Mark Down Value
//:: _sk_oat_markdw10
//:: Copyright (c) 2013 dunahan@schwerterkueste.de
//:://////////////////////////////////////////////
/*
    Beim Dialog unter, On Action Taken einfügen
    Gibt dem SL die Möglichkeit den Kaufpreis um X%
    unter 100% zu verringern.

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

  int nDown, nNow = GetLocalInt(oStore, "BonusDown");
  DebugMode("Verkaufabschlag "+IntToString(nDown)+" für Händler "+GetName(oStore)+" gesetzt.");

  nDown = nNow - SK_MARKUPVALUE;

  SetLocalInt(oStore, "BonusDown", nDown);
  DebugMode("Verkaufabschlag "+IntToString(nDown)+" für Händler "+GetName(oStore)+" gesetzt.");

  SendMessageToAllDMs("Verkaufabschlag "+IntToString(nDown)+" für Händler "+GetName(oStore)+" gesetzt.");
}
