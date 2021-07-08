#include "dart_inc"
#include "x2_inc_switches"

// Wird im Kontext des Spielers ausgeführt.
void ActionCheckMissed();

void main() {

    int nEvent = GetUserDefinedItemEventNumber();

    if (nEvent == X2_ITEM_EVENT_EQUIP)
    {
        object oPC = GetPCItemLastEquippedBy();

        SetLocalInt(oPC, IS_THROWING_DART, 1);
    }

    else if (nEvent == X2_ITEM_EVENT_UNEQUIP)
    {
        object oPC = GetPCItemLastUnequippedBy();
        object oItem = GetPCItemLastUnequipped();

        AssignCommand(oPC, DelayCommand(3.0f, ActionCheckMissed()));
        SetPlotFlag(oItem, FALSE);
        DestroyObject(oItem);
    }
}

void ActionCheckMissed()
{
    int bIsThrowingDart = GetLocalInt(OBJECT_SELF, IS_THROWING_DART);

    if (bIsThrowingDart) {

        FloatingTextStringOnCreature(GetName(OBJECT_SELF) + " verfehlt das Dartbrett.", OBJECT_SELF, TRUE);
        DeleteLocalInt(OBJECT_SELF, IS_THROWING_DART);
    }
}
