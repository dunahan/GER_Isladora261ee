//::///////////////////////////////////////////////
//:: SL Tools
//:: itm_destroyall
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*
    SL-Tool: Versch. zerstoeren
*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 05.12.2009
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_sltools_inc"

void main()
{
  object oDestroy = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, locItemTarget);
  if ( (oItemTarget != OBJECT_INVALID) && (oItemTarget != oItemCaster) )
  { DestroyObject(oItemTarget, 0.0);
    WriteTimestampedLogEntry(GetName(oItemCaster) + " hat " + GetName(oItemTarget) + " zerstört."); }
  else if ( oDestroy != OBJECT_INVALID )
  { DestroyObject(oDestroy, 0.0);
    WriteTimestampedLogEntry(GetName(oItemCaster) + " hat " + GetName(oItemTarget) + " zerstört."); }
  else
  { SendServerMessageToPC(oItemCaster, "Du kannst das nicht zerstören!"); }
}
