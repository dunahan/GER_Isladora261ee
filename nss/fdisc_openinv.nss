/*
Tenser's Floating Disc script

This will open the disc's inventory for the disc's creator, so that items can
be placed on it or taken off.

Created by: The Amethyst Dragon (www.amethyst-dragon.com/nwn)
Created: June 18, 2008
*/

void main()
{
object oDisc = OBJECT_SELF;
object oCaster = GetPCSpeaker();
OpenInventory(oDisc, oCaster);
}
