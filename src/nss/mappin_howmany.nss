#include "00_jk_pins"
//Put this on action taken in the conversation editor
void main()
{
  SendServerMessageToPC(GetPCSpeaker(), MNCUR1+IntToString(GetPinCount(GetPCSpeaker()))+MNCUR2);
}

