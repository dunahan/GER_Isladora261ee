#include "bbs_include"

int StartingConditional()
{
  if (GetLocalString(OBJECT_SELF, "#T") != "") {
    return TRUE;
  }
  return FALSE;
}
