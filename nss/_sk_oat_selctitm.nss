//::///////////////////////////////////////////////
//:: Shop Keeper Dialogue, Select First Item In Shop
//:: _sk_oat_selctitm
//:: Copyright (c) 2013 dunahan@schwerterkueste.de
//:://////////////////////////////////////////////
/*
    Beim Dialog unter On Action Taken einf�gen
    Gibt dem SL die M�glichkeit ein Item im Shop
    anzuw�hlen um dieses dann sp�ter zu bearbeiten

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

  int nSelected = GetLocalInt(oStore, "HadSelected");
  object oItem;

  if (nSelected == 0)
  {
    oItem = GetFirstItemInInventory(oStore);
    SetLocalInt(oStore, "HadSelected", 1);
  }

  else
    oItem = GetNextItemInInventory(oStore);


  while (GetIsObjectValid(oItem) == TRUE)
  {
    SetLocalObject(oStore, "Target", oItem);
    SendServerMessageToPC(GetPCSpeaker(), GetName(oItem)+" wurde ausgew�hlt.");
    return;
  }
}

