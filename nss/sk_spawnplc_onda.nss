#include "nw_i0_2q4luskan"
#include "_isla_inc"

void main()
{
    object    oArea = GetArea(OBJECT_SELF);
    location locPLC = GetLocation(OBJECT_SELF);

    SetLocalLocation(oArea, "sPLCSpawn", locPLC);
}
