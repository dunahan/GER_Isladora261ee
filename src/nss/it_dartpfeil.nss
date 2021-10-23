#include "dart_inc"
#include "x2_inc_switches"
#include "x3_inc_skin"

// Phase 2, Pfeile anziehen und damit das Dartbrett angreifen
void Phase2(object oDart, object oDartscheibe);

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();

    if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
        // Phase 1, Talent geben, Pfeile geben
        object oPC = GetItemActivator();
        object oDartbrett = GetNearestObjectByTag(TAG_DARTBRETT, oPC);
        object oDart = CreateItemOnObject(RESREF_DART_WURFPFEIL, oPC, 1, TAG_DART_WURFPFEIL);
        object oSkin = SKIN_SupportGetSkin(oPC);

        itemproperty ipBonusFeat = ItemPropertyBonusFeat(IP_CONST_FEAT_WEAPON_PROF_SIMPLE);

        AddItemProperty(DURATION_TYPE_TEMPORARY, ipBonusFeat, oSkin, 9.0f);

        AssignCommand(oPC, Phase2(oDart, oDartbrett)); // 1 Tick warten, damit der Wurfpfeil auch richtig existiert.
    }
}

void Phase2(object oDart, object oDartbrett)
{
    ActionEquipItem(oDart, INVENTORY_SLOT_RIGHTHAND);
    ActionDoCommand(ActionAttack(oDartbrett, TRUE));
}
