//============================================================================
//
// Name: CS Resting Subsystem - Handle disallowed resting.
// File: cs_rest_cnt
// Author: Craig Smith (Galap) <craig@smith.dropbear.id.au>
//
// $Id: cs_rest_cnt.nss,v 1.6 2005/09/14 12:36:23 cs Exp $
// $Source: /local/cvs/nwn/resting/cs_rest_cnt.nss,v $
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
// This script is executed by the resting system's OnPlayerRest script once
// it has determined the resting profile to which a player is currently set.
//
//============================================================================
#include "cs_dbg"
#include "cs_rest"
void main() {
    cs_dbg_Enter("cs_rest_cnt()");

    object pc = GetLastPCRested();
    if (GetIsPC(pc)) {
        struct cs_rest_config cfg = cs_rest_GetConfig(pc);
        int restType = GetLastRestEventType();
        if (restType == REST_EVENTTYPE_REST_STARTED) {
            cs_dbg_Trace(GetName(pc) + " ist nicht erlaubt zu rasten.");
            cs_rest_ShowFloatingTextByID(pc, cfg, CS_REST_TXT_CANNOT);
            cs_rest_SetAbort(pc);
            AssignCommand(pc, ClearAllActions());
        }
        else if (restType == REST_EVENTTYPE_REST_FINISHED) {
            cs_dbg_Trace(GetName(pc) + " beendete das rasten.");
        }
        else if (restType == REST_EVENTTYPE_REST_CANCELLED) {
            cs_dbg_Trace(GetName(pc) + " brach das rasten ab.");
        }
    }

    cs_dbg_Exit("cs_rest_cnt");
}
