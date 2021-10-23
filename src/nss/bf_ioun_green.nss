/**

Ioun Stone - Green (bf_ioun_green)

+1 to Attack, all Saves and all Skills as an Extraordinary Effect, ie only removed by resting.

**/

#include "x2_inc_switches"
#include "_isla_inc"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;

    if (GetLocalInt(GetItemActivator(), "nCount") <= 2)
    {
        if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
        {
            oPC   = GetItemActivator();
            oItem = GetItemActivated();

            effect eEffect1 = EffectSkillIncrease(SKILL_ALL_SKILLS, 1);
            effect eEffect2 = EffectAttackIncrease(1, ATTACK_BONUS_MISC);
            effect eEffect3 = EffectSavingThrowIncrease(SAVING_THROW_ALL, 1, SAVING_THROW_TYPE_ALL);
            effect eEffect4 = EffectLinkEffects(eEffect2, eEffect1);
            effect eEffect5 = EffectLinkEffects(eEffect3, eEffect4);

            effect eVis = EffectVisualEffect(7170);
            DebugMode("Iounstone Green - VFX 7170");

            effect eLink = EffectLinkEffects(eVis, eEffect5);

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
