//============================================================================
//
// Name: CS Debugging Subsystem - Actual Debug Functions
// File: cs_dbg_debug
// Author: Craig Smith (Galap) <craig@smith.dropbear.id.au>
//         Magnus Tyrland (Athinair)
//
// $Id: cs_dbg_debug.nss,v 1.5 2005/07/10 09:44:30 cs Exp $
// $Source: /local/cvs/nwn/debug/cs_dbg_debug.nss,v $
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
// Introduction
// ------------
// This file contains the real debug functions. Use these when testing your
// scripts.
//
// To change your code from using the release stub debug functions to the
// actual functions, edit the "cs_dbg" file and change the #include directive
// at the bottom of the file to the following line:
//
//     #include "cs_dbg_debug"
//
// Of course, if you change from debug functions to release stub functions
// or back again, a complete build of your module is recommended.
//
// Do not just include the "cs_dbg_debug" file directly into your own
// scripts!
//
//============================================================================


//============================================================================
//
// Data Types and Constants
//
//============================================================================

// Local variable names for debug support.
const string CS_DBG_VAR_LEVEL = "cs_dbgLevel";
const string CS_DBG_VAR_PC = "cs_dbgPc";
const string CS_DBG_VAR_INDENT = "cs_dbgIndent";
const string CS_DBG_VAR_DESTINATION = "cs_dbgDestination";

// Predefined constants for indentation. Anyone who is calling more then 20
// levels deep is getting silly.
const string CS_DBG_INDENT_1  = "  ";
const string CS_DBG_INDENT_2  = "    ";
const string CS_DBG_INDENT_3  = "      ";
const string CS_DBG_INDENT_4  = "        ";
const string CS_DBG_INDENT_5  = "          ";
const string CS_DBG_INDENT_6  = "            ";
const string CS_DBG_INDENT_7  = "              ";
const string CS_DBG_INDENT_8  = "                ";
const string CS_DBG_INDENT_9  = "                  ";
const string CS_DBG_INDENT_10 = "                    ";
const string CS_DBG_INDENT_11 = "                      ";
const string CS_DBG_INDENT_12 = "                        ";
const string CS_DBG_INDENT_13 = "                          ";
const string CS_DBG_INDENT_14 = "                            ";
const string CS_DBG_INDENT_15 = "                              ";
const string CS_DBG_INDENT_16 = "                                ";
const string CS_DBG_INDENT_17 = "                                  ";
const string CS_DBG_INDENT_18 = "                                    ";
const string CS_DBG_INDENT_19 = "                                      ";
const string CS_DBG_INDENT_20 = "                                        ";

const string CS_DBG_COLOUR_TIMESTAMP = "<c°°°>";//CS_DBG_COLOUR_LIGHT_GREY;
const string CS_DBG_COLOUR_CRITICAL = "<cþ  >";//CS_DBG_COLOUR_RED;
const string CS_DBG_COLOUR_ERROR = "<cþ  >";//CS_DBG_COLOUR_RED;
const string CS_DBG_COLOUR_WARNING = "<cþþ >";//CS_DBG_COLOUR_YELLOW;
const string CS_DBG_COLOUR_INFO = "<c þ >";//CS_DBG_COLOUR_GREEN;
const string CS_DBG_COLOUR_TRACE = "<c®þþ>";//CS_DBG_COLOUR_LIGHT_BLUE;
const string CS_DBG_COLOUR_ENTER = "<cfÌþ>";//CS_DBG_COLOUR_BLUE;
const string CS_DBG_COLOUR_EXIT = "<cfÌþ>";//CS_DBG_COLOUR_BLUE;

string cs_dbg_textColour = CS_DBG_COLOUR_NONE;


//----------------------------------------------------------------------------
void cs_dbg_Enable(int level) {
    SetLocalInt(GetModule(), CS_DBG_VAR_LEVEL, level);
}

//----------------------------------------------------------------------------
void cs_dbg_Disable(int level) {
    object mod = GetModule();
    int currentLevel = GetLocalInt(mod, CS_DBG_VAR_LEVEL);
    SetLocalInt(mod, CS_DBG_VAR_LEVEL, currentLevel & ~level);
}

//----------------------------------------------------------------------------
int cs_dbg_GetIsEnabled(int which = 0xffffffff) {
    return GetLocalInt(GetModule(), CS_DBG_VAR_LEVEL) & which;
}

//----------------------------------------------------------------------------
void cs_dbg_EnableDestination(int destination) {
    SetLocalInt(GetModule(), CS_DBG_VAR_DESTINATION, destination);
}

//----------------------------------------------------------------------------
void cs_dbg_DisableDestination(int destination) {
    object mod = GetModule();
    int currentDestination = GetLocalInt(mod, CS_DBG_VAR_DESTINATION);
    SetLocalInt(mod, CS_DBG_VAR_LEVEL, currentDestination & ~destination);
}

//----------------------------------------------------------------------------
int cs_dbg_GetIsDestinationEnabled(int which = 0xffffffff) {
    return GetLocalInt(GetModule(), CS_DBG_VAR_DESTINATION) & which;
}

//----------------------------------------------------------------------------
void cs_dbg_SetPCListener(object pc) {
    SetLocalObject(GetModule(), CS_DBG_VAR_PC, pc);
}

//----------------------------------------------------------------------------
object cs_dbg_GetPCListener() {
    object pc = GetLocalObject(GetModule(), CS_DBG_VAR_PC);
    if (!GetIsObjectValid(pc)) {
        pc = OBJECT_INVALID;
    }
    return pc;
}

//----------------------------------------------------------------------------
// Display a string for debugging purposes. Debug messages are prefixed with
// the current time, however this is represented in game terms and so is not
// very useful except to determine sequence.
//
// If the Debug Toggle item is used within a module, it is possible to set
// a specific object to display debug messages even if debugging is disabled.
// If a player or DM uses the Debug Toggle item to set themselves as the
// debug target for a specific object, all of that object's debug messages
// will be displayed in that player or DM's message window regardless of
// the global debug setting. The override argument, if specified, will
// override the Debug Toggle item's target selection and cause the display
// of message to be sent to another window.
//
// level        Set to a combination of the following constants by logically
//              combining the constants together with the '|' operator:
//                  CS_DBG_CRITICAL
//                  CS_DBG_ERROR
//                  CS_DBG_WARNING
//                  CS_DBG_INFO
//                  CS_DBG_TRACE
// msg          The message string to be displayed.
// override     If set to a valid player object, the debug message will be
//              displayed in that player's message window even if the global
//              debug flag for the specified level is disabled. The message
//              will also be written to the server log file if the log file
//              destination is enabled.
void cs_dbg_OutputString(int level, string msg, object override=OBJECT_INVALID) {
    object mod = GetModule();

    // If we have no override target, check the calling object to see if
    // there is a debug target set for it.
    if (!GetIsObjectValid(override)) {
        object debug = GetLocalObject(OBJECT_SELF, CS_DBG_VAR_DEBUG_TARGET);
        if (GetIsObjectValid(debug)) {
            override = debug;
        }
    }

    // If the specified debug level for this message is not currently
    // being displayed, and we have no override target, ignore the message.
    if ((level & GetLocalInt(mod, CS_DBG_VAR_LEVEL)) ||
        GetIsObjectValid(override)
    ) {
        // Build a time stamp prefix. The time stamp will be the same for
        // all messages generated within the same script call, but debug
        // output just doesn't look right without one...
        int indent = GetLocalInt(mod, CS_DBG_VAR_INDENT);
        switch (indent) {
        case -10:
        case -9:
        case -8:
        case -7:
        case -6:
        case -5:
        case -4:
        case -3:
        case -2:
        case -1:
        case 0:
            // We do nothing at indent level 0, or if the indent count has
            // become unmatched and gone negative for some reason.
            break;
        case 1:
            msg = CS_DBG_INDENT_1 + msg;
            break;
        case 2:
            msg = CS_DBG_INDENT_2 + msg;
            break;
        case 3:
            msg = CS_DBG_INDENT_3 + msg;
            break;
        case 4:
            msg = CS_DBG_INDENT_4 + msg;
            break;
        case 5:
            msg = CS_DBG_INDENT_5 + msg;
            break;
        case 6:
            msg = CS_DBG_INDENT_6 + msg;
            break;
        case 7:
            msg = CS_DBG_INDENT_7 + msg;
            break;
        case 8:
            msg = CS_DBG_INDENT_8 + msg;
            break;
        case 9:
            msg = CS_DBG_INDENT_9 + msg;
            break;
        case 10:
            msg = CS_DBG_INDENT_10 + msg;
            break;
        case 11:
            msg = CS_DBG_INDENT_11 + msg;
            break;
        case 12:
            msg = CS_DBG_INDENT_12 + msg;
            break;
        case 13:
            msg = CS_DBG_INDENT_13 + msg;
            break;
        case 14:
            msg = CS_DBG_INDENT_14 + msg;
            break;
        case 15:
            msg = CS_DBG_INDENT_15 + msg;
            break;
        case 16:
            msg = CS_DBG_INDENT_16 + msg;
            break;
        case 17:
            msg = CS_DBG_INDENT_17 + msg;
            break;
        case 18:
            msg = CS_DBG_INDENT_18 + msg;
            break;
        case 19:
            msg = CS_DBG_INDENT_19 + msg;
            break;
        default:
            // Any more deeply indented than 20 is getting silly.
            msg = CS_DBG_INDENT_20 + msg;
        }

        // Determine the destinations. If a subsystem override has been
        // specified, use that as the player destination.
        int destination;
        object pc;
        if (GetIsObjectValid(override)) {
            destination = CS_DBG_LOGPC | CS_DBG_LOGFILE;
            pc = override;
        }
        else {
            destination = GetLocalInt(mod, CS_DBG_VAR_DESTINATION);
            pc = GetLocalObject(mod, CS_DBG_VAR_PC);
        }
        string timestamp = CS_DBG_COLOUR_TIMESTAMP +
                           IntToString(GetTimeHour() / 10) +
                           IntToString(GetTimeHour() % 10) + ":" +
                           IntToString(GetTimeMinute() / 10) +
                           IntToString(GetTimeMinute() % 10) + ":" +
                           IntToString(GetTimeSecond() / 10) +
                           IntToString(GetTimeSecond() % 10) +
                           CS_DBG_COLOUR_END + " ";

        // Write message, plus timestamp and indentation, to PC message log.
        if ((destination & CS_DBG_LOGPC) && (GetIsPC(pc) || GetIsDM(pc))) {
            if (cs_dbg_textColour != "") {
                SendMessageToPC(pc, cs_dbg_textColour + timestamp + msg + CS_DBG_COLOUR_END);
            }
            else {
                SendMessageToPC(pc, timestamp + msg);
            }
        }

        // Write message, plus timestamp and indentation, to all DMs.
        if (destination & CS_DBG_LOGDM) {
            if (cs_dbg_textColour != "") {
                SendMessageToAllDMs(cs_dbg_textColour + timestamp + msg + CS_DBG_COLOUR_END);
            }
            else {
                SendMessageToAllDMs(timestamp + msg);
            }
        }

        // Write message, plus indentation, to log file. Log messages have
        // their own timestamps.
        if (destination & CS_DBG_LOGFILE) {
            WriteTimestampedLogEntry(msg);
        }
    }
}

//----------------------------------------------------------------------------
void cs_dbg_PrintString(int level, string msg, object override=OBJECT_INVALID) {
    cs_dbg_textColour = CS_DBG_COLOUR_NONE;
    cs_dbg_OutputString(level, msg, override);
}

//----------------------------------------------------------------------------
void cs_dbg_Critical(string msg, object override=OBJECT_INVALID) {
    cs_dbg_textColour = CS_DBG_COLOUR_CRITICAL;
    cs_dbg_OutputString(CS_DBG_CRITICAL, msg, override);
}

//----------------------------------------------------------------------------
void cs_dbg_Error(string msg, object override=OBJECT_INVALID) {
    cs_dbg_textColour = CS_DBG_COLOUR_ERROR;
    cs_dbg_OutputString(CS_DBG_ERROR, msg, override);
}

//----------------------------------------------------------------------------
void cs_dbg_Warning(string msg, object override=OBJECT_INVALID) {
    cs_dbg_textColour = CS_DBG_COLOUR_WARNING;
    cs_dbg_OutputString(CS_DBG_WARNING, msg, override);
}

//----------------------------------------------------------------------------
void cs_dbg_Info(string msg, object override=OBJECT_INVALID) {
    cs_dbg_textColour = CS_DBG_COLOUR_INFO;
    cs_dbg_OutputString(CS_DBG_INFO, msg, override);
}

//----------------------------------------------------------------------------
void cs_dbg_Trace(string msg, object override=OBJECT_INVALID) {
    cs_dbg_textColour = CS_DBG_COLOUR_TRACE;
    cs_dbg_OutputString(CS_DBG_TRACE, msg, override);
}

//----------------------------------------------------------------------------
void cs_dbg_Enter(string msg, object override=OBJECT_INVALID) {
    cs_dbg_textColour = CS_DBG_COLOUR_ENTER;
    cs_dbg_OutputString(CS_DBG_TRACE, "Entering " + msg, override);

    // Indentation of debug messages is tracked even if debug is turned off.
    object mod = GetModule();
    int indent = GetLocalInt(mod, CS_DBG_VAR_INDENT);
    indent++;
    SetLocalInt(mod, CS_DBG_VAR_INDENT, indent);
}

//----------------------------------------------------------------------------
void cs_dbg_Exit(string msg, object override=OBJECT_INVALID) {
    // Indentation of debug messages is tracked even if debug is turned off.
    object mod = GetModule();
    int indent = GetLocalInt(mod, CS_DBG_VAR_INDENT);
    indent--;
    SetLocalInt(mod, CS_DBG_VAR_INDENT, indent);

    cs_dbg_textColour = CS_DBG_COLOUR_EXIT;
    cs_dbg_OutputString(CS_DBG_TRACE, "Exiting " + msg, override);
}

//----------------------------------------------------------------------------
string cs_dbg_VectorToString(vector vec) {
    string str = FloatToString(vec.x) + ", " +
                 FloatToString(vec.y) + ", " +
                 FloatToString(vec.z);
    return str;
}

//----------------------------------------------------------------------------
string cs_dbg_LocationToString(location loc) {
    object area = GetAreaFromLocation(loc);
    vector vec = GetPositionFromLocation(loc);
    float facing = GetFacingFromLocation(loc);
    string str = GetName(area) + ", " +
                 cs_dbg_VectorToString(vec) +
                 FloatToString(facing);
    return str;
}

//----------------------------------------------------------------------------
void cs_dbg_SetLocalString(object container, string name, string value) {
    cs_dbg_PrintString(
        CS_DBG_INFO,
        name + " set to '" + value + "' on " + GetName(container)
    );
    SetLocalString(container, name, value);
}

//----------------------------------------------------------------------------
void cs_dbg_SetLocalInt(object container, string name, int value) {
    cs_dbg_PrintString(
        CS_DBG_INFO,
        name + " set to " + IntToString(value) + " on " + GetName(container)
    );
    SetLocalInt(container, name, value);
}

//----------------------------------------------------------------------------
void cs_dbg_SetLocalObject(object container, string name, object value) {
    cs_dbg_PrintString(
        CS_DBG_INFO,
        name + " set to " + GetName(value) + " on " + GetName(container)
    );
    SetLocalObject(container, name, value);
}

//----------------------------------------------------------------------------
string cs_dbg_GetLocalString(object container, string name) {
    string value = GetLocalString(container, name);
    cs_dbg_PrintString(
        CS_DBG_INFO,
        name + " retrieved from " + GetName(container) + ": '" + value + "'"
    );
    return value;
}

//----------------------------------------------------------------------------
int cs_dbg_GetLocalInt(object container, string name) {
    int value = GetLocalInt(container, name);
    cs_dbg_PrintString(
        CS_DBG_INFO,
        name + " retrieved from " + GetName(container) + ": " +
        IntToString(value)
    );
    return value;
}

//----------------------------------------------------------------------------
object cs_dbg_GetLocalObject(object container, string name) {
    object value = GetLocalObject(container, name);
    cs_dbg_PrintString(
        CS_DBG_INFO,
        name + " retrieved from " + GetName(container) + ": " +
        GetName(value)
    );
    return value;
}

//----------------------------------------------------------------------------
void cs_dbg_DeleteLocalString(object container, string name) {
    cs_dbg_PrintString(
        CS_DBG_INFO,
        name + " deleted from " + GetName(container)
    );
    DeleteLocalString(container, name);
}

//----------------------------------------------------------------------------
void cs_dbg_DeleteLocalInt(object container, string name) {
    cs_dbg_PrintString(
        CS_DBG_INFO,
        name + " deleted from " + GetName(container)
    );
    DeleteLocalInt(container, name);
}

//----------------------------------------------------------------------------
void cs_dbg_DeleteLocalObject(object container, string name) {
    cs_dbg_PrintString(
        CS_DBG_INFO,
        name + " deleted from " + GetName(container)
    );
    DeleteLocalObject(container, name);
}

//----------------------------------------------------------------------------
void cs_dbg_SetCustomToken(int token, string value) {
    cs_dbg_PrintString(
        CS_DBG_INFO,
        "Token " + IntToString(token) + " set to '" + value + "'"
    );
    SetLocalString(GetModule(), CS_DBG_TOKEN_PREFIX + IntToString(token), value);
    SetCustomToken(token, value);
}

//----------------------------------------------------------------------------
string cs_dbg_GetCustomToken(int token) {
    string value = GetLocalString(GetModule(), CS_DBG_TOKEN_PREFIX + IntToString(token));
    cs_dbg_PrintString(
        CS_DBG_INFO,
        "Token " + IntToString(token) + " value is '" + value + "'"
    );
    return value;
}

//----------------------------------------------------------------------------
string cs_dbg_Red(string text) {
    return CS_DBG_COLOUR_RED + text + CS_DBG_COLOUR_END;
}

//----------------------------------------------------------------------------
string cs_dbg_Green(string text) {
    return CS_DBG_COLOUR_GREEN + text + CS_DBG_COLOUR_END;
}

//----------------------------------------------------------------------------
string cs_dbg_Blue(string text) {
    return CS_DBG_COLOUR_BLUE + text + CS_DBG_COLOUR_END;
}

//----------------------------------------------------------------------------
string cs_dbg_Yellow(string text) {
    return CS_DBG_COLOUR_YELLOW + text + CS_DBG_COLOUR_END;
}

//----------------------------------------------------------------------------
string cs_dbg_Grey(string text) {
    return CS_DBG_COLOUR_GREY + text + CS_DBG_COLOUR_END;
}
