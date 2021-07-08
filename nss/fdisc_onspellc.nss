/*
Tenser's Floating Disc script

Disc's OnSpellCastAt script.

Created by: The Amethyst Dragon (www.amethyst-dragon.com/nwn)
Created: June 18, 2008
*/

void main()
{
object oCaster = GetMaster(OBJECT_SELF);
object oSCaster = GetLastSpellCaster();
int nSCLevel = GetCasterLevel(oSCaster) + d20(1);

int nSpell = GetLastSpell();
if (nSpell == SPELL_DISPEL_MAGIC ||
    nSpell == SPELL_GREATER_DISPELLING ||
    nSpell == SPELL_LESSER_DISPEL ||
    nSpell == SPELL_MORDENKAINENS_DISJUNCTION)
   {
   if (nSCLevel >= d20(1) + 11)
      {
      ExecuteScript("fdisc_end", OBJECT_SELF);
      }
   }
else
   {
   ClearAllActions(TRUE);
   ActionForceFollowObject(oCaster);
   }
}
