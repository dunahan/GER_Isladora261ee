/*
Tenser's Floating Disc script

Disc's heartbeat script.  If not in conversation with the caster, it will follow the caster around.

Created by: The Amethyst Dragon (www.amethyst-dragon.com/nwn)
Created: June 18, 2008
*/

void main()
{
// Check to see if talking..
if (IsInConversation(OBJECT_SELF) != TRUE)
   {
   object oCaster = GetMaster(OBJECT_SELF);
   ActionForceFollowObject(oCaster);
   }
ExecuteScript("nw_c2_default1", OBJECT_SELF);
}
