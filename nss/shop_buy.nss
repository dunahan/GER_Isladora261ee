/* Script Created By Rami_Ahmed */
#include "shop_inc"
void main()
{ object oPC = GetPCSpeaker();
  SetOwner(oPC, GetArea(OBJECT_SELF));
}
