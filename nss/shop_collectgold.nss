/* Script Created By Rami_Ahmed */
#include "shop_inc"
void main()
{ object oPC = GetPCSpeaker(),
         oArea = GetArea(OBJECT_SELF);
  if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) || !GetIsObjectValid(oArea)) return;
  if (GetOldOwner(oArea) == GetName(oPC))
  {    int nLostGold = GetPersistentInt(oArea, "ShopOldGold" + GetTag(oArea));
       if (nLostGold > 0)
       {   GiveGoldToCreature(oPC, nLostGold);
           SetPersistentInt(oArea, "ShopOldGold" + GetTag(oArea), 0);
       }
       int nLostVault = GetPersistentInt(oArea, "ShopOldVault" + GetTag(oArea));
       if (nLostVault > 0)
       {   GiveGoldToCreature(oPC, nLostVault);
           SetPersistentInt(oArea, "ShopOldVault" + GetTag(oArea), 0);
       }
   SetPersistentString(oArea, "ShopOldOwner" + GetTag(oArea), "");
  }
  else
  {  FloatingTextStringOnCreature("You are not the old owner and can not collect any gold!", oPC);
  }
}
