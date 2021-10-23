/* Script Created By Rami_Ahmed */
#include "shop_inc"
void main()
{ object oPC = GetPCSpeaker(),
         oArea = GetArea(OBJECT_SELF);
  if (!GetIsObjectValid(oPC) || !GetIsPC(oPC)) return;
  if (GetOwner(oArea) != GetName(oPC))
  {  FloatingTextStringOnCreature("You are not the owner!", oPC);
    return;
  }
  object oListener = SetUpListener(oPC);
  SetListenPattern(oListener, "**", 6434);
  SendServerMessageToPC(oPC, "Please wait 4-5 seconds then write the price.");
}
