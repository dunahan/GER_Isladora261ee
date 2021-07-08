string SPAWN_ADD = "25";

void main()
{
  object oPC = GetPCSpeaker();
  string sTicks = GetLocalString(oPC, "Spawn_Ticks");

  if (sTicks == "")                                                             //no value, add one step
    sTicks = SPAWN_ADD;
  else                                                                          //else add step to acual value
    sTicks = IntToString(StringToInt(sTicks) + StringToInt(SPAWN_ADD));

  SetLocalString(oPC, "Spawn_Ticks", sTicks);                                   //save value
  SetCustomToken(1002, sTicks);                                                 //actualize token
}
