#include "00_jk_pins"

void main()
{
  object oPC = GetPCSpeaker();
  SetListening(OBJECT_SELF, FALSE);
  DeleteLocalObject(OBJECT_SELF, "Listening");
  string sName = GetPCChatMessage();
  if (sName == "")
  {
    SpeakString(NO_SAY);
    return;
  }

  if (GetLocalInt(oPC, "MAPPIN") == 1)
    DeleteMapPin(oPC, StringToInt(sName));

  if (GetLocalInt(oPC, "MAPPIN") == 2)
  {
    if (GetActivePinCount(oPC) > iLimit)
    {
      SendServerMessageToPC(oPC, TOMUCH);
      SendServerMessageToPC(oPC, MAX_MN + IntToString(iLimit));
      return;
    }

    AddMapPin(oPC, sName, GetLocalFloat(oPC, "MAPPIN_X"), GetLocalFloat(oPC, "MAPPIN_Y"), GetArea(oPC));
    SendServerMessageToPC(oPC, CRE_MN);
    PersistentMapPins(oPC, 1, "map_pin_conv2");
  }
}

