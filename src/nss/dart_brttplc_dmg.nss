#include "dart_inc"

void main()
{
    effect eHeal = EffectHeal(GetMaxHitPoints());
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);

    object oPC = GetLastDamager();

    if (GetLocalInt(oPC, IS_THROWING_DART))
    {
        DeleteLocalInt(oPC, IS_THROWING_DART);

        int nRoll = Random(42);

        if (nRoll < 40)
        {
            FloatingTextStringOnCreature(GetName(oPC) + " trifft das Dartbrett für " + IntToString(nRoll / 2 + 1) +" Punkte.", oPC);
        }

        else if (nRoll == 40)
        {
            FloatingTextStringOnCreature(GetName(oPC) + " trifft das Dartbrett für 25 Punkte.", oPC);
        }

        else
        {
            FloatingTextStringOnCreature(GetName(oPC) + " trifft das Dartbrett für 50 Punkte.", oPC);
        }
    }
}
