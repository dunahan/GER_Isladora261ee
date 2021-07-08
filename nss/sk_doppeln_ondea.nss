void main()
{
  SetCreatureAppearanceType(OBJECT_SELF, 1215);

  object oHelmet = GetItemInSlot(0); object oChest = GetItemInSlot(1);
  object oRHand = GetItemInSlot(4); object oLHand = GetItemInSlot(5);
  object oCloak = GetItemInSlot(6);

  if (GetIsObjectValid(oHelmet)) { DestroyObject(oHelmet); }
  if (GetIsObjectValid(oChest))  { DestroyObject(oChest); }
  if (GetIsObjectValid(oRHand))  { DestroyObject(oRHand); }
  if (GetIsObjectValid(oLHand))  { DestroyObject(oLHand); }
  if (GetIsObjectValid(oCloak))  { DestroyObject(oCloak); }

  ExecuteScript("x2_def_ondeath", OBJECT_SELF);
}
