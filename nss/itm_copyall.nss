//::///////////////////////////////////////////////
//:: SL Tools
//:: itm_copyall
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*
    SL-Tool: Versch. kopieren
*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 05.12.2009
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_sltools_inc"

void main()
{
  if ( (oItemTarget != OBJECT_INVALID) && (oItemTarget != oItemCaster) )
  { if (GetObjectType(oItemTarget) == OBJECT_TYPE_ITEM)
    { CreateItemOnObject( GetResRef(oItemTarget), oItemCaster, GetItemStackSize(oItemTarget) ); }

    if (GetObjectType(oItemTarget) == OBJECT_TYPE_CREATURE)
    { CopyObject(oItemTarget, locItemTarget); }

    WriteTimestampedLogEntry(GetName(oItemCaster) + " hat " + GetName(oItemTarget) + " kopiert"); }
  else
  { SendServerMessageToPC(oItemCaster, "Du kannst das nicht kopieren!"); }
}
