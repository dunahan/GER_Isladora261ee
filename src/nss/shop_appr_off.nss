/* Script Created By Rami_Ahmed */
#include "shop_inc"
void main()
{ object oPC = GetPCSpeaker(),
         oArea = GetArea(OBJECT_SELF);
  if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) || !GetIsObjectValid(oArea)) return;
  if (GetOwner(oArea) != GetName(oPC))
  {  FloatingTextStringOnCreature("You are not the owner!", oPC);
    return;
  }
  SetLocalInt(oArea, "ShopUseAppraise", TRUE);
  SendServerMessageToPC(oPC, "Appraise checks are turned off.");
}
