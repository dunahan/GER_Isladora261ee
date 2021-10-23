//============================================================================
//
// Name: CS Debugging Subsystem - Main Include File
// File: cs_dbg
// Author: Craig Smith (Galap) <craig@smith.dropbear.id.au>
//         Magnus Tyrland (Athinair)
//
// $Id: cs_dbg.nss,v 1.5 2005/07/10 09:44:30 cs Exp $
// $Source: /local/cvs/nwn/debug/cs_dbg.nss,v $
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
// The functions in this subsystem allow the display of debug messages to
// either the on-screen player message window, to DMs, to the log file, or
// any combination.
//
// This file only contains function prototypes. The debug functions are
// actually in two other files:
//     cs_dbg_debug         Real functions that manage debug output
//     cs_dbg_release       Stub functions that do nothing
//
// The debug functions are the actual functions that allow the display of
// debug messages. The stub functions are identical to the real debug
// functions except that they don't actually do anything, except allow the
// compiler to function correctly. Providing two sets of functions allows
// you to leave the calls to the debug functions in your scripts even when
// you release them. Simply use the debug functions when creating and
// testing, and then the release functions once debugging is no longer
// required. Then, should you need to debug again, all your debug calls are
// still in place and you simply resume using the debug functions again!
//
// To change your code from using the actual debug functions to the release
// stub functions, change the #include directive at the bottom of this file
// to the following line:
//
// #include "cs_dbg_release"
//
// To change your code from using the release stub debug functions to the
// actual functions, change the #include directive at the bottom of this
// file to the following line:
//
// #include "cs_dbg_debug"
//
// Of course, if you change from actual functions to release stub functions
// or back again, a complete build of your module is highly recommended.
//
// If you make changes to this code that you think improves its capabilities,
// *please* send me the changes. If I like what you've done, I'll incorporate
// it for all to see and use! Should you find a bug, then let me know that
// too. Problems won't necessarily get fixed if I don't know about them.
//
// The CS Debugging Subsystem is set to use the debug functions by default.
//
// Using the CS Debugging Subsystem in your own code
// -------------------------------------------------
// Using the CS Debugging Subsystem is quite simple. Include this file in
// each script that is to use the debugging functions by adding the following
// directive at the top of the file:
//
// #include "cs_dbg"
//
// Since debug output is disabled by default, you must enable the output of
// debug messages, and indicate where you want messages to be sent. This is
// done by calling the cs_dbg_Enable() and cs_dbg_EnableDestination()
// functions, probably in the module's OnLoad event handler. If you want
// to send debug messages to a player message window, you will also need to
// call the cs_dbg_SetPCListener() function with a valid PC object. The
// module's OnLoad event handler may therefore look something like this:
//
// #include "cs_dbg"
// void main() {
//     cs_dbg_Enable(CS_DBG_ALL);
//     cs_dbg_EnableDestination(CS_DBG_ALL);
// }
//
// and the module's OnClientEnter event handler may look like this:
//
// #include "cs_dbg"
// void main() {
//     cs_dbg_SetPCListener(GetEnteringObject());
// }
//
// The cs_dbg_SetPCListener() function cannot be called in the OnModuleLoad
// event since there is no valid player object that early in the loading
// sequence for the module. The suggestions above will work fine when
// debugging a module with a single player. Multiplayer modules are more
// challenging to debug.
//
// An easier alternative to the OnClientEnter event handler is to use the
// Debug Control Switch in the custom Containers and Switches placeable
// palette. The Debug Control Switch allows debug output to be turned on or
// off, and when turned on will send debug messages to the message window of
// the player (or DM) who threw the switch. For more fine control of the
// display of debug messages, the Debug Toggle item may be use.
//
// When writing your scripts, just call the cs_dbg_Enter(), cs_dbg_Exit()
// and cs_dbg_PrintString() functions when you want a debug message generated.
// The cs_dbg_Critical(), cs_dbg_Error(), cs_dbg_Warning(), cs_dbg_Info()
// and cs_dbg_Trace() functions are wrappers for the cs_dbg_PrintString()
// function provided for convenience. The use of the cs_dbg_Enter() and
// cs_dbg_Exit() functions is something that I personally believe to be
// highly useful, though other programmers disagree. Make your own choice.
//
// The last argument to all of the message printing functions is an object
// argument named override, which defaults to OBJECT_INVALID. This object,
// if specified, must be a player object and indicates that debug messages
// should be sent to the specified player regardless of the current global
// debug state. This feature allows specific parts or subsystems within a
// module to implement their own local debug state that can override the
// global state and cause messages just for that part of the module to be
// displayed. The override argument, if provided, will also override the
// target set through the Debug Toggle item.
//
// To stop debug messages, just call cs_dbg_Disable() somewhere, possibly in
// a conversation such as that supplied for the Debug Avatar. Note that there
// may still be some display of messages through the use of the Debug Switch
// placeable or Debug Toggle item.
//
// Using The Provided Object Resources
// -----------------------------------
// There are a number of object resources provided by this subsystem for use
// as debug aids within modules.
//
// Debug Avatar
//     The Debug Avatar is a henchman that provides some useful debug options
//     as part of its control conversation. These options include turning the
//     display of debug messages on or off, changing the time of day, etc.
//     Since the Debug Avatar is a henchman, it will follow players around
//     the module, and can be dismissed as needed.
// Debug Control Switch
//     The Debug Control Switch is a placeable in the Containers & Switches
//     category of the custom placeables palette. This switch will turn the
//     display of debug messages on or off, and arrange for the messages to
//     be displayed in the message window of the player or DM that throws the
//     switch.
// Debug Toggle Item
//     The Debug Toggle Item is found on the Special|Custom4 category of the
//     custom items palette. It is an item with a unique special power that
//     allows debug messages to be enabled or disabled for individual objects
//     selectively. The messages will be displayed in the message window of
//     the player or DM who activates the Debug Toggle item.
//
// Examples
// --------
// Enable all debugging messages but only to DMs and the log file:
//     cs_dbg_Enable(CS_DBG_ALL);
//     cs_dbg_EnableDestination(CS_DBG_LOGDM | CS_DBG_LOGFILE);
//
// Enable only error and critical messages to the PC message window:
//     cs_dbg_Enable(CS_DBG_CRITICAL | CS_DBG_ERROR);
//     cs_dbg_EnableDestination(CS_DBG_LOGPC);
//
// Disable all debugging messages:
//     cs_dbg_Disable(CS_DBG_ALL);
//
// Disable informational and tracing messages:
//     cs_dbg_Disable(CS_DBG_INFO | CS_DBG_TRACE);
//
// Revision History
// ----------------
// 1.7.0final   Added coloured message support.
// 1.6.0final   Added the Debug Toggle item for integration into modules
//              that require more fine degree of control over individual
//              objects during debugging. Updated documentation.
// 1.5.1final   Fixed a minor bug in the Debug Control Switch that caused
//              log messages to be disabled.
// 1.5.0final   Add subsystem override for message printing functions.
// 1.4.0final   Some performance tweaks. Added Get/Set/Delete... wrapper
//              functions. Added some convenience functions.
// 1.3.0final   Added cs_dbg_LocationToString, cs_dbg_VectorToString.
// 1.2.0final   Added debug control switch.
// 1.1.1final   Documentation update; no code change.
// 1.1.0final   Incorporated nifty new features from Athinair:
//                  Multiple destinations
//                  Debug levels
// 1.0.0beta    Jumped version for beta release.
// 0.7.0dev     Debug Avatar becomes a henchman.
// 0.6.0dev     Differentiation between onscreen and file logging.
// 0.5.0dev     Added Debug Avatar.
// 0.4.0dev     Enable/Disable functions.
// 0.3.0dev     Indentation tracking.
// 0.2.0dev     Basic print functions.
// 0.1.0dev     Various debug functions scattered around.
//
//============================================================================

// The version numbering I use is comprised of a tripartite version number
// and a trailing string. The version is arranged into 1.2.3 form, where 1 is
// the major release number, 2 is the minor release number and 3 is the bugfix
// level. Each number in the version starts at 0 and increments each time a
// change is made to the code that classifies as that level. The trailing
// string is either "dev", "beta" or "final" depending upon whether the code
// is still under development (it will have bugs, count on it), is considered
// to be beta quality (i.e. technically finished but probably has bugs), or
// finished, tested and believed to be correctly functional. If you wish to
// report a bug, please include the version number with your bug report.
string cs_dbg_version = "1.7.0final";


//============================================================================
//
// Data Types and Constants
//
//============================================================================

// Constants for both debug levels and destinations.
const int CS_DBG_ALL      = 0xffffffff;     // All debug outputs and levels
const int CS_DBG_NONE     = 0x00000000;     // No debug outputs or levels

// Constants for debug destinations.
const int CS_DBG_LOGPC    = 0x00000001;     // Log to a PC window
const int CS_DBG_LOGDM    = 0x00000002;     // Log to all DMs
const int CS_DBG_LOGFILE  = 0x00000004;     // Write to the log file

// Pre-defined debug message types. Note that the debug levels int is a
// bitmapped field and so the remaining bits (currently 6 and up) may be
// used for user-defined message types.
const int CS_DBG_CRITICAL = 0x00000001;     // Critical messages
const int CS_DBG_ERROR    = 0x00000002;     // Error messages
const int CS_DBG_WARNING  = 0x00000004;     // Warning messages
const int CS_DBG_INFO     = 0x00000008;     // Informational messages
const int CS_DBG_TRACE    = 0x00000010;     // Tracing messages from the
                                            // cs_dbg_Enter() and the
                                            // cs_dbg_Exit() functions.

// The name of variable to be set on object to surgically enable debugging.
const string CS_DBG_VAR_DEBUG_TARGET = "cs_dbg_debugTarget";

// The prefix for a generated variable named used to store the values of
// tokens.
const string CS_DBG_TOKEN_PREFIX = "cs_dbg_token";

// Coloured text tokens.
const string CS_DBG_COLOUR_BLUE         = "<cfÌþ>";
const string CS_DBG_COLOUR_DARK_BLUE    = "<c fþ>";
const string CS_DBG_COLOUR_LIGHT_BLUE   = "<c®þþ>";
const string CS_DBG_COLOUR_GREEN        = "<c þ >";
const string CS_DBG_COLOUR_GREY         = "<c®®®>";
const string CS_DBG_COLOUR_LIGHT_GREY   = "<c°°°>";
const string CS_DBG_COLOUR_ORANGE       = "<cþf >";
const string CS_DBG_COLOUR_LIGHT_ORANGE = "<cþ® >";
const string CS_DBG_COLOUR_PURPLE       = "<cÌwþ>";
const string CS_DBG_COLOUR_LIGHT_PURPLE = "<cÌ®Ì>";
const string CS_DBG_COLOUR_RED          = "<cþ  >";
const string CS_DBG_COLOUR_YELLOW       = "<cþþ >";
const string CS_DBG_COLOUR_NONE         = "";
const string CS_DBG_COLOUR_END          = "</c>";


//============================================================================
//
// Function Prototypes and toolset IDE documentation.
//
//============================================================================

// Determine which types of debugging messages are currently being displayed.
// This function will return a mask value that indicates which levels of
// output are returned. This mask value may be tested in a boolean conditional
// or used as a parameter to the cs_dbg_Enable() or cs_dbg_Disable() functions.
//
// which        Set to a combination of the following constants by logically
//              combining the constants together with the '|' operator:
//                  CS_DBG_CRITICAL
//                  CS_DBG_ERROR
//                  CS_DBG_WARNING
//                  CS_DBG_INFO
//                  CS_DBG_TRACE
//
// returns      TRUE if the specified debug output is enabled, otherwise FALSE.
int cs_dbg_GetIsEnabled(int which = 0xffffffff);

// Enable the display of specific types of debugging messages. This function
// will overwrite any previous value that has been set, so if you wish to
// add additional debug message types to the currently enabled set, you
// will have to retrieve the existing enabled message types with the
// cs_dbg_GetIsEnabled() function first.
//
// level        Set to a combination of the following constants by logically
//              combining the constants together with the '|' operator:
//                  CS_DBG_CRITICAL
//                  CS_DBG_ERROR
//                  CS_DBG_WARNING
//                  CS_DBG_INFO
//                  CS_DBG_TRACE
void cs_dbg_Enable(int level);

// Disable the display of specific types of debugging messages.
//
// level        Set to a combination of the following constants by logically
//              combining the constants together with the '|' operator:
//                  CS_DBG_CRITICAL
//                  CS_DBG_ERROR
//                  CS_DBG_WARNING
//                  CS_DBG_INFO
//                  CS_DBG_TRACE
void cs_dbg_Disable(int level);

// Determine whether debugging messages are being displayed either on screen
// in a message window, or being written to the log file. This function will
// return a mask value that indicates which levels of output are returned.
// This mask value may be tested in a boolean conditional or used as a
// parameter to the cs_dbg_EnableDestination() or cs_dbg_DisableDestination()
// functions.
//
// which        Set to a combination of the following constants by logically
//              combining the constants together with the '|' operator:
//                  CS_DBG_LOGPC   Query whether PC output is enabled
//                  CS_DBG_LOGDM   Query whether DM output is enabled
//                  CS_DBG_LOGFILE Query whether log file entries are written
//
// returns      TRUE if the specified debug output is enabled, otherwise FALSE.
int cs_dbg_GetIsDestinationEnabled(int which = 0xffffffff);

// Enable the display of debugging messages to either an on screen message
// window, or to the log file.  This function will overwrite any previous
// value that has been set, so if you wish to add additional destinations
// to the currently enabled set, you will have to retrieve the existing set
// with the cs_dbg_GetIsDestinationEnabled() function first.
//
// destination  Set to a combination of the following constants by logically
//              combining the constants together with the '|' operator:
//                  CS_DBG_LOGPC   Enable PC message window output
//                  CS_DBG_LOGDM   Enable DM message window output
//                  CS_DBG_LOGFILE Enable writing of log file entries
void cs_dbg_EnableDestination(int destination);

// Disable the display of debugging messages to either an on screen message
// window, or to the log file.
//
// destination  Set to a combination of the following constants by logically
//              combining the constants together with the '|' operator:
//                  CS_DBG_LOGPC   Disable PC message window output
//                  CS_DBG_LOGDM   Disable DM message window output
//                  CS_DBG_LOGFILE Disable writing of log file entries
void cs_dbg_DisableDestination(int destination);

// Specify the PC to whom debug messages should be sent. If specified PC
// should log out, then PC messages will be disabled automatically until
// another PC is set.
//
// pc           The PC object to whom to send messages.
void cs_dbg_SetPCListener(object pc);

// Determine which PC is currently the destination for debug messages, if
// PC message output is enabled. Disable PC message output by setting the
// PC Listener to OBJECT_INVALID.
//
// returns      The PC object to whom messages are being sent, or
//              OBJECT_INVALID if no PC is currently set.
object cs_dbg_GetPCListener();

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
void cs_dbg_PrintString(int level, string msg, object override=OBJECT_INVALID);

// Display a string for debugging purposes. Debug messages are prefixed with
// the current time, however this is represented in game terms and so is not
// very useful except to determine sequence. This function uses the
// CS_DBG_CRITICAL level when displaying messages.
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
// msg          The message string to be displayed.
// override     If set to a valid player object, the debug message will be
//              displayed in that player's message window even if the global
//              debug flag for the specified level is disabled. The message
//              will also be written to the server log file if the log file
//              destination is enabled.
void cs_dbg_Critical(string msg, object override=OBJECT_INVALID);

// Display a string for debugging purposes. Debug messages are prefixed with
// the current time, however this is represented in game terms and so is not
// very useful except to determine sequence. This function uses the
// CS_DBG_ERROR level when displaying messages.
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
// msg          The message string to be displayed.
// override     If set to a valid player object, the debug message will be
//              displayed in that player's message window even if the global
//              debug flag for the specified level is disabled. The message
//              will also be written to the server log file if the log file
//              destination is enabled.
void cs_dbg_Error(string msg, object override=OBJECT_INVALID);

// Display a string for debugging purposes. Debug messages are prefixed with
// the current time, however this is represented in game terms and so is not
// very useful except to determine sequence. This function uses the
// CS_DBG_WARNING level when displaying messages.
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
// msg          The message string to be displayed.
// override     If set to a valid player object, the debug message will be
//              displayed in that player's message window even if the global
//              debug flag for the specified level is disabled. The message
//              will also be written to the server log file if the log file
//              destination is enabled.
void cs_dbg_Warning(string msg, object override=OBJECT_INVALID);

// Display a string for debugging purposes. Debug messages are prefixed with
// the current time, however this is represented in game terms and so is not
// very useful except to determine sequence. This function uses the CS_DBG_INFO
// level when displaying messages.
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
// msg          The message string to be displayed.
// override     If set to a valid player object, the debug message will be
//              displayed in that player's message window even if the global
//              debug flag for the specified level is disabled. The message
//              will also be written to the server log file if the log file
//              destination is enabled.
void cs_dbg_Info(string msg, object override=OBJECT_INVALID);

// Display a string for debugging purposes. Debug messages are prefixed with
// the current time, however this is represented in game terms and so is not
// very useful except to determine sequence. This function uses the
// CS_DBG_TRACE level when displaying messages.
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
// msg          The message string to be displayed.
// override     If set to a valid player object, the debug message will be
//              displayed in that player's message window even if the global
//              debug flag for the specified level is disabled. The message
//              will also be written to the server log file if the log file
//              destination is enabled.
void cs_dbg_Trace(string msg, object override=OBJECT_INVALID);

// Display a string indicating entry from a function using the CS_DBG_TRACE
// level. Debug messages are prefixed with the current time, however this is
// represented in game terms and so is not very useful except to determine
// sequence.
//
// Additional debug messages generated from within a function are indented
// to show the function calling depth. This function should be called in
// matched pairs with cs_dbg_Exit() as indentation is managed  between the
// two functions.
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
// msg          The message string to be displayed.
// override     If set to a valid player object, the debug message will be
//              displayed in that player's message window even if the global
//              debug flag for the specified level is disabled. The message
//              will also be written to the server log file if the log file
//              destination is enabled.
void cs_dbg_Enter(string msg, object override=OBJECT_INVALID);

// Display a string indicating exit from a function using the CS_DBG_TRACE
// level. Debug messages are prefixed with the current time, however this is
// represented in game terms and so is not very useful except to determine
// sequence.
//
// Additional debug messages generated from within a function are indented
// to show the function calling depth. This function should be called in
// matched pairs with cs_dbg_Enter() as indentation is managed  between the
// two functions.
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
// msg          The message string to be displayed.
// override     If set to a valid player object, the debug message will be
//              displayed in that player's message window even if the global
//              debug flag for the specified level is disabled. The message
//              will also be written to the server log file if the log file
//              destination is enabled.
void cs_dbg_Exit(string msg, object override=OBJECT_INVALID);

// Convert a vector to a string representation.
//
// vec          The vector to be converted.
// returns      The vector in x,y,z form as a string.
string cs_dbg_VectorToString(vector vec);

// Convert a location to a string representation.
//
// loc          The location to be converted.
// returns      The location as a string.
string cs_dbg_LocationToString(location loc);

// Set the value of a local variable, and display the variable's details
// if debugging is enabled. This function is a wrapper around the standard
// library function SetLocalString().
//
// container    The object on which to set the variable.
// name         The name of the variable to be set.
// value        The value to which to set the variable.
void cs_dbg_SetLocalString(object container, string name, string value);

// Set the value of a local variable, and display the variable's details
// if debugging is enabled. This function is a wrapper around the standard
// library function SetLocalInt().
//
// container    The object on which to set the variable.
// name         The name of the variable to be set.
// value        The value to which to set the variable.
void cs_dbg_SetLocalInt(object container, string name, int value);

// Set the value of a local variable, and display the variable's details
// if debugging is enabled. This function is a wrapper around the standard
// library function SetLocalObject().
//
// container    The object on which to set the variable.
// name         The name of the variable to be set.
// value        The value to which to set the variable.
void cs_dbg_SetLocalObject(object container, string name, object value);

// Retrieve the value of a local variable, and display the variable's details
// if debugging is enabled. This function is a wrapper around the standard
// library function GetLocalString().
//
// container    The object from which to get the variable.
// name         The name of the variable to get.
// returns      The value of the variable, or an empty string ("") if the
//              variable does not exist.
string cs_dbg_GetLocalString(object container, string name);

// Retrieve the value of a local variable, and display the variable's details
// if debugging is enabled. This function is a wrapper around the standard
// library function GetLocalInt().
//
// container    The object from which to get the variable.
// name         The name of the variable to get.
// returns      The value of the variable, or an empty string ("") if the
//              variable does not exist.
int cs_dbg_GetLocalInt(object container, string name);

// Retrieve the value of a local variable, and display the variable's details
// if debugging is enabled. This function is a wrapper around the standard
// library function GetLocalObject().
//
// container    The object from which to get the variable.
// name         The name of the variable to get.
// returns      The value of the variable, or an empty string ("") if the
//              variable does not exist.
object cs_dbg_GetLocalObject(object container, string name);

// Delete a local variable, indicating which variable has been deleted if
// debugging is enabled. This function is a wrapper around the standard
// library function DeleteLocalString().
//
// container    The object from which to delete the variable.
// name         The name of the variable to be deleted.
void cs_dbg_DeleteLocalString(object container, string name);

// Delete a local variable, indicating which variable has been deleted if
// debugging is enabled. This function is a wrapper around the standard
// library function DeleteLocalInt().
//
// container    The object from which to delete the variable.
// name         The name of the variable to be deleted.
void cs_dbg_DeleteLocalInt(object container, string name);

// Delete a local variable, indicating which variable has been deleted if
// debugging is enabled. This function is a wrapper around the standard
// library function DeleteLocalObject().
//
// container    The object from which to delete the variable.
// name         The name of the variable to be deleted.
void cs_dbg_DeleteLocalObject(object container, string name);

// Set the value of a custom token, displaying the token's details if
// debugging is turned on. This function is a wrapper around the standard
// library function SetCustomToken().
//
// token        The integer number of the token to be changed.
// value        The string value to which the token is to be set.
void cs_dbg_SetCustomToken(int token, string value);

// Determine the value that was last set for a specific custom token.
//
// token        The integer number of the token to be returned.
// returns      The string value to which the token has been set.
string cs_dbg_GetCustomToken(int token);

// Return the specified text in a form that will display in colour.
//
// text         The text to be coloured.
// returns      The text in the indicated colour.
string cs_dbg_Red(string text);

// Return the specified text in a form that will display in colour.
//
// text         The text to be coloured.
// returns      The text in the indicated colour.
string cs_dbg_Green(string text);

// Return the specified text in a form that will display in colour.
//
// text         The text to be coloured.
// returns      The text in the indicated colour.
string cs_dbg_Blue(string text);

// Return the specified text in a form that will display in colour.
//
// text         The text to be coloured.
// returns      The text in the indicated colour.
string cs_dbg_Yellow(string text);

// Return the specified text in a form that will display in colour.
//
// text         The text to be coloured.
// returns      The text in the indicated colour.
string cs_dbg_Grey(string text);


// Uncomment this directive if you wish to use the actual debug functions.
// Comment this out again if you want to use the release stub functions.
#include "cs_dbg_debug"

// Uncomment this directive if you wish to use the release stub functions.
// Comment this out again if you want to use the actual debug functions.
//#include "cs_dbg_release"
