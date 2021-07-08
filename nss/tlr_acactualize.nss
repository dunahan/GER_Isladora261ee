int GetArmorType(object oItem)
{ // Make sure the item is valid and is an armor.
  if (!GetIsObjectValid(oItem)) return -1;
  if (GetBaseItemType(oItem) != BASE_ITEM_ARMOR) return -1;

  // Get the identified flag for safe keeping.
  int bIdentified = GetIdentified(oItem);
  SetIdentified(oItem, FALSE);

  int nType = -1;
  switch (GetGoldPieceValue(oItem))
    { case    1: nType = 0; break;   // None
      case    5: nType = 1; break;   // Padded
      case   10: nType = 2; break;   // Leather
      case   15: nType = 3; break;   // Studded Leather / Hide
      case  100: nType = 4; break;   // Chain Shirt / Scale Mail
      case  150: nType = 5; break;   // Chainmail / Breastplate
      case  200: nType = 6; break;   // Splint Mail / Banded Mail
      case  600: nType = 7; break;   // Half-Plate
      case 1500: nType = 8; break; } // Full Plate

  // Restore the identified flag, and return armor type.
  SetIdentified(oItem, bIdentified);
  return nType;
}

void main()
{
  if (GetLocalInt(GetModule(), "DEBUG_MODE") > 0)
    SetCustomToken(99997, Get2DAString(GetLocalString(OBJECT_SELF, "2DAFile"), "LABEL", GetItemAppearance(GetItemInSlot(INVENTORY_SLOT_CHEST, OBJECT_SELF), ITEM_APPR_TYPE_ARMOR_MODEL, GetLocalInt(OBJECT_SELF, "ToModify"))));
  else
    SetCustomToken(99997, "");

  SetCustomToken(99998, IntToString(GetArmorType(GetItemInSlot(INVENTORY_SLOT_CHEST, GetPCSpeaker()))));
  SetCustomToken(99999, IntToString(GetArmorType(GetItemInSlot(INVENTORY_SLOT_CHEST, OBJECT_SELF))));
}
