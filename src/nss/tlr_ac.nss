int GetArmorType(object oItem);

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
  int nAC = GetArmorType(oItem);
  string sAC = IntToString(nAC);

  int iToModify = GetLocalInt(OBJECT_SELF, "ToModify");
  int iApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, iToModify);
  string sApp = IntToString(iApp);

  SetCustomToken(99998, sApp);

  if (!GetIsObjectValid(oItem))
    SetCustomToken(99999, "- - -");
  else
    SetCustomToken(99999, sAC);

  SetCustomToken(99997, Get2DAString(GetLocalString(OBJECT_SELF, "2DAFile"), "LABEL", iApp));
  return TRUE;
}

int GetArmorType(object oItem)
{ // Make sure the item is valid and is an armor.
  if (!GetIsObjectValid(oItem)) return -1;
  if (GetBaseItemType(oItem) != BASE_ITEM_ARMOR) return -1;

  // Get the identified flag for safe keeping.
  int bIdentified = GetIdentified(oItem);
  SetIdentified(oItem,FALSE);

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
  SetIdentified(oItem,bIdentified);
  return nType;
}
