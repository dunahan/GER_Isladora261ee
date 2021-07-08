void d(string s)
{
  object p = GetFirstPC();
  while (GetIsObjectValid(p))
  {
    if (GetPCPlayerName(p) == "dunahan" || GetPCPlayerName(p) == "dun_android")
      SendMessageToPC(p, s);

    p = GetNextPC();
  }
}

void DebugMode(string sDebug)
{
  int DEBUG_MODE = GetLocalInt(GetModule(), "DEBUG_MODE");

       if (DEBUG_MODE == TRUE)
    d(sDebug);

  else if (DEBUG_MODE == 2)
    SpeakString(sDebug, TALKVOLUME_SHOUT);

  else if (DEBUG_MODE == 3)
    WriteTimestampedLogEntry(sDebug);
}

void SendServerMessageToPC(object oPlayer, string szMessage)
{
    SendMessageToPC(oPlayer, "[Server] "+szMessage);
}

string DebugLocation(location locTarget)
{
  string r = "ERROR";
  vector vecLocation = GetPositionFromLocation(locTarget); // Lese die Koordinaten aus der Position
  r = GetResRef(GetAreaFromLocation(locTarget));
  r = r+"\n"+FloatToString(vecLocation.x, 3, 0);
  r = r+"\n"+FloatToString(vecLocation.y, 3, 0);
  r = r+"\n"+FloatToString(vecLocation.z, 3, 0);

  return r;
}
