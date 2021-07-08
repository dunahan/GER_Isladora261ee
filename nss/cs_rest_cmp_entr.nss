//============================================================================
//
// Name: CS Resting Subsystem - Indicate that resting is allowed.
// File: cs_rest_cmp_entr
// Author: Craig Smith (Galap) <craig@smith.dropbear.id.au>
//
// $Id: cs_rest_cmp_entr.nss,v 1.6 2005/09/14 12:36:23 cs Exp $
// $Source: /local/cvs/nwn/resting/cs_rest_cmp_entr.nss,v $
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
// This script is intended to be placed on the OnEnter event of a trigger
// or other object. Players that enter the trigger are flagged as being able
// to rest.
//
//============================================================================
#include "cs_dbg"
#include "cs_rest"
void main() {
    cs_dbg_Enter("cs_rest_cmp_entr()");

    object pc = GetEnteringObject();
    if (GetIsPC(pc)) {
        // Set tracking information for this trigger.
        cs_rest_SetProfile(pc, "cs_rest_cmp");
        cs_rest_SetTriggeringObject(pc, OBJECT_SELF);

        struct cs_rest_config cfg = cs_rest_RetrieveConfig(pc);
        cs_rest_ShowFloatingTextByID(pc, cfg, CS_REST_TXT_ENTER_REST);
    }

    cs_dbg_Exit("cs_rest_cmp_entr");
}
