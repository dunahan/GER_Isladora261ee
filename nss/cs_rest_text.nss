//============================================================================
//
// Name: CS Resting Subsystem - Text display strings
// File: cs_rest_text
// Author: Craig Smith (Galap) <craig@smith.dropbear.id.au>
//
// $Id: cs_rest_text.nss,v 1.7 2005/09/14 12:36:23 cs Exp $
// $Source: /local/cvs/nwn/resting/cs_rest_text.nss,v $
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
// This file contains the text strings displayed as floating text on players
// when resting events occur. Changing these strings will change the messages
// displayed to all players when resting anywhere in the module. If you wish
// to change the messages only for specific area or triggers, consult the
// documentation and check the description for the CS Rest: Text Messages
// configuration item.
//
//============================================================================

const string CS_REST_MSG_START = "Du beginnst zu rasten.";
const string CS_REST_MSG_FINISH = "Du hast das Rasten abgeschlossen.";
const string CS_REST_MSG_CANCEL = "Das Rasten wurde unterbrochen.";
const string CS_REST_MSG_CANNOT = "Du kannst momentan nicht rasten.";
const string CS_REST_MSG_TOO_SOON = "Du kannst erst in <MIN> wieder rasten.";
const string CS_REST_MSG_DAY_ONLY = "Du kannst hier nicht in der Nacht rasten.";
const string CS_REST_MSG_NIGHT_ONLY = "Du kannst hier nicht während des Tages rasten.";
const string CS_REST_MSG_NO_ARMOUR = "Du kannst nicht mit Rüstung rasten.";
const string CS_REST_MSG_NO_WEAPON = "Du kannst nicht mit Waffen rasten.";
const string CS_REST_MSG_BEDROLL_RUINED = "Du rastest, aber die Matte ist in zerlumpt.";
const string CS_REST_MSG_NOT_COMFORTABLE = "Du fühlst Dich unwohl und kannst Dich nicht richtig erholen.";
const string CS_REST_MSG_ENTER_REST = "Dies ist ein sicherer Platz zum rasten.";
const string CS_REST_MSG_EXIT_REST = "Du verlässt einen sicheren Rastplatz.";
const string CS_REST_MSG_UNSAFE = "Du kannst nicht in einem unsicheren Gebiet rasten.";
const string CS_REST_MSG_ENTER_NO_REST = "Du hast eine Zone betreten, die das Rasten verbietet.";
const string CS_REST_MSG_EXIT_NO_REST = "Du verlässt eine Zone, die das Rasten verbietet.";
const string CS_REST_MSG_NO_BEDROLL = "Du kannst ohne Matte nicht rasten.";
const string CS_REST_MSG_RATIONS_EATEN = "Du hast etwas Nahrung zu Dir genommen.";
const string CS_REST_MSG_NO_RATIONS = "Dir fehlt die Nahrung zum Rasten.";
const string CS_REST_MSG_HUNGRY = "Du kannst Dich nicht vollständig erholen, wenn Du keine Nahrung zu Dir nimmst.";

