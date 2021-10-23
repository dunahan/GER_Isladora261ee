/* Script Created By Rami_Ahmed */
#include "shop_inc"
int StartingConditional()
{ object oArea = GetArea(OBJECT_SELF);
  if (GetOwner(oArea) == GetName(GetPCSpeaker())) return TRUE;
 return FALSE;
}
