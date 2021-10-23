//============================================================================
//
// Name: CS Resting Subsystem - Example User Script
// File: cs_rest_userxmpl
// Author: Craig Smith (Galap) <craig@smith.dropbear.id.au>
//
// $Id: cs_rest_userxmpl.nss,v 1.1 2005/09/14 12:36:23 cs Exp $
// $Source: /local/cvs/nwn/resting/cs_rest_userxmpl.nss,v $
//
//----------------------------------------------------------------------------
// This software is distributed in the hope that it will be useful. It is
// provided "as is" WITHOUT WARRANTY OF ANY KIND, either expressed or implied,
// including, but not limited to, the implied warranties of merchantability
// and fitness for a particular purpose. You may redistribute or modify this
// software for your own purposes so long as all original credit information
// remains intact.
//----------------------------------------------------------------------------
//
// An example user script for use with the CS Resting Subsystem. This script
// demonstrates both how the Bioware HotU wandering monster system can be
// integrated into the CS Resting Subsystem via the user script facility,
// and how additional custom resting rules may be incorporated into the rest
// system.
//
// To use this script, place a "CS Rest: User Script" item in a resting
// configuration container and set the tag of that item to "cs_rest_userxmpl".
// This script does not make any changes to the Bioware HotU wandering
// monster system, nor does it provide any mechanism to manage the monsters
// generated by the system. The management of the wandering monster system
// is exactly as if the standard Bioware HotU resting system were in use.
//
//============================================================================
#include "x2_inc_restsys"
#include "x2_inc_switches"

#include "cs_dbg"
#include "cs_rest"
void main() {
    cs_dbg_Enter("cs_rest_wndmonst");

    int state = cs_rest_GetUserScriptState();
    if (state == CS_REST_START_RESTING) {
        cs_dbg_Trace("started resting");

        // Only perform wandering monster check if enabled.
        if (GetModuleSwitchValue(MODULE_SWITCH_USE_XP2_RESTSYSTEM)) {
            object area = GetArea(OBJECT_SELF);
            string table = GetLocalString(area, "X2_WM_ENCOUNTERTABLE");
            if (table != "" ) {
                // Set up the Encounter table.
                int doors = GetLocalInt(area, "X2_WM_AREA_USEDOORS");
                int DC = GetLocalInt(area, "X2_WM_AREA_LISTENCHECK");
                WMSetAreaTable(area, table, doors, DC);

                // Remove string to indicate we are set up
                DeleteLocalString(area,"X2_WM_ENCOUNTERTABLE");
            }

            if (GetLocalInt(OBJECT_SELF,"X2_WM_AMBUSH_IN_PROGRESS")) {
                // The resting system has objections against resting here and
                // now. Probably because there is an ambush already in progress.
                FloatingTextStrRefOnCreature(84142, OBJECT_SELF);

                // Abort the resting process for this player.
                cs_rest_SetAbort();
            }
            if (WMCheckForWanderingMonster(OBJECT_SELF)) {
                // This script MUST be run or the player won't be able to rest
                // again...
                ExecuteScript("x2_restsys_ambus", OBJECT_SELF);
            }
        }
    }
    else if (state == CS_REST_STOP_RESTING) {
        cs_dbg_Trace("stopped resting");
    }
    else if (state == CS_REST_CANCEL_RESTING) {
        cs_dbg_Trace("cancelled resting");
    }
    else if (state == CS_REST_RULE_CHECK) {
        cs_dbg_Trace("custom rule checks");
        // Search the equipped items of the player to see if any have
        // fire resistance, and allow resting by setting the override
        // profile if so.
        int i = 0;
        int done = FALSE;
        while ((i < NUM_INVENTORY_SLOTS) && !done) {
            object item = GetItemInSlot(i, OBJECT_SELF);
            if (GetIsObjectValid(item)) {
                itemproperty prop = GetFirstItemProperty(item);
                while(GetIsItemPropertyValid(prop) && !done) {
                    if (GetItemPropertyType(prop) == ITEM_PROPERTY_DAMAGE_RESISTANCE) {
                        // Fire resistance. Constant?
                        if (GetItemPropertySubType(prop) == 10) {
                            // This item has fire resistance and is equipped
                            // so switch the player to a safe rest profile
                            // temporarily.
                            cs_rest_SetOverrideProfile(OBJECT_SELF, "cs_rest_cmp");
                            done = TRUE;
                        }
                    }
                    prop = GetNextItemProperty(item);
                }
            }
            i++;
        }
    }

    cs_dbg_Exit("cs_rest_wndmonst");
}