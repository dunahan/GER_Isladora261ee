//::///////////////////////////////////////////////
//:: Shop Keeper Include File
//:: _sk_include
//:: Copyright (c) 2013 dunahan@schwerterkueste.de
//:://////////////////////////////////////////////
/*
    Die Include, in der alle Konfigurationen vorge-
    genommen werden und notwendige Funktionen bzw
    Wrapper vorhanden sind.

*/
//:://////////////////////////////////////////////
//:: Created By:  dunahan@schwerterkueste.de
//:: Created On:  23.01.2013
//:://////////////////////////////////////////////

// notwendige Include für diese Skripte
#include "nw_i0_plot"
#include "_tokenizer_inc"
#include "_debugisla"

// Globale Konfiguration der Händler

// SK_PREFIX bezeichnet ein Vorzeichen des Händlers
// Es sollte eindeutig und kurz bleiben, zB SHOP_(Händlerart)
const string SK_PREFIX = "Store_";

// SK_COSTIDENTFY gibt die generellen Kosten zum Identifizieren von
// Gegenständen vor. Dabei muss der Wert immer über 0 liegen!
const int SK_COSTIDENTFY =  100;

// SK_MAXSHOPGOLD gibt des Shops grundlegendes Gold wieder
// Dabei muss der Wert immer über 0 liegen!
const int SK_MAXSHOPGOLD = 5000;

// SK_MAXBUYPRICE gibt des Shops höchsten Kaufpreis wieder
// Dabei muss der Wert immer über 0 liegen!
const int SK_MAXBUYPRICE = 2500;

// SK_MARKUPVALUE gibt den generellen Wert an, mit dem der MarkUp
// Wert beeinflusst werden kann. Dabei muss dieser immer über
// 0 liegen!
const int SK_MARKUPVALUE =   10;

// SK_STACKVALUE gibt den generelle Wert an, mit der die Stackgröße
// eines Stapels verändert werden kann. Dabei muss dieser immer
// über 0 liegen!
const int SK_STACKVALUE  =   10;

// Clears the shop from all items which are in the inventory
void ClearShopFromItems(object oStore);

// Saves all items to a shop-related database
void SaveShopItemsToDB(object oStore);

// Loads all saved items back to the store!
void LoadShopItemsFromDB(object oStore);

// Tells the stacksize of the checked item, even if
// baseitems.2da is edited by pw owners
int GetMaxStacksize(object oItem)
{
  // Gets the base item type, which is needed for searching through the 2da
  int nBaseType = GetBaseItemType(oItem);

  // Search baseitems.2da for the checked item
  int nResult = StringToInt(Get2DAString("baseitems", "Stacking", nBaseType));

  // then return the maximum stacksize, like 10 for healingkits...
  return nResult;
}

// Tells you if the item is stackable, returns TRUE if it is
// and FALSE if not ;-)
int GetIsStackableItem(object oItem)
{
    //Must have a chest tagged checkchest
    object oCopy = CopyItem(oItem, GetObjectByTag("checkchest") );

    //Set the stacksize to two
    SetItemStackSize(oCopy, 2);

    //Check if it really is two - otherwise, not stackable!
    int bStack = GetItemStackSize(oCopy) == 2;

    //Destroy the test copy
    DestroyObject(oCopy);

    //Return bStack which is TRUE if item is stackable
    return bStack;
}

// Clears the shop from all items which are in the inventory
void ClearShopFromItems(object oStore)
{
  if (GetIsObjectValid(oStore) == TRUE)
  {
    object oItem = GetFirstItemInInventory(oStore);

    while (GetIsObjectValid(oItem) == TRUE)
    {
      DebugMode(GetName(oStore)+" leert sein Inventar.");

      SetPlotFlag(oItem, FALSE);       // hebe die Eigenschaft Handlung  auf
      SetItemCursedFlag(oItem, FALSE); // hebe die Eigenschaft Verflucht auf
      SetStolenFlag(oItem, FALSE);     // hebe die Eigenschaft Gestohlen auf

      DebugMode(GetName(oItem)+" wird nun geloescht.");

      DestroyObject(oItem);            // zerstöre das Objekt

      oItem = GetNextItemInInventory(oStore);
    }
  }
}

// Saves all items to a shop-related database
void SaveShopItemsToDB(object oStore)
{
  object oItem, oChest;
  string sResRef, sTag, sItemSave, sResRefSave, sTagSave, sStacksSave, sInfiniSave;
  int nStacksize, nInfinite, nAppraise, nBonusUp;
  int nBonusDown, nStoreGold, nMaxGold, nIdentify, nCount;

  string sStore = GetStringRight(GetTag(oStore), 8);

  if (GetIsObjectValid(oStore) == TRUE)
  {
    location locChest = GetLocation(GetWaypointByTag("_sk_shopsave"));

    oItem = GetFirstItemInInventory(oStore);

    while (GetIsObjectValid(oItem) == TRUE)
    {
      sResRef    = GetResRef(oItem);
      sTag       = GetTag(oItem);
      nStacksize = GetItemStackSize(oItem);
      nInfinite  = GetInfiniteFlag(oItem);

      oChest = CreateObject(OBJECT_TYPE_ITEM, "_sk_shopitem", locChest, FALSE, "SAVE"+sStore);

      oChest = GetObjectByTag("SAVE"+sStore);

      sResRefSave = GetLocalString(oChest, "shop_resref");
      sResRefSave = AddTokenToString(sResRef, "shop_resref");
      DebugMode(sResRefSave+" wird nun gespeichert.");

      SetLocalString(oChest, "shop_resref", sResRefSave);

      sTagSave = GetLocalString(oChest, "shop_tag");
      sTagSave = AddTokenToString(sTag, "shop_tag");
      DebugMode(sTagSave+" wird nun gespeichert.");

      SetLocalString(oChest, "shop_tag", sTagSave);

      sStacksSave = GetLocalString(oChest, "shop_stacksize");
      sStacksSave = AddTokenToString(IntToString(nStacksize), "shop_stacksize");
      DebugMode(sStacksSave+" wird nun gespeichert.");

      SetLocalString(oChest, "shop_stacksize", sStacksSave);

      sInfiniSave = GetLocalString(oChest, "shop_infinite");
      sInfiniSave = AddTokenToString(IntToString(nInfinite), "shop_infinite");
      DebugMode(sInfiniSave+" wird nun gespeichert.");

      SetLocalString(oChest, "shop_infinite", sInfiniSave);

      nCount++;

      oItem = GetNextItemInInventory(oStore);
    }

      SetLocalInt(oChest, "CountedItems", nCount);

    nAppraise  = GetLocalInt(oStore, "UseAppraise");
      SetLocalInt(oChest, "UseAppraise", nAppraise);

    nBonusUp   = GetLocalInt(oStore, "BonusMarkUp");
      SetLocalInt(oChest, "BonusMarkUp", nBonusUp);

    nBonusDown = GetLocalInt(oStore, "BonusMarkDown");
      SetLocalInt(oChest, "BonusMarkDown", nBonusDown);

    nStoreGold = GetStoreGold(oStore);
      SetLocalInt(oChest, "StoreGold", nStoreGold);

    nMaxGold = GetStoreMaxBuyPrice(oStore);
      SetLocalInt(oChest, "MaxGold", nMaxGold);

    nIdentify = GetStoreIdentifyCost(oStore);
      SetLocalInt(oChest, "Identify", nIdentify);
  }

  DestroyCampaignDatabase("SAVE_"+sStore);
  StoreCampaignObject("SAVE_"+sStore, "ShopItems", oChest);

  DestroyObject(oChest);
}

// Loads all saved items back to the store!
void LoadShopItemsFromDB(object oStore)
{
  object oItem, oChest;
  string sResRef, sTag, sItemSave;
  int nStacksize, nInfinite, nAppraise, nBonusUp, nRetrieved = 1;
  int nBonusDown, nStoreGold, nMaxGold, nIdentify, nCount;

  location locChest = GetLocation(GetWaypointByTag("_sk_shopsave"));
  string sStore = GetStringRight(GetTag(oStore), 8);

  oChest = RetrieveCampaignObject("SAVE_"+sStore, "ShopItems", locChest);
  nCount = GetLocalInt(oChest, "CountedItems");

  if (GetIsObjectValid(oStore) == TRUE)
  {
    while ( (GetIsObjectValid(oChest) == TRUE)
       &&   (nRetrieved <= nCount)             )
    {
      DebugMode(GetName(oStore)+" holt nun die gespeicherten Items in sein Inventar.");

      sResRef    = GetTokenFromString(nRetrieved, "shop_resref");
      DebugMode(sResRef+" wurde ausgelesen.");

      sTag       = GetTokenFromString(nRetrieved, "shop_tag");
      DebugMode(sTag+" wurde ausgelesen.");

      nStacksize = StringToInt(GetTokenFromString(nRetrieved, "shop_stacksize"));
      DebugMode(IntToString(nStacksize)+" wurde ausgelesen.");

      nInfinite  = StringToInt(GetTokenFromString(nRetrieved, "shop_infinite"));
      DebugMode(IntToString(nInfinite)+" wurde ausgelesen.");

      oItem = CreateItemOnObject(sResRef, oStore, nStacksize);
      if (GetIsObjectValid(oItem) == FALSE)
      { oItem = CreateItemOnObject(sTag, oStore, nStacksize); }

      SetIdentified(oItem, TRUE);
      SetInfiniteFlag(oItem, nInfinite);

      DebugMode(GetName(oStore)+" erschuf sich "+GetName(oItem)+".");

      nRetrieved++;
    }

    nAppraise  = GetLocalInt(oChest, "UseAppraise");
      SetLocalString(oStore, "UseAppraise", IntToString(nAppraise));

    nBonusUp   = GetLocalInt(oChest, "BonusMarkUp");
      SetLocalString(oStore, "BonusMarkUp", IntToString(nBonusUp));

    nBonusDown = GetLocalInt(oChest, "BonusMarkDown");
      SetLocalString(oStore, "BonusMarkDown", IntToString(nBonusDown));

    nStoreGold = GetLocalInt(oChest, "StoreGold");
      SetLocalString(oStore, "StoreGold", IntToString(nStoreGold));

    nMaxGold = GetLocalInt(oChest, "MaxGold");
      SetLocalString(oStore, "MaxGold", IntToString(nMaxGold));

    nIdentify = GetLocalInt(oChest, "Identify");
      SetLocalString(oStore, "Identify", IntToString(nIdentify));
  }

  DestroyObject(oChest);
}
/*
void RetrieveItems(object oArea, object oCreateIn, int iType)
{ if (!GetIsObjectValid(oArea)) return;
  int nLoop = GetPersistentInt(oArea, "ShopItemCount" + IntToString(iType));
  int i; for (i; i <= nLoop; i++)
  {  GetPersistentObject(oArea, "ShopItems" + IntToString(iType) + IntToString(i), oCreateIn);
  }
}

void SaveItems(object oArea, object oPC, object oChest, int bDestroy, int iType)
{ if (!GetIsObjectValid(oArea) || !GetIsObjectValid(oChest)) return;
  int iCount, nMaxItems = GetLocalInt(GetModule(), "ShopMaxItems");
  CleanUPItems(oArea, iType);
  object oLoop = GetFirstItemInInventory(oChest);
  while (GetIsObjectValid(oLoop))
  {  if (!GetPlotFlag(oLoop) && !GetStolenFlag(oLoop) && !GetItemCursedFlag(oLoop))
     {   if (GetHasInventory(oLoop))
         {  FloatingTextStringOnCreature("Can not save containers!", oPC);
            AssignCommand(oChest, ActionGiveItem(oLoop, oPC));
         }
         else if (iCount >= nMaxItems)
         {  FloatingTextStringOnCreature("Can not have any more items - max number of items are: " + IntToString(nMaxItems) + ".", oPC);
            AssignCommand(oChest, ActionGiveItem(oLoop, oPC));
         }
         else
         {  SetPersistentObject(oArea, "ShopItems" + IntToString(iType) + IntToString(iCount), oLoop);
            if (bDestroy)
            {  DestroyObject(oLoop, 4.0);
            }
            iCount++;
         }
     }
     else
     {  AssignCommand(oChest, ActionGiveItem(oLoop, oPC));
        FloatingTextStringOnCreature("Can not store stolen, plot or undroppable items.", oPC);
     }
   oLoop = GetNextItemInInventory(oChest);
  }
  SetPersistentInt(oArea, "ShopItemCount" + IntToString(iType), iCount);
}
*/
