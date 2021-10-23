#include "_key_include"
string s = "key_dlg_oaw001: ";
int n = 5500;

int StartingConditional()
{
  object oKeyBoard = OBJECT_SELF;
  string sDoorsWithKeys = GetLocalString(oKeyBoard, KEYSYS_DOORKEYS);

  if (GetTokenCount(sDoorsWithKeys)> 0)
    SetCustomToken(n, KEYSYS_BOARD001);
  else
    SetCustomToken(n, KEYSYS_BOARD002);

  return TRUE;
}
