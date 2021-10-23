/* Script Created By Rami_Ahmed */
#include "shop_inc"
void main()
{ object oPC = GetLastOpenedBy(),
         oArea = GetArea(OBJECT_SELF),
         oSelf = OBJECT_SELF;
  if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) ||
  GetOwner(oArea) != GetName(oPC)) return;
  DelayCommand(1.2, RetrieveItems(oArea, OBJECT_SELF, GetLocalInt(oArea, "ShopCurStoreType")));
}
