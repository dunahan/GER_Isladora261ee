//============================================================================
//
// Name: CS Resting Subsystem - Handle resting within a "safe" room.
// File: cs_rest_rom
// Author: Craig Smith (Galap) <craig@smith.dropbear.id.au>
//
// $Id: cs_rest_rom.nss,v 1.6 2005/09/14 12:36:23 cs Exp $
// $Source: /local/cvs/nwn/resting/cs_rest_rom.nss,v $
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
    cs_dbg_Enter("cs_rest_rom()");

    object pc = GetLastPCRested();
    if (GetIsPC(pc)) {
        struct cs_rest_config cfg = cs_rest_GetConfig(pc);
        int restType = GetLastRestEventType();
        if (restType == REST_EVENTTYPE_REST_STARTED) {
            // Find all doors within the area of the triggering object the
            // PC is within.
            cs_dbg_Trace("Suche nach Tueren");
            int doorsFound = 0;
            int openDoors = 0;
            if (GetIsObjectValid(cfg.trigger)) {
                object door = GetFirstInPersistentObject(
                    cfg.trigger,
                    OBJECT_TYPE_DOOR
                );
                while (GetIsObjectValid(door)) {
                    cs_dbg_Trace("Tuer gefunden.");
                    doorsFound++;
                    if (GetIsOpen(door)) {
                        cs_dbg_Trace("Die Tuer ist noch offen.");
                        openDoors++;
                    }
                    door = GetNextInPersistentObject(
                        cfg.trigger,
                        OBJECT_TYPE_DOOR
                    );
                }
            }

            // Do we stop the player from resting? This is a safe room rest
            // check. Players may only rest if they have taken steps to
            // ensure their own safety, i.e. closing all doors. Resting is
            // not permitted if:
            //    - there are no doors in this trigger
            //    - a door within this trigger is open
            if (!doorsFound || openDoors) {
                cs_dbg_Trace(GetName(pc) + "Nicht sicher, Du kannst nicht rasten.");
                cs_rest_ShowFloatingTextByID(pc, cfg, CS_REST_TXT_UNSAFE);
                AssignCommand(pc, ClearAllActions());
            }
            else {
                cs_dbg_Trace(GetName(pc) + "beginnt zu rasten.");
                cs_rest_StartResting(pc, cfg);
            }
        }
        else if (restType == REST_EVENTTYPE_REST_FINISHED) {
            cs_dbg_Trace(GetName(pc) + "beendet das rasten.");
            cs_rest_StopResting(pc, cfg);
        }
        else if (restType == REST_EVENTTYPE_REST_CANCELLED) {
            cs_dbg_Trace(GetName(pc) + "brach das rasten ab.");
            cs_rest_CancelResting(pc, cfg);
        }
    }

    cs_dbg_Exit("cs_rest_rom");
}
