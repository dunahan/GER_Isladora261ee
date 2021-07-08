#include "x3_inc_string"
#include "spawn_functions"

object GetNearestWaypointByResRef(location locTarget, string sResRef="spawn_point");
void Spawn_StopDueOptionsChanged();

void main()
{
  object oBanner = OBJECT_SELF;
  object oPC = GetPCSpeaker();

  object oWaypoint = GetLocalObject(oBanner, "ParentSpawn");
  string sSpawnNum = GetLocalString(oBanner, "SpawnNumber");
  string sOrgSpawnOps = GetName(oWaypoint);
  if (FindSubString(sOrgSpawnOps, "SP") == -1)
    sOrgSpawnOps = GetLocalString(oWaypoint, "NESS");

  string sCycle = GetLocalString(oPC, "Spawn_Cycle");
  string sTicks = GetLocalString(oPC, "Spawn_Ticks");

  string sNewTicks = StringReplace(sOrgSpawnOps, sCycle, "SP"+sTicks);

  Spawn_StopDueOptionsChanged();
  DespawnChildren(oWaypoint);

  oWaypoint = GetNearestWaypointByResRef(GetLocation(oPC));
  SetName(oWaypoint, sNewTicks);
  SetLocalString(oWaypoint, "NESS", sNewTicks);
  SetLocalString(oWaypoint, "f_Flags", sNewTicks);
  SetCustomToken(1000, sNewTicks);

  SetLocalObject(oBanner, "ParentSpawn", oWaypoint);
  SetLocalObject(GetArea(oPC), sSpawnNum, oWaypoint);

  SetLocalInt(GetArea(oPC), "NESS_AreaSpawnsReset", TRUE);
}

object GetNearestWaypointByResRef(location locTarget, string sResRef="spawn_point")
{
  int nNth = 1;
  object oWaypoint = GetNearestObjectToLocation(OBJECT_TYPE_WAYPOINT, locTarget, nNth);
  while (GetIsObjectValid(oWaypoint))
  {
    if (GetResRef(oWaypoint) == sResRef)
      return oWaypoint;

    nNth++;
    oWaypoint = GetNearestObjectToLocation(OBJECT_TYPE_WAYPOINT, locTarget, nNth);
  }

  return OBJECT_INVALID;
}

void Spawn_StopDueOptionsChanged()
{
  object oArea = OBJECT_SELF;
  object oPC = GetFirstObjectInArea(oArea);
  int nPCsInArea;

  while (GetIsObjectValid(oPC))
  {
    if (GetIsPC(oPC) || GetIsDM(oPC) || GetIsPlayerDM(oPC) || GetIsDMPossessed(oPC))
    {
      DeleteLocalInt(oPC, "NESS_Player");
      nPCsInArea = GetLocalInt( oArea, SPAWN_PCS_IN_AREA );
      nPCsInArea--;
      SetLocalInt( oArea, SPAWN_PCS_IN_AREA, nPCsInArea );
    }

    oPC = GetNextObjectInArea(oArea);
  }

  DeleteLocalInt( oArea, SPAWN_PCS_IN_AREA );
  DeleteLocalInt( oArea, SPAWN_AREA_COUNT );
  DeleteLocalInt( oArea, SPAWN_HEARTBEAT_SCHEDULED );
}
