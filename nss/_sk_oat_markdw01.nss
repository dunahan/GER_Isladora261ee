//::///////////////////////////////////////////////
//:: Shop Keeper Dialogue, Set Mark Down Value
//:: _sk_oat_markdw01
//:: Copyright (c) 2013 dunahan@schwerterkueste.de
//:://////////////////////////////////////////////
/*
    Beim Dialog unter, On Action Taken einfügen
    Gibt dem SL die Möglichkeit den Kaufpreis auf
    Normallevel zurück zu setzen

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

  SetLocalInt(oStore, "BonusDown", 0);
  DebugMode("Verkaufabschlag 0 für Händler "+GetName(oStore)+" gesetzt.");

  SendMessageToAllDMs("Verkaufabschlag 0 für Händler "+GetName(oStore)+" gesetzt.");
}
