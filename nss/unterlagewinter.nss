//::///////////////////////////////////////////////
//:: Adding a damage immunty to a specified itemgroup
//:: addeffectitm/unterlagewinter
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Adds an Damage Immunity to an Item

    Note that this system only works, if
    the following events set on your module

    OnEquip      - x2_mod_def_equ
    OnUnEquip    - x2_mod_def_unequ
    OnAcquire    - x2_mod_def_aqu
    OnUnAcqucire - x2_mod_def_unaqu
    OnActivate   - x2_mod_def_act

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-09-10
//:://////////////////////////////////////////////
#include "x2_inc_switches"
#include "x2_inc_itemprop"
#include "_debugisla"

const int DAMAGE_TYPE =  7;  // like IP_CONST_DAMAGETYPE_COLD;
const int PERCENT_NBR =  1;  // like IP_CONST_DAMAGEIMMUNITY_5_PERCENT;
const int ALLOWED_ITM = 16;  // BASE_ITEM_ARMOR;

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;

    // * This code runs when the Unique Power property of the item is used
    // * Note that this event fires PCs only
    if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
        oPC   = GetItemActivator();
        oItem = GetItemActivated();
        object oTarget = GetItemActivatedTarget();
        itemproperty ip;

        DebugMode("unterlagewinter: OnItemActivated fired");

        // Only add Effect when Item is Valid
        if (GetIsObjectValid(oTarget) == TRUE)
        {
            if (GetIsPC(oTarget) == FALSE)
            {
                DebugMode("unterlagewinter: Tries to add the things!\n"+
                          "Activator is "+GetName(oPC)+"\n"+
                          "Item is "+GetName(oItem)+"\n"+
                          "Target is "+GetName(oTarget)+"\n"+
                          "Nr. of Itemproperty is "+IntToString(DAMAGE_TYPE)+"\n"+
                          "Nr. of Percent is "+IntToString(PERCENT_NBR)+"\n"+
                          "Allowed Item Type is "+IntToString(ALLOWED_ITM));

                // Can we add it to the type of item?
                if (GetBaseItemType(oTarget) == ALLOWED_ITM)
                {
                    DebugMode("unterlagewinter: Item is valid and we can add the property.");

                    ip = ItemPropertyDamageImmunity(DAMAGE_TYPE, PERCENT_NBR);

                    IPSafeAddItemProperty(oTarget, ip, 0.0f,
                                          X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,
                                          TRUE, TRUE);

                    DebugMode("unterlagewinter: Now that everything has been set, look if its right.");

                    if (IPGetItemHasProperty(oTarget, ip, DURATION_TYPE_PERMANENT, TRUE) == TRUE)
                        DestroyObject(oItem, 0.5);
                }
                else
                {
                    SendServerMessageToPC(oPC, "Auf diesen Gegenstand lässt sich das nicht anwenden.");
                }
            }
            else
            {
                SendServerMessageToPC(oPC, "Du kannst das nicht auf Dich anwenden.");
            }
        }
    }
}
