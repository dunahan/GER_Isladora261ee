/*
Tenser's Floating Disc script

Causes any creature attacking the disc to instead attack the caster.

Created by: The Amethyst Dragon (www.amethyst-dragon.com/nwn)
Created: June 18, 2008
*/

void main()
{
object oDisc = OBJECT_SELF;
object oCaster = GetMaster(oDisc);
object oAttacker = GetLastAttacker(oDisc);

AssignCommand(oAttacker, ClearAllActions());
AssignCommand(oAttacker, ActionAttack(oCaster));
}
