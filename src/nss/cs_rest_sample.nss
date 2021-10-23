//============================================================================
//
// Name: CS Resting Subsystem - Sample User Script
// File: cs_rest_sample
// Author: Craig Smith (Galap) <craig@smith.dropbear.id.au>
//
// $Id: cs_rest_sample.nss,v 1.1 2005/09/14 12:36:23 cs Exp $
// $Source: /local/cvs/nwn/resting/cs_rest_sample.nss,v $
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
// A sample user script for use with the CS Resting Subsystem. This script
// demonstrates the structure and operation of a user script, and it should
// be copied to a new name and changed to suit the needs of the module.
//
//============================================================================
#include "cs_dbg"
#include "cs_rest"
void main() {
    cs_dbg_Enter("cs_rest_sample");

    int state = cs_rest_GetUserScriptState();
    if (state == CS_REST_START_RESTING) {
        cs_dbg_Trace("started resting");
    }
    else if (state == CS_REST_STOP_RESTING) {
        cs_dbg_Trace("stopped resting");
    }
    else if (state == CS_REST_CANCEL_RESTING) {
        cs_dbg_Trace("cancelled resting");
    }
    else if (state == CS_REST_RULE_CHECK) {
        cs_dbg_Trace("custom rule checks");
    }

    cs_dbg_Exit("cs_rest_sample");
}
