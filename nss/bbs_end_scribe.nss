#include "bbs_include"

void main()
{
  object oPC = GetPCSpeaker();

  object oAvatar = GetNearestObjectByTag("BBS_SCRIBE",oPC,1);
  AssignCommand(oPC,ClearAllActions());
  DestroyObject(oAvatar);
}

