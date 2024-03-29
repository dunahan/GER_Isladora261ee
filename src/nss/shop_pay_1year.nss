/* Script Created By Rami_Ahmed */
#include "shop_inc"
void main()
{ object oPC = GetPCSpeaker(),
         oArea = GetArea(OBJECT_SELF);
  if (!GetIsObjectValid(oPC) || !GetIsPC(oPC)) return;
  int nCost = (GetLocalInt(GetModule(), "ShopMinSalary") * 30) * 12;
  if (GetGold(oPC) < nCost)
  {  SpeakString("You dont have enough gold.");
    return;
  }
  TakeGoldFromCreature(nCost, oPC, TRUE);
  float fTime = HoursToSeconds((24 * 30) * 12);
  PaySalary(oArea, fTime);
  SendServerMessageToPC(oPC, "You have paid your salesman to stay for 1 year.");
}
