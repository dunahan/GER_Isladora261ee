int StartingConditional()
{
  object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, OBJECT_SELF);

  int iToModify = GetLocalInt(OBJECT_SELF, "ToModify");
  int iApp = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, iToModify);
  string sApp = IntToString(iApp);

  SetCustomToken(99998, sApp);
  SetCustomToken(99997, Get2DAString(GetLocalString(OBJECT_SELF, "2DAFile"), "LABEL", iApp));

  return TRUE;
}
