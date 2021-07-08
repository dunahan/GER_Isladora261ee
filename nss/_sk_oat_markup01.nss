//::///////////////////////////////////////////////
//:: Shop Keeper Dialogue, Set Mark Up Value
//:: _sk_oat_markup01
//:: Copyright (c) 2013 dunahan@schwerterkueste.de
//:://////////////////////////////////////////////
/*
    Beim Dialog unter, On Action Taken einf�gen
    Gibt dem SL die M�glichkeit den Kaufpreis auf
    Normallevel zur�ck zu setzen

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

  SetLocalInt(oStore, "BonusUp", 0);
  DebugMode("Kaufabschlag 0 f�r H�ndler "+GetName(oStore)+" gesetzt.");

  SendMessageToAllDMs("Kaufabschlag 0 f�r H�ndler "+GetName(oStore)+" gesetzt.");
}
