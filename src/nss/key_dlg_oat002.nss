#include "_key_include"
string s = "key_dlg_oat002: ";
int n = 5501;

void main()
{
  object oKeyBoard = OBJECT_SELF;
  string sKeyTag = GetLocalString(oKeyBoard, IntToString(n)), sDoor = GetName(GetDoorByKeyTag(sKeyTag, GetArea(oKeyBoard))), sDoorsWithKeys;
  object oPC = GetPCSpeaker(), oKey = GetItemPossessedBy(oPC, sKeyTag);

  if (GetIsObjectValid(oKey))
  {
    sDoorsWithKeys = AddTokenToString(GetTag(oKey), GetLocalString(oKeyBoard, KEYSYS_DOORKEYS));
    SetLocalString(oKeyBoard, KEYSYS_DOORKEYS, sDoorsWithKeys);

    CalcFeeAndTakeIt(oKey, oPC);
  }

  else
  {
    oKey = CreateItemOnObject(KEYSYS_TEMPLATE, oPC, 1, sKeyTag);
    SetLocalInt(oKey, KEYSYS_DOORSFEE, CalcActualDays());
    //SetName(oKey, StringReplace(sKeyTag, "_", " "));
    SetName(oKey, GetName(GetArea(oKeyBoard)) + " " + sDoor);

    sDoorsWithKeys = DeleteTokenFromString(sKeyTag, GetLocalString(oKeyBoard, KEYSYS_DOORKEYS));
    SetLocalString(oKeyBoard, KEYSYS_DOORKEYS, sDoorsWithKeys);
    
    WriteTimestampedLogEntry(GetName(oPC) + " got " + GetName(oKey) + "/"+ GetTag(oKey));
  }
}
