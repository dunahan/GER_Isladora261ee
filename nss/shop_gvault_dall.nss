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
  int nCurrent = GetGoldInShopVault(oArea, iType);
  if (nCurrent <= 0)
  {  FloatingTextStringOnCreature("There is no gold in the vault!", oPC);
    return;
  }
  SetGoldInShopVault(oArea, 0, iType);
  GiveGoldToCreature(oPC, nCurrent);
}
