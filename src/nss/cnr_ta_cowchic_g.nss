#include "nw_i0_plot"

int StartingConditional()
{
  object oPC = GetPCSpeaker();
  string sTag = "cnrCornRaw";

  if (HasItem(oPC, sTag))
  {
    return TRUE;
  }

  return FALSE;
}
