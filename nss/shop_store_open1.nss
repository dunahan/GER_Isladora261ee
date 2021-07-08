/* Script Created By Rami_Ahmed */
#include "shop_inc"
#include "_isla_inc"

void main()
{ object oPC = GetPCSpeaker(),
         oArea = GetArea(OBJECT_SELF),
         oStore;
  if (!GetIsObjectValid(oPC) || !GetIsObjectValid(oArea)) return;
  SpeakString("Just a moment there...");
  int i; for (i; i <= 10; i++)
  {  oStore = GetNearestObject(OBJECT_TYPE_STORE, OBJECT_SELF, i);
     if (GetIsObjectValid(oStore) && GetTag(oStore) == "shop_store990")
     { oStore = oStore;
       break;
     }
     else
     { oStore = CreateObject(OBJECT_TYPE_STORE, "shopstore", GetLocation(OBJECT_SELF), FALSE, "shop_store990");
       DelayCommand(0.5, RetrieveItems(oArea, oStore, 0));
     }
  }
  int nMarkUp   = GetShopBonusMarkUp(oArea, 0),
      nMarkDown = GetShopBonusMarkDown(oArea, 0),
      nShopGold = GetGoldInShopVault(oArea, 0);
  SetLocalObject(oStore, "ShopPCObject", oPC);
  DelayCommand(1.0, SetStoreGold(oStore, nShopGold));
  if (!GetLocalInt(oArea, "ShopUseAppraise"))
  { DelayCommand(1.5, gplotAppraiseOpenStore(oStore, oPC, nMarkUp, nMarkDown));
  }
  else
  { DelayCommand(1.5, OpenStore(oStore, oPC, nMarkUp, nMarkDown));
  }
}
