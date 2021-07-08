#include "bbs_include"

void main()
{
  string sTalk = GetLocalString(OBJECT_SELF, "Stack");
  if (sTalk != "") {
    if (GetStringLength(sTalk) > 20) {sTalk = GetStringLeft(sTalk, 20);}
    SetLocalString(OBJECT_SELF, "#T", sTalk);
    SetLocalString(OBJECT_SELF, "Stack", "");
  }
}
