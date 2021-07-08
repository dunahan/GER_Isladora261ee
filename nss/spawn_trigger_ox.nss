#include "spawn_islafuncs"

void main()
{
    object oCreature = GetExitingObject();
    
    if (GetIsPC(oCreature) == FALSE)
      return;
    
    float fRespawn = IntToFloat(GetLocalInt(OBJECT_SELF, "respawn"));
    DelayCommand(fRespawn, Spawn_ResetSpawnsWithinAOE());
}
