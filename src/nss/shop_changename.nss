/* Script Created By Rami_Ahmed */
#include "shop_inc"
void main()
{ object oPC = GetPCSpeaker(),
         oArea = GetArea(OBJECT_SELF);
  if (!GetIsObjectValid(oPC) || !GetIsObjectValid(oArea) || !GetIsPC(oPC)) return;
  object oListener = SetUpListener(oPC);
  SetListenPattern(oListener, "**", 6436);
  DelayCommand(2.0, SendServerMessageToPC(oPC, "Write the new name for your shop."));
}
