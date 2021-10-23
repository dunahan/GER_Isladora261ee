// port_metotargets
#include "_debugisla"

void main()
{
  object oTarget = GetItemActivatedTarget();              // Get the target of the key
  object oUser = GetItemActivator();                      // Get the activator of the item
  location locTarget = GetItemActivatedTargetLocation();  // Get the target location
  
  if (GetIsObjectValid(oTarget))
  {
    AssignCommand(oUser, ClearAllActions(TRUE));
    AssignCommand(oUser, JumpToObject(oTarget, FALSE));
  }
  else
  {
    AssignCommand(oUser, ClearAllActions(TRUE));
    AssignCommand(oUser, JumpToLocation(locTarget));
  }
}
