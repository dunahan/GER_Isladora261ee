/*
Tenser's Floating Disc script

Disc tries to follow the caster, even through doors.

Created by: The Amethyst Dragon (www.amethyst-dragon.com/nwn)
Created: June 18, 2008
*/

void main()
{
object oDisc = OBJECT_SELF;
object oCaster = GetMaster(oDisc);

DelayCommand(6.0, ActionJumpToLocation(GetLocation(oCaster)));
}
