/* Script Created By Rami_Ahmed */
#include "shop_inc"
void main()
{ object oPC = GetPCSpeaker(),
         oArea = GetArea(oPC);
  if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) || !GetIsObjectValid(oArea)) return;
  if (GetOwner(oArea) != GetName(oPC))
  {  FloatingTextStringOnCreature("You are not the owner!", oPC);
    return;
  }
  int iType = GetLocalInt(oArea, "ShopCurStoreType");
  int nBonusMark = GetShopBonusMarkDown(oArea, iType);
  SetShopBonusMarkDown(oArea, nBonusMark - 10, iType);
}
