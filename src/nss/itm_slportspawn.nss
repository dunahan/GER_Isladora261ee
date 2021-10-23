//::///////////////////////////////////////////////
//:: SL Tools
//:: itm_slportspawn
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*
    SL-Tool: Portal erstellen
*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 05.12.2009
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_sltools_inc"

void main()
{
  CreateObject(OBJECT_TYPE_PLACEABLE, "customarea", locItemTarget, TRUE);
}
