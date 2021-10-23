#include "_key_include"
string s = "key_board_onused: ";

void main()
{
  object oKeyBoard = OBJECT_SELF;
  string sDoorsWithKeys;

  if (GetLocalInt(oKeyBoard, KEYSYS_DOORLINI) == TRUE)
  {
    ActionStartConversation(GetLastUsedBy(), "key_board", TRUE, FALSE);
    WriteTimestampedLogEntry(GetLocalString(oKeyBoard, KEYSYS_DOORKEYS));
  }

  else
  {
    sDoorsWithKeys = CreateKeyList(GetArea(oKeyBoard));
    WriteTimestampedLogEntry(sDoorsWithKeys);

    SetLocalInt(oKeyBoard, KEYSYS_DOORLINI, TRUE);
    SetLocalString(oKeyBoard, KEYSYS_DOORKEYS, sDoorsWithKeys);
    SetLocalString(oKeyBoard, KEYSYS_DOORKEYS+"_ORG", sDoorsWithKeys);

    ActionStartConversation(GetLastUsedBy(), "key_board", TRUE, FALSE);
  }
}
