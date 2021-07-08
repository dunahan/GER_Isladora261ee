/*
Tenser's Floating Disc script

This spell will conjure a hovering disc of magical force that will carry items
for the caster.  The disc cannot be damaged, but will vanish after

Created by: The Amethyst Dragon (www.amethyst-dragon.com/nwn)
Created: June 18, 2008
*/

#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oCaster = OBJECT_SELF;
    location lTarget = GetLocation(oCaster);

    int nDuration = GetCasterLevel(OBJECT_SELF);

    //Enter Metamagic conditions
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
       {
       nDuration = nDuration *2; //Duration is +100%
       }

    // Visuals
    effect eVisual = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisual, lTarget);

    // The actual conjuration
    object oDisc = CreateObject(OBJECT_TYPE_CREATURE, "floatingdisc", lTarget);
    SetLocalString(oDisc, "caster", GetName(oCaster));
    AddHenchman(oCaster, oDisc);

    DelayCommand(HoursToSeconds(nDuration), ExecuteScript("fdisc_end", oDisc));
}


