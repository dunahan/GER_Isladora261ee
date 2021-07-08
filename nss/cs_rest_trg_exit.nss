//============================================================================
//
// Name: CS Resting Subsystem - Remove trigger-specific resting data.
// File: cs_rest_trg_exit
// Author: Craig Smith (Galap) <craig@smith.dropbear.id.au>
//
// $Id: cs_rest_trg_exit.nss,v 1.7 2005/09/14 12:36:23 cs Exp $
// $Source: /local/cvs/nwn/resting/cs_rest_trg_exit.nss,v $
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
// This script is intended to be placed on the OnExit event of a trigger
// or other object. Players that leave the trigger have any trigger-specific
// rules removed.
//
//============================================================================
#include "cs_dbg"
#include "cs_rest"
void main() {
    cs_dbg_Enter("cs_rest_trg_exit()");

    object pc = GetExitingObject();
    if (GetIsPC(pc)) {
        struct cs_rest_config cfg = cs_rest_RetrieveConfig(pc);
        if (GetLocalInt(pc, CS_REST_VAR_NO_REST_ZONE)) {
            cs_rest_ShowFloatingTextByID(pc, cfg, CS_REST_TXT_EXIT_NO_REST);
        }
        else {
            cs_rest_ShowFloatingTextByID(pc, cfg, CS_REST_TXT_EXIT_REST);
        }

        // Remove the trigger tracking information for the trigger.
        cs_rest_DeleteProfile(pc);
        cs_rest_DeleteTriggeringObject(pc);
    }

    cs_dbg_Exit("cs_rest_trg_exit");
}
