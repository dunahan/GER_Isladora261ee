/*
Tenser's Floating Disc script

This will start the disc's conversation if the PC is the caster of the spell.

Created by: The Amethyst Dragon (www.amethyst-dragon.com/nwn)
Created: June 18, 2008
*/

int StartingConditional()
{
object oDisc = OBJECT_SELF;
object oCaster = GetPCSpeaker();
string sCaster = GetLocalString(oDisc, "caster");
int nYes = FALSE;
if (sCaster == GetName(oCaster))
   {
   nYes = TRUE;
   if (GetMaster(oDisc) != oCaster)
      {
      AddHenchman(oCaster, oDisc);
      }
   }
if (nYes == TRUE)
   {
   return TRUE;
   }
return FALSE;
}
