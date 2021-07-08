//::///////////////////////////////////////////////
//:: Feuerstein und Stahl-Skript
//:: itm_feuerstahl
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creates a fireplace with fire, and hopefully
    an area with protection from cold

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

const string TRIGGER_RESREF = "tri_feuerstahl";
const string FIRE_RESREF = "plc_flamemedium";
const string FIREPLACE_RESREF = "plc_lagerfeuer";

void main()
{
    int nEvent =GetUserDefinedItemEventNumber();
    object oPC;   object oTarget;
    object oItem; location locTarget;

    // * This code runs when the Unique Power property of the item is used
    // * Note that this event fires PCs only
    if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
        oPC   = GetItemActivator();
        oItem = GetItemActivated();
        oTarget = GetItemActivatedTarget();
        locTarget = GetItemActivatedTargetLocation();

        object oSite = GetLocalObject(oPC, "Site");
        object oFire = GetLocalObject(oPC, "Fire");
        object oPlace = GetLocalObject(oPC, "Place");

        if (GetIsObjectValid(oSite) == TRUE || GetIsObjectValid(oFire) == TRUE || GetIsObjectValid(oPlace) == TRUE ) {
            DestroyObject(oSite);
            DestroyObject(oFire);
            DestroyObject(oPlace);
        }

        // create the campfire-ground
        oSite = CreateObject(OBJECT_TYPE_PLACEABLE, FIREPLACE_RESREF, locTarget, FALSE);
        SetLocalObject(oPC, "Site", oSite);

        // create the fire itself
        oFire= CreateObject(OBJECT_TYPE_PLACEABLE, FIRE_RESREF, locTarget, FALSE);
        SetLocalObject(oPC, "Fire", oFire);

        // create a traplike area
        //oPlace = CreateTrapAtLocation(TRAP_BASE_TYPE_MINOR_FIRE, locTarget, 2.0, TRIGGER_RESREF, STANDARD_FACTION_DEFENDER, "", "no_script");
        //SetLocalObject(oPC, "Place", oPlace);

    }
}
