#include "qsa_include"

void main()
{
  object oData = OBJECT_SELF;
  object oSpawn = GetWaypointByTag(GetResRef(oData));

  qsa_CopyVars(oSpawn, oData);                                                  // kopiere die variablen des nsc zum spawnpoint
  ExecuteScript("x2_def_spawn", OBJECT_SELF);
}
