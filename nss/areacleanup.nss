/* areacleanup script
checks the area that it was called for for the presence of pc's,
if there aren't any then it systematically cleans up the area
of extra encounters and loot
*/

#include "_isla_inc"

//Trashfunktion fuers Area-Cleaning
void TrashObject(object oObject)
{
  if (GetHasInventory(oObject) == TRUE)
  {
    object oItem = GetFirstItemInInventory(oObject);
    while (GetIsObjectValid(oItem))
    {
      DebugMode(ColorString(GetTag(oItem) + " ist in " + GetTag(oObject) + " und wird gelöscht.", 255, 0, 0));
      TrashObject(oItem);
      oItem = GetNextItemInInventory(oObject);
    }
  }
  else
  {
    DebugMode(ColorString(GetTag(oObject) + " besitzt kein Inventar und wird gelöscht.", 255, 0, 0));
    DestroyObject(oObject);
  }
}


void main()
{
  DebugMode(ColorString(GetName(OBJECT_SELF) + " wird gesäubert!", 0, 255, 0));

  object oObject = GetFirstObjectInArea(OBJECT_SELF);
    while (oObject != OBJECT_INVALID)
    {
      if (GetObjectType(oObject) == OBJECT_TYPE_CREATURE)
      {
        if (GetIsPC(oObject) != TRUE &&                                         // Pruefung ist kein Spielerchar
            GetIsDM(oObject) != TRUE &&                                         // Pruefung ist kein Spielleiter
            GetMaster(oObject) != GetFirstPC() )                                // und ist kein Beschworenes Monster
        {
          if (GetStringLeft (GetTag(oObject), 6) != "Clone_"  &&                // Creatures, NSC
              GetStringLeft (GetTag(oObject), 4) != "nsc_"    &&                // and BossMonsters
              GetStringRight(GetTag(oObject), 5) != "_boss")
          {
            DebugMode(ColorString(GetTag(oObject) + " wird gelöscht.", 255, 0, 0));
            TrashObject(oObject);
          }
        }
      }

      if (GetObjectType(oObject) == OBJECT_TYPE_PLACEABLE)
      {
        if (GetStringLowerCase(GetTag(oObject)) == "bodybag")
        {
          DebugMode(ColorString(GetTag(oObject) + " wird gelöscht.", 255, 0, 0));
          TrashObject(oObject);
        }
      }

      if (GetObjectType(oObject) == OBJECT_TYPE_ITEM)
      {
        if (GetTag(oObject) != "nw_it_spdvscr702" ||
            GetTag(oObject) != "nw_it_spdvscr501" ||
            GetTag(oObject) != "habd_corpsefem"   ||
            GetTag(oObject) != "habd_corpsemale")
        {
          TrashObject(oObject);
        }
      }

    oObject = GetNextObjectInArea(OBJECT_SELF);
  }
}

