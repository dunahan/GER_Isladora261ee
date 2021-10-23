#include "spawn_islafuncs"

void main()
{
    //const float SPAWN_CENTER_RADIUS = 20.0;
    if (GetLocalInt(OBJECT_SELF, "done") == 1)
        return;

    object oCreature = GetEnteringObject();
    float fSizeOfRadius = GetLocalFloat(OBJECT_SELF, "Radius");

    //ggf. mehr abfragen?
    if (GetIsPC(oCreature) == FALSE)
      return;

    if (fSizeOfRadius == 0.0)    fSizeOfRadius = SPAWN_CENTER_RADIUS;

    //Spawn_ShowAOE();
    Spawn_FromTriggerWithAOE();

    SetLocalInt(OBJECT_SELF, "done", 1);
    float fRespawn = IntToFloat(GetLocalInt(OBJECT_SELF, "respawn"));

    if (CountPCsInArea(GetArea(OBJECT_SELF), TRUE) > 0)
        DeleteLocalInt(OBJECT_SELF, "done");

    else
        DelayCommand(fRespawn, DeleteLocalInt(OBJECT_SELF, "done"));
}
