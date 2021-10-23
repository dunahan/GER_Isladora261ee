#include "_key_include"
string s = "key_dlg_oat001: ";
int b = 5500;

void main()
{
  object oKeyBoard = OBJECT_SELF;                                               DebugMode(s+GetName(oKeyBoard));
  string sDoorsWithKeys = GetLocalString(oKeyBoard, KEYSYS_DOORKEYS);           DebugMode(s+sDoorsWithKeys);
  string c, k;
  int i, n, t = GetTokenCount(sDoorsWithKeys);                                  DebugMode(s+IntToString(t));

  if (t>0)
  {
    for (i = 1; i <= t; i++)
    {
      c = GetStringRight(GetTokenFromString(i, sDoorsWithKeys), 1);             DebugMode(s+c);
      n = StringToInt(c);                                                       DebugMode(s+IntToString(n));
      k = GetTokenFromString(i, sDoorsWithKeys);
      
    //SetCustomToken(b+n, StringReplace(k, "_", " "));                          DebugMode(s+IntToString(i));
      SetCustomToken(b+n, KEYSYS_BOARD007+GetName(GetDoorByKeyTag(k, GetArea(oKeyBoard))));
      SetLocalString(oKeyBoard, IntToString(b+n), k);
    }
  }
}
