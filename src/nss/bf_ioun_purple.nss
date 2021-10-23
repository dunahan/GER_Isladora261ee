/**

Ioun Stone - Purple (bf_ioun_purple)

Absorbs 20 levels of spells 4th level or lower as an Extraordinary Effect, ie only removed by resting.

**/

#include "x2_inc_switches"
#include "_isla_inc"

void main()
{
    int nEvent =GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;

    if (GetLocalInt(GetItemActivator(), "nCount") <= 2)
    {
        if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
        {
            oPC   = GetItemActivator();
            oItem = GetItemActivated();

            effect eEffect = EffectSpellLevelAbsorption(4, 20, SPELL_SCHOOL_GENERAL);
            effect eVis = EffectVisualEffect(7171);
            DebugMode("Iounstone Purple - VFX 7171");

            effect eLink = EffectLinkEffects(eVis, eEffect);

            effect eDone = ExtraordinaryEffect(eLink);

            int nCount = GetLocalInt(GetItemActivator(), "nCount");

            switch (nCount)
            {
                case 1:  { DelayCommand( 5.0, SetLocalInt(GetItemActivator(), "nCount", 2));
                SendServerMessageToPC(GetItemActivator(), GetName(GetItemActivated()) +
                " wurde aktiviert."); break;}

                case 2:  { DelayCommand( 5.0, SetLocalInt(GetItemActivator(), "nCount", 3));
                SendServerMessageToPC(GetItemActivator(), GetName(GetItemActivated()) +
                " wurde aktiviert."); break;}

                default: { DelayCommand( 5.0, SetLocalInt(GetItemActivator(), "nCount", 1));
                SendServerMessageToPC(GetItemActivator(), GetName(GetItemActivated()) +
                " wurde aktiviert."); break;}
            }

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDone, oPC, HoursToSeconds(24));
            DelayCommand(HoursToSeconds(24), DeleteLocalInt(GetItemActivator(), "nCount"));
        }
    }
    else if (GetLocalInt(GetItemActivator(), "nCount") == 3)
    {
        FloatingTextStringOnCreature("Du hast bereits die maximale Anzahl an Ionensteine aktiviert!", oPC, FALSE);
        DebugMode(GetName(oPC) + " hat bereits die maximale Anzahl an Ionensteine aktiviert!");
    }
}
