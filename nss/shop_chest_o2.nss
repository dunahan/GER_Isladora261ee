/* Script Created By Rami_Ahmed */
void main()
{ object oPC = GetPCSpeaker(),
         oArea = GetArea(OBJECT_SELF);
  if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) || !GetIsObjectValid(oArea)) return;
  SetLocalInt(oArea, "ShopCurStoreType", 1);
  object oChest = CreateObject(OBJECT_TYPE_PLACEABLE, "shop_savechest", GetLocation(oPC));
  AssignCommand(oPC, ActionInteractObject(oChest));
}
