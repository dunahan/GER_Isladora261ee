/* Script Created By Rami_Ahmed */
#include "shop_inc"
int StartingConditional()
{ object oPC = GetPCSpeaker(),
         oArea = GetArea(OBJECT_SELF);
  if (GetOldOwner(oArea) == GetName(oPC)) return TRUE;
return FALSE;
}
