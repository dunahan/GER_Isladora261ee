#include "_isla_inc"

void main()
{
  object oSpawnPoint = CreateObject(OBJECT_TYPE_WAYPOINT, "NW_WAYPOINT001", GetLocation(OBJECT_SELF), FALSE, GetResRef(OBJECT_SELF));
  object oTrigger = GetNearestObjectToLocation(OBJECT_TYPE_TRIGGER, GetLocation(OBJECT_SELF));
  object oTarget = GetWaypointByTag(GetTag(OBJECT_SELF));

  SetTag(oTrigger, GetResRef(OBJECT_SELF));
  SetLocalObject(oTrigger, "SpawnPoint", oSpawnPoint);
  SetLocalObject(oTrigger, "Destination", oTarget);
  SetEventScript(oTrigger, EVENT_SCRIPT_TRIGGER_ON_OBJECT_ENTER, "_rid_sectri_onen");
  SetLocalInt(oTrigger, "hidden", TRUE);

  if (GetPlotFlag())  SetPlotFlag(OBJECT_SELF, FALSE);
  DestroyObject(OBJECT_SELF);
}
