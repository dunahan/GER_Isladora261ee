//Created by 420 for the CEP
//Get color number spoken by PC
#include "_debugisla"
  
//Get Spoken Color
string GetSpokenColor()
{
  int iCount = 0;
  int iMax = GetMatchedSubstringsCount();
  string sName;

  if(GetListenPatternNumber() == 8888)
  {
    while(iCount<iMax)
    {
      sName = sName+GetMatchedSubstring(iCount);
      iCount++;
    }
  }
  SetListening(OBJECT_SELF, FALSE);
  return sName;
}

void main()
{
  object oPC = GetPCSpeaker();

  string sToModify = GetLocalString(OBJECT_SELF, "ToModify"); //Get part to color

  int iMin = 0; //Min color
  int iMax = 175; //Max color

  int iChannel;
  int iNewColor;

  //Set part to color
  if(sToModify == "SKIN")     iChannel = COLOR_CHANNEL_SKIN;
  if(sToModify == "HAIR")     iChannel = COLOR_CHANNEL_HAIR;
  if(sToModify == "TATTOO1")  iChannel = COLOR_CHANNEL_TATTOO_1;
  if(sToModify == "TATTOO2")  iChannel = COLOR_CHANNEL_TATTOO_2;

  iNewColor = StringToInt(GetSpokenColor()); //Set new color

  //Check for max
  if(iNewColor > iMax)
  {
    SendServerMessageToPC(oPC, IntToString(iNewColor)+" ist zu hoch!"); //Tell PC color
    iNewColor = 175;
  }
  //Check for min
  if(iNewColor < iMin)
  {
    SendServerMessageToPC(oPC, IntToString(iNewColor)+" ist zu niedrig!"); //Tell PC color
    iNewColor = 0;
  }

  SetColor(OBJECT_SELF, iChannel, iNewColor); //Change color
  SendServerMessageToPC(oPC, "Neue Farbe: " + IntToString(iNewColor)); //Tell PC color
}
