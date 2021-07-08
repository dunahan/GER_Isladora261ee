/* Script Created By Rami_Ahmed */
#include "shop_inc"
void main()
{ object oPC = GetPCSpeaker(),
         oArea = GetArea(OBJECT_SELF);
  if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) || !GetIsObjectValid(oArea)) return;
  if (GetOwner(oArea) != GetName(oPC))
  {  FloatingTextStringOnCreature("You are not the owner!", oPC);
    return;
  }
  int iType = GetLocalInt(oArea, "ShopCurStoreType");
  int nCurrent = GetGoldInShopVault(oArea, iType), nGold = 100;
  if (nCurrent < nGold)
  {  FloatingTextStringOnCreature("There is not enough gold in your shop vault.", oPC);
    return;
  }
  SetGoldInShopVault(oArea, nCurrent - nGold, iType);
  GiveGoldToCreature(oPC, nGold);
}
