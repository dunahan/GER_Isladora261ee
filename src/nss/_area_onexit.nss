/* onexit script:
This script is placed in the onexit event handler for each area. Its purpose is to check for the presence of remaining pc's in
an area and if it finds none, then it activates a delayed call to an areacleanup script which cleans the area
*/

#include "_area_inc"
#include "00_jk_pins"
#include "spawn_functions"

const float AREACLEAN = 150.0;

void main()
{
  object oPC = GetExitingObject();
  float cleanupdelay;

  if (!GetIsPC(oPC)) return;                                                    // the leaving object. if it isn't a pc, stop at this point!
  PersistentMapPins(oPC, 1, "map_pin_conv2");                                   // Save the Mappins on the Item
  Spawn_OnAreaExit();                                                           // Despawn every Creature

  if (GetIsObjectValid(GetNearestObjectByTag("areacleanstop", oPC)))            // Should Items/Leftovers also be despawned?
    return;

  if (GetLocalFloat(OBJECT_SELF, "cleanupdelay")== 0.0)                         // if you change this, it alters how long before the area cleans up,
    cleanupdelay = AREACLEAN;                                                   // if you do change it INCLUDE THE DECIMAL, or it won't work

  if (GetIsAreaEmpty(OBJECT_SELF) && GetLocalInt(OBJECT_SELF, "CleanMe") == 0)
  {
    SetLocalInt(OBJECT_SELF, "CleanMe", 1);                                     // Set it ready to be cleansed
    DelayCommand(cleanupdelay, ExecuteScript("areacleanup", OBJECT_SELF));      // do the delayed run of the cleanuo script
    DelayCommand(cleanupdelay+1.0, DeleteLocalInt(OBJECT_SELF, "CleanMe"));     // delete the cleaning var
  }

  ExecuteScript(GetLocalString(OBJECT_SELF, "AreaOnExit"), OBJECT_SELF);        // execute any script that is predefined, than this.
}

