#include "_key_include"
string s = "key_dlg_oaw004: ";
int n = 5503;

int StartingConditional()
{
  object oKeyBoard = OBJECT_SELF, oPC = GetPCSpeaker(), oArea = GetArea(oKeyBoard);
  string sDoorsWithKeys = GetLocalString(oKeyBoard, KEYSYS_DOORKEYS), sKeyTag = GetLocalString(oKeyBoard, IntToString(n));
  string sDoor = GetName(GetDoorByKeyTag(sKeyTag, oArea));
  int i, t = GetTokenCount(sDoorsWithKeys), nFee = CalcFee(GetItemPossessedBy(oPC, sKeyTag), oPC);

  if (GetIsObjectValid(GetItemPossessedBy(oPC, sKeyTag)))
  {
    //SetCustomToken(n, KEYSYS_BOARD004 + StringReplace(sKeyTag, "_", " "));
    SetCustomToken(n, KEYSYS_BOARD004 + sDoor+" ("+IntToString(nFee)+" Gold)");
    return TRUE;
  }

  if (t == 0)
    return FALSE;

  for (i = 1; i <= t; i++)
  {
    if (FindSubString(sDoorsWithKeys, sKeyTag) == -1)
      return FALSE;
  }

  return TRUE;
}
