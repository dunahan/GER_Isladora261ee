//::///////////////////////////////////////////////
//:: Shop Keeper Dialogue, Modify Stacksize Of Items
//:: _sk_oat_modstack
//:: Copyright (c) 2013 dunahan@schwerterkueste.de
//:://////////////////////////////////////////////
/*
    Beim Dialog unter, On Action Taken einfügen
    Gibt dem SL die Möglichkeit die Stackgröße
    eines Items zu beeinflussen.
    Dabei muss dieses Item bereits durch den SL
    ausgewählt worden sein!
    Vollständig zu ersetzen, beachte dabei Debug-
    Funktion!
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

  int nStack, nStackable, nMaXStacks;

  if (GetIsObjectValid(oItem) == TRUE)
  {
    nStack     = GetItemStackSize(oItem);
    nStackable = GetIsStackableItem(oItem);
    nMaXStacks = GetMaxStacksize(oItem);

    if (nStackable == TRUE)
    {
      if (nStack == 1)
      {
        SetItemStackSize(oItem, SK_STACKVALUE);
        DebugMode("Stacksize: "+IntToString(nStack));
        SendServerMessageToPC(GetPCSpeaker(), GetName(oItem)+" wurde auf "+IntToString(GetItemStackSize(oItem))+" Items gesetzt.");
      }

      else if (nStack >= 2 && nStack < nMaXStacks)
      {
        SetItemStackSize(oItem, nStack+SK_STACKVALUE);
        DebugMode("Stacksize: "+IntToString(nStack));
        SendServerMessageToPC(GetPCSpeaker(), GetName(oItem)+" wurde um "+ IntToString(SK_STACKVALUE) +" erhöht.\n"+
                                              GetName(oItem)+" kann nur bis "+ IntToString(nMaXStacks) +" erhöht werden.");
      }

      else if (nStack >= nMaXStacks)
      {
        SetItemStackSize(oItem, 1);
        DebugMode("Stacksize: "+IntToString(nStack));
        SendServerMessageToPC(GetPCSpeaker(), GetName(oItem)+" wurde auf 1 gesetzt.");
      }
    }
  }
}


