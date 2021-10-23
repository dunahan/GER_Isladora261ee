#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();

    if (nEvent == X2_ITEM_EVENT_EQUIP) {
        object oItem = GetPCItemLastEquipped();

        if (GetTag(oItem) != "X2_IT_MRING017") return;

        object oPC = GetPCItemLastEquippedBy();

        int nDDLevel = GetLevelByClass(CLASS_TYPE_DWARVEN_DEFENDER, oPC);
        int nAmount;

        if (nDDLevel >= 10) nAmount = 16;
        else if (nDDLevel >= 6) nAmount = 13;
        else nAmount = 0;

        if (nAmount > 0) {
            effect eDamageReduction = EffectDamageReduction(nAmount, DAMAGE_POWER_PLUS_FIVE);
            effect eSupernatural = SupernaturalEffect(eDamageReduction);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSupernatural, oPC);
        }
    } else if (nEvent == X2_ITEM_EVENT_UNEQUIP) {
        object oItem = GetPCItemLastUnequipped();

        if (GetTag(oItem) != "X2_IT_MRING017") return;

        object oPC = GetPCItemLastUnequippedBy();
        object oSelf = OBJECT_SELF;

        effect eEffect = GetFirstEffect(oPC);
        while (GetIsEffectValid(eEffect)) {
            if (GetEffectType(eEffect) == EFFECT_TYPE_DAMAGE_REDUCTION &&
                GetEffectDurationType(eEffect) == DURATION_TYPE_PERMANENT &&
                GetEffectCreator(eEffect) == oSelf &&
                GetEffectSubType(eEffect) == SUBTYPE_SUPERNATURAL)
            {
                RemoveEffect(oPC, eEffect);
                break;
            }

            eEffect = GetNextEffect(oPC);
        }
    }
}
