/* Script Created By Rami_Ahmed */
#include "shop_inc"
void main()
{ object oPC = GetPCSpeaker(),
         oArea = GetArea(OBJECT_SELF);
  if (!GetIsObjectValid(oPC) || !GetIsPC(oPC)) return;
  int nCost = GetLocalInt(GetModule(), "ShopMinSalary");
  if (GetGold(oPC) < nCost)
  {  SpeakString("You dont have enough gold.");
    return;
  }
  TakeGoldFromCreature(nCost, oPC, TRUE);
  PaySalary(oArea, HoursToSeconds(24));
  SendServerMessageToPC(oPC, "You have paid your salesman to stay for 1 day.");
}
