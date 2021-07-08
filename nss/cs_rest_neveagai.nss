#include "cs_dbg"
#include "cs_rest"

void main()
{
  object creature = GetLastSpeaker();
  SetLocalString(creature, "isResting", "NEVER");

  FloatingTextStringOnCreature("//OOC: Diese Entscheidung gilt nur bis zu Deinem Logoff!", creature, FALSE);
}
