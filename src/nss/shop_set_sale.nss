/* Script Created By Rami_Ahmed */
#include "shop_inc"
void main()
{ object oPC = GetPCSpeaker(),
         oArea = GetArea(OBJECT_SELF);
  if (!GetIsPC(oPC) || !GetIsObjectValid(oPC)) return;
  if (GetBuySellState(oArea) == 0)
  {  FloatingTextStringOnCreature("The shop is already set for sale.", oPC);
    return;
  }
  SetBuySellState(oArea, 0);
  SendServerMessageToPC(oPC, "You have set this shop: For sale.");
}
