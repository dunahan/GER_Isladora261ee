#include "spawn_functions"

void main()
{
  object oBanner = OBJECT_SELF;
  object oPC = GetPCSpeaker();

  object oWaypoint = GetLocalObject(oBanner, "ParentSpawn");                        //SP_SN03M01_PCR_RW
  string sSpawnNum = GetLocalString(oBanner, "SpawnNumber");                        //Spawn01 etc...
  string sOrgSpawnOps = GetName(oWaypoint);
  if (FindSubString(sOrgSpawnOps, "SP") == -1)
    sOrgSpawnOps = GetLocalString(oWaypoint, "NESS");

  string sCycle = GetStringLeft(sOrgSpawnOps, FindSubString(sOrgSpawnOps, "_"));
  string sTicks = GetStringRight(sCycle, GetStringLength(sCycle)-2);

  SetLocalString(oPC, "OrgSpawnOps", sOrgSpawnOps);
  SetLocalString(oPC, "Spawn_Cycle", sCycle);
  SetLocalString(oPC, "Spawn_Ticks", sTicks);

  SetCustomToken(1002, sTicks);
}
