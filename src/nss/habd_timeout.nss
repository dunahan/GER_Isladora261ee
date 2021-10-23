#include "spawn_main"

void main()
{
    object oPC = GetFirstPC();
    object oSelf = OBJECT_SELF;
    while (GetIsObjectValid(oPC)) {
        if (GetArea(oPC) == oSelf) {
            int nCounter = GetLocalInt(oPC, "DEATH_TIME_LEFT");
            if (nCounter > 0) {
                nCounter -= 6;
                SetLocalInt(oPC, "DEATH_TIME_LEFT", nCounter);
            }
        }

        oPC = GetNextPC();
    }

  Spawn();
}
