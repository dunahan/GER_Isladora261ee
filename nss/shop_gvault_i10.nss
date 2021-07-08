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
  int nGold = 100;
  if (GetGold(oPC) < nGold)
  {  FloatingTextStringOnCreature("You dont have enough gold!", oPC);
    return;
  }
  int iType = GetLocalInt(oArea, "ShopCurStoreType");
  int nCurrent = GetGoldInShopVault(oArea, iType);
  SetGoldInShopVault(oArea, nGold + nCurrent, iType);
  TakeGoldFromCreature(nGold, oPC, TRUE);
}
