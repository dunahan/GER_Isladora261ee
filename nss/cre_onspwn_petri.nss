// Creature OnSpawn
// Inspired by ¶nVinoVeri†@s
// Neverending Tales of The Sword Coast
// http://swordcoast.forumcircle.com
#include "x0_i0_petrify"

void main()
{
  ExecuteScript("x2_def_spawn", OBJECT_SELF);

  //If petrified already - do nothing
  if (GetLocalInt(OBJECT_SELF, "petrified") == 1)
  { return; }

  //If not petrified - petrify with effects / dialogues, change the name to Obscure Statue, boost AC +25
  if (GetLocalInt(OBJECT_SELF, "petrified") == 0)
  {
      // apply the statue vfx
      DelayCommand(1.0, Petrify(OBJECT_SELF));
      // set plot flag
      DelayCommand(1.3, SetPlotFlag(OBJECT_SELF, TRUE));
      //change name to Obscure Statue and set var
      DelayCommand(1.4, SetName(OBJECT_SELF, "Statue"));
      DelayCommand(1.5, SetLocalInt(OBJECT_SELF, "petrified", 1));
  }
}
