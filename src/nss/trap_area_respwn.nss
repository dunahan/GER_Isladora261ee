//  This script is called from a trap's OnTrapTriggered or OnDisarmed script (trap_respawn.nss)
//  to respawn a trap that isn't a square                    .

const float TRAP_AREA_RESPAWN_TIME = 6.0;

void RespawnTrap(string sCoords, int iTrapType)
{
    // Since we need a location for the CreateTrapAtLocation call
    // we simply use the first pair of coordinates from the list
    vector v;

    int iP = FindSubString(sCoords, "�"), iStart = 0;
    v.x = StringToFloat(GetSubString(sCoords, iStart, iP));

    iStart = iP+1; iP = FindSubString(sCoords, "�", iStart);
    v.y = StringToFloat(GetSubString(sCoords, iStart, iP));

    // and then we remove them from the list
    sCoords = GetSubString(sCoords, iP+1, GetStringLength(sCoords)-(iP+1));

    PrintString(FloatToString(v.x)+FloatToString(v.y));
    PrintString(sCoords);

    location lLoc = Location(OBJECT_SELF, v, 0.0);

    //NWNXFuncs_SetCustomTrapGeometry(sCoords, TRUE);
    CreateTrapAtLocation(iTrapType, lLoc, 2.0, "", STANDARD_FACTION_HOSTILE, "trap_respawn", "trap_respawn");
}

void main()
{
  // Get the coordinates list
  string sTag = GetTag(OBJECT_SELF);
  string sCoords = GetLocalString(OBJECT_SELF, sTag);

//if (sCoords == "")
//  sCoords = NWNXFuncs_GetTrapGeometry(OBJECT_SELF);

  int iTrapType = GetLocalInt(OBJECT_SELF, "TrapBaseType");
  DeleteLocalString(OBJECT_SELF, sTag);
  DeleteLocalInt(OBJECT_SELF, "TrapBaseType");

  //Respawn the trap after 6 seconds
  DelayCommand(TRAP_AREA_RESPAWN_TIME, RespawnTrap(sCoords, iTrapType));
}
