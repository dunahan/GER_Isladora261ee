/* Script Created By Rami_Ahmed */
void main()
{ object oPC   = GetLastDisturbed(),
         oItem = GetInventoryDisturbItem();
  int nEvent   = GetInventoryDisturbType(),
      nCount   = 0,
      nMax     = GetLocalInt(GetModule(), "ShopMaxItems");
  string sItems;
  if (!GetIsObjectValid(oItem) || !GetIsObjectValid(oPC) || !GetIsPC(oPC)) return;
  object oLoop = GetFirstItemInInventory();
  while (GetIsObjectValid(oLoop))
  {  nCount++;
   oLoop = GetNextItemInInventory();
  }
  if (nEvent == INVENTORY_DISTURB_TYPE_ADDED)
  {  if (nCount > nMax)
     {   FloatingTextStringOnCreature("You can not store that many items, maximum items you can store are: " + IntToString(nMax) + ".", oPC);
         ActionGiveItem(oItem, oPC);
     }
     else if (GetHasInventory(oItem))
     {   FloatingTextStringOnCreature("Can not save containers.", oPC);
         ActionGiveItem(oItem, oPC);
     }
  }
  if (nCount == 1)
  {   sItems = "item";
  }
  else
  {   sItems = "items";
  }
  FloatingTextStringOnCreature("You now have " + IntToString(nCount) + " " + sItems + " in the chest.", oPC);
}
