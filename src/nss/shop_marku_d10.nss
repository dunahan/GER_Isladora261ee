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
  int nBonusMark = GetShopBonusMarkUp(oArea, iType);
  SetShopBonusMarkUp(oArea, nBonusMark - 10, iType);
}
