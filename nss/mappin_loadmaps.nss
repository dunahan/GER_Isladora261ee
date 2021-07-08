// this loads the data from the db

#include "00_jk_pins"

void main()
{
  PersistentMapPins(GetPCSpeaker(), 0, "");
  SendServerMessageToPC(GetPCSpeaker(), LOADMN);
}

