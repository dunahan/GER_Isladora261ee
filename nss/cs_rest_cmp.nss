//============================================================================
//
// Name: CS Resting Subsystem - Handle resting within specified safe areas.
// File: cs_rest_cmp
// Author: Craig Smith (Galap) <craig@smith.dropbear.id.au>
//
// $Id: cs_rest_cmp.nss,v 1.6 2005/09/14 12:36:23 cs Exp $
// $Source: /local/cvs/nwn/resting/cs_rest_cmp.nss,v $
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
    cs_dbg_Enter("cs_rest_cmp()");

    object pc = GetLastPCRested();
    if (GetIsPC(pc)) {
        struct cs_rest_config cfg = cs_rest_GetConfig(pc);
        int restType = GetLastRestEventType();
        if (restType == REST_EVENTTYPE_REST_STARTED) {
            cs_dbg_Trace(GetName(pc) + " beginnt zu rasten.");
            cs_rest_StartResting(pc, cfg);
        }
        else if (restType == REST_EVENTTYPE_REST_FINISHED) {
            cs_dbg_Trace(GetName(pc) + " stoppte das rasten.");
            cs_rest_StopResting(pc, cfg);
        }
        else if (restType == REST_EVENTTYPE_REST_CANCELLED) {
            cs_dbg_Trace(GetName(pc) + " brach das rasten ab.");
            cs_rest_CancelResting(pc, cfg);
        }
    }
    cs_dbg_Exit("cs_rest_cmp");
}
