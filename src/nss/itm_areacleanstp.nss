//::///////////////////////////////////////////////
//:: SL Tools
//:: itm_areacleanstp
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*
    SL-Tool: Gold vergeben
*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 05.12.2009
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_sltools_inc"

void main()
{
  CreateObject(OBJECT_TYPE_PLACEABLE, "areacleanstop", locItemTarget, TRUE);
}
