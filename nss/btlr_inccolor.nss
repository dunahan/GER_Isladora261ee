//Created by 420 for the CEP
//Next color
//Based on script btlr_increase.nss by bloodsong
#include "_debugisla"

void main()
{
  object oPC = GetPCSpeaker();
  string sToModify = GetLocalString(OBJECT_SELF, "ToModify"); //Get part to color
  int iMax = 175; //Max color
  int iChannel;
  int iNewColor;

  //Set part to color
  if(sToModify == "SKIN")     iChannel = COLOR_CHANNEL_SKIN;
  if(sToModify == "HAIR")     iChannel = COLOR_CHANNEL_HAIR;
  if(sToModify == "TATTOO1")  iChannel = COLOR_CHANNEL_TATTOO_1;
  if(sToModify == "TATTOO2")  iChannel = COLOR_CHANNEL_TATTOO_2;

  iNewColor = GetColor(OBJECT_SELF, iChannel)+1; //Set next color

  //Check for max
  if(iNewColor > iMax)
    iNewColor = 0;

  SetColor(OBJECT_SELF, iChannel, iNewColor); //Change color
  SendServerMessageToPC(oPC, "Neue Farbe: " + IntToString(iNewColor)); //Tell PC color
}
