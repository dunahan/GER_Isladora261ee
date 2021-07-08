#include "_key_include"
string s = "key_dlg_oaw009: ";
int n = 5508;

int StartingConditional()
{
  SetCustomToken(n, KEYSYS_BOARD006);

  if (GetIsDM(GetPCSpeaker()) || GetIsDMPossessed(GetPCSpeaker()))
    return TRUE;

  return FALSE;
}
