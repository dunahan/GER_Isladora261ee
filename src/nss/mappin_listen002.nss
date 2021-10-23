#include "00_jk_pins"

void main()
{
  object oPC = GetPCSpeaker();
  string sName = GetPCChatMessage();
  if (sName == "")
  {
      SpeakString(NO_SAY);
      SendServerMessageToPC(oPC, NO_SAY);
      return;
  }

  SetCustomToken(919, sName);
  SetCustomToken(918, FloatToString(GetLocalFloat(oPC, "MAPPIN_X"),3,0));
  SetCustomToken(917, FloatToString(GetLocalFloat(oPC, "MAPPIN_Y"),3,0));
  SetCustomToken(916, GetName(GetArea(oPC)));
}

