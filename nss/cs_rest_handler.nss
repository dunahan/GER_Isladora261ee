//============================================================================
//
// Name: CS Resting Subsystem - Module OnPlayerRest handler.
// File: cs_rest_handler
// Author: Craig Smith (Galap) <craig@smith.dropbear.id.au>
//
// $Id: cs_rest_handler.nss,v 1.8 2005/09/14 12:36:23 cs Exp $
// $Source: /local/cvs/nwn/resting/cs_rest_handler.nss,v $
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
// This script is intended to be placed on the OnPlayerRest event of the
// module. When a player chooses to rest, or finishes resting, this script
// is invoked.
//
//============================================================================
#include "cs_dbg"
#include "cs_rest"
#include "ll_include"

void cs_DeleteRestingString(object creature);

void main() {
    cs_dbg_Enter("cs_rest_handler()");

    // The creature who is resting.
    object creature = GetLastPCRested();

    LegendaryLevelsRecalculate(creature);
//  LegendaryLevelsTempHP(creature);

    // What resting function are we performing? If resting is just starting,
    // we have to check whether the player is permitted to rest, but if this
    // event is a cancel or stop event, it always runs.
    int restType = GetLastRestEventType();
    string isResting = GetLocalString(creature, "isResting");

    if (restType == REST_EVENTTYPE_REST_STARTED) {

        if (isResting == "" && isResting != "NEVER") {
            AssignCommand(creature, ClearAllActions(TRUE));
            AssignCommand(creature, ActionStartConversation(creature, "cs_rest_convo", TRUE));
            return; }

        // Find the initial config for this creature.
        struct cs_rest_config cfg = cs_rest_RetrieveConfig(creature);

        // If we're not enabled or allowed to rest, don't do anything.
        if (cfg.enabled) {
            // Evaluate rest rules.
            cfg = cs_rest_GetIsRestPermitted(creature, cfg);

            // Store the config on the creature.
            cs_rest_SetConfig(creature, cfg);

            if (cfg.permitted) {
                // Execute the user handler script.
                if (cfg.userScript != "") {
                    cs_rest_SetUserScriptState(creature, CS_REST_START_RESTING);
                    ExecuteScript(cfg.userScript, creature);
                    cs_rest_DeleteUserScriptState(creature);
                    cfg = cs_rest_GetConfig(creature);
                }

                // Make sure that the user handler script has not chosen to
                // override and abort a previously accepted rest request.
                if (cfg.permitted) {
                    // Perform resting for this player.
                    SetLocalInt(creature, CS_REST_VAR_STARTED, CS_REST_STARTED);
                    cs_rest_ExecuteRestScript(creature, cfg);
                    cs_rest_PostRestProcessing(creature, cfg);
                }
                else {
                    // Player is not allowed to start resting.
                    cs_dbg_Trace("Rasten nicht erlaubt: Userskript greift");
                    SetLocalInt(creature, CS_REST_VAR_STARTED, CS_REST_ABORTED);
                    AssignCommand(creature, ClearAllActions());

                    // Cleanup stray config that may be lying around.
                    cs_rest_DeleteConfig(creature);
                }
            }
            else {
                // Player is not allowed to start resting.
                cs_dbg_Trace("Rasten nicht erlaubt.");
                SetLocalInt(creature, CS_REST_VAR_STARTED, CS_REST_ABORTED);
                AssignCommand(creature, ClearAllActions());

                // Cleanup stray config that may be lying around.
                cs_rest_DeleteConfig(creature);
            }
        }
        else {
            // Player is not allowed to start resting.
            cs_dbg_Trace("Rasten wurde deaktiviert.");
            SetLocalInt(creature, CS_REST_VAR_STARTED, CS_REST_ABORTED);
            AssignCommand(creature, ClearAllActions());

            // Cleanup stray config that may be lying around.
            cs_rest_DeleteConfig(creature);
        }
        cs_DeleteRestingString(creature);
    }
    else {
        // Retrieve the stored config for this creature.
        struct cs_rest_config cfg = cs_rest_GetConfig(creature);

        // Execute the user handler script.
        if (cfg.userScript != "") {
            if (restType == REST_EVENTTYPE_REST_FINISHED) {
                cs_rest_SetUserScriptState(creature, CS_REST_STOP_RESTING);
            }
            else {
                cs_rest_SetUserScriptState(creature, CS_REST_CANCEL_RESTING);
            }
            ExecuteScript(cfg.userScript, creature);
            cs_rest_DeleteUserScriptState(creature);
        }

        // Complete resting for this player.
        cs_rest_ExecuteRestScript(creature, cfg);

        // Cleanup stray config that may be lying around.
        cs_rest_DeleteConfig(creature);

        cs_DeleteRestingString(creature);
    }
    cs_dbg_Trace("Reset der Ionensteine."); SetLocalInt(creature, "nCount", 0); //Ionensteine wieder auf normal setzen

    cs_dbg_Exit("cs_rest_handler");
}

void cs_DeleteRestingString(object creature)
{
  string sTest = GetLocalString(creature, "isResting");
  if (sTest != "NEVER")
    DeleteLocalString(creature, "isResting");
}
