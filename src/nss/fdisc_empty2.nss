/*
Tenser's Floating Disc script

This will transfer ALL items from the disc's inventory, then destroy the disc.

Created by: The Amethyst Dragon (www.amethyst-dragon.com/nwn)
Created: June 18, 2008
*/

void main()
{
object oDisc = OBJECT_SELF;
object oCaster = GetPCSpeaker();
object oInv = GetFirstItemInInventory(oDisc);
while (oInv != OBJECT_INVALID)
   {
   ActionGiveItem(oInv, oCaster);
   oInv = GetNextItemInInventory(oDisc);
   }
int nGold = GetGold(oDisc);
if (nGold > 1)
   {
   AssignCommand(oCaster, TakeGoldFromCreature(nGold, oDisc, FALSE));
   }
oInv = GetItemInSlot(INVENTORY_SLOT_ARMS, oDisc);
ActionGiveItem(oInv, oCaster);
oInv = GetItemInSlot(INVENTORY_SLOT_ARROWS, oDisc);
ActionGiveItem(oInv, oCaster);
oInv = GetItemInSlot(INVENTORY_SLOT_BELT, oDisc);
ActionGiveItem(oInv, oCaster);
oInv = GetItemInSlot(INVENTORY_SLOT_BOLTS, oDisc);
ActionGiveItem(oInv, oCaster);
oInv = GetItemInSlot(INVENTORY_SLOT_BOOTS, oDisc);
ActionGiveItem(oInv, oCaster);
oInv = GetItemInSlot(INVENTORY_SLOT_BULLETS, oDisc);
ActionGiveItem(oInv, oCaster);
oInv = GetItemInSlot(INVENTORY_SLOT_CHEST, oDisc);
ActionGiveItem(oInv, oCaster);
oInv = GetItemInSlot(INVENTORY_SLOT_CLOAK, oDisc);
ActionGiveItem(oInv, oCaster);
oInv = GetItemInSlot(INVENTORY_SLOT_HEAD, oDisc);
ActionGiveItem(oInv, oCaster);
oInv = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oDisc);
ActionGiveItem(oInv, oCaster);
oInv = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oDisc);
ActionGiveItem(oInv, oCaster);
oInv = GetItemInSlot(INVENTORY_SLOT_NECK, oDisc);
ActionGiveItem(oInv, oCaster);
oInv = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oDisc);
ActionGiveItem(oInv, oCaster);
oInv = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oDisc);
ActionGiveItem(oInv, oCaster);

DelayCommand(6.0, DestroyObject(oDisc));
}
