#include "_key_include"
string s = "key_dlg_oaw008: ";
int n = 5507;

int StartingConditional()
{
  SetCustomToken(n, KEYSYS_BOARD005);

  if (GetTokenCount(GetLocalString(OBJECT_SELF, KEYSYS_DOORKEYS)) > 6)
    return TRUE;

  return FALSE;
}
