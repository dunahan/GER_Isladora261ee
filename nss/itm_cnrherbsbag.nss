/*   Script generated by
Lilac Soul's NWN Script Generator, v. 2.3

For download info, please visit:
http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625    */

#include "_debugisla"

void main()
{
  object         oPC = GetItemActivator();
  location locTarget = GetItemActivatedTargetLocation();
  object     oTarget = GetItemActivatedTarget();

  if ( GetIsObjectValid( oTarget ) || GetIsInCombat( oPC ) )
  { SendServerMessageToPC(oPC, "Falsche Anwendung für diesen Gegenstand"); return; }

  object oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "cnrherbsbag", locTarget);
}
