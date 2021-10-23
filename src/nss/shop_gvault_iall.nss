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
  int nGold = GetGold(oPC);
  if (nGold <= 0)
  {  FloatingTextStringOnCreature("You dont have any gold!", oPC);
    return;
  }
  int iType = GetLocalInt(oArea, "ShopCurStoreType");
  int nCurrent = GetGoldInShopVault(oArea, iType);
  SetGoldInShopVault(oArea, nCurrent + nGold, iType);
  TakeGoldFromCreature(nGold, oPC, TRUE);
}
