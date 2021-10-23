string SPAWN_SUB = "25";

void main()
{
  object oPC = GetPCSpeaker();
  string sTicks = GetLocalString(oPC, "Spawn_Ticks");

  if (StringToInt(sTicks) <= StringToInt(SPAWN_SUB))                            //lower than step => no value
    sTicks = "";
  else if (StringToInt(sTicks) > StringToInt(SPAWN_SUB))                        //greater than step => reduce one step
    sTicks = IntToString(StringToInt(sTicks) - StringToInt(SPAWN_SUB));

  SetLocalString(oPC, "Spawn_Ticks", sTicks);                                   //save value
  SetCustomToken(1002, sTicks);                                                 //actualize token
}
