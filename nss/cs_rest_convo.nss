#include "cs_dbg"
#include "cs_rest"

void main()
{
  object creature = GetLastSpeaker();
  SetLocalString(creature, "isResting", "YES");

  FloatingTextStringOnCreature("//OOC: Dein Charakter rastet in 5 Sekunden", creature, FALSE);
  DelayCommand(5.0, AssignCommand(creature, ActionRest()));
}
