/* Script Created By Rami_Ahmed */
#include "shop_inc"
void main()
{ object oPC = GetPCSpeaker(),
         oArea = GetArea(OBJECT_SELF);
  if (!GetIsPC(oPC) || !GetIsObjectValid(oPC)) return;
  if (GetBuySellState(oArea) == 1)
  {  FloatingTextStringOnCreature("The shop is already set not for sale.", oPC);
    return;
  }
  SetBuySellState(oArea, 1);
  SendServerMessageToPC(oPC, "You have set this shop: Not for sale.");
}
