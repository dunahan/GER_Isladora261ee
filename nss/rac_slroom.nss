//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: rac_slroom
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Sonderrassen
    Abfrage, ist Placeable aktiv


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

int StartingConditional()
{
  if ( GetLocalInt(OBJECT_SELF, "SLRoom") == 1 ) { return TRUE; }

  return FALSE;
}
