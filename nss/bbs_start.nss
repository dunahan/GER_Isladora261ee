#include "bbs_include"

void main()
{
  object oPC = GetLastUsedBy();
  if (GetIsPC(oPC)) {
    bbs_initiate(OBJECT_SELF);
    SetLocalInt(GetLocalObject(GetModule(), "BBS_" + GetTag(OBJECT_SELF)), "PageIndex", 0);

    bbs_change_page(-1000);
    ActionStartConversation(oPC, "", TRUE);
  }
}
