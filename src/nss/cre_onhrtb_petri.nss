// Creature Heartbeat
// Inspired by ¶nVinoVeri†@s
// Neverending Tales of The Sword Coast
// http://swordcoast.forumcircle.com
#include "x0_i0_petrify"

void main()
{
  //Get Nearst PC and see if within Distance of the statue.
  object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
  if (GetLocalInt(OBJECT_SELF, "petrified") == 1 &&
      GetIsObjectValid(oPC) == TRUE              &&
      GetDistanceToObject(oPC) < 5.0)
    {
      AssignCommand(OBJECT_SELF, ClearAllActions(TRUE));
      // apply the statue vfx
      DelayCommand(1.0, Depetrify(OBJECT_SELF));
      // set plot flag
      DelayCommand(1.3, SetPlotFlag(OBJECT_SELF, FALSE));
      // delete integer
      DelayCommand(1.5, DeleteLocalInt(OBJECT_SELF, "petrified"));
  }
}
