/* Script Created By Rami_Ahmed */
#include "shop_inc"
void main()
{ object oArea = GetArea(OBJECT_SELF),
         oPC = GetLocalObject(OBJECT_SELF, "ShopPCObject");
  if (!GetIsObjectValid(oArea)) return;
  int iType = StringToInt(GetStringRight(GetTag(OBJECT_SELF), 1));
  DeleteLocalObject(OBJECT_SELF, "ShopPCObject");
  DelayCommand(1.2, SaveItems(oArea, oPC, OBJECT_SELF, FALSE, iType));
  DelayCommand(2.2, SetGoldInShopVault(oArea, GetStoreGold(OBJECT_SELF), iType));
}
