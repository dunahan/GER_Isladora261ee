//This saves the data to the db

#include "00_jk_pins"

void main()
{
  if (GetActivePinCount(GetPCSpeaker()) > iLimit)
  {
    SendServerMessageToPC(GetPCSpeaker(), TOMUCH);
    return;
  }

  PersistentMapPins(GetPCSpeaker(), 1, "");
  SendServerMessageToPC(GetPCSpeaker(), SAVEMN);
}

