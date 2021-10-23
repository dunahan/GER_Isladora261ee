/* Script Created By Rami_Ahmed */
#include "shop_inc"
void main()
{ object oPC = GetEnteringObject(),
         oArea = OBJECT_SELF,
         oDest = GetNearestObject(OBJECT_TYPE_DOOR, oPC);
  if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) || GetIsDM(oPC) ||
     GetLocalInt(oArea, "ShopAreaUse")) return;
  if (!GetIsObjectValid(oDest))
  {  oDest = oPC;
  }
  SetLocalInt(oArea, "ShopAreaUse", TRUE);
  int nNumberSalesman = GetNumberSalesman(oArea);
  if (nNumberSalesman > 0)
  {  int i = 1; for (i = 1; i <= nNumberSalesman; i++)
     {  CreateObject(OBJECT_TYPE_CREATURE, "shopsalesman", GetLocation(oDest));
     }
  }
  if (!GetLocalInt(oArea, "ShopDoOnce"))
  {  object oSign = GetNearestObjectByTag("shop_signboard", oPC);
     if (GetIsObjectValid(oSign))
     {  if (GetOwner(oArea) != "")
        {  SetName(oSign, GetShopName(oArea));
           SetLocalInt(oArea, "ShopDoOnce", TRUE);
        }
     }
  }
}
