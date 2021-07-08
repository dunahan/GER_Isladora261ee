void main()
{
  // * note that nActive == 1 does  not necessarily mean the placeable is active
  // * that depends on the initial state of the object
  int nActive = GetLocalInt (OBJECT_SELF,"X2_L_PLC_ACTIVATED_STATE");
  // * Play Appropriate Animation
  if (!nActive)
    ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);

  else
    ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);

  // * Store New State
  SetLocalInt(OBJECT_SELF,"X2_L_PLC_ACTIVATED_STATE",!nActive);

  object oPC = GetLastUsedBy();
  object oItem = GetItemPossessedBy(oPC, GetLocalString(OBJECT_SELF, "ItemWrong"));
  if (GetIsObjectValid(oItem))
  {
    DestroyObject(oItem);
    CreateItemOnObject(GetLocalString(OBJECT_SELF, "ItemRight"), oPC);
  }

  else
    SendMessageToPC(oPC, "Kein Item zum Austausch gefunden.");
}
