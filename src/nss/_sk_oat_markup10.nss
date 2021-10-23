//::///////////////////////////////////////////////
//:: Shop Keeper Dialogue, Set Mark Up Value
//:: _sk_oat_markup10
//:: Copyright (c) 2013 dunahan@schwerterkueste.de
//:://////////////////////////////////////////////
/*
    Beim Dialog unter, On Action Taken einf�gen
    Gibt dem SL die M�glichkeit den Kaufpreis um X%
    �ber 100% zu verringern.

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

  nUp = nNow - SK_MARKUPVALUE;

  SetLocalInt(oStore, "BonusUp", nUp);
  DebugMode("Kaufabschlag "+IntToString(nUp)+" f�r H�ndler "+GetName(oStore)+" gesetzt.");

  SendMessageToAllDMs("Kaufabschlag "+IntToString(nUp)+" f�r H�ndler "+GetName(oStore)+" gesetzt.");
}
