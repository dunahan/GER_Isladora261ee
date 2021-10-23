#include "bbs_include"

void main()
{
  object Notice = CreateItemOnObject("bbs_notice_bp", GetPCSpeaker());
  if (Notice != OBJECT_INVALID) {
    SetLocalString(Notice, "#T", GetLocalString(OBJECT_SELF, "#T"));            bbs_debug_speak(GetLocalString(GetItemPossessedBy(GetPCSpeaker(), "bbs_notice_bp"), "#T"));
    SetLocalString(Notice, "#M", GetLocalString(OBJECT_SELF, "#M"));            bbs_debug_speak(GetLocalString(GetItemPossessedBy(GetPCSpeaker(), "bbs_notice_bp"), "#M"));
  }
}
