//============================================================================
//
// Name: CS Resting Subsystem - Main Include File
// File: cs_rest
// Author: Craig Smith (Galap) <craig@smith.dropbear.id.au>
//
// $Id: cs_rest.nss,v 1.8 2005/09/14 12:36:23 cs Exp $
// $Source: /local/cvs/nwn/resting/cs_rest.nss,v $
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
// The CS Resting Subsystem provides a framework for setting various popular
// forms of resting rules in a module, and allows these resting rules to be
// changed dynamically while the module is running.
//
// Installing The CS Resting Subsystem
// -----------------------------------
// To install the CS Resting Subsystem, you need to import the scripts and
// blueprints into your module. Open the module in the Aurora Toolset and
// select the File menu. Then select the Import item from the menu and
// navigate through your computer's directory structure until you locate
// the ERF file for the CS Resting Subsystem. Select the ERF file and click
// on the Ok button. If the toolset warns you about missing files with a .ncs
// extension, ignore the warning and continue--the .ncs files are compiled
// script files and will be created if necessary when you build your module.
// Once the import finishes, you have installed the CS Resting Subsystem!
//
// To use the CS Resting Subsystem in a module, you will need to change
// the module's OnPlayerRest event handler to be the "cs_rest_handler"
// script. To do this, pull down the Edit menu and select Module Properties.
// Select the Events tab and either drop down the list for the OnPlayerRest
// event to scroll through and find "cs_rest_handler", or simply delete the
// script name that is already there and type in "cs_rest_handler" in place.
// Then select the Ok button and you're done.
//
// Configuring Resting
// -------------------
// One of the design goals of the CS Resting Subsystem package is that the
// resting rules must be able to be managed and configured completely
// through the standard toolset interface *without* the need to resort to
// editing scripts. It is of course possible to extend the resting subsystem
// through writing your own resting profiles or user scripts, however if you
// choose to do so, you will also need to manage any configuration for your
// own resting extension. For most situations, however, the standard resting
// subsystem should be sufficient.
//
// To this end, configuration is handled through the use of a container and
// special items. I personally use chests but any placeable object with an
// inventory will work. Place the container object somewhere in your module
// and then change its tag to be "CS_REST_GLOBAL_CONFIG". Since this container
// is accessed by tag, it may be placed anywhere in the module though it
// should be placed somewhere that players cannot access. I recommend creating
// a DM room area and placing things like this global config container there.
//
// Once you have a placed the container with the correct tag, you now need
// to place the custom configuration items into the container, and modify
// any of the item tags as required for your needs. Items that represent
// integer values must have their tags set to the integer itself. Some other
// items require their tags to be set to strings such as the names of scripts.
//
// Once you have created the configuration container and put all of the desired
// configuration items into its inventory, the resting subsystem will function
// as specified by the items. This particular container is referred to as the
// global configuration container, but the resting subsystem allows the use of
// other configuration containers as well (see Other Configuration Facilities
// for more details). The custom configuration items are found under the
// "Special|Custom4" category of the Custom items palette.
//
// NOTE: If you don't place the global configuration container and set the
// "CS Rest: Enable" and "CS Rest: Default Profile" items as the absolute
// minimum configuration, the CS Resting Subsystem will *not* function and
// the standard Bioware default resting will remain in place.
//
// The complete list of available items, with descriptions, follows.
//
// CS Rest: Enable
//     Default value: FALSE
//     Enabled the resting subsystem, enforcing the rules as configured through
//     the use of these items. The resting subsystem is *disabled* by default
//     and one of these items *must* be placed in a configuration container
//     before it will function. To use this item, you simply place it in the
//     configuration container's inventory. No change to this item's tag is
//     required. This item is the opposite of the Disable item below and only
//     one of the two may be used at the same time.
// CS Rest: Disable
//     Default value: TRUE
//     Disable the resting subsystem, returning the player to the standard
//     Bioware resting rules if placed in the global configuration container,
//     or just causing an area or trigger configuration container to be
//     ignored. To use this item, you simply place it in the configuration
//     container's inventory. No change to this item's tag is required. This
//     item is the opposite of the Enable item above and only one of the two
//     may be used at the same time.
// CS Rest: Default Profile
//     Default value: Not set
//     Sets the name of the resting profile script to be executed by default
//     when a player is not within a resting trigger. The tag of this item
//     should be set to the name of one of the standard profile scripts:
//         cs_rest_cnt  This script disallows resting completely
//         cs_rest_cmp  This script allows resting
//         cs_rest_rom  This script only allows resting when in a room with
//                      all doors closed.
//     One of these items *must* be placed in the global config container with
//     its tag set correctly or the resting subsystem will fail to operate in
//     an expected manner. It it of course possible to write your own scripts
//     for handling resting profile. See Creating Your Own Resting Profile
//     for further information, though please note that there is no need to
//     create new resting profiles in most situations (and most probably *all*
//     situations, since I can't think of any more).
// CS Rest: Standard HP
//     Default value: TRUE
//     Use the standard Bioware-style of HP regain and allow the player to
//     regain all lost hit points after resting. If resting is interrupted
//     part way through, the player will be left at the number of hit points
//     they had regained to that point. To use this item, you simply place it
//     in the configuration container's inventory. No change to this item's
//     tag is required. This item is the opposite of the 3rd Ed Style HP
//     item below and only one of the two may be used at the same time.
// CS Rest: 3rd Ed Style HP
//     Default value: FALSE
//     Use a style of HP gain modelled on the 3rd edition D&D manuals, wherein
//     players regain one hit point per level each time they rest. If resting
//     is interrupted part way through, the player will regain hit points in
//     a pro-rata fashion, i.e. if resting was half complete, the player will
//     regain half the number of hit points that they would have otherwise
//     To use this item, you simply place it in the configuration container's
//     inventory. No change to this item's tag is required. This item is the
//     opposite of the Standard HP item above and only one of the two may be
//     used at the same time.
// CS Rest: Day Only
//     Default value: FALSE
//     Sets the resting subsystem to allow resting only during daylight hours.
//     To use this item, you simply place it in the configuration container's
//     inventory. No change to this item's tag is required. Note that this
//     item is the opposite of the Night Only item below. Only one of the two
//     items may be used at the same time. The All Hours below item may be
//     used to reset either Day Only or Night Only operation.
// CS Rest: Night Only
//     Default value: FALSE
//     Sets the resting subsystem to allow resting only during night hours.
//     To use this item, you simply place it in the configuration container's
//     inventory. No change to this item's tag is required. Note that this
//     item is the opposite of the Night Only item above. Only one of the two
//     items may be used at the same time. The All Hours item below may be
//     used to reset either Day Only or Night Only operation.
// CS Rest: All Hours
//     Default value: TRUE
//     Sets the resting subsystem to allow resting at any time of the day or
//     night. This item may be used after setting day only or night only
//     operation to restore the resting subsystem to its default operation. To
//     use this item, you simply place it in the configuration container's
//     inventory. No change to this item's tag is required. Note that this
//     item should not be used at the same time as either the Day Only or
//     Night Only items. Remove such items from the configuration container's
//     inventory before placing this item.
// CS Rest: Day Start
//     Default value: 6
//     Sets the hour of the day at which the resting subsystem considers "day"
//     to begin. When the resting subsystem is operating in Day Only mode, it
//     will only allow resting after this hour, or only before this hour if
//     in Night Only mode. The Day Start value may be set to any integer
//     between 0 and 22 inclusive. To use  this item, you must set its
//     tag to an integer value.
// CS Rest: Day End
//     Default value: 18
//     Sets the hour of the day at which the resting subsystem considers "day"
//     to end. When the resting subsystem is operating in Day Only mode, it
//     will only allow resting before this hour, or only after this hour if in
//     Night Only mode. The Day End value may be set to any integer between
//     1 and 23 inclusive.  To use  this item, you must set its tag to an
//     integer value.
// CS Rest: Armour Not Allowed
//     Default value: FALSE
//     Stops players from resting when then are wearing armour or helmets.
//     No armour at all may be worn while resting by default when this item
//     is in use, however the AC value of acceptable armour may be set as
//     the tag of this item. For example, to allow leather armour and lighter
//     to be worn while resting, set the tag of this item to "2". To use
//     this item, you simply place it in the configuration container's
//     inventory, changing the item's tag as required. Note that this item
//     is the opposite of the Armour Allowed item below. Only one of the two
//     items may be used at the same time.
// CS Rest: Armour Allowed
//     Default value: TRUE
//     Allow player to rest regardless of the armour they are wearing. To
//     use this item, you simply place it in the configuration container's
//     inventory. No change to this item's tag is required. Note that this
//     item is the opposite of the Armour Not Allowed item above. Only one
//     of the two items may be used at the same time.
// CS Rest: Weapons Not Allowed
//     Default value: FALSE
//     Stops players from resting when then are carrying weapons. To use this
//     item, you simply place it in the configuration container's inventory.
//     No change to this item's tag is required. Note that this item is the
//     opposite of the Weapons Allowed item below. Only one of the two items
//     may be used at the same time.
// CS Rest: Weapons Allowed
//     Default value: TRUE
//     Allow player to rest regardless of whether they are armed or not. To
//     use this item, you simply place it in the configuration container's
//     inventory. No change to this item's tag is required. Note that this
//     item is the opposite of the Weapons Not Allowed item above. Only one
//     of the two items may be used at the same time.
// CS Rest: Fade Screen
//     Default value: FALSE
//     Fade the player's screen display to black when resting starts, and fade
//     back to a visible screen again when resting finishes.
// CS Rest: 1 Minute Limit
// CS Rest: 2 Minute Limit
// CS Rest: 3 Minute Limit
// CS Rest: 4 Minute Limit
// CS Rest: 5 Minute Limit
// CS Rest: 6 Minute Limit
// CS Rest: 7 Minute Limit
// CS Rest: 8 Minute Limit
// CS Rest: 9 Minute Limit
// CS Rest: 10 Minute Limit
// CS Rest: 12 Minute Limit
// CS Rest: 14 Minute Limit
// CS Rest: 16 Minute Limit
// CS Rest: 18 Minute Limit
// CS Rest: 20 Minute Limit
// CS Rest: 25 Minute Limit
// CS Rest: 30 Minute Limit
//     Default Value: No Limit
//     All of these items may be used to control how frequently players may
//     rest. Pick the item that matches the time limit you wish to set and
//     place it into the configuration container. No change to the item's tag
//     is necessary. You may only use one of these items at a time, and you
//     may not use any of these items at the same time as the Rest Time Limit
//     or No Limit items below.
// CS Rest: Rest Time Limit
//     Default Value: No Limit
//     Use this item if you wish more fine-grained control over the time limit
//     between resting. Place this item in a configuration container and then
//     change its tag to an integer value representing the number of seconds
//     that players must wait before being allowed to rest again. You may not
//     use this item at the same time as any of the time limit items above, or
//     the No Limit item below.
// CS Rest: No Limit
//     Default value: No Limit
//     Use this item to restore the default unlimited resting behaviour like
//     the standard Bioware resting system. To use this item, you simply place
//     it in the configuration container's inventory. No change to this item's
//     tag is required. You may not use this item at the same time as any of
//     the time limit items or the Rest Time Limit item above.
// CS Rest: Bedroll In Use
//     Default value: FALSE
//     Use bedrolls if the player has one in his or her inventory on resting.
//     When bedrolls are in use, the player only regains full hit points, as
//     per the regain style in use, when they have a bedroll. If they do not
//     have a bedroll, then only half the normal number of hit points will be
//     regained. Bedrolls are consumable items and after being used 20 times,
//     they are destroyed. To use this item, you must place it in the
//     configuration container's inventory and change its tag to be the same
//     as the item that is to be used as a bedroll, e.g. if you have an item
//     with a tag of "BEDROLL" that you intend for players to use as a bedroll,
//     then you must set the tag of *this* item to "BEDROLL" as well. This
//     item is the opposite of the Bedroll Not Used item below and you may
//     not use the two items at the same time. Note that there is not yet any
//     persistence used for storing the number of times a bedroll has been
//     used.
// CS Rest: Bedroll Not Used
//     Default value: TRUE
//     Allow players to rest without bedrolls with no penalty to hit point
//     regain. To use this item, you simply place it in the configuration
//     container's inventory. No change to this item's tag is required. This
//     item is the opposite of the Bedroll In Use item above and you may not
//     use the two items at the same time.
// CS Rest: Bedroll HP multiplier
//     Default value: 50
//     This item sets the numerical modifier applied to hit points when
//     bedrolls are in use and the player does not have one. If the player
//     does not have a bedroll when resting, the hit points regained will be
//     multiplied by the value set with this item to determine the final
//     number of hit points regained. To define this value, set the item's
//     tag to the pecentage number for the multiplier, e.g. for half hit
//     points, use 50, for a third use 33, etc. By default, this value is 50,
//     so players will regain half the normal hit points when resting without
//     a bedroll. If you were to set this value to 25, then players would
//     regain a quarter of the number of hit points, and setting this value to
//     100 would mean that bedrolls would have no effect at all (which is
//     kind of silly but nevertheless will work). Setting this value to 0
//     will stop players from being allowed to rest at all if they do not
//     have a bedroll. This item and the HP Multiplier item are cumulative,
//     so if both are configured, both will take affect. For example, if the
//     bedroll multiplier is 50 and the HP multiplier is also 50, a player
//     who rests without a bedroll will regain 25% of normal hit points (as
//     50% of 50% is 25%).
// CS Rest: Rations In Use
//     Default value: FALSE
//     Use rations if the player has one in his or her inventory on resting.
//     When rations are in use, the player only regains full hit points, as per
//     the regain style in use, when they have a rations item. If they do not
//     have any rations, then only half the normal number of hit points will be
//     regained. Rations are consumable items and one rations item is destroyed
//     each time the player rests. To use this item, you must place it in the
//     configuration container's inventory and change its tag to be the same
//     as the item that is to be used as the rations, e.g. if you have an item
//     with a tag of "FOOD" that you intend for players to use as rations,
//     then you must set the tag of *this* item to "FOOD" as well. This
//     item is the opposite of the Rations Not Used item below and you may
//     not use the two items at the same time.
// CS Rest: Rations Not Used
//     Default value: TRUE
//     Allow players to rest without rations with no penalty to hit point
//     regain. To use this item, you simply place it in the configuration
//     container's inventory. No change to this item's tag is required. This
//     item is the opposite of the Rations In Use item above and you may not
//     use the two items at the same time.
// CS Rest: Rations HP multiplier
//     Default value: 50
//     This item sets the numerical modifier applied to hit points when rations
//     are in use and the player does not have any. If the player does not
//     have any rations items when resting, the hit points regained will be
//     multiplied by the value set with this item to determine the final
//     number of hit points regained. To define this value, set the item's
//     tag to the pecentage number for the multiplier, e.g. for half hit
//     points, use 50, for a third use 33, etc. By default, this value is 50,
//     so players will regain half the normal hit points when resting without
//     any rations. If you were to set this value to 25, then players would
//     regain a quarter of the number of hit points, and setting this value to
//     100 would mean that rations would have no effect at all (which is
//     kind of silly but nevertheless will work). Setting this value to 0
//     will stop players from being allowed to rest at all if they do not
//     have any rations. This item and the HP Multiplier item are cumulative,
//     so if both are configured, both will take affect. For example, if the
//     rations multiplier is 50 and the HP multiplier is also 50, a player
//     who rests without any rations will regain 25% of normal hit points (as
//     50% of 50% is 25%).
// CS Rest: HP Multiplier
//     Default value: 100
//     This item sets a numerical value that is used as a multiplier against
//     the number of hit points that a player would normally regain from
//     resting, i.e. the number of hitpoints is calculated first, and then
//     multiplied by the value set with this item to determine the final number
//     of hit points regained. To define this value, set the item's tag to the
//     percentage number for the multiplier, e.g. for half hit points, use 50,
//     etc. By default, this value is 100 (i.e. 100% or full hit points) and
//     will have no effect on the hit points regained by players. If you were
//     to set this value to 200, then players would regain twice the number of
//     hitpoints, setting the value to 300 would give three times the normal
//     number, and 50 will give half. This item and the Bedroll HP Multiplier
//     item are cumulative, so if both are configured, both will take affect.
//     For example, if the bedroll multiplier is 50 and the HP multiplier is
//     also 50, a player who rests without a bedroll will regain 25% of normal
//     hit points (as 50% of 50% is 25%).
// CS Rest: Use CON Bonus
//     Default value: FALSE
//     Use this item to give players additional hit points equal to their CON
//     bonus. The CON bonus hit points are applied *after* the calculation of
//     the multiplier value, so for example if 3rd edition style HP regain is
//     enabled with a multipler of 2, players will receive hit points equalling
//     (level * 2) + CON Bonus. This item is the opposite of the No CON Bonus
//     item below and you may not use both items at the same time.
// CS Rest: No CON Bonus
//     Default value: TRUE
//     Use this item to disable the addition of CON bonus hit points. This
//     item is the opposite of the Use CON Bonus item above and you may not
//     use both items at the same time.
// CS Rest: User Script
//     Default value: Not set
//     Sets the name of the user script to be executed at specific points in
//     the resting process. The tag of this item should be set to the name
//     of the script to be executed. There are no standard user scripts
//     provided with the CS Resting Subsystem as by definition all customised
//     features must be provided by users of the subsystem. See Writing User
//     Scripts for more information.
// CS Rest: Text Messages
//     Default value: TRUE, with built in messages from cs_rest_text script
//     This item will enable the display of floaty text messages, and allows
//     the text of the messages to be changed. Once an instance of this item
//     has been placed in the relevant configuration container, edit the item
//     properties and click on the Description tab, then select the Variables
//     button if you wish to change the text of the messages. The item
//     contains all of the default messages already, so simply select the one
//     to be changed, and change or overwrite the message that is displayed in
//     the text field at the bottom of the dialogue box. Select the Replace
//     button to update the message variable on the item, and then repeat
//     for any other messages that require change. Then click Ok to save the
//     changes to the item. The names of the variables, and explanation of
//     when the corresponding messages are displayed, are:
//         Variable Name                Displayed When
//         -------------                --------------
//         cs_rest_startText            A player starts resting.
//         cs_rest_finishText           A player finishes resting properly.
//         cs_rest_cancelText           A rest attempt is interrupted and
//                                      so is unfinished. The player concerned
//                                      will regain a portion of normal HP.
//         cs_rest_cannotText           A player may not rest due to rule
//                                      restrictions.
//         cs_rest_tooSoonText          A time limit rule is in force and the
//                                      player has not waited long enough.
//         cs_rest_dayOnlyText          The Day Only rest rule is in force and
//                                      a player tries to rest at night.
//         cs_rest_nightOnlyText        The Night Only rest rule is in force
//                                      and a player tries to rest during the
//                                      day.
//         cs_rest_noArmourText         The No Armour rest rule is in force
//                                      and the player is wearing armour, a
//                                      helmet or carrying a shield.
//         cs_rest_noWeaponText         The no Weapons rest rule is in force
//                                      and the player is carrying a weapon.
//         cs_rest_bedrollRuinedText    A bedroll is used for the last time
//                                      before it becomes useless. The player
//                                      gains a full rest, but must then
//                                      replace the bedroll.
//         cs_rest_notComfortable       The Bedroll rest rule is in force, the
//                                      player has no bedroll, but the bedroll
//                                      multiplier is set to a value > 0.
//         cs_rest_enterZoneText        The player enters a Safe Camp resting
//                                      trigger.
//         cs_rest_exitZoneText         The player leaves a Safe Camp resting
//                                      trigger.
//         cs_rest_unsafeText           A player tries to rest within a Safe
//                                      Room trigger without closing all doors.
//         cs_rest_enterNoZoneText      The player enters a No Rest resting
//                                      trigger.
//         cs_rest_exitNoZoneText       The player leaves a no Rest resting
//                                      trigger.
//         cs_rest_noBedrollText        The Bedroll rest rule is in force, the
//                                      player has no bedroll, and the bedroll
//                                      multiplier is set to 0.
//     When a text message is displayed, any occurances of the string "<MIN>"
//     will be replaced with the number of minutes remaining until the player
//     will be permitted to rest again. This is really only useful in the
//     "cs_rest_tooSoonText" variable. In addition, any variable that is set
//     to the string "off" will not be displayed. This allows the individual
//     messages to be controlled. This item is the opposite of the No Messages
//     item below and you may not use both items at the same time.
// CS Rest: No Messages
//     Default value: FALSE
//     Use this item to disable the display of any floaty text messages. This
//     item is the opposite of the Text Messages item above and you may not use
//     both items at the same time.
// CS Rest: Effects
//     Default value: FALSE
//     Use this item to apply visual effects to resting players. Once a copy of
//     this item has been placed in the relevant configuration container, edit
//     the item properties and click on the Description tab, then select the
//     Variables button to change the effects to be applied. The item already
//     has the necessary variable, which is named "cs_rest_effects", set though
//     with an empty value. Select the variable name in the list, and enter
//     the numeric effect constant values desired in the text field at the
//     bottom of the dialogue box, separated by commas. Select the Replace
//     button to update the variable on the item, then click Ok to save the
//     changes to the item. The numeric effect constants can be determined by
//     opening the script named "nwscript" in the script editor and searching
//     for "VFX". Don't forget to select the "All Resources" radio button.
//     I'd list them all here, but there are many hundreds and most are not
//     very useful for resting purposes. Some effects that may be quite useful
//     for resting are:
//         Description          Constant Name           Value
//         -----------          -------------           -----
//         Darkness             VFX_DUR_DARKNESS        1
//         Sleep                VFX_IMP_SLEEP           94
//     As an example, to set darkness and sleep effects on a player during
//     resting, use a value of "1,94" for the "cs_rest_effects" variable
//     on the item. Note that these are *visual* effects only, and some may
//     run for fixed durations, finishing either before or after the resting
//     period.
// CS Rest: Enable Debug
//     Default value: FALSE
//     Use this item to enable debug output from the resting subsystem. The
//     debug output will be written to the message window of the player who
//     is resting, and to server log. Debug is managed with the CS Debug
//     subsystem, a separate package for displaying debug information. A
//     minimal set of scripts from the CS Debug package is included with the
//     CS Resting Subsystem.
//
// Using The Resting Triggers
// --------------------------
// The resting triggers track the entry and exit of players, and apply specific
// resting rules while a player is within the bounds of the trigger. The three
// standard triggers provided with the CS Resting Subsystem are the Camp
// trigger, the Room trigger and the No Rest trigger.
//
// NOTE: you do not need to use the triggers to make use of the resting
// subsystem, however in many instances the triggers are easier and more
// flexible to work with. Should you wish to block resting in most parts of
// an area and only allow resting at specific points, such as campsites, then
// using Camp triggers is the logical approach. Likewise, if you only wish to
// stop players from resting at specific points, such as within a boss room,
// then the No Rest trigger is the perfect tool.
//
// Placing a resting trigger basically involves drawing one somewhere in an
// area and setting any configuration necessary. The following steps provide
// a minimal guide to creating a Camp Trigger.
//
// 1/. Select the "CS Camp Resting Trigger" trigger from the "Generic
//     Triggers" category of the Custom triggers palette.
// 2/. Draw a trigger polygon somewhere in an area, such as around a campfire
//     tile.
// 3/. Edit the properties of the trigger (right click within the polygon
//     and select "Properties" from the menu that is displayed) and change
//     the Tag field to something sensible for your module. If you place
//     more than one trigger with the same tag, they will all use the same
//     configuration. This feature allows a module to have resting triggers
//     that provide different combinations of resting rules.
// 4/. If you wish, create a container and place configuration items in
//     its inventory to modify the operation of the trigger (see the section
//     on configuring the CS Resting Subsystem for more details).
//
// You now have a functioning rest trigger. Save your module and load
// it up in Neverwinter Nights to see what happens, however unless you have
// placed a configuration container and changed the default operation, the
// trigger won't actually do anything different to standard Bioware resting.
//
// Other Configuration Facilities
// ------------------------------
// It is possible however to configure resting triggers differently to the
// global rules defined in the global configuration container. You do this
// by creating another container and setting its tag to match that of the
// trigger in question with the string "_REST_CONFIG" appended, i.e. if the
// trigger has a tag of "NoRestZone", the container's tag must be set to
// "NoRestZone_REST_CONFIG". If the tag is not set correctly, the trigger
// won't be able to find the container so be sure to double check this.
// Note that the length of the tag set on the trigger may not be more than
// 20 characters, since "_REST_CONFIG" is 12 characters. Tags are may a maximum
// of 32 characters, so 32 - 12 leaves 20 for the trigger tag.
//
// Once you create a configuration container that is specific to a trigger,
// any configuration items that you place in it will apply only to triggers
// with matching tags (and to *all* triggers with matching tags).
//
// But wait, there's more! It is also possible, in exactly the same way, to
// apply a set of resting rules to a specific area! Say you create an area
// and set its tag to be "BigBadForest". Create a container, set its tag to
// be "BigBadForest_REST_CONFIG" and place some configuration items in the
// container. This particular resting configuration will now apply to all
// players whenever they rest within that area. If however, there is a
// trigger within the area that has a different set of rules, the trigger's
// own rules will apply should the player rest within it.
//
// When a player rests, the resting subsystem will apply the most specific
// rules that it can find based on where the player actually rests. First
// a check is made to see if the player is within a trigger, then the area
// is checked for a specific config container, and finally the global config
// container is checked. It is important to note that this search is performed
// for each configuration item, not just for the configuration container itself
// and so if an item is not present in a trigger's configuration container,
// but *is* present in the global container or an area container, the resting
// subsystem will still apply it to the player! If you wish a specific rest
// rule to apply, then be careful which container you put it in.
//
// A Worked Example Of Setting Up The CS Resting Subsystem
// -------------------------------------------------------
// Ok, lets take a closer look at precisely how to make use to the CS Resting
// Subsystem. Let's say that you're building a module containing three areas: a
// city, an inn and a forest. You decide that there should be limited resting
// available in the forest, but no resting should be possible in the city
// itself since players are supposed to rest in the inn. Within the inn, full
// resting operates.
//
// First set the module's OnPlayerRest event script to "cs_rest_handler".
// Pull down the Edit menu and select Module Properties. Select the Events
// tab and either drop down the list for the OnPlayerRest event to scroll
// through and find "cs_rest_handler", or simply delete the script name
// that is already there and type in "cs_rest_handler" in place. Now select
// the Ok button and the module's rest script is set.
//
// Now create three areas and set their tags to be "TheCity", "TheInn" and
// "BigBadForest". Since the configuration containers for the resting subsystem
// should not be accessible to players, create a fourth area specifically to
// hold the configuration containers. DMs can jump to this area if necessary,
// and when editing the module in the toolset the location of the containers
// is irrelevant. For this module, the global resting rules will apply to the
// forest area while the city and inn have their own specific configuration.
//
// Create three containers and place them in the fourth area. Set their tags to
// be "CS_REST_GLOBAL_CONFIG", "TheCity_REST_CONFIG" and "TheInn_REST_CONFIG".
// Place configuration items into the three containers as indicated below:
//
// Container tagged "CS_REST_GLOBAL_CONFIG":
//     CS Rest: Enable
//     CS Rest: 3rd Ed Style HP
//     CS Rest: Default Profile; set this item's tag to "cs_rest_cmp"
//     CS Rest: 4 Minute Limit
//
// Container tagged "TheCity_REST_CONFIG":
//     CS Rest: Default Profile; set this item's tag to "cs_rest_cnt"
//
// Container tagged "TheInn_REST_CONFIG":
//     CS Rest: Standard HP
//     CS Rest: Armour Not Allowed
//     CS Rest: No Limit
//
// We're done! You now have a module configured to use the CS Resting Subsystem
// instead of the Bioware default resting. In the forest area, and by extension
// any others areas you may add to this module, players may rest once every 4
// minutes and will regain 1 hit point per level. No resting is permitted in
// the city area at all, and players may rest as often as they wish, and regain
// full hit points each time, in the inn but they will have to remove their
// armour to do it.
//
// Notice how not all configuration items need to be set in each container.
// When the resting subsystem is looking for a particular rule, such as whether
// to allow resting in armour, it looks first in any trigger-specific
// container that exists, then it looks in the area-specific container, and
// then it checks the global container. The first item found sets the rule for
// that resting session for that player. If no item is found, the default
// operation is assumed. In this example, you will see that the inn area's
// configuration container does not need to contain a CS Rest: Default Profile
// item since it can use the same script that is set in the configuration for
// the global container. It does however need to have the CS Rest: No Limit
// item to reset resting to unlimited times otherwise the 4 minute limit set
// in the global container would also apply.
//
// Writing User Scripts
// --------------------
// A user script can be used to add module-specific resting rules to those
// evaluated when determining whether a player should be permitted to rest.
// User scripts can also allow interoperation with other systems, such as
// a wandering monster system, and can be used to implement plot-specific
// logic that is triggered when players rest. User scripts are not required
// for normal use of the resting subsystem, but provide instead a powerful
// facility for extending the resting subsystem to meet specific module
// requirements. Some scripting knowledge is required to properly make use
// of the user scripts facility.
//
// A given user script will be executed potentially at four points during the
// rest cycle for a player: when rules are being evaluated to determine whether
// the player may rest, when the player starts to rest, when the player
// finishes resting, and when resting is cancelled for any reason. Only one of
// finish resting or cancel resting will be executed, and if a player is not
// permitted to rest due to not satisfying an active rest rule, then the user
// script will only be executed for the rule evaluation stage. User scripts
// are always executed with the player who is attempting to rest as the
// current object (i.e. OBJECT_SELF within the user script will refer to
// the player).
//
// When the resting subsystem is determining a player's eligibility to rest,
// a set of builtin rules are evaluated against the player. These rules may
// be enabled through configuration and are things like No Armour, Day Only,
// etc. Each of the rules that has been enabled will be checked and the result
// stored for the rest session. Once all rules have been evaluated, the player
// is only permitted to rest if every single rule allows it.
//
// When a user script is executed for evaluation of rest rules, the builder
// may add additional rules for the module. The builder may also override
// the evaluation of the builtin rules by performing additional checks and
// potentially changing the previously calculated result for a rule. For
// example, the No Weapons rule may be enabled, which will prevent a player
// from resting while holding a weapon. The module builder may however decide
// that daggers are small enough to be no hinderance and so would like to
// allow resting if the equipped weapon is a dagger. When a player rests
// with an equipped dagger, the resting subsystem builtin rule will fail, thus
// indicating that resting is not permitted. A user script may then be written
// that performs an additional check on the weapon to see if it is a dagger.
// If so, the previously calculated result of the builtin rule can be reset,
// allowing the player to rest. Of course, if the player fails any other
// rule, she will still not be allowed to rest anyway.
//
// The other execution points for the user script, i.e. when resting starts,
// finishes or is cancelled, are provided specifically for adding custom
// module-specific functionality rather than interacting with the resting
// subsystem itself. The user script may initiate a cutscene when resting
// finishes for example, or generate a random wandering monster encounter
// when resting starts. These execution points are provided for use by builders
// when integrating the resting subsystem into other aspects of a module.
//
// In structure, a user script closely resembles a standard NWN user-defined
// event handler script. Each execution point is numbered and the script calls
// a function, cs_rest_GetUserScriptState(), to determine the execution point
// for which it has been executed. This function will return one of the
// following constants:
//     CS_REST_START_RESTING
//     CS_REST_STOP_RESTING
//     CS_REST_CANCEL_RESTING
//     CS_REST_RULE_CHECK
//
// Once the execution point number has been obtained, a set of if statements
// or a switch statement is used to perform the necessary functionality. When
// the execution point number is CS_REST_RULE_CHECK, the following functions
// may also be used:
//     cs_rest_GetIsRuleEnabled     returns TRUE if a specific rule is
//                                  enabled in configuration.
//     cs_rest_GetRule              returns TRUE if a specific rule has
//                                  has been failed (i.e. the player may
//                                  not rest.
//     cs_rest_SetRule              used to force a specific rule to a
//                                  given state (TRUE will cause the player
//                                  to be unable to rest).
//     cs_rest_SetOverrideProfile   changes the profile that will be used
//                                  for the current rest session *only*.
//                                  The next time the player rests, the
//                                  profile will automatically revert to
//                                  that which is active for the player
//                                  (should the player be inside a trigger)
//                                  or the default profile if the player
//                                  has no profile.
//
// These functions allow the user script to control the rest rules. The rest
// rules are indicated by using the following constants when calling the
// functions above:
//     CS_REST_RULE_LAST_REST
//     CS_REST_RULE_DAY_ONLY
//     CS_REST_RULE_NIGHT_ONLY
//     CS_REST_RULE_NO_ARMOUR
//     CS_REST_RULE_NO_WEAPONS
//     CS_REST_RULE_NO_BEDROLL
//     CS_REST_RULE_USER_1
//     CS_REST_RULE_USER_2
//     CS_REST_RULE_USER_3
//     CS_REST_RULE_USER_4
//     CS_REST_RULE_USER_5
//     CS_REST_RULE_USER_6
//     CS_REST_RULE_USER_7
//     CS_REST_RULE_USER_8
//     CS_REST_RULE_USER_9
//     CS_REST_RULE_USER_10
//     CS_REST_RULE_USER_11
//     CS_REST_RULE_USER_12
//     CS_REST_RULE_USER_13
//     CS_REST_RULE_USER_14
//     CS_REST_RULE_USER_15
//     CS_REST_RULE_USER_16
//
// These constants identify the builtin rest rules provided by the resting
// subsystem, and also the 16 user rules that are available for use by builders
// within user scripts. The user rules will be honoured by the resting
// subsystem in exactly the same way as the builtin rules, with the single
// exception that the resting subsystem will never change the state of a user
// rule. All user rules are always enabled, and will always be FALSE (i.e.
// the player is allowed to rest) when the user script is executed. Changing
// any user rule to a state of TRUE through the cs_rest_SetRule() function
// will prevent the player from resting.
//
// When the execution point is CS_REST_START_RESTING, the following functions
// may also be used:
//     cs_rest_SetAbort             Causing the rest process to be aborted
//                                  as if it had not started. This allows
//                                  last minute decisions to be made as to
//                                  whether a player may rest, despite the
//                                  player having successfully satisfied all
//                                  enabled rest rules.
//     cs_rest_SetOverrideProfile   changes the profile that will be used
//                                  for the current rest session *only*.
//                                  The next time the player rests, the
//                                  profile will automatically revert to
//                                  that which is active for the player
//                                  (should the player be inside a trigger)
//                                  or the default profile if the player
//                                  has no profile.
//
// Consult the help text for each function for further details, and read
// through the sample code in An Example User Script. The script named
// cs_rest_sample is  template script that may used as a starting point for
// user scripts. The script named cs_rest_userxmpl is a functional example
// that demonstrates how the Bioware HotU wandering monster system may be
// integrated into the resting subsystem.
//
// An Example User Script
// ----------------------
// The sample script in this section shows how to implement the example
// presented in Writing User Scripts.
//
// #include "cs_rest"
// void main() {
//     int state = cs_rest_GetUserScriptState();
//     if (state == CS_REST_START_RESTING) {
//     }
//     else if (state == CS_REST_STOP_RESTING) {
//     }
//     else if (state == CS_REST_CANCEL_RESTING) {
//     }
//     else if (state == CS_REST_RULE_CHECK) {
//         // Has the No Weapons rule actually been enabled?
//         if (cs_rest_GetIsRuleEnabled(CS_REST_RULE_NO_WEAPONS)) {
//             // Retrieve the items in the resting player's hands.
//             object right = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
//             // If the player has a dagger in her right hand, we have to
//             // check a little more carefully before resetting the No
//             // Weapons rule and allowing her to rest.
//             if ((GetBaseItemType(right) == BASE_ITEM_DAGGER) {
//                 // If the player has nothing in her left hand, or a dagger,
//                 // a shield, or a torch, she's ok to rest for this rule.
//                 // Anything else will be assumed to be another weapon
//                 // and so the resting state for the No Weapons rule will
//                 // be left unchanged.
//                 int left = GetBaseItemType(
//                     GetItemInSlot(INVENTORY_SLOT_LEFTHAND)
//                 );
//                 if ((left == BASE_ITEM_INVALID) ||
//                     (left == BASE_ITEM_TORCH) ||
//                     (left == BASE_ITEM_SMALLSHIELD) ||
//                     (left == BASE_ITEM_LARGESHIELD) ||
//                     (left == BASE_ITEM_TOWERSHIELD) ||
//                     (left == BASE_ITEM_DAGGER)
//                 ) {
//                     // The player only has a dagger or an allowed item
//                     // equipped, so the No Weapon rule can be reset.
//                     // Note that shields are checked as part of the
//                     // No Armour rule, not the No WSeapons rule.
//                     cs_rest_SetRule(CS_REST_RULE_NO_WEAPONS, FALSE);
//                 }
//             }
//         }
//     }
// }
//
// Creating Your Own Resting Profile
// ---------------------------------
// A resting profile sets the fundamental operation of the resting subsystem.
// Resting profiles are represented by scripts that call the basic functions
// of the resting subsystem in response to the engine's rest events, sometimes
// performing additional checks (such as the safe room profile used by the
// CS Safe Room Trigger, which checks that all doors in a room are closed
// before executing the resting). The three standard profiles provided with
// resting subsystem are:
//     Name             Script
//     --------------   ------
//     Safe/Camp Rest   cs_rest_cmp
//     Safe Room Rest   cs_rest_rom
//     No Rest          cs_rest_cnt
//
// Resting profiles are used in two places: when setting a default profile
// for the global rest configuration or in an area's rest configuration,
// or when creating a resting trigger. Using a resting profile from a
// configuration container is simply a matter of setting the profile script
// name using the Default Profile config item, after writing the profile
// script, of course. Creating a profile for use with a trigger is slightly
// more complex. Creating a rest profile is a task for a moderately skilled
// scripter with good knowledge of how the resting subsystem works.
//
// There are three components to a rest profile when it is used from a
// trigger: a trigger OnEnter script, a trigger OnExit script, and the
// resting profile script itself. The OnEnter script is a simple modification
// of an existing OnEnter script, since the only thing that has to change is
// the name of the resting profile script contained within it. The standard
// OnExit script provided by the resting subsystem should work for all new
// resting profile triggers as well, so the only real work comes about when
// writing the resting profile script itself.
//
// The standard resting profiles should be sufficient for most purposes, as
// most custom operation may be added theough the user script facility in a
// more elegant manner.
//
// An Example Resting Profile
// --------------------------
// To illustrate how resting profiles are created, the Safe Room Rest profile
// script and its corresponding trigger OnEnter script are shown here. The
// standard trigger OnExit script, cs_rest_trg_exit, should be sufficient
// for any new resting profile trigger.
//
// This is the trigger OnEnter script for the Safe Room Rest trigger. It first
// checks to ensure that the creature who has entered the trigger is a player,
// and then it sets the name of the resting profile script ("cs_rest_rom")
// as the player's resting profile using the cs_rest_SetProfile() function.
// The trigger itself is set as the object that the player has entered using
// the cs_rest_SetTriggeringObject() function (this is so the resting subsystem
// knows which configuration container to search for). Finally, a floaty text
// message is displayed indicating that the player has entered a rest trigger.
// The cs_rest_RetrieveConfig() function is used to determine whether floaty
// text messages are enabled (a check is performed within the function call).
// Basically all OnEnter scripts for resting triggers will look identical to
// this script except for the name of the rest profile script.
//
// #include "cs_rest"
// void main() {
//    object pc = GetEnteringObject();
//    if (GetIsPC(pc)) {
//        // Set tracking information for this trigger.
//        cs_rest_SetProfile(pc, "cs_rest_rom");
//        cs_rest_SetTriggeringObject(pc, OBJECT_SELF);
//        struct cs_rest_config cfg = cs_rest_RetrieveConfig(pc);
//        cs_rest_ShowFloatingTextByID(pc, cfg, CS_REST_TXT_ENTER_REST);
//    }
// }
//
// This is the Safe Room Rest profile script. It retrieves the current rest
// session config from the player with the cs_rest_GetConfig() function (all
// resting configuration has by this stage been retrieved from containers and
// stored as local variables on the player). The specific rest event is then
// checked to determine whether a start, stop or cancel event is currently
// being processed. The stop and cancel events simply require standard rest
// processing so the cs_rest_StopResting() and cs_rest_CancelResting()
// functions are called. For a start resting event, the trigger that the
// player has entered is searched for doors, and the state of every door
// is checked to make sure it has been closed. Only if there are actually
// doors, and all of them are closed, is the player allowed to rest. The
// configuration values retrieved from the player at the start of the function
// are passed to most resting subsystem functions to minimise the need to
// continually read local variables.
//
// #include "cs_rest"
// void main() {
//     object pc = GetLastPCRested();
//     if (GetIsPC(pc)) {
//         struct cs_rest_config cfg = cs_rest_GetConfig(pc);
//         int restType = GetLastRestEventType();
//         if (restType == REST_EVENTTYPE_REST_STARTED) {
//             // Find all doors within the area of the triggering object the
//             // PC is within.
//             int doorsFound = 0;
//             int openDoors = 0;
//             if (GetIsObjectValid(cfg.trigger)) {
//                 object door = GetFirstInPersistentObject(
//                     cfg.trigger,
//                     OBJECT_TYPE_DOOR
//                 );
//                 while (GetIsObjectValid(door)) {
//                     doorsFound++;
//                     if (GetIsOpen(door)) {
//                         openDoors++;
//                     }
//                     door = GetNextInPersistentObject(
//                         cfg.trigger,
//                         OBJECT_TYPE_DOOR
//                     );
//                 }
//             }
//
//             // Do we stop the player from resting? This is a safe room rest
//             // check. Players may only rest if they have taken steps to
//             // ensure their own safety, i.e. closing all doors. Resting is
//             // not permitted if:
//             //    - there are no doors in this trigger
//             //    - a door within this trigger is open
//             if (!doorsFound || openDoors) {
//                 cs_rest_ShowFloatingTextByID(pc, cfg, CS_REST_TXT_UNSAFE);
//                 AssignCommand(pc, ClearAllActions());
//             }
//             else {
//                 cs_rest_StartResting(pc, cfg);
//             }
//         }
//         else if (restType == REST_EVENTTYPE_REST_FINISHED) {
//             cs_rest_StopResting(pc, cfg);
//         }
//         else if (restType == REST_EVENTTYPE_REST_CANCELLED) {
//             cs_rest_CancelResting(pc, cfg);
//         }
//     }
// }
//
// Using the CS Resting Subsystem Within A Persistent World
// --------------------------------------------------------
// In general, The CS Resting Subsystem will function correctly when used in a
// persistent world environment. The one thing that may cause issues is the
// last resting time, which must be calculated and stored each time a player
// rests. When a player logs in after a server restart, she will be able to
// rest immediately, which may not be what is desired. There are however a
// set of functions provided that address this situation.
//
// The cs_rest_GetState() and cs_rest_SetState() functions may be used to
// store the information needed to restore a player's resting situation to
// a specific point. The cs_rest_GetState() function may be used to retrieve
// resting information for a player, which may then be stored in a persistence
// mechanism such as a database. This resting information is returned in the
// form of a string for convenience. The cs_rest_SetState() function may be
// used to restore the resting information for when that player logs into
// the server again.
//
// The use of these two functions must be performed through scripting and so
// is not handled as part of the normal configuration of the resting subsystem.
// It is not necessary to use these functions in anything other than a
// persistent world, and not even in every one of those. Please try using the
// resting subsystem first before making use of these functions.
//
// Acknowledgements
// ----------------
// Many thanks go to __Abaddon__ and Elorin for being sounding boards of
// ideas and for telling me when I'm being stupid. Elorin finds bugs and I
// fix them. Sigh. Provsul has been of great assistance in providing better
// support for persistent worlds. Thank to rdjparadis for the explanation
// of item property cost tables.
//
// To Do
// -----
//   - Party-only resting.
//
// Revision History
// ----------------
// 0.8.1dev     Added simple rations support. Added rations config items.
// 0.8.0dev     Changed builtin resting rules to act upon a bitmapped flag
//              integer, thus allowing all rules to operate independently.
//              Some internal consistency tweaks, constant renaming and
//              the like to make the code more maintainable. Added execution
//              of a user script immediately after evaluating builtin rules,
//              and on start, stop and cancel of resting. Added User Script
//              config item. Updated to release 1.7.0 of CS Debug. Updated
//              documentation. Finally added support for changing the floaty
//              text messages through the usual dynamic configuration model,
//              and now allow individual floaty messages to be disabled as
//              well. Added the Effects config item. Added override profile.
//              Finally got around to changing the hit point multiplier and
//              CON bonus modifiers so that they apply to standard hit point
//              regain as well as to 3rd Edition style regain. Changed the
//              calculation of AC for armour checks to be accurately derived
//              from base AC and properties (thanks Mermut :). Changed the
//              No Armour rest rule item to use the tag of the config item
//              to set the maximum acceptable AC for armour when resting.
//              Changed the way damage is applied for 3rd edition resting
//              to account for resistance, reduction and immunities.
// 0.7.3dev     Added the Bedroll HP Multiplier config item. Changed the
//              generation of the remaining minutes message to be more
//              sensible.
// 0.7.2dev     Rewrote the still dysfunctional time manipulation to use
//              a double-int method of tracking times, thus providing more
//              than sufficient scope for managing the DR calendar at any
//              minutes-per-hour resolution that anyone may care to use.
//              Shields are now considered armour with regard to resting.
// 0.7.1dev     More debug messages. Corrected some minor issues related to
//              time manipulation changes. Restored incorrect trigger tags.
// 0.7.0dev     Some documentation updates. Added persistence hooks. Updated
//              to release 1.5.0 of CS Debug. Added internal debug config
//              support to allow debug output for the resting subsystem to
//              be controlled through the resting subsystem configuration.
//              Armour and weapons checks are now controlled through separate
//              configuration items. Internal changes to time manipulation.
// 0.6.6dev     Documentation corrections. No code change.
// 0.6.5dev     Removed Destroy config item and associated code. The idea of
//              destroying the config and keeping static copies of the rules
//              as local variables never really made sense anyway. Added Use
//              CON Bonus, No CON Bonus and HP Multiplier configuration items.
// 0.6.1dev     Fixed No Messages configuration item so that it works.
//              Added separate floaty messages for entering and exiting no
//              rest zones.
// 0.6.0dev     Major refactoring to eliminate proliferation of get/set
//              functions and replace most with a single set of functions.
//              Much cleaner code now. First draft of documentation. Added
//              fade screen to black function and corresponding config item.
//              Even more debug! Added No Messages configuration item.
// 0.5.0dev     Added bedrolls and associated configuration items--still
//              mostly untested. Corrected overzealous armour restrictions
//              (forced resting naked is probably a bit over the top :).
//              Included equipped weapons in the "armour check". Added
//              resting never permitted function for special purposes.
//              Added config cleanup when not destroying config containers,
//              thus allowing defaults to re-apply the next time the container
//              is read.
// 0.4.0dev     Incorporated 3rd ed style resting as a configurable option
//              for all triggers, and removed the 3rd ed trigger. Added
//              global and area configuration facility. Added day/night
//              only configuration items. Added armour configuration items.
// 0.3.0dev     Added 3rd edition rules profile. Improved safe room resting
//              by accounting for multiple doors. Rejigged framework to use
//              two scripts per profile (enter/rest) rather than four
//              (enter/start/stop/cancel). Added dynamic configuration.
//              Added time limits. Added floaty text.
// 0.2.0dev     Added profile support. Added safe room profile.
// 0.1.0dev     Basic framework. Safe campsites.
//
//============================================================================
#include "cs_dbg"
#include "cs_token"
#include "cs_rest_text"
#include "_isla_inc"

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
const string cs_rest_version = "0.8.1dev";

//============================================================================
//
// Data Types and Constants
//
//============================================================================

// The maximum length of tags. This is used for error validation.
const int CS_REST_MAX_TAG_LENGTH = 32;

// Constants for default values when using bedrolls.
const int CS_REST_DEF_BEDROLL_MAX_USE = 20;
const float CS_REST_DEF_BEDROLL_MULTIPLIER = 0.5;
const float CS_REST_DEF_RATIONS_MULTIPLIER = 0.5;
const float CS_REST_DEF_MULTIPLIER = 1.0;
const int CS_REST_DEF_NO_ARMOUR = -1;
const string CS_REST_DEF_EFFECTS = "";

// The tag of the global rest container.
const string CS_REST_TAG_CONFIG = "CS_REST_GLOBAL_CONFIG";

// The suffix added to an area or trigger tag to generate the matching
// rest container tag.
const string CS_REST_TAG_CONFIG_SUFFIX = "_REST_CONFIG";

// Floaty text message IDs.
const int CS_REST_TXT_START = 1;
const int CS_REST_TXT_FINISH = 2;
const int CS_REST_TXT_CANCEL = 3;
const int CS_REST_TXT_CANNOT = 4;
const int CS_REST_TXT_TOO_SOON = 5;
const int CS_REST_TXT_DAY_ONLY = 6;
const int CS_REST_TXT_NIGHT_ONLY = 7;
const int CS_REST_TXT_NO_ARMOUR = 8;
const int CS_REST_TXT_NO_WEAPON = 9;
const int CS_REST_TXT_BEDROLL_RUINED = 10;
const int CS_REST_TXT_NOT_COMFORTABLE = 11;
const int CS_REST_TXT_ENTER_REST = 12;
const int CS_REST_TXT_EXIT_REST = 13;
const int CS_REST_TXT_UNSAFE = 14;
const int CS_REST_TXT_ENTER_NO_REST = 15;
const int CS_REST_TXT_EXIT_NO_REST = 16;
const int CS_REST_TXT_NO_BEDROLL = 17;
const int CS_REST_TXT_RATIONS_EATEN = 18;
const int CS_REST_TXT_NO_RATIONS = 19;
const int CS_REST_TXT_HUNGRY = 20;

// Names of resrefs for configuration items.
const string CS_REST_RR_DEBUG_ON = "cs_rest_cfg_dbgo";
const string CS_REST_RR_ENABLE = "cs_rest_cfg_enbl";
const string CS_REST_RR_DISABLE = "cs_rest_cfg_dsbl";
const string CS_REST_RR_PROFILE = "cs_rest_cfg_prfl";
const string CS_REST_RR_TIME_LIMIT = "cs_rest_cfg_time";
const string CS_REST_RR_TIME_PREFIX = "cs_rest_cfg_tm";
const string CS_REST_RR_HP_3ED = "cs_rest_cfg_3ed";
const string CS_REST_RR_HP_STD = "cs_rest_cfg_std";
const string CS_REST_RR_NO_ARMOUR = "cs_rest_cfg_armn";
const string CS_REST_RR_YES_ARMOUR = "cs_rest_cfg_army";
const string CS_REST_RR_NO_WEAPONS = "cs_rest_cfg_wepn";
const string CS_REST_RR_YES_WEAPONS = "cs_rest_cfg_wepy";
const string CS_REST_RR_NO_BEDROLL = "cs_rest_cfg_bedn";
const string CS_REST_RR_YES_BEDROLL = "cs_rest_cfg_bedy";
const string CS_REST_RR_BEDROLL_MULTIPLIER = "cs_rest_cfg_bedm";
const string CS_REST_RR_NO_RATIONS = "cs_rest_cfg_ratn";
const string CS_REST_RR_YES_RATIONS = "cs_rest_cfg_raty";
const string CS_REST_RR_RATIONS_MULTIPLIER = "cs_rest_cfg_ratm";
const string CS_REST_RR_DAY_ONLY = "cs_rest_cfg_donl";
const string CS_REST_RR_NIGHT_ONLY = "cs_rest_cfg_nonl";
const string CS_REST_RR_ALL_HOURS = "cs_rest_cfg_allh";
const string CS_REST_RR_DAY_START = "cs_rest_cfg_days";
const string CS_REST_RR_DAY_END = "cs_rest_cfg_daye";
const string CS_REST_RR_FADE_TO_BLACK = "cs_rest_cfg_fade";
const string CS_REST_RR_NO_MESSAGES = "cs_rest_cfg_nmsg";
const string CS_REST_RR_USE_CON_BONUS = "cs_rest_cfg_cony";
const string CS_REST_RR_NO_CON_BONUS = "cs_rest_cfg_conn";
const string CS_REST_RR_HP_MULTIPLIER = "cs_rest_cfg_hmul";
const string CS_REST_RR_USER_SCRIPT = "cs_rest_cfg_uscr";
const string CS_REST_RR_TEXT_MESSAGES = "cs_rest_cfg_text";
const string CS_REST_RR_EFFECTS = "cs_rest_cfg_efct";

// Names of local variables used within the resting code.
const string CS_REST_VAR_DEBUG = "cs_rest_debug";
const string CS_REST_VAR_PERMITTED = "cs_rest_permitted";
const string CS_REST_VAR_RULE_FLAGS = "cs_rest_ruleFlags";
const string CS_REST_VAR_ENABLE = "cs_rest_enable";
const string CS_REST_VAR_STARTED = "cs_rest_started";
const string CS_REST_VAR_NEVER_PERMITTED = "cs_rest_neverPermitted";
//const string CS_REST_VAR_PLAYER_ALLOWED = "cs_rest_playerAllowed";
const string CS_REST_VAR_PLAYER_PROFILE = "cs_rest_playerProfile";
const string CS_REST_VAR_DEFAULT_PROFILE = "cs_rest_defaultProfile";
const string CS_REST_VAR_OVERRIDE_PROFILE = "cs_rest_overrideProfile";
const string CS_REST_VAR_TIME_LIMIT = "cs_rest_timeLimit";
const string CS_REST_VAR_LAST_REST_DAYS = "cs_rest_lastRestDays";
const string CS_REST_VAR_LAST_REST_SECONDS = "cs_rest_lastRestSeconds";
const string CS_REST_VAR_SAVE_HP = "cs_rest_savedHP";
const string CS_REST_VAR_HP_3ED = "cs_rest_3ed";
const string CS_REST_VAR_NO_ARMOUR = "cs_rest_noArmour";
const string CS_REST_VAR_NO_WEAPONS = "cs_rest_noWeapons";
const string CS_REST_VAR_BEDROLL_IN_USE = "cs_rest_bedrollInUse";
const string CS_REST_VAR_BEDROLL_TAG = "cs_rest_bedrollTag";
const string CS_REST_VAR_BEDROLL_USE = "cs_rest_bedrollUse";
const string CS_REST_VAR_BEDROLL_MULTIPLIER = "cs_rest_bedrollMultiplier";
const string CS_REST_VAR_RATIONS_IN_USE = "cs_rest_rationsInUse";
const string CS_REST_VAR_RATIONS_TAG = "cs_rest_rationsTag";
const string CS_REST_VAR_RATIONS_MULTIPLIER = "cs_rest_rationsMultiplier";
const string CS_REST_VAR_DAY_MODE = "cs_rest_dayMode";
const string CS_REST_VAR_DAY_START = "cs_rest_dayStart";
const string CS_REST_VAR_DAY_END = "cs_rest_dayEnd";
const string CS_REST_VAR_TRIGGER = "cs_rest_trigger";
const string CS_REST_VAR_MULTIPLIER = "cs_rest_multiplier";
const string CS_REST_VAR_FADE_TO_BLACK = "cs_rest_fadeToBlack";
const string CS_REST_VAR_FADE_DONE = "cs_rest_fadeDone";
const string CS_REST_VAR_NO_MESSAGES = "cs_rest_noMessages";
const string CS_REST_VAR_CON_BONUS = "cs_rest_conBonus";
const string CS_REST_VAR_NO_REST_ZONE = "cs_rest_noRestZone";
const string CS_REST_VAR_USER_SCRIPT = "cs_rest_userScript";
const string CS_REST_VAR_USER_SCRIPT_STATE = "cs_rest_userScriptState";
const string CS_REST_VAR_EFFECTS = "cs_rest_effects";
const string CS_REST_VAR_START_TIME = "cs_rest_startTime";

// Constants for indicating when resting is permitted.
const int CS_REST_DAY_AND_NIGHT = 0;
const int CS_REST_DAY_ONLY = 1;
const int CS_REST_NIGHT_ONLY = 2;

// Constants for state tracking whether resting actually began.
const int CS_REST_STARTED = 1;
const int CS_REST_ABORTED = 2;

// Constants for use with user hook scripts.
const int CS_REST_START_RESTING = 1;
const int CS_REST_STOP_RESTING = 2;
const int CS_REST_CANCEL_RESTING = 3;
const int CS_REST_RULE_CHECK = 4;

// Names of variables that hold floaty text message strings.
const string CS_REST_VAR_START_TEXT = "cs_rest_startText";
const string CS_REST_VAR_FINISH_TEXT = "cs_rest_finishText";
const string CS_REST_VAR_CANCEL_TEXT = "cs_rest_cancelText";
const string CS_REST_VAR_CANNOT_TEXT = "cs_rest_cannotText";
const string CS_REST_VAR_TOO_SOON_TEXT = "cs_rest_tooSoonText";
const string CS_REST_VAR_DAY_ONLY_TEXT = "cs_rest_dayOnlyText";
const string CS_REST_VAR_NIGHT_ONLY_TEXT = "cs_rest_nightOnlyText";
const string CS_REST_VAR_NO_ARMOUR_TEXT = "cs_rest_noArmourText";
const string CS_REST_VAR_NO_WEAPON_TEXT = "cs_rest_noWeaponText";
const string CS_REST_VAR_BEDROLL_RUINED_TEXT = "cs_rest_bedrollRuinedText";
const string CS_REST_VAR_NOT_COMFORTABLE_TEXT = "cs_rest_notComfortable";
const string CS_REST_VAR_ENTER_REST_TEXT = "cs_rest_enterZoneText";
const string CS_REST_VAR_EXIT_REST_TEXT = "cs_rest_exitZoneText";
const string CS_REST_VAR_UNSAFE_TEXT = "cs_rest_unsafeText";
const string CS_REST_VAR_ENTER_NO_REST_TEXT = "cs_rest_enterNoZoneText";
const string CS_REST_VAR_EXIT_NO_REST_TEXT = "cs_rest_exitNoZoneText";
const string CS_REST_VAR_NO_BEDROLL_TEXT = "cs_rest_noBedrollText";
const string CS_REST_VAR_RATIONS_EATEN_TEXT = "cs_rest_rationsEatenText";
const string CS_REST_VAR_NO_RATIONS_TEXT = "cs_rest_noRationsText";
const string CS_REST_VAR_HUNGRY_TEXT = "cs_rest_hungryText";

// Rest rule bitmapped IDs for rule checks.
const int CS_REST_RULE_LAST_REST  = 0x00000001;
const int CS_REST_RULE_DAY_ONLY   = 0x00000002;
const int CS_REST_RULE_NIGHT_ONLY = 0x00000004;
const int CS_REST_RULE_NO_ARMOUR  = 0x00000008;
const int CS_REST_RULE_NO_WEAPONS = 0x00000010;
const int CS_REST_RULE_NO_BEDROLL = 0x00000020;
const int CS_REST_RULE_NO_RATIONS = 0x00000040;
const int CS_REST_RULE_RESERVED_1 = 0x00000080;
const int CS_REST_RULE_RESERVED_2 = 0x00000100;
const int CS_REST_RULE_RESERVED_3 = 0x00000200;
const int CS_REST_RULE_RESERVED_4 = 0x00000400;
const int CS_REST_RULE_RESERVED_5 = 0x00000800;
const int CS_REST_RULE_RESERVED_6 = 0x00001000;
const int CS_REST_RULE_RESERVED_7 = 0x00002000;
const int CS_REST_RULE_RESERVED_8 = 0x00004000;
const int CS_REST_RULE_RESERVED_9 = 0x00008000;
const int CS_REST_RULE_USER_1     = 0x10000000;
const int CS_REST_RULE_USER_2     = 0x20000000;
const int CS_REST_RULE_USER_3     = 0x40000000;
const int CS_REST_RULE_USER_4     = 0x80000000;
const int CS_REST_RULE_USER_5     = 0x01000000;
const int CS_REST_RULE_USER_6     = 0x02000000;
const int CS_REST_RULE_USER_7     = 0x04000000;
const int CS_REST_RULE_USER_8     = 0x08000000;
const int CS_REST_RULE_USER_9     = 0x00100000;
const int CS_REST_RULE_USER_10    = 0x00200000;
const int CS_REST_RULE_USER_11    = 0x00400000;
const int CS_REST_RULE_USER_12    = 0x00800000;
const int CS_REST_RULE_USER_13    = 0x00010000;
const int CS_REST_RULE_USER_14    = 0x00020000;
const int CS_REST_RULE_USER_15    = 0x00040000;
const int CS_REST_RULE_USER_16    = 0x00080000;

const string CS_REST_IPRP_COST_TABLE = "iprp_costtable";
const string CS_REST_IPRP_NAME = "Name";
const string CS_REST_IPRP_AMOUNT = "Amount";
const string CS_REST_IPRP_VALUE = "Value";

// A configuration structure that tracks the operational parameters for a
// resting session.
struct cs_rest_config {
    object debug;           // The object to which debug messages are sent.
    int permitted;          // If resting is permitted for a given session.
    int ruleFlags;          // A bitmapped flag word for tracking rules.
    int lastRestDays;       // Days since start of calendar since of last rest.
    int lastRestSeconds;    // Seconds within day of last rest.
    int savedHitPoints;     // Number of HP when resting session was begin.
    int enabled;            // If this rest system is actually enabled at all.
    int started;            // If a resting session has been begun.
    int neverPermitted;     // If resting for the creature is never allowed.
//    int allowed;            // XXX Don't know. Might not be used anymore.
    string profile;         // The current profile for the player.
    string defaultProfile;  // The default profile if not otherwise set.
    string overrideProfile; // A profile that exists only for the rest session.
    int limit;              // Number of seconds between rests.
    int use3Ed;             // Use 3rd Edition-style HP regain.
    int noArmour;           // Armour may not be equipped while resting.
    int noWeapons;          // Weapons may not be equipped while resting.
    int useBedroll;         // A bedroll must be available to rest.
    string bedrollTag;      // The tag of bedroll items.
    float bedrollMultiplier;// A multiplier for HP regain in bedroll resting.
    int useRations;         // Food rations must be available to rest.
    string rationsTag;      // The tag of food ration items.
    float rationsMultiplier;// A multiplier for HP regain in rationed resting.
    int dayMode;            // Resting may only occur during the day or night.
    int dayStart;           // The hour at which "day" starts.
    int dayEnd;             // The hour at which "day" ends.
    object trigger;         // The trigger in which the player exists.
    float multiplier;       // A multiplier for HP regain.
    int fadeToBlack;        // If the screen should fade to black while resting.
    int noMessages;         // If floating messages should be displayed.
    int useConBonus;        // If CON bonus should be added to HP regain.
    string userScript;      // Name of rule script provided by builder.
    string effects;         // A set of effect numbers to apply.
};

// A representation of a date and time broken down into number of days
// since the beginning of the calendar and a number of seconds within the
// current day.
struct cs_rest_time {
    int days;       // The number of days since the beginning of the calendar.
    int seconds;    // The number of seconds elapsed within the current day.
};

// An internal structure used to capture the resistance and immunity values
// from properties on the equipment being worn by a player.
struct cs_rest_resistance {
    int resistance;
    int immunity;
    int vulnerability;
};


//============================================================================
//
// Function Prototypes and toolset IDE documentation.
//
//============================================================================

// Set the rest profile to be associated with the specified player.
//
// pc           The player for whom to set the profile.
// profile      The name of the profile to associate with the player.
void cs_rest_SetProfile(object pc, string profile);

// Remove any rest profile that may be associated with the specified
// player.
//
// pc           The player from whom to remove any profile.
void cs_rest_DeleteProfile(object pc);

// Set the session-specific rest profile to be associated with the specified
// player. Session profiles are only used for the specific resting session
// in which they are set.
//
// pc           The player for whom to set the profile.
// profile      The name of the profile to associate with the player.
void cs_rest_SetOverrideProfile(object pc, string profile);

// Remove any session-specific rest profile that may be associated with the
// specified player. Session profiles are only used for the specific resting
// session in which they are set.
//
// pc           The player from whom to remove any profile.
void cs_rest_DeleteOverrideProfile(object pc);

// Set the object that associated the rest profile with the specified player.
//
// pc           The player for whom to set the triggering object.
// profile      The triggering object.
void cs_rest_SetTriggeringObject(object pc, object trigger);

// Remove any triggering object that may be stored for the specified player.
//
// pc           The player from whom to remove any triggering object.
void cs_rest_DeleteTriggeringObject(object pc);

// Set a rule flag to a specific state (i.e. TRUE or FALSE). Rule flags are
// used to track whether a player has satisfied a specific rule that will
// block resting. Resting will only be permitted if *no* rules have been
// satisfied and all rule flags are FALSE.
//
// cfg          The current rest config for a player.
// rule         The specific rule flag that is to be changed.
// value        Either TRUE to set the flag or FALSE to clear it.
// returns      The modified rest config.
struct cs_rest_config cs_rest_SetRuleFlag(struct cs_rest_config cfg, int rule, int value);

// Determine the state of a specific rule flag.
//
// cfg          The current rest config for a player.
// rule         The specific rule flag that is to be checked.
// returns      TRUE if the flag is set otherwise FALSE.
int cs_rest_GetRuleFlag(struct cs_rest_config cfg, int rule);

// Execute the resting script associated with the rest profile that has
// been set for the specified player.
//
// pc           The player for whom to run the script.
// cfg          A set of configuration data for a player.
void cs_rest_ExecuteRestScript(object pc, struct cs_rest_config cfg);

// Return the current time as a since the beginning of the calendar.
//
// returns      The current time.
struct cs_rest_time cs_rest_GetCurrentTime(struct cs_rest_config cfg);

// Process the configuration for the rest subsystem.
//
// pc           The player for whom to process configuration.
// container    A container object containing the configuration.
// cfg          A set of configuration data for a player.
// returns      The updated configuration data.
struct cs_rest_config cs_rest_ProcessConfig(object pc, object container, struct cs_rest_config cfg);

// Search for and compile together all of the configuration that applies to
// a specific player.
//
// pc           The player for whom to search for configuration.
// returns      The player's resting configuration
struct cs_rest_config cs_rest_RetrieveConfig(object pc);

// Read any messages that exist as variables on the specified item and set
// them to be used for the specified player's rest session.
//
// pc           The player for whom to change messages.
// cfg          The player's resting configuration.
// item         The item containing message text variables.
void cs_rest_UpdateMessages(object pc, struct cs_rest_config cfg, object item);

// Display a floating text message on a player from those messages defined
// by the rest system. If floaty messages are disabled for the resting zone
// in which this function is invoked (i.e. cfg.noMessage is TRUE), no
// messages will be displayed.
//
// pc           The player on whom to display the message.
// cfg          The player's resting configuration.
// id           The ID of the message to be displayed. This value may be one
//              of the following constants:
//                  CS_REST_TXT_START
//                  CS_REST_TXT_FINISH
//                  CS_REST_TXT_CANCEL
//                  CS_REST_TXT_CANNOT
//                  CS_REST_TXT_TOO_SOON
//                  CS_REST_TXT_DAY_ONLY
//                  CS_REST_TXT_NIGHT_ONLY
//                  CS_REST_TXT_NO_ARMOUR
//                  CS_REST_TXT_NO_WEAPON
//                  CS_REST_TXT_BEDROLL_RUINED
//                  CS_REST_TXT_NOT_COMFORTABLE
//                  CS_REST_TXT_ENTER_REST_ZONE
//                  CS_REST_TXT_EXIT_REST_ZONE
//                  CS_REST_TXT_UNSAFE
//                  CS_REST_TXT_ENTER_NO_REST_ZONE
//                  CS_REST_TXT_EXIT_NO_REST_ZONE
//                  CS_REST_TXT_NO_BEDROLL
void cs_rest_ShowFloatingTextByID(object pc, struct cs_rest_config cfg, int id);

// Retrieve rest configuration from an object.
//
// returns      The configuration data found.
struct cs_rest_config cs_rest_GetConfig(object container);

// Set current rest configuration on an object.
//
// container    The object on which to set the config.
// cfg          A set of configuration data.
void cs_rest_SetConfig(object container, struct cs_rest_config cfg);

// Delete rest configuration from an object.
//
// container    The object from which to delete the configuration data.
void cs_rest_DeleteConfig(object container);

// Generate a string containing the data needed to restore the resting
// state of a player in the event of a system failure, or after a player
// logs out. This function should be called periodically while a server
// is running, if persistent state is being stored in such a fashion, or
// whenever a player logs out.
//
// NOTE: This function is not needed for the normal operation of the
// resting subsystem and should be used only for integration into modules
// that run as persistent worlds.
//
// pc           The object from which to retrieve the config.
// returns      The persistence state in string form.
string cs_rest_GetState(object container);

// Set the resting state for a player from a previous call to the
// cs_rest_GetState() function. This function should be called when
// a player logs into a server running as a persistent module.
//
// NOTE: This function is not needed for the normal operation of the
// resting subsystem and should be used only for integration into modules
// that run as persistent worlds.
//
// pc           The object on which to set the config.
// state        A string containing state information.
// timeOffset   The amount of time in seconds by which the time values
//              in the resting state should be adjusted. Adjusting the
//              time will usually be unnecessary.
void cs_rest_SetState(object container, string state, int timeOffset=0);

// Set the user hook script state for a resting session.
//
// pc           The player who is resting.
// state        The state for the hook script. This should be one of the
//              following constants:
//                  CS_REST_START_RESTING
//                  CS_REST_STOP_RESTING
//                  CS_REST_CANCEL_RESTING
//                  CS_REST_RULE_CHECK
void cs_rest_SetUserScriptState(object pc, int state);

// Determine the resting state for which the user hook script has been
// executed.
//
// pc           The player who is resting. If not specified, this defaults
//              to the current object.
// returns      The script hook state. This will be one of the following
//              constants:
//                  CS_REST_START_RESTING
//                  CS_REST_STOP_RESTING
//                  CS_REST_CANCEL_RESTING
//                  CS_REST_RULE_CHECK
int cs_rest_GetUserScriptState(object pc=OBJECT_SELF);

// Delete the user script state variable from the specified player.
//
// pc           The player from which the variable is to be deleted.
void cs_rest_DeleteUserScriptState(object pc);

// Determine whether a specific rest rule has been enabled in the resting
// system configuration. Though the user rules can be checked with this
// function, they are always enabled.
//
// This function may only be used within the CS_REST_RULE_CHECK execution
// point for a user script.
//
// rule         The specific rest rule that is to be checked. This value
//              must be one of the following constants:
//                  CS_REST_RULE_LAST_REST
//                  CS_REST_RULE_DAY_ONLY
//                  CS_REST_RULE_NIGHT_ONLY
//                  CS_REST_RULE_NO_ARMOUR
//                  CS_REST_RULE_NO_WEAPONS
//                  CS_REST_RULE_NO_BEDROLL
//                  CS_REST_RULE_NO_RATIONS
//                  CS_REST_RULE_USER_1
//                  CS_REST_RULE_USER_2
//                  CS_REST_RULE_USER_3
//                  CS_REST_RULE_USER_4
//                  CS_REST_RULE_USER_5
//                  CS_REST_RULE_USER_6
//                  CS_REST_RULE_USER_7
//                  CS_REST_RULE_USER_8
//                  CS_REST_RULE_USER_9
//                  CS_REST_RULE_USER_10
//                  CS_REST_RULE_USER_11
//                  CS_REST_RULE_USER_12
//                  CS_REST_RULE_USER_13
//                  CS_REST_RULE_USER_14
//                  CS_REST_RULE_USER_15
//                  CS_REST_RULE_USER_16
// state        TRUE if the rule is enabled, which means the rest subsystem
//              will evaluate the rule when determining whether a player is
//              allowed to rest, otherwise FALSE.
// pc           The player who is resting. This value will default to the
//              current object, which will always be the resting player when
//              this function is called from a user script.
// returns      TRUE if the specified rule has been enabled in the rest
//              subsystem configuration, or FALSE if the rule is not enabled.
int cs_rest_GetIsRuleEnabled(int rule, object pc=OBJECT_SELF);

// Determine the current state of a specific rest rule, either a builtin rule
// or a user rule. The builtin rules are evaluated before the user script is
// executed. User rules are provided specifically for use by builders, will
// always be FALSE initially, and will never be changed by the rest subsystem.
//
// This function may only be used within the CS_REST_RULE_CHECK execution
// point for a user script.
//
// rule         The specific rest rule that is to be checked. This value
//              must be one of the following constants:
//                  CS_REST_RULE_LAST_REST
//                  CS_REST_RULE_DAY_ONLY
//                  CS_REST_RULE_NIGHT_ONLY
//                  CS_REST_RULE_NO_ARMOUR
//                  CS_REST_RULE_NO_WEAPONS
//                  CS_REST_RULE_NO_BEDROLL
//                  CS_REST_RULE_NO_RATIONS
//                  CS_REST_RULE_USER_1
//                  CS_REST_RULE_USER_2
//                  CS_REST_RULE_USER_3
//                  CS_REST_RULE_USER_4
//                  CS_REST_RULE_USER_5
//                  CS_REST_RULE_USER_6
//                  CS_REST_RULE_USER_7
//                  CS_REST_RULE_USER_8
//                  CS_REST_RULE_USER_9
//                  CS_REST_RULE_USER_10
//                  CS_REST_RULE_USER_11
//                  CS_REST_RULE_USER_12
//                  CS_REST_RULE_USER_13
//                  CS_REST_RULE_USER_14
//                  CS_REST_RULE_USER_15
//                  CS_REST_RULE_USER_16
// pc           The player who is resting. This value will default to the
//              current object, which will always be the resting player when
//              this function is called from a user script.
// returns      TRUE if the rule has been evaluated and the player does not
//              satisfy it (which will prevent the player from resting),
//              otherwise FALSE (which will allow the player to rest).
int cs_rest_GetRule(int rule, object pc=OBJECT_SELF);

// Set or clear the specified rule for a resting player. When the rule is
// set, i.e. the state is TRUE, the player will not be permitted to rest.
// If any rule at all is set to TRUE, the player will be prevented from
// resting. This function may be used to change the state of one of the
// builtin rest rules, or a user rule. User rules are provided specifically
// for use by builders.
//
// If a builtin rest rule is not enabled in the configuration for the resting
// subsystem, then changing the state of that rule will have no effect. The
// user rules are always considered enabled.
//
// This function may only be used within the CS_REST_RULE_CHECK execution
// point for a user script.
//
// rule         The specific rest rule that is to be changed. This value
//              must be one of the following constants:
//                  CS_REST_RULE_LAST_REST
//                  CS_REST_RULE_DAY_ONLY
//                  CS_REST_RULE_NIGHT_ONLY
//                  CS_REST_RULE_NO_ARMOUR
//                  CS_REST_RULE_NO_WEAPONS
//                  CS_REST_RULE_NO_BEDROLL
//                  CS_REST_RULE_NO_RATIONS
//                  CS_REST_RULE_USER_1
//                  CS_REST_RULE_USER_2
//                  CS_REST_RULE_USER_3
//                  CS_REST_RULE_USER_4
//                  CS_REST_RULE_USER_5
//                  CS_REST_RULE_USER_6
//                  CS_REST_RULE_USER_7
//                  CS_REST_RULE_USER_8
//                  CS_REST_RULE_USER_9
//                  CS_REST_RULE_USER_10
//                  CS_REST_RULE_USER_11
//                  CS_REST_RULE_USER_12
//                  CS_REST_RULE_USER_13
//                  CS_REST_RULE_USER_14
//                  CS_REST_RULE_USER_15
//                  CS_REST_RULE_USER_16
// state        TRUE if the rule is to be set, which will disallow resting,
//              otherwise FALSE to allow resting.
// pc           The player who is resting. This value will default to the
//              current object, which will always be the resting player when
//              this function is called from a user script.
void cs_rest_SetRule(int rule, int state, object pc=OBJECT_SELF);

// Abort resting for a specific player even if that player has satisfied all
// enabled rest rules.
//
// This function may only be used within the CS_REST_START_RESTING execution
// point for a user script.
//
// pc           The player who is resting. This value will default to the
//              current object, which will always be the resting player when
//              this function is called from a user script.
void cs_rest_SetAbort(object pc=OBJECT_SELF);

// Damage the specified creature by a specific amount, bypassing any damage
// resistance, damage reduction, immunities or vulnerabilities that the
// target may possess.
//
// pc           The creature to be damaged.
// damage       The number of hit points of damage to be applied.
void cs_rest_ApplyGuaranteedDamage(object pc, int damage);


//----------------------------------------------------------------------------
// Double integer precision date arithmetic support.
const int cs_rest_secondsPerMinute = 60;
int cs_rest_secondsPerHour = FloatToInt(HoursToSeconds(1));
const int cs_rest_hoursPerDay = 24;
int cs_rest_secondsPerDay = cs_rest_hoursPerDay * cs_rest_secondsPerHour;
const int cs_rest_daysPerMonth = 28;
const int cs_rest_daysPerYear = 336;
struct cs_rest_time cs_rest_GetCurrentTime(struct cs_rest_config cfg) {
    struct cs_rest_time time;
    time.days = GetCalendarYear() * cs_rest_daysPerYear;
    time.days += GetCalendarMonth() * cs_rest_daysPerMonth;
    time.days += GetCalendarDay();
    time.seconds = GetTimeHour() * cs_rest_secondsPerHour;
    time.seconds += GetTimeMinute() * cs_rest_secondsPerMinute;
    time.seconds += GetTimeSecond();
    return time;
}

// Add b to a.
struct cs_rest_time cs_rest_AddTime(struct cs_rest_time a, struct cs_rest_time b) {
    a.seconds += b.seconds;
    if (a.seconds >= cs_rest_secondsPerDay) {
        a.seconds -= cs_rest_secondsPerDay;
        a.days++;
    }
    a.days += b.days;
    return a;
}

// Subtract b from a.
struct cs_rest_time cs_rest_SubtractTime(struct cs_rest_time a, struct cs_rest_time b) {
    a.seconds -= b.seconds;
    if (a.seconds < 0) {
        a.seconds += cs_rest_secondsPerDay;
        a.days--;
    }
    a.days -= b.days;
    return a;
}

// Determine if a is greater than b.
int cs_rest_GetIsTimeGreater(struct cs_rest_time a, struct cs_rest_time b) {
    if (a.days > b.days) return TRUE;
    if (a.days < b.days) return FALSE;
    if (a.seconds > b.seconds) return TRUE;
    return FALSE;
}

// Determine if a is less than b.
int cs_rest_GetIsTimeLess(struct cs_rest_time a, struct cs_rest_time b) {
    if (a.days < b.days) return TRUE;
    if (a.days > b.days) return FALSE;
    if (a.seconds < b.seconds) return TRUE;
    return FALSE;
}

// Determine whether a equals b.
int cs_rest_GetIsTimeEqual(struct cs_rest_time a, struct cs_rest_time b) {
    if ((a.days == b.days) && (a.seconds == b.seconds)) return TRUE;
    return FALSE;
}

// Convert a time to a string representation.
string cs_rest_TimeToString(struct cs_rest_time time) {
    return IntToString(time.days) + "." + IntToString(time.seconds);
}

// Construct a time value from individual values.
struct cs_rest_time cs_rest_Time(int days, int seconds) {
    struct cs_rest_time time;
    time.days = days;
    time.seconds = seconds;
    return time;
}

//----------------------------------------------------------------------------
void cs_rest_ShowConfig(struct cs_rest_config cfg) {
    if (cs_dbg_GetIsEnabled() || GetIsObjectValid(cfg.debug)) {
        // Data generated within the rest system.
        cs_dbg_Trace(
            "cfg.permitted: " + IntToString(cfg.permitted),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.ruleFlags: " + IntToString(cfg.ruleFlags),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.started: " + IntToString(cfg.started),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.savedHitPoints: " + IntToString(cfg.savedHitPoints),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.profile: " + cfg.profile,
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.overrideProfile: " + cfg.overrideProfile,
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.trigger: " + GetName(cfg.trigger),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.lastRest: " +
            cs_rest_TimeToString(cs_rest_Time(cfg.lastRestDays, cfg.lastRestSeconds)),
            cfg.debug
        );

        // Configuration data.
        cs_dbg_Trace(
            "cfg.debug: " + ObjectToString(cfg.debug),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.enabled: " + IntToString(cfg.enabled),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.neverPermitted: " + IntToString(cfg.neverPermitted),
            cfg.debug
        );
//        cs_dbg_Trace(
//            "cfg.allowed: " + IntToString(cfg.allowed),
//            cfg.debug
//        );
        cs_dbg_Trace(
            "cfg.defaultProfile: " + cfg.defaultProfile,
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.limit: " + IntToString(cfg.limit),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.use3Ed: " + IntToString(cfg.use3Ed),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.noArmour: " + IntToString(cfg.noArmour),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.noWeapons: " + IntToString(cfg.noWeapons),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.useBedroll: " + IntToString(cfg.useBedroll),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.bedrollTag: " + cfg.bedrollTag,
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.bedrollMultiplier: " + FloatToString(cfg.bedrollMultiplier),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.useRations: " + IntToString(cfg.useRations),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.rationsTag: " + cfg.rationsTag,
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.rationsMultiplier: " + FloatToString(cfg.rationsMultiplier),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.dayMode: " + IntToString(cfg.dayMode),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.dayStart: " + IntToString(cfg.dayStart),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.dayEnd: " + IntToString(cfg.dayEnd),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.multiplier: " + FloatToString(cfg.multiplier),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.fadeToBlack: " + IntToString(cfg.fadeToBlack),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.noMessages: " + IntToString(cfg.noMessages),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.useConBonus: " + IntToString(cfg.useConBonus),
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.userScript: " + cfg.userScript,
            cfg.debug
        );
        cs_dbg_Trace(
            "cfg.effects: " + cfg.effects,
            cfg.debug
        );
    }
}

//----------------------------------------------------------------------------
struct cs_rest_config cs_rest_GetConfig(object container) {
    struct cs_rest_config cfg;
    cfg.debug = GetLocalObject(container, CS_REST_VAR_DEBUG);

    cs_dbg_Enter("cs_rest_GetConfig(" + GetName(container) + ")", cfg.debug);

    // Data generated within the rest system.
    cfg.permitted = GetLocalInt(container, CS_REST_VAR_PERMITTED);
    cfg.ruleFlags = GetLocalInt(container, CS_REST_VAR_RULE_FLAGS);
    cfg.started = GetLocalInt(container, CS_REST_VAR_STARTED);
    cfg.savedHitPoints = GetLocalInt(container, CS_REST_VAR_SAVE_HP);
    cfg.profile = GetLocalString(container, CS_REST_VAR_PLAYER_PROFILE);
    cfg.overrideProfile = GetLocalString(container, CS_REST_VAR_OVERRIDE_PROFILE);
    cfg.trigger = GetLocalObject(container, CS_REST_VAR_TRIGGER);
    cfg.lastRestDays = GetLocalInt(container, CS_REST_VAR_LAST_REST_DAYS);
    cfg.lastRestSeconds = GetLocalInt(container, CS_REST_VAR_LAST_REST_SECONDS);

    // Configuration data.
    cfg.enabled = GetLocalInt(container, CS_REST_VAR_ENABLE);
    cfg.neverPermitted = GetLocalInt(container, CS_REST_VAR_NEVER_PERMITTED);
//    cfg.allowed = GetLocalInt(container, CS_REST_VAR_PLAYER_ALLOWED);
    cfg.defaultProfile = GetLocalString(container, CS_REST_VAR_DEFAULT_PROFILE);
    cfg.limit = GetLocalInt(container, CS_REST_VAR_TIME_LIMIT);
    cfg.use3Ed = GetLocalInt(container, CS_REST_VAR_HP_3ED);
    cfg.noArmour = GetLocalInt(container, CS_REST_VAR_NO_ARMOUR);
    cfg.noWeapons = GetLocalInt(container, CS_REST_VAR_NO_WEAPONS);
    cfg.useBedroll = GetLocalInt(container, CS_REST_VAR_BEDROLL_IN_USE);
    cfg.bedrollTag = GetLocalString(container, CS_REST_VAR_BEDROLL_TAG);
    cfg.bedrollMultiplier = GetLocalFloat(container, CS_REST_VAR_BEDROLL_MULTIPLIER);
    cfg.useRations = GetLocalInt(container, CS_REST_VAR_RATIONS_IN_USE);
    cfg.rationsTag = GetLocalString(container, CS_REST_VAR_RATIONS_TAG);
    cfg.rationsMultiplier = GetLocalFloat(container, CS_REST_VAR_RATIONS_MULTIPLIER);
    cfg.dayMode = GetLocalInt(container, CS_REST_VAR_DAY_MODE);
    cfg.dayStart = GetLocalInt(container, CS_REST_VAR_DAY_START);
    cfg.dayEnd = GetLocalInt(container, CS_REST_VAR_DAY_END);
    cfg.multiplier = GetLocalFloat(container, CS_REST_VAR_MULTIPLIER);
    cfg.fadeToBlack = GetLocalInt(container, CS_REST_VAR_FADE_TO_BLACK);
    cfg.noMessages = GetLocalInt(container, CS_REST_VAR_NO_MESSAGES);
    cfg.useConBonus = GetLocalInt(container, CS_REST_VAR_CON_BONUS);
    cfg.userScript = GetLocalString(container, CS_REST_VAR_USER_SCRIPT);
    cfg.effects = GetLocalString(container, CS_REST_VAR_EFFECTS);
    if (cfg.bedrollMultiplier < 0.0f) {
        cfg.bedrollMultiplier = 0.5f;
    }
    if (cfg.multiplier <= 0.0f) {
        cfg.multiplier = 1.0f;
    }

    cs_rest_ShowConfig(cfg);

    cs_dbg_Exit("cs_rest_GetConfig", cfg.debug);
    return cfg;
}

//----------------------------------------------------------------------------
void cs_rest_SetConfig(object container, struct cs_rest_config cfg) {
    cs_dbg_Enter("cs_rest_SetConfig(" + GetName(container) + ")", cfg.debug);

    cs_rest_ShowConfig(cfg);

    if (cfg.bedrollMultiplier < 0.0f) {
        cfg.bedrollMultiplier = 0.5f;
    }
    if (cfg.multiplier <= 0.0f) {
        cfg.multiplier = 1.0f;
    }

    // Data generated within the rest system.
    SetLocalInt(container, CS_REST_VAR_PERMITTED, cfg.permitted);
    SetLocalInt(container, CS_REST_VAR_RULE_FLAGS, cfg.ruleFlags);
    SetLocalInt(container, CS_REST_VAR_STARTED, cfg.started);
    SetLocalInt(container, CS_REST_VAR_SAVE_HP, cfg.savedHitPoints);
    SetLocalString(container, CS_REST_VAR_PLAYER_PROFILE, cfg.profile);
    SetLocalString(container, CS_REST_VAR_OVERRIDE_PROFILE, cfg.overrideProfile);
    SetLocalObject(container, CS_REST_VAR_TRIGGER, cfg.trigger);
    SetLocalInt(container, CS_REST_VAR_LAST_REST_DAYS, cfg.lastRestDays);
    SetLocalInt(container, CS_REST_VAR_LAST_REST_SECONDS, cfg.lastRestSeconds);

    // Configuration data.
    SetLocalObject(container, CS_REST_VAR_DEBUG, cfg.debug);
    SetLocalInt(container, CS_REST_VAR_ENABLE, cfg.enabled);
    SetLocalInt(container, CS_REST_VAR_NEVER_PERMITTED, cfg.neverPermitted);
//    SetLocalInt(container, CS_REST_VAR_PLAYER_ALLOWED, cfg.allowed);
    SetLocalString(container, CS_REST_VAR_DEFAULT_PROFILE, cfg.defaultProfile);
    SetLocalInt(container, CS_REST_VAR_TIME_LIMIT, cfg.limit);
    SetLocalInt(container, CS_REST_VAR_HP_3ED, cfg.use3Ed);
    SetLocalInt(container, CS_REST_VAR_NO_ARMOUR, cfg.noArmour);
    SetLocalInt(container, CS_REST_VAR_NO_WEAPONS, cfg.noWeapons);
    SetLocalInt(container, CS_REST_VAR_BEDROLL_IN_USE, cfg.useBedroll);
    SetLocalString(container, CS_REST_VAR_BEDROLL_TAG, cfg.bedrollTag);
    SetLocalFloat(container, CS_REST_VAR_BEDROLL_MULTIPLIER, cfg.bedrollMultiplier);
    SetLocalInt(container, CS_REST_VAR_RATIONS_IN_USE, cfg.useRations);
    SetLocalString(container, CS_REST_VAR_RATIONS_TAG, cfg.rationsTag);
    SetLocalFloat(container, CS_REST_VAR_RATIONS_MULTIPLIER, cfg.rationsMultiplier);
    SetLocalInt(container, CS_REST_VAR_DAY_MODE, cfg.dayMode);
    SetLocalInt(container, CS_REST_VAR_DAY_START, cfg.dayStart);
    SetLocalInt(container, CS_REST_VAR_DAY_END, cfg.dayEnd);
    SetLocalFloat(container, CS_REST_VAR_MULTIPLIER, cfg.multiplier);
    SetLocalInt(container, CS_REST_VAR_FADE_TO_BLACK, cfg.fadeToBlack);
    SetLocalInt(container, CS_REST_VAR_NO_MESSAGES, cfg.noMessages);
    SetLocalInt(container, CS_REST_VAR_CON_BONUS, cfg.useConBonus);
    SetLocalString(container, CS_REST_VAR_USER_SCRIPT, cfg.userScript);
    SetLocalString(container, CS_REST_VAR_EFFECTS, cfg.effects);

    cs_dbg_Exit("cs_rest_SetConfig", cfg.debug);
}

//----------------------------------------------------------------------------
void cs_rest_DeleteConfig(object container) {
    object debug = GetLocalObject(container, CS_REST_VAR_DEBUG);

    cs_dbg_Enter("cs_rest_DeleteConfig(" + GetName(container) + ")", debug);

    // Data generated within the rest system and used only when a player is
    // actually resting. It is not necessary to store this data within a
    // persistence mechanism since should either a player log out or the
    // server crash, the player won't be resting anymore and so this data
    // will be superfluous.
    DeleteLocalInt(container, CS_REST_VAR_PERMITTED);
    DeleteLocalInt(container, CS_REST_VAR_RULE_FLAGS);
    DeleteLocalString(container, CS_REST_VAR_OVERRIDE_PROFILE);
    DeleteLocalInt(container, CS_REST_VAR_STARTED);
    DeleteLocalInt(container, CS_REST_VAR_SAVE_HP);

    // These variables are used by the resting system to track the current
    // state of the player with regard to resting policies, however since
    // the values are set through trigger scripts, it is not necessary to
    // store the data in a persistence mechanism as it will simply be
    // recreated when the player logs in again and reenters the trigger.
    // The following variables are deleted elsewhere and are listed
    // here merely for completion. These deletions should not be
    // uncommented.
//    DeleteLocalString(container, CS_REST_VAR_PLAYER_PROFILE);
//    DeleteLocalObject(container, CS_REST_VAR_TRIGGER);

    // These variables are maintained across rests and constitute the
    // persistent data within the resting subsystem. Should full persistence
    // be desired, this data should be stored for each player and restored
    // to each player when they log in. The following variables are deleted
    // elsewhere if necessary and are listed here merely for completion.
    // These deletions should not be uncommented.
//    DeleteLocalInt(container, CS_REST_VAR_LAST_REST_DAYS);
//    DeleteLocalInt(container, CS_REST_VAR_LAST_REST_SECONDS);

    // Configuration data. This data is generated from the configuration
    // containers each time a player rests and so it is not necessary for
    // any of this data to be stored in a persistence mechanism.
    DeleteLocalObject(container, CS_REST_VAR_DEBUG);
    DeleteLocalInt(container, CS_REST_VAR_ENABLE);
    DeleteLocalInt(container, CS_REST_VAR_NEVER_PERMITTED);
//    DeleteLocalInt(container, CS_REST_VAR_PLAYER_ALLOWED);
    DeleteLocalString(container, CS_REST_VAR_DEFAULT_PROFILE);
    DeleteLocalInt(container, CS_REST_VAR_TIME_LIMIT);
    DeleteLocalInt(container, CS_REST_VAR_HP_3ED);
    DeleteLocalInt(container, CS_REST_VAR_NO_ARMOUR);
    DeleteLocalInt(container, CS_REST_VAR_NO_WEAPONS);
    DeleteLocalInt(container, CS_REST_VAR_BEDROLL_IN_USE);
    DeleteLocalString(container, CS_REST_VAR_BEDROLL_TAG);
    DeleteLocalFloat(container, CS_REST_VAR_BEDROLL_MULTIPLIER);
    DeleteLocalInt(container, CS_REST_VAR_RATIONS_IN_USE);
    DeleteLocalString(container, CS_REST_VAR_RATIONS_TAG);
    DeleteLocalFloat(container, CS_REST_VAR_RATIONS_MULTIPLIER);
    DeleteLocalInt(container, CS_REST_VAR_DAY_MODE);
    DeleteLocalInt(container, CS_REST_VAR_DAY_START);
    DeleteLocalInt(container, CS_REST_VAR_DAY_END);
    DeleteLocalFloat(container, CS_REST_VAR_MULTIPLIER);
    DeleteLocalInt(container, CS_REST_VAR_FADE_TO_BLACK);
    DeleteLocalInt(container, CS_REST_VAR_NO_MESSAGES);
    DeleteLocalInt(container, CS_REST_VAR_CON_BONUS);
    DeleteLocalString(container, CS_REST_VAR_USER_SCRIPT);
    DeleteLocalString(container, CS_REST_VAR_EFFECTS);

    // Custom text messages.
    DeleteLocalString(container, CS_REST_VAR_START_TEXT);
    DeleteLocalString(container, CS_REST_VAR_FINISH_TEXT);
    DeleteLocalString(container, CS_REST_VAR_CANCEL_TEXT);
    DeleteLocalString(container, CS_REST_VAR_CANNOT_TEXT);
    DeleteLocalString(container, CS_REST_VAR_TOO_SOON_TEXT);
    DeleteLocalString(container, CS_REST_VAR_DAY_ONLY_TEXT);
    DeleteLocalString(container, CS_REST_VAR_NIGHT_ONLY_TEXT);
    DeleteLocalString(container, CS_REST_VAR_NO_ARMOUR_TEXT);
    DeleteLocalString(container, CS_REST_VAR_NO_WEAPON_TEXT);
    DeleteLocalString(container, CS_REST_VAR_BEDROLL_RUINED_TEXT);
    DeleteLocalString(container, CS_REST_VAR_NOT_COMFORTABLE_TEXT);
    DeleteLocalString(container, CS_REST_VAR_ENTER_REST_TEXT);
    DeleteLocalString(container, CS_REST_VAR_EXIT_REST_TEXT);
    DeleteLocalString(container, CS_REST_VAR_UNSAFE_TEXT);
    DeleteLocalString(container, CS_REST_VAR_ENTER_NO_REST_TEXT);
    DeleteLocalString(container, CS_REST_VAR_EXIT_NO_REST_TEXT);
    DeleteLocalString(container, CS_REST_VAR_NO_BEDROLL_TEXT);

    cs_dbg_Exit("cs_rest_DeleteConfig", debug);
}

//----------------------------------------------------------------------------
string cs_rest_GetProfile(object pc) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    string profile = GetLocalString(pc, CS_REST_VAR_PLAYER_PROFILE);
    cs_dbg_Trace(
        "cs_rest_GetProfile(" + GetName(pc) + "): " + profile,
        debug
    );
    return profile;
}

//----------------------------------------------------------------------------
void cs_rest_SetProfile(object pc, string profile) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    cs_dbg_Trace(
        "cs_rest_SetProfile(" + GetName(pc) + "): " + profile,
        debug
    );
    SetLocalString(pc, CS_REST_VAR_PLAYER_PROFILE, profile);
}

//----------------------------------------------------------------------------
string cs_rest_GetOverrideProfile(object pc) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    string profile = GetLocalString(pc, CS_REST_VAR_OVERRIDE_PROFILE);
    cs_dbg_Trace(
        "cs_rest_GetOverrideProfile(" + GetName(pc) + "): " + profile,
        debug
    );
    return profile;
}

//----------------------------------------------------------------------------
void cs_rest_SetOverrideProfile(object pc, string profile) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    cs_dbg_Trace(
        "cs_rest_SetOverrideProfile(" + GetName(pc) + "): " + profile,
        debug
    );
    SetLocalString(pc, CS_REST_VAR_OVERRIDE_PROFILE, profile);
}

//----------------------------------------------------------------------------
void cs_rest_DeleteProfile(object pc) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    cs_dbg_Trace(
        "cs_rest_DeleteProfile(" + GetName(pc) + ")",
        debug
    );
    DeleteLocalString(pc, CS_REST_VAR_PLAYER_PROFILE);
}

//----------------------------------------------------------------------------
void cs_rest_SetUserScriptState(object pc, int state) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    cs_dbg_Trace(
        "cs_rest_SetUserScriptState(" + GetName(pc) + ", " + IntToString(state) + ")",
        debug
    );
    SetLocalInt(pc, CS_REST_VAR_USER_SCRIPT_STATE, state);
}

//----------------------------------------------------------------------------
int cs_rest_GetUserScriptState(object pc=OBJECT_SELF) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    int state = GetLocalInt(pc, CS_REST_VAR_USER_SCRIPT_STATE);
    cs_dbg_Trace(
        "cs_rest_GetUserScriptState(" + GetName(pc) + "): " + IntToString(state),
        debug
    );
    return state;
}

//----------------------------------------------------------------------------
void cs_rest_DeleteUserScriptState(object pc) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    cs_dbg_Trace(
        "cs_rest_DeleteUserScriptState(" + GetName(pc) + ")",
        debug
    );
    DeleteLocalString(pc, CS_REST_VAR_USER_SCRIPT_STATE);
}

//----------------------------------------------------------------------------
int cs_rest_GetIsRuleEnabled(int rule, object pc=OBJECT_SELF) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    int state = TRUE;
    switch(rule) {
    case CS_REST_RULE_LAST_REST:
        state = (GetLocalInt(pc, CS_REST_VAR_TIME_LIMIT) > 0);
        break;
    case CS_REST_RULE_DAY_ONLY:
        state = (GetLocalInt(pc, CS_REST_VAR_DAY_MODE) == CS_REST_DAY_ONLY);
        break;
    case CS_REST_RULE_NIGHT_ONLY:
        state = (GetLocalInt(pc, CS_REST_VAR_DAY_MODE) == CS_REST_NIGHT_ONLY);
        break;
    case CS_REST_RULE_NO_ARMOUR:
        state = GetLocalInt(pc, CS_REST_VAR_NO_ARMOUR);
        break;
    case CS_REST_RULE_NO_WEAPONS:
        state = GetLocalInt(pc, CS_REST_VAR_NO_WEAPONS);
        break;
    case CS_REST_RULE_NO_BEDROLL:
        state = GetLocalInt(pc, CS_REST_VAR_BEDROLL_IN_USE);
        break;
    case CS_REST_RULE_NO_RATIONS:
        state = GetLocalInt(pc, CS_REST_VAR_RATIONS_IN_USE);
        break;
    }
    cs_dbg_Trace(
        "cs_rest_GetIsRuleEnabled(" +
        IntToString(rule) + ", " +
        GetName(pc) + "): " +
        IntToString(state),
        debug
    );
    return state;
}

//----------------------------------------------------------------------------
int cs_rest_GetRule(int rule, object pc=OBJECT_SELF) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    int flags = GetLocalInt(pc, CS_REST_VAR_RULE_FLAGS);
    int state = flags & rule;
    cs_dbg_Trace(
        "cs_rest_GetRule(" +
        IntToString(rule) + ", " +
        GetName(pc) + "): " +
        IntToString(state),
        debug
    );
    return state;
}

//----------------------------------------------------------------------------
void cs_rest_SetRule(int rule, int state, object pc=OBJECT_SELF) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    cs_dbg_Enter(
        "cs_rest_SetRule(" +
        IntToString(rule) + ", " +
        IntToString(state) + ", " +
        GetName(pc) + ")",
        debug
    );
    if (cs_rest_GetIsRuleEnabled(rule, pc)) {
        int flags = GetLocalInt(pc, CS_REST_VAR_RULE_FLAGS);
        cs_dbg_Trace("flags before: " + IntToHexString(flags));
        if (state) {
            // We want to set the flag.
            flags |= rule;
        }
        else {
            // We want to clear the flag.
            flags &= ~rule;
        }
        cs_dbg_Trace("flags after: " + IntToHexString(flags));
        SetLocalInt(pc, CS_REST_VAR_RULE_FLAGS, flags);
    }
    else {
        cs_dbg_Trace("disabled rule");
    }
    cs_dbg_Exit("cs_rest_SetRule", debug);
}

//----------------------------------------------------------------------------
void cs_rest_SetAbort(object pc=OBJECT_SELF) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    cs_dbg_Trace(
        "cs_rest_SetAbort(" +
        GetName(pc) + ")",
        debug
    );
    SetLocalInt(pc, CS_REST_VAR_PERMITTED, FALSE);
}

//----------------------------------------------------------------------------
struct cs_rest_time cs_rest_GetLastRestTime(object pc) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    struct cs_rest_time time = cs_rest_Time(
        GetLocalInt(pc, CS_REST_VAR_LAST_REST_DAYS),
        GetLocalInt(pc, CS_REST_VAR_LAST_REST_SECONDS)
    );
    cs_dbg_Trace(
        "cs_rest_GetLastRestTime(" + GetName(pc) + "): " +
        cs_rest_TimeToString(time),
        debug
    );
    return time;
}

//----------------------------------------------------------------------------
void cs_rest_SetLastRestTime(object pc, struct cs_rest_time time) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    cs_dbg_Trace(
        "cs_rest_SetLastRestTime(" + GetName(pc) + "): " +
        cs_rest_TimeToString(time),
        debug
    );
    SetLocalInt(pc, CS_REST_VAR_LAST_REST_DAYS, time.days);
    SetLocalInt(pc, CS_REST_VAR_LAST_REST_SECONDS, time.seconds);
}

//----------------------------------------------------------------------------
object cs_rest_GetTriggeringObject(object pc) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    object trigger = GetLocalObject(pc, CS_REST_VAR_TRIGGER);
    cs_dbg_Trace(
        "cs_rest_GetTriggeringObject(" + GetName(pc) + "): " +
        GetName(trigger),
        debug
    );
    return trigger;
}

//----------------------------------------------------------------------------
void cs_rest_SetTriggeringObject(object pc, object trigger) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    cs_dbg_Trace(
        "cs_rest_SetTriggeringObject(" + GetName(pc) + "): " +
        GetName(trigger),
        debug
    );
    SetLocalObject(pc, CS_REST_VAR_TRIGGER, trigger);
}

//----------------------------------------------------------------------------
void cs_rest_DeleteTriggeringObject(object pc) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    cs_dbg_Trace(
        "cs_rest_DeleteTriggeringObject(" + GetName(pc) + ")",
        debug
    );
    DeleteLocalObject(pc, CS_REST_VAR_TRIGGER);
}

//----------------------------------------------------------------------------
string cs_rest_GetState(object pc) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    string state = "";
    struct cs_rest_time lastRest = cs_rest_GetLastRestTime(pc);
    state += IntToString(lastRest.days);
    state += ":";
    state += IntToString(lastRest.seconds);
    cs_dbg_Trace("cs_rest_GetState: " + state, debug);
    return state;
}

//----------------------------------------------------------------------------
void cs_rest_SetState(object pc, string state, int timeOffset=0) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    cs_dbg_Trace(
        "cs_rest_SetState(" +
        GetName(pc) + ", " +
        state + ", " +
        IntToString(timeOffset) + ")",
        debug
    );
    cs_tkn_SetTokenString(state, ":");
    int lastRestDays = StringToInt(cs_tkn_GetNextToken());
    int lastRestSeconds = StringToInt(cs_tkn_GetNextToken());
    struct cs_rest_time lastRest = cs_rest_Time(lastRestDays, lastRestSeconds);
    if (timeOffset != 0) {
        lastRest = cs_rest_AddTime(lastRest, cs_rest_Time(0, timeOffset));
    }
    cs_rest_SetLastRestTime(pc, lastRest);
}

//----------------------------------------------------------------------------
// Shamelessly stolen from Mermut :)
int cs_rest_GetBaseAC(object armour, struct cs_rest_config cfg) {
    int bonusAC = 0;
    if (GetItemHasItemProperty(armour, ITEM_PROPERTY_AC_BONUS)) {
        itemproperty prop = GetFirstItemProperty(armour);
        while (GetIsItemPropertyValid(prop)) {
            if (GetItemPropertyType(prop) == ITEM_PROPERTY_AC_BONUS) {
                bonusAC = GetItemPropertyCostTableValue(prop);
                break;
            }
            prop = GetNextItemProperty(armour);
        }
    }

    int baseAC = GetItemACValue(armour) - bonusAC;
    cs_dbg_Trace(
        "cs_rest_GetBaseAC(" + GetName(armour) + "): " +
        IntToString(baseAC),
        cfg.debug
    );
    return baseAC;
}

//----------------------------------------------------------------------------
int cs_rest_GetIsWearingHelm(object pc, struct cs_rest_config cfg) {
    int result = FALSE;
    int head = GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_HEAD, pc));
    if (head == BASE_ITEM_HELMET) {
        result = TRUE;
    }
    cs_dbg_Trace(
        "cs_rest_GetIsWearingHelm(" + GetName(pc) + "): " +
        IntToString(result),
        cfg.debug
    );
    return result;
}

//----------------------------------------------------------------------------
int cs_rest_GetIsWearingArmour(object pc, struct cs_rest_config cfg) {
    int result = FALSE;
    object armour = GetItemInSlot(INVENTORY_SLOT_CHEST, pc);
//    if (GetItemACValue(armour) > 5) {
    if (cs_rest_GetBaseAC(armour, cfg) > cfg.noArmour) {
        result = TRUE;
    }
    cs_dbg_Trace(
        "cs_rest_GetIsWearingArmour(" + GetName(pc) + "): " +
        IntToString(result),
        cfg.debug
    );
    return result;
}

//----------------------------------------------------------------------------
int cs_rest_GetIsArmed(object pc, struct cs_rest_config cfg) {
    int result = 0;
    if (GetIsObjectValid(pc)) {
        int hand1 = GetBaseItemType(
            GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, pc)
        );
        if (hand1 != BASE_ITEM_INVALID) {
            result++;
        }
        int hand2 = GetBaseItemType(
            GetItemInSlot(INVENTORY_SLOT_LEFTHAND, pc)
        );
        if (!((hand2 == BASE_ITEM_INVALID) ||
              (hand2 == BASE_ITEM_TORCH) ||
              (hand2 == BASE_ITEM_SMALLSHIELD) ||
              (hand2 == BASE_ITEM_LARGESHIELD) ||
              (hand2 == BASE_ITEM_TOWERSHIELD))
        ) {
            result++;
        }
    }
    cs_dbg_Trace(
        "cs_rest_GetIsArmed(" + GetName(pc) + "): " + IntToString(result),
        cfg.debug
    );
    return result;
}

//----------------------------------------------------------------------------
int cs_rest_GetIsShieldEquipped(object pc, struct cs_rest_config cfg) {
    int result = 0;
    if (GetIsObjectValid(pc)) {
        int hand2 = GetBaseItemType(
            GetItemInSlot(INVENTORY_SLOT_LEFTHAND, pc)
        );
        if ((hand2 == BASE_ITEM_SMALLSHIELD) ||
            (hand2 == BASE_ITEM_LARGESHIELD) ||
            (hand2 == BASE_ITEM_TOWERSHIELD)
        ) {
            result = TRUE;
        }
    }
    cs_dbg_Trace(
        "cs_rest_GetIsShieldEquipped(" + GetName(pc) + "): " +
        IntToString(result),
        cfg.debug
    );
    return result;
}

//----------------------------------------------------------------------------
struct cs_rest_config cs_rest_SetRuleFlag(struct cs_rest_config cfg, int rule, int value) {
    cs_dbg_Enter(
        "cs_rest_SetRuleFlag(" +
        IntToString(rule) + ", " +
        IntToString(value) + ")",
        cfg.debug
    );
    cs_dbg_Trace("before flags: " + IntToString(cfg.ruleFlags));
    if (value) {
        // We want to set the flag.
        cfg.ruleFlags |= rule;
    }
    else {
        // We want to clear the flag.
        cfg.ruleFlags &= ~rule;
    }
    cs_dbg_Trace("after flags: " + IntToString(cfg.ruleFlags));
    cs_dbg_Exit("cs_rest_SetRuleFlag");
    return cfg;
}

//----------------------------------------------------------------------------
int cs_rest_GetRuleFlag(struct cs_rest_config cfg, int rule) {
    int flag = cfg.ruleFlags &= rule;
    cs_dbg_Trace("cs_rest_GetRuleFlag(" + IntToString(rule) +"): " + IntToString(flag));
    return flag;
}

//----------------------------------------------------------------------------
// Stores the object to be destroyed when a bedroll is consumed.
object bedrollItem = OBJECT_INVALID;
// Set to TRUE when a bedroll has been used but not consumed.
int bedrollUsed = FALSE;
// Stored the object to be destroyed when rations are to be consumed.
object rationsItem = OBJECT_INVALID;

struct cs_rest_config cs_rest_GetIsRestPermitted(
    object pc,
    struct cs_rest_config cfg
) {
    // By default, resting is permitted and no rule flags are set.
    cfg.permitted = TRUE;
    cfg.ruleFlags = 0;

    // Check whether this creature is ever allowed to rest at all.
    if (cfg.neverPermitted) {
        cfg.permitted = FALSE;
    }

    // Check for a rest time limit.
    if (cfg.permitted && (cfg.limit > 0)) {
        // Determine the current time.
        struct cs_rest_time currentTime = cs_rest_GetCurrentTime(cfg);

        // Determine the time at which resting is next available by adding
        // the current rest limit to the last rest time.
        struct cs_rest_time nextRest = cs_rest_Time(
            cfg.lastRestDays,
            cfg.lastRestSeconds
        );
        nextRest = cs_rest_AddTime(nextRest, cs_rest_Time(0, cfg.limit));
        cs_dbg_Trace(
            "current time: " + cs_rest_TimeToString(currentTime),
            cfg.debug
        );
        cs_dbg_Trace(
            "Next rest time: " + cs_rest_TimeToString(nextRest),
            cfg.debug
        );

        if (cs_rest_GetIsTimeLess(currentTime, nextRest)) {
            // The required time period has not passed so the player
            // may not rest yet.
            cs_rest_ShowFloatingTextByID(pc, cfg, CS_REST_TXT_TOO_SOON);
            cfg = cs_rest_SetRuleFlag(cfg, CS_REST_RULE_LAST_REST, TRUE);
        }
    }

    // Check for day only resting.
    if (cfg.permitted && (cfg.dayMode == CS_REST_DAY_ONLY)) {
        int hour = GetTimeHour();
        if ((hour < cfg.dayStart) || (hour >= cfg.dayEnd)) {
            cs_dbg_Trace("Day-only set and it is not day", cfg.debug);
            cs_rest_ShowFloatingTextByID(pc, cfg, CS_REST_TXT_DAY_ONLY);
            cfg = cs_rest_SetRuleFlag(cfg, CS_REST_RULE_DAY_ONLY, TRUE);
        }
    }

    // Check for night only resting.
    if (cfg.permitted && (cfg.dayMode == CS_REST_NIGHT_ONLY)) {
        int hour = GetTimeHour();
        if ((hour >= cfg.dayStart) && (hour < cfg.dayEnd)) {
            cs_dbg_Trace("Night-only set and it is not night", cfg.debug);
            cs_rest_ShowFloatingTextByID(pc, cfg, CS_REST_TXT_NIGHT_ONLY);
            cfg = cs_rest_SetRuleFlag(cfg, CS_REST_RULE_NIGHT_ONLY, TRUE);
        }
    }

    // Check if wearing armour.
    if (cfg.permitted && (cfg.noArmour >= 0)) {
        if (cs_rest_GetIsWearingHelm(pc, cfg) ||
            cs_rest_GetIsShieldEquipped(pc, cfg) ||
            cs_rest_GetIsWearingArmour(pc, cfg)
        ) {
            cs_dbg_Trace("Armour is not permitted while resting", cfg.debug);
            cs_rest_ShowFloatingTextByID(pc, cfg, CS_REST_TXT_NO_ARMOUR);
            cfg = cs_rest_SetRuleFlag(cfg, CS_REST_RULE_NO_ARMOUR, TRUE);
        }
    }

    // Check if carrying weapons.
    if (cfg.permitted && cfg.noWeapons) {
        if (cs_rest_GetIsArmed(pc, cfg)) {
            cs_dbg_Trace("Arms are not permitted while resting", cfg.debug);
            cs_rest_ShowFloatingTextByID(pc, cfg, CS_REST_TXT_NO_WEAPON);
            cfg = cs_rest_SetRuleFlag(cfg, CS_REST_RULE_NO_WEAPONS, TRUE);
        }
    }

    // Check if carrying a bedroll.
    if (cfg.permitted && cfg.useBedroll) {
        object item = GetItemPossessedBy(pc, cfg.bedrollTag);
        if (GetIsObjectValid(item)) {
            bedrollItem = item;
            int used = GetLocalInt(item, CS_REST_VAR_BEDROLL_USE);
            if (used > (CS_REST_DEF_BEDROLL_MAX_USE - 1)) {
                cs_dbg_Trace("Bedroll has been destroyed through use", cfg.debug);
            }
            else {
                cs_dbg_Trace("Incrementing bedroll use count", cfg.debug);
                bedrollUsed = TRUE;
            }
        }
        else {
            // Is there hit point regain without a bedroll?
            if (cfg.bedrollMultiplier > 0.0) {
                // No bedroll means only partial hit points regained.
                cs_dbg_Trace("Resting without a bedroll reduces regain", cfg.debug);
                cfg.multiplier = cfg.multiplier * cfg.bedrollMultiplier;
                cs_rest_ShowFloatingTextByID(pc, cfg, CS_REST_TXT_NOT_COMFORTABLE);
            }
            else {
                // No bedroll means no rest allowed at all.
                cs_dbg_Trace("Resting without a bedroll not permitted", cfg.debug);
                cfg = cs_rest_SetRuleFlag(cfg, CS_REST_RULE_NO_BEDROLL, TRUE);
                cs_rest_ShowFloatingTextByID(pc, cfg, CS_REST_TXT_NO_BEDROLL);
            }
        }
    }

    // Check if carrying rations.
    if (cfg.permitted && cfg.useRations) {
        object item = GetItemPossessedBy(pc, cfg.rationsTag);
        if (GetIsObjectValid(item)) {
            cs_dbg_Trace("Rations item destroyed through use", cfg.debug);
            rationsItem = item;
        }
        else {
            // Is there hit point regain without rations?
            if (cfg.rationsMultiplier > 0.0) {
                // No rations means only partial hit points regained.
                cs_dbg_Trace("Resting without rations reduces regain", cfg.debug);
                cfg.multiplier = cfg.multiplier * cfg.rationsMultiplier;
                cs_rest_ShowFloatingTextByID(pc, cfg, CS_REST_TXT_HUNGRY);
            }
            else {
                // No rations means no rest allowed at all.
                cs_dbg_Trace("Resting without rations not permitted", cfg.debug);
                cfg = cs_rest_SetRuleFlag(cfg, CS_REST_RULE_NO_RATIONS, TRUE);
                cs_rest_ShowFloatingTextByID(pc, cfg, CS_REST_TXT_NO_RATIONS);
            }
        }
    }

    // Execute external script hook for rest rule evaluation. We don't even
    // bother executing the user script if the never permitted flag is set,
    // since by definition the player will not be permitted to rest no matter
    // what.
    if ((cfg.userScript != "") && !cfg.neverPermitted) {
        cs_rest_SetConfig(pc, cfg);
        cs_rest_SetUserScriptState(pc, CS_REST_RULE_CHECK);
        ExecuteScript(cfg.userScript, pc);
        cs_rest_DeleteUserScriptState(pc);
        cfg = cs_rest_GetConfig(pc);
    }

    if (cfg.permitted) {
        // If resting is still permitted at this point, check whether any
        // of the rules should disallow it. Any rule that is set will cause
        // resting to be not permitted.
        cs_dbg_Trace("Checking rule evaluation", cfg.debug);
        cfg.permitted = (cfg.ruleFlags == 0);
        cs_dbg_Trace(
            "Permitted after rule evaluation: " + IntToString(cfg.permitted),
            cfg.debug
        );
    }

    cs_dbg_Trace(
        "cs_rest_GetIsRestPermitted(" + GetName(pc) + "): " +
        IntToString(cfg.permitted),
        cfg.debug
    );
    return cfg;
}


//----------------------------------------------------------------------------
void cs_rest_PostRestProcessing(object pc, struct cs_rest_config cfg)
{
    cs_dbg_Enter("cs_rest_PostRestProcessing(" + GetName(pc) + ")", cfg.debug);
    int permitted = GetLocalInt(pc, CS_REST_VAR_PERMITTED);
    if (permitted)
    {
        // Finally, if we actually did rest, check whether a bedroll or
        // rations item is to be consumed and so needs to be destroyed.
        if (GetIsObjectValid(bedrollItem))
                {
            if (bedrollUsed)
                        {   // Increment a usage count on the bedroll.
                // XXX This may need to be persistent.
                int used = GetLocalInt(bedrollItem, CS_REST_VAR_BEDROLL_USE);
                cs_dbg_Trace("incrementing bedroll use count from " + IntToString(used) + " to " + IntToString(used+1) );
                used++;
                SetLocalInt(bedrollItem, CS_REST_VAR_BEDROLL_USE, used);
            }
            else
                        {   // Bedroll item all used up.
                cs_dbg_Trace("destroying bedroll item " + GetName(bedrollItem));
                cs_rest_ShowFloatingTextByID(pc, cfg, CS_REST_TXT_BEDROLL_RUINED);
                DestroyObject(bedrollItem);
            }
        }
        if (GetIsObjectValid(rationsItem))
        {
            // Rations consumed.
            cs_dbg_Trace("destroying rations item " + GetName(rationsItem));
            cs_rest_ShowFloatingTextByID(pc, cfg, CS_REST_TXT_RATIONS_EATEN);
            //DestroyObject(rationsItem);       // alte konfig ohne stackeditems
            DercrementStackSize(pc, "FOOD", 1); // neue konfig mit  stackeditems
        }
    }
    cs_dbg_Exit("cs_rest_PostRestProcessing", cfg.debug);
}


//----------------------------------------------------------------------------
void cs_rest_ExecuteRestScript(object pc, struct cs_rest_config cfg) {
    cs_dbg_Enter("cs_rest_ExecuteRestScript(" + GetName(pc) + ")", cfg.debug);

    // Make sure that we have a rest profile.
    string profile = cfg.profile;
    if (profile == "") {
        // No configured profile so fall back on the default.
        profile = cfg.defaultProfile;
        cs_dbg_Trace("No profile, assuming default: " + profile, cfg.debug);
    }
    if (cfg.overrideProfile != "") {
        // There's an override so use that instead.
        profile = cfg.overrideProfile;
        cs_dbg_Trace("Using override profile instead: " + profile, cfg.debug);
    }

    cs_dbg_Trace("Running rest script: " + profile, cfg.debug);
    ExecuteScript(profile, GetModule());

    cs_dbg_Exit("cs_rest_ExecuteRestScript", cfg.debug);
}

//----------------------------------------------------------------------------
struct cs_rest_config cs_rest_ProcessConfig(
    object pc,
    object container,
    struct cs_rest_config cfg
) {
    cs_dbg_Enter("cs_rest_ProcessConfig(" + GetTag(container) + ")", cfg.debug);

    // Do we have a valid object from which to configure?
    if (GetIsObjectValid(container) && GetHasInventory(container)) {
        cs_dbg_Trace(
            "Valid configuration object: " + GetResRef(container),
            cfg.debug
        );

        // Sort through all items in the configuration object's inventory,
        // checking each one to see if it is something that we recognise.
        object item = GetFirstItemInInventory(container);
        while (GetIsObjectValid(item)) {
            string resref = GetResRef(item);
            if (resref == CS_REST_RR_DEBUG_ON) {
                // Found a debug on value. The presence of this item is
                // enough to indicate that debugging should be enabled.
                // When debug is enabled, messages are sent to the player
                // current resting.
                cfg.debug = pc;
                cs_dbg_EnableDestination(CS_DBG_ALL);
                cs_dbg_Trace("Enabling debugging", cfg.debug);
            }
            else if (resref == CS_REST_RR_ENABLE) {
                // Found an enable value. The presence of this item is
                // enough to indicate that the rest system is active.
                cfg.enabled = TRUE;
                cs_dbg_Trace("Enabling resting", cfg.debug);
            }
            else if (resref == CS_REST_RR_DISABLE) {
                // Found a disable value. The presence of this item is
                // enough to indicate that the rest system is inactive.
                cfg.enabled = FALSE;
                cs_dbg_Trace("Disabling resting", cfg.debug);
            }
            else if (resref == CS_REST_RR_HP_3ED) {
                // Found a 3ed HP value. The presence of this item is
                // enough to indicate that the rest system should use 3rd
                // edition style hit point rules.
                cfg.use3Ed = TRUE;
                cs_dbg_Trace("Using 3rd Ed Style HP", cfg.debug);
            }
            else if (resref == CS_REST_RR_HP_STD) {
                // Found a standard HP value. The presence of this item is
                // enough to indicate that the rest system should use normal
                // hit point rules.
                cfg.use3Ed = FALSE;
                cs_dbg_Trace("Using standard HP", cfg.debug);
            }
            else if (resref == CS_REST_RR_PROFILE) {
                // Found a profile value. Set the default profile to be
                // a script the same name as this item's tag.
                string profile = GetStringLowerCase(GetTag(item));
                cfg.defaultProfile = profile;
                cs_dbg_Trace("Default profile is " + profile, cfg.debug);
            }
            else if (resref == CS_REST_RR_DAY_ONLY) {
                // Found a day-only value. The presence of this item is
                // enough to indicate that resting should only be permitted
                // during daylight hours.
                cfg.dayMode = CS_REST_DAY_ONLY;
                cs_dbg_Trace("Setting day only mode", cfg.debug);
            }
            else if (resref == CS_REST_RR_NIGHT_ONLY) {
                // Found a night-only value. The presence of this item is
                // enough to indicate that resting should only be permitted
                // during night hours.
                cfg.dayMode = CS_REST_NIGHT_ONLY;
                cs_dbg_Trace("Setting night only mode", cfg.debug);
            }
            else if (resref == CS_REST_RR_ALL_HOURS) {
                // Found an all-hours value. The presence of this item is
                // enough to indicate that resting is permitted at all
                // times during the day and night.
                cfg.dayMode = CS_REST_DAY_AND_NIGHT;
                cs_dbg_Trace("Setting resting for all hours", cfg.debug);
            }
            else if (resref == CS_REST_RR_DAY_START) {
                // Found a start of day value. Convert the item's tag into an
                // integer and use it as the starting hour for the "day".
                int hour = StringToInt(GetTag(item));
                if ((hour >= 0) && (hour < 23)) {
                    cfg.dayStart = hour;
                    cs_dbg_Trace(
                        "Setting day start: " + IntToString(hour),
                        cfg.debug
                    );
                }
            }
            else if (resref == CS_REST_RR_DAY_END) {
                // Found an end of day value. Convert the item's tag into an
                // integer and use it as the ending hour for the "day".
                int hour = StringToInt(GetTag(item));
                if ((hour > 0) && (hour <= 23)) {
                    cfg.dayEnd = hour;
                    cs_dbg_Trace(
                        "Setting day end: " + IntToString(hour),
                        cfg.debug
                    );
                }
            }
            else if (resref == CS_REST_RR_NO_ARMOUR) {
                // Found a no armour value. Convert the item's tag to the
                // maximum AC value acceptable when resting.
                cfg.noArmour = StringToInt(GetTag(item));
                cs_dbg_Trace("Setting no armour mode", cfg.debug);
            }
            else if (resref == CS_REST_RR_YES_ARMOUR) {
                // Found an armour allowed value. The presence of this item
                // is enough to indicate that resting is permitted even while
                // armour is being worn.
                cfg.noArmour = CS_REST_DEF_NO_ARMOUR;
                cs_dbg_Trace("Setting armour allowed mode", cfg.debug);
            }
            else if (resref == CS_REST_RR_NO_WEAPONS) {
                // Found a no weapons value. The presence of this item is
                // enough to indicate that resting is not permitted while
                // weapons are equipped.
                cfg.noWeapons = TRUE;
                cs_dbg_Trace("Setting no weapons mode", cfg.debug);
            }
            else if (resref == CS_REST_RR_YES_WEAPONS) {
                // Found a weapons allowed value. The presence of this item
                // is enough to indicate that resting is permitted even while
                // weapons are equipped.
                cfg.noWeapons = FALSE;
                cs_dbg_Trace("Setting weapons allowed mode", cfg.debug);
            }
            else if (resref == CS_REST_RR_NO_BEDROLL) {
                // Found a no bedroll value. The presence of this item is
                // enough to indicate that bedrolls are ignored completely
                // for purposes of calculating hit point regain.
                cfg.useBedroll = FALSE;
                cs_dbg_Trace("Setting no bedroll mode", cfg.debug);
            }
            else if (resref == CS_REST_RR_YES_BEDROLL) {
                // Found a bedroll in use value. The presence of this item
                // is enough to indicate that bedrolls are used to determine
                // the number of hit points regained while resting, while
                // its tag contains the tag of the item that is to considered
                // to be a bedroll.
                cfg.useBedroll = TRUE;
                cfg.bedrollTag = GetTag(item);
                cs_dbg_Trace("Setting bedroll mode: " + GetTag(item), cfg.debug);
            }
            else if (resref == CS_REST_RR_BEDROLL_MULTIPLIER) {
                // Found a bedroll HP multiplier value. The tag of this item
                // provides a multiplier for hit points regained by players
                // when bedrolls are in effect and no bedroll is present.
                float multiplier = StringToInt(GetTag(item))/100.0;
                if ((multiplier < 0.0) && (multiplier >= 100.0)) {
                    multiplier = CS_REST_DEF_BEDROLL_MULTIPLIER;
                    cs_dbg_Trace(
                        "Invalid Bedroll HP multiplier: " + GetTag(item),
                        cfg.debug
                    );
                }
                cfg.bedrollMultiplier = multiplier;
                if (multiplier > 0.0) {
                    cs_dbg_Trace(
                        "Bedroll HP multiplier is " + FloatToString(cfg.bedrollMultiplier),
                        cfg.debug
                    );
                }
                else {
                    cs_dbg_Trace(
                        "Resting without a bedroll is disabled",
                        cfg.debug
                    );
                }
            }
            else if (resref == CS_REST_RR_NO_RATIONS) {
                // Found a no rations value. The presence of this item is
                // enough to indicate that rations are ignored completely
                // for purposes of calculating hit point regain.
                cfg.useRations = FALSE;
                cs_dbg_Trace("Setting no rations mode", cfg.debug);
            }
            else if (resref == CS_REST_RR_YES_RATIONS) {
                // Found a rations in use value. The presence of this item
                // is enough to indicate that rations are used to determine
                // the number of hit points regained while resting, while
                // its tag contains the tag of the item that is to considered
                // to be rations.
                cfg.useRations = TRUE;
                cfg.rationsTag = GetTag(item);
                cs_dbg_Trace("Setting rations mode: " + GetTag(item), cfg.debug);
            }
            else if (resref == CS_REST_RR_RATIONS_MULTIPLIER) {
                // Found a rations HP multiplier value. The tag of this item
                // provides a multiplier for hit points regained by players
                // when rations are in effect and no rations are present.
                float multiplier = StringToInt(GetTag(item))/100.0;
                if ((multiplier < 0.0) && (multiplier >= 100.0)) {
                    multiplier = CS_REST_DEF_RATIONS_MULTIPLIER;
                    cs_dbg_Trace(
                        "Invalid Rations HP multiplier: " + GetTag(item),
                        cfg.debug
                    );
                }
                cfg.rationsMultiplier = multiplier;
                if (multiplier > 0.0) {
                    cs_dbg_Trace(
                        "Rations HP multiplier is " + FloatToString(cfg.rationsMultiplier),
                        cfg.debug
                    );
                }
                else {
                    cs_dbg_Trace(
                        "Resting without rations is disabled",
                        cfg.debug
                    );
                }
            }
            else if ((resref == CS_REST_RR_TIME_LIMIT) ||
                     (GetStringLeft(resref, 14) == CS_REST_RR_TIME_PREFIX)){
                // Found a time limit value. Set the resting time limit to be
                // an integer taken from this item's tag.
                if (GetStringLowerCase(GetTag(item)) != "none") {
                    int limit = StringToInt(GetTag(item));
                    cfg.limit = limit;
                    cs_dbg_Trace(
                        "Time limit is " + IntToString(limit) + " seconds",
                        cfg.debug
                    );
                }
                else {
                    cs_dbg_Trace("Time limit does not apply", cfg.debug);
                }
            }
            else if (resref == CS_REST_RR_FADE_TO_BLACK) {
                // Found a fade to black value. The presence of this item
                // is enough to indicate that the screen should fade to black
                // when a player rests.
                cfg.fadeToBlack = TRUE;
                cs_dbg_Trace("The screen will fade to black", cfg.debug);
            }
            else if (resref == CS_REST_RR_NO_MESSAGES) {
                // Found a no messages value. The presence of this item
                // is enough to indicate the display of messages should be
                // suppressed.
                cfg.noMessages = TRUE;
                cs_dbg_Trace("No floaty messages will be displayed", cfg.debug);
            }
            else if (resref == CS_REST_RR_USE_CON_BONUS) {
                // Found a use CON bonus value. The presence of this item
                // is enough to indicate that players should receive their
                // CON bonus as hit points when resting.
                cfg.useConBonus = TRUE;
                cs_dbg_Trace("CON bonus will be used", cfg.debug);
            }
            else if (resref == CS_REST_RR_NO_CON_BONUS) {
                // Found a no CON bonus value. The presence of this item
                // is enough to indicate that players should not receive their
                // CON bonus as hit points when resting.
                cfg.useConBonus = FALSE;
                cs_dbg_Trace("CON bonus will be not used", cfg.debug);
            }
            else if (resref == CS_REST_RR_HP_MULTIPLIER) {
                // Found a HP multiplier value. The tag of this item provides
                // a multiplier for hit points regained by players.
                float multiplier = StringToInt(GetTag(item))/100.0;
                if ((multiplier <= 0.0) && (multiplier >= 100.0)) {
                    multiplier = CS_REST_DEF_MULTIPLIER;
                    cs_dbg_Trace(
                        "Invalid HP multiplier: " + GetTag(item),
                        cfg.debug
                    );
                }
                cfg.multiplier = multiplier;
                cs_dbg_Trace(
                    "HP multiplier is " + FloatToString(cfg.multiplier),
                    cfg.debug
                );
            }
            else if (resref == CS_REST_RR_USER_SCRIPT) {
                // Found a user script value. The tag of this item provides
                // the name of a script to be executed at user hook points.
                cfg.userScript = GetStringLowerCase(GetTag(item));
                cs_dbg_Trace("User script is " + cfg.userScript, cfg.debug);
            }
            else if (resref == CS_REST_RR_TEXT_MESSAGES) {
                // Found a container item for text messages. A set of
                // variables on this item may override the default messages.
                cs_dbg_Trace("Floaty messages will be displayed", cfg.debug);
                cfg.noMessages = FALSE;
                cs_rest_UpdateMessages(pc, cfg, item);
            }
            else if (resref == CS_REST_RR_EFFECTS) {
                // Found an effects value. A set of effects may be applied
                // to a player when resting, derived from the value of a
                // variable on this item.
                cs_dbg_Trace("Effects will be applied", cfg.debug);
                cfg.effects = GetLocalString(item, CS_REST_VAR_EFFECTS);
            }
            else {
                cs_dbg_Trace("Unrecognised item: " + resref, cfg.debug);
            }
            item = GetNextItemInInventory(container);
        }
    }
    else {
        cs_dbg_Trace(
            "Not a valid configuration object: " + GetResRef(container),
            cfg.debug
        );
    }

    // Validate and override hour settings if they are obviously screwy.
    if ((cfg.dayStart < 1) || (cfg.dayStart > cfg.dayEnd)) {
        cfg.dayStart = 6;
    }
    if ((cfg.dayEnd > 23) || (cfg.dayEnd < cfg.dayStart)) {
        cfg.dayEnd = 18;
    }

    cs_dbg_Exit("cs_rest_ProcessConfig", cfg.debug);
    return cfg;
}
//----------------------------------------------------------------------------
// Find our configuration. First we find a global configuration object,
// then an area-specific one for the area that the player is in, and
// if there is a profile set for the resting player we look for a profile
// configuration object.
struct cs_rest_config cs_rest_RetrieveConfig(object pc) {
    struct cs_rest_config cfg;
    cfg.debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    cs_dbg_Enter("cs_rest_RetrieveConfig(" + GetName(pc) + ")", cfg.debug);

    // Initialise default values.
    cfg.bedrollMultiplier = CS_REST_DEF_BEDROLL_MULTIPLIER;
    cfg.rationsMultiplier = CS_REST_DEF_RATIONS_MULTIPLIER;
    cfg.multiplier = CS_REST_DEF_MULTIPLIER;
    cfg.noArmour = CS_REST_DEF_NO_ARMOUR;
    cfg.effects = CS_REST_DEF_EFFECTS;

    // Pull in internal state from the PC if any.
    cfg.profile = cs_rest_GetProfile(pc);
    cfg.overrideProfile = cs_rest_GetOverrideProfile(pc);
    cfg.trigger = cs_rest_GetTriggeringObject(pc);
    cfg.permitted = GetLocalInt(pc, CS_REST_VAR_PERMITTED);
    cfg.ruleFlags = GetLocalInt(pc, CS_REST_VAR_RULE_FLAGS);
    cfg.started = GetLocalInt(pc, CS_REST_VAR_STARTED);
    cfg.savedHitPoints = GetLocalInt(pc, CS_REST_VAR_SAVE_HP);
    struct cs_rest_time time = cs_rest_GetLastRestTime(pc);
    cfg.lastRestDays = time.days;
    cfg.lastRestSeconds = time.seconds;

    // Find the global config container.
    cs_dbg_Trace("Searching global config: " + CS_REST_TAG_CONFIG, cfg.debug);
    object container = GetObjectByTag(CS_REST_TAG_CONFIG);
    if (!GetIsObjectValid(container)) {
        // Try again in lowercase just to be sure.
        container = GetObjectByTag(GetStringLowerCase(CS_REST_TAG_CONFIG));
    }
    if (GetIsObjectValid(container)) {
        cs_dbg_Trace("Global config found", cfg.debug);
        cfg = cs_rest_ProcessConfig(pc, container, cfg);
    }
    else {
        cs_dbg_Trace("Global config not found", cfg.debug);
    }

    // Find any area config container.
    string tag = GetTag(GetArea(pc)) + CS_REST_TAG_CONFIG_SUFFIX;
    cs_dbg_Trace("Searching area config: " + tag, cfg.debug);
    if (GetStringLength(tag) > CS_REST_MAX_TAG_LENGTH) {
        cs_dbg_Trace(
            "Rest config tag > " +
            IntToString(CS_REST_MAX_TAG_LENGTH) +
            " characters. This will cause problems.",
            cfg.debug
        );
    }
    container = GetObjectByTag(tag);
    if (!GetIsObjectValid(container)) {
        // Try again in lowercase just to be sure.
        container = GetObjectByTag(GetStringLowerCase(tag));
    }
    if (GetIsObjectValid(container)) {
        cs_dbg_Trace("Area config found", cfg.debug);
        cfg = cs_rest_ProcessConfig(pc, container, cfg);
    }
    else {
        cs_dbg_Trace("Area config not found", cfg.debug);
    }

    // Find a trigger config container if any.
    container = cfg.trigger;
    if (GetIsObjectValid(container)) {
        tag = GetTag(container) + CS_REST_TAG_CONFIG_SUFFIX;
        cs_dbg_Trace("Searching trigger config: " + tag, cfg.debug);
        if (GetStringLength(tag) > CS_REST_MAX_TAG_LENGTH) {
        cs_dbg_Trace(
            "Rest config tag > " +
            IntToString(CS_REST_MAX_TAG_LENGTH) +
            " characters. This will cause problems.",
            cfg.debug
        );
        }
        container = GetObjectByTag(tag);
        if (!GetIsObjectValid(container)) {
            // Try again in lowercase just to be sure.
            container = GetObjectByTag(GetStringLowerCase(tag));
        }
        if (GetIsObjectValid(container)) {
            cs_dbg_Trace("Trigger config found", cfg.debug);
            cfg = cs_rest_ProcessConfig(pc, container, cfg);
        }
        else {
            cs_dbg_Trace("Trigger config not found", cfg.debug);
        }
    }
    else {
        cs_dbg_Trace("Searching trigger config: not inside a trigger", cfg.debug);
    }

    cs_dbg_Exit("cs_rest_RetrieveConfig", cfg.debug);
    return cfg;
}

//----------------------------------------------------------------------------
void cs_rest_UpdateMessages(object pc, struct cs_rest_config cfg, object item) {
    SetLocalString(pc, CS_REST_VAR_START_TEXT, GetLocalString(item, CS_REST_VAR_START_TEXT));
    SetLocalString(pc, CS_REST_VAR_FINISH_TEXT, GetLocalString(item, CS_REST_VAR_FINISH_TEXT));
    SetLocalString(pc, CS_REST_VAR_CANCEL_TEXT, GetLocalString(item, CS_REST_VAR_CANCEL_TEXT));
    SetLocalString(pc, CS_REST_VAR_CANNOT_TEXT, GetLocalString(item, CS_REST_VAR_CANNOT_TEXT));
    SetLocalString(pc, CS_REST_VAR_TOO_SOON_TEXT, GetLocalString(item, CS_REST_VAR_TOO_SOON_TEXT));
    SetLocalString(pc, CS_REST_VAR_DAY_ONLY_TEXT, GetLocalString(item, CS_REST_VAR_DAY_ONLY_TEXT));
    SetLocalString(pc, CS_REST_VAR_NIGHT_ONLY_TEXT, GetLocalString(item, CS_REST_VAR_NIGHT_ONLY_TEXT));
    SetLocalString(pc, CS_REST_VAR_NO_ARMOUR_TEXT, GetLocalString(item, CS_REST_VAR_NO_ARMOUR_TEXT));
    SetLocalString(pc, CS_REST_VAR_NO_WEAPON_TEXT, GetLocalString(item, CS_REST_VAR_NO_WEAPON_TEXT));
    SetLocalString(pc, CS_REST_VAR_BEDROLL_RUINED_TEXT, GetLocalString(item, CS_REST_VAR_BEDROLL_RUINED_TEXT));
    SetLocalString(pc, CS_REST_VAR_NOT_COMFORTABLE_TEXT, GetLocalString(item, CS_REST_VAR_NOT_COMFORTABLE_TEXT));
    SetLocalString(pc, CS_REST_VAR_ENTER_REST_TEXT, GetLocalString(item, CS_REST_VAR_ENTER_REST_TEXT));
    SetLocalString(pc, CS_REST_VAR_EXIT_REST_TEXT, GetLocalString(item, CS_REST_VAR_EXIT_REST_TEXT));
    SetLocalString(pc, CS_REST_VAR_UNSAFE_TEXT, GetLocalString(item, CS_REST_VAR_UNSAFE_TEXT));
    SetLocalString(pc, CS_REST_VAR_ENTER_NO_REST_TEXT, GetLocalString(item, CS_REST_VAR_ENTER_NO_REST_TEXT));
    SetLocalString(pc, CS_REST_VAR_EXIT_NO_REST_TEXT, GetLocalString(item, CS_REST_VAR_EXIT_NO_REST_TEXT));
    SetLocalString(pc, CS_REST_VAR_NO_BEDROLL_TEXT, GetLocalString(item, CS_REST_VAR_NO_BEDROLL_TEXT));
    SetLocalString(pc, CS_REST_VAR_RATIONS_EATEN_TEXT, GetLocalString(item, CS_REST_VAR_RATIONS_EATEN_TEXT));
    SetLocalString(pc, CS_REST_VAR_NO_RATIONS_TEXT, GetLocalString(item, CS_REST_VAR_NO_RATIONS_TEXT));
    SetLocalString(pc, CS_REST_VAR_HUNGRY_TEXT, GetLocalString(item, CS_REST_VAR_HUNGRY_TEXT));
}

//----------------------------------------------------------------------------
void cs_rest_ShowFloatingTextByID(object pc, struct cs_rest_config cfg, int id){
    cs_dbg_Enter(
        "cs_rest_ShowFloatingTextByID(" +
        GetName(pc) + ", " +
        IntToString(id) + ")",
        cfg.debug
    );

    if (cfg.noMessages) {
        // Bail out if messages are turned off.
        cs_dbg_Trace("message display is disabled");
        cs_dbg_Exit("cs_rest_ShowFloatingTextByID", cfg.debug);
        return;
    }

//    object mod = GetModule();
    string text = "";
    cs_dbg_Trace("Message ID: " + IntToString(id), cfg.debug);
    switch (id) {
        case CS_REST_TXT_START:
            text = GetLocalString(pc, CS_REST_VAR_START_TEXT);
            if (text == "") {
                text = CS_REST_MSG_START;
            }
            break;
        case CS_REST_TXT_FINISH:
            text = GetLocalString(pc, CS_REST_VAR_FINISH_TEXT);
            if (text == "") {
                text = CS_REST_MSG_FINISH;
            }
            break;
        case CS_REST_TXT_CANCEL:
            text = GetLocalString(pc, CS_REST_VAR_CANCEL_TEXT);
            if (text == "") {
                text = CS_REST_MSG_CANCEL;
            }
            break;
        case CS_REST_TXT_CANNOT:
            text = GetLocalString(pc, CS_REST_VAR_CANNOT_TEXT);
            if (text == "") {
                text = CS_REST_MSG_CANNOT;
            }
            break;
        case CS_REST_TXT_TOO_SOON:
            text = GetLocalString(pc, CS_REST_VAR_TOO_SOON_TEXT);
            if (text == "") {
                text = CS_REST_MSG_TOO_SOON;
            }
            break;
        case CS_REST_TXT_DAY_ONLY:
            text = GetLocalString(pc, CS_REST_VAR_DAY_ONLY_TEXT);
            if (text == "") {
                text = CS_REST_MSG_DAY_ONLY;
            }
            break;
        case CS_REST_TXT_NIGHT_ONLY:
            text = GetLocalString(pc, CS_REST_VAR_NIGHT_ONLY_TEXT);
            if (text == "") {
                text = CS_REST_MSG_NIGHT_ONLY;
            }
            break;
        case CS_REST_TXT_NO_ARMOUR:
            text = GetLocalString(pc, CS_REST_VAR_NO_ARMOUR_TEXT);
            if (text == "") {
                text = CS_REST_MSG_NO_ARMOUR;
            }
            break;
        case CS_REST_TXT_NO_WEAPON:
            text = GetLocalString(pc, CS_REST_VAR_NO_WEAPON_TEXT);
            if (text == "") {
                text = CS_REST_MSG_NO_WEAPON;
            }
            break;
        case CS_REST_TXT_BEDROLL_RUINED:
            text = GetLocalString(pc, CS_REST_VAR_BEDROLL_RUINED_TEXT);
            if (text == "") {
                text = CS_REST_MSG_BEDROLL_RUINED;
            }
            break;
        case CS_REST_TXT_NOT_COMFORTABLE:
            text = GetLocalString(pc, CS_REST_VAR_NOT_COMFORTABLE_TEXT);
            if (text == "") {
                text = CS_REST_MSG_NOT_COMFORTABLE;
            }
            break;
        case CS_REST_TXT_ENTER_REST:
            text = GetLocalString(pc, CS_REST_VAR_ENTER_REST_TEXT);
            if (text == "") {
                text = CS_REST_MSG_ENTER_REST;
            }
            break;
        case CS_REST_TXT_EXIT_REST:
            text = GetLocalString(pc, CS_REST_VAR_EXIT_REST_TEXT);
            if (text == "") {
                text = CS_REST_MSG_EXIT_REST;
            }
            break;
        case CS_REST_TXT_UNSAFE:
            text = GetLocalString(pc, CS_REST_VAR_UNSAFE_TEXT);
            if (text == "") {
                text = CS_REST_MSG_UNSAFE;
            }
            break;
        case CS_REST_TXT_ENTER_NO_REST:
            text = GetLocalString(pc, CS_REST_VAR_ENTER_NO_REST_TEXT);
            if (text == "") {
                text = CS_REST_MSG_ENTER_NO_REST;
            }
            break;
        case CS_REST_TXT_EXIT_NO_REST:
            text = GetLocalString(pc, CS_REST_VAR_EXIT_NO_REST_TEXT);
            if (text == "") {
                text = CS_REST_MSG_EXIT_NO_REST;
            }
            break;
        case CS_REST_TXT_NO_BEDROLL:
            text = GetLocalString(pc, CS_REST_VAR_NO_BEDROLL_TEXT);
            if (text == "") {
                text = CS_REST_MSG_NO_BEDROLL;
            }
            break;
        case CS_REST_TXT_RATIONS_EATEN:
            text = GetLocalString(pc, CS_REST_VAR_RATIONS_EATEN_TEXT);
            if (text == "") {
                text = CS_REST_MSG_RATIONS_EATEN;
            }
            break;
        case CS_REST_TXT_NO_RATIONS:
            text = GetLocalString(pc, CS_REST_VAR_NO_RATIONS_TEXT);
            if (text == "") {
                text = CS_REST_MSG_NO_RATIONS;
            }
            break;
        case CS_REST_TXT_HUNGRY:
            text = GetLocalString(pc, CS_REST_VAR_HUNGRY_TEXT);
            if (text == "") {
                text = CS_REST_MSG_HUNGRY;
            }
            break;
        default:
            cs_dbg_Trace("Message ID not recognised", cfg.debug);
            break;
    }
    if (text != "") {
        if (text == "off") {
            cs_dbg_Trace("message is disabled");
        }
        else {
            // Expand references in the string.
            cs_dbg_Trace("Expanding embedded references", cfg.debug);
            int pos = FindSubString(text, "<MIN>");
            if (pos > 0) {
                // Number of minutes before next rest.
                struct cs_rest_time currentTime = cs_rest_GetCurrentTime(cfg);
                struct cs_rest_time nextRest = cs_rest_Time(
                    cfg.lastRestDays,
                    cfg.lastRestSeconds
                );
                nextRest = cs_rest_AddTime(nextRest, cs_rest_Time(0, cfg.limit));
                cs_dbg_Trace(
                    "current time: " + cs_rest_TimeToString(currentTime),
                    cfg.debug
                );
                cs_dbg_Trace(
                    "Next rest time: " + cs_rest_TimeToString(nextRest),
                    cfg.debug
                );
                struct cs_rest_time left = cs_rest_SubtractTime(nextRest, currentTime);
                int minutes = (left.seconds / cs_rest_secondsPerMinute);
                string replace = "";
                if (minutes == 0) {
                    replace = "less than a minute";
                }
                else {
                    replace = IntToString(minutes) + " minute";
                    if (minutes > 1) {
                        replace += "s";
                    }
                }
                text =
                    GetStringLeft(text, pos) +
                    replace +
                    GetStringRight(text, GetStringLength(text) - pos - 5);
            }
            FloatingTextStringOnCreature("[Server] "+text, pc, FALSE);
        }
    }

    cs_dbg_Exit("cs_rest_ShowFloatingTextByID", cfg.debug);
}

//----------------------------------------------------------------------------
void cs_rest_ApplyEffects(object pc, struct cs_rest_config cfg) {
    cs_dbg_Enter("cs_rest_ApplyEffects(" + GetName(pc) + ")", cfg.debug);

    cs_dbg_Trace("effects to apply: " + cfg.effects);
    cs_tkn_SetTokenString(cfg.effects);
    while(!cs_tkn_GetIsLastToken()) {
        string token = cs_tkn_GetNextToken();
        int effectID = StringToInt(token);
        if (effectID > 0) {
            cs_dbg_Trace("applying effect: " + token);
            effect eff = EffectVisualEffect(effectID);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eff, pc, 22.0);
        }
        else {
            cs_dbg_Trace("effect failed to parse: " + token);
        }
    }

    cs_dbg_Exit("cs_rest_ApplyEffects", cfg.debug);
}

//----------------------------------------------------------------------------
// Determine the damage resistance sub-property to check for based on the
// specified resistance type. Some standard constants here would have been
// nice. The damage types are bit masks but the sub-property can't be
// determined by counting bitshifts due to additional types being inserted
// into the sub-property list that are not present in the bit mask, nor can
// the bit masks be used to look up a 2DA record. Goddamned pain.
int cs_rest_GetDamageResistanceSubProperty(int resistanceType) {
    int subProp = -1;
    switch (resistanceType) {
    case DAMAGE_TYPE_BLUDGEONING:
        subProp = 0;  //   Bludgeoning
        break;
    case DAMAGE_TYPE_PIERCING:
        subProp = 1;  //   Piercing
        break;
    case DAMAGE_TYPE_SLASHING:
        subProp = 2;  //   Slashing
        break;
    case DAMAGE_TYPE_MAGICAL:
        subProp = 5;  //   Magical
        break;
    case DAMAGE_TYPE_ACID:
        subProp = 6;  //   Acid
        break;
    case DAMAGE_TYPE_COLD:
        subProp = 7;  //   Cold
        break;
    case DAMAGE_TYPE_DIVINE:
        subProp = 8;  //   Divine
        break;
    case DAMAGE_TYPE_ELECTRICAL:
        subProp = 9;  //   Electrical
        break;
    case DAMAGE_TYPE_FIRE:
        subProp = 10; //   Fire
        break;
    case DAMAGE_TYPE_NEGATIVE:
        subProp = 11; //   Negative
        break;
    case DAMAGE_TYPE_POSITIVE:
        subProp = 12; //   Positive
        break;
    case DAMAGE_TYPE_SONIC:
        subProp = 13; //   Sonic
        break;
    }
    return subProp;
}

//----------------------------------------------------------------------------
struct cs_rest_resistance cs_rest_GetDamageResistanceFromProperties(object pc, int damageType) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    cs_dbg_Enter(
        "cs_rest_GetDamageResistanceFromProperties(" +
        GetName(pc) + ", " +
        IntToString(damageType) + ")",
        debug
    );

    struct cs_rest_resistance resistance;
    resistance.resistance = 0;
    resistance.vulnerability = 0;
    resistance.immunity = 0;

    // Determine the damage resistance sub-property to check for based on the
    // specified resistance type.
    int subProp = cs_rest_GetDamageResistanceSubProperty(damageType);

    // If we have a damage resistance sub-property, search for resistances.
    if (subProp >= 0) {
        cs_dbg_Trace("resistance sub-property: " + IntToString(subProp), debug);

        // Cost tables for damage properties.
        string resistCost2DA = "";
        string vulnerabilityCost2DA = "";
        string immunityCost2DA = "";

        // We only search through equipped items.
        int i;
        for(i = 0; i < NUM_INVENTORY_SLOTS; i++) {
            object item = GetItemInSlot(i, pc);
            if (GetIsObjectValid(item)) {
                cs_dbg_Trace("item in slot " + IntToString(i) + ": " + GetName(item), debug);
                itemproperty prop = GetFirstItemProperty(item);
                while(GetIsItemPropertyValid(prop)) {
                    if (GetItemPropertySubType(prop) == subProp) {
                        cs_dbg_Trace("sub-property matches", debug);
                        int itemType = GetItemPropertyType(prop);
                        int value;
                        string amount;
                        switch (itemType) {
                        case ITEM_PROPERTY_DAMAGE_RESISTANCE:
                            // Found a resistance of the appropriate type,
                            // so use it if it is higher than any we have
                            // already found. Only the highest resistance
                            // value for a given type is used.
                            cs_dbg_Trace("found a damage resistance property", debug);
                            if (resistCost2DA == "") {
                                // Determine which 2DA we need.
                                resistCost2DA = Get2DAString(
                                    CS_REST_IPRP_COST_TABLE,
                                    CS_REST_IPRP_NAME,
                                    GetItemPropertyCostTable(prop)
                                );
                                cs_dbg_Trace("resist cost 2DA: " + resistCost2DA);
                            }
                            // Get the resistance value from 2DA
                            value = GetItemPropertyCostTableValue(prop);
                            cs_dbg_Trace("property cost table value: " + IntToString(value));
                            amount = Get2DAString(resistCost2DA, CS_REST_IPRP_AMOUNT, value);
                            cs_dbg_Trace("property cost table amount: " + amount);
                            value = StringToInt(amount);
                            // If this property is greater than the existing
                            // value, replace the existing value.
                            if (value > resistance.resistance) {
                                cs_dbg_Trace(
                                    "new property value " + IntToString(value) +
                                    " is > current " + IntToString(resistance.resistance),
                                    debug
                                );
                                resistance.resistance += value;
                            }
                            else {
                                cs_dbg_Trace(
                                    "new property value " + IntToString(value) +
                                    " is <= current " + IntToString(resistance.resistance),
                                    debug
                                );
                            }
                            cs_dbg_Trace("current resistance: " + IntToString(resistance.resistance), debug);
                            break;
                        case ITEM_PROPERTY_DAMAGE_VULNERABILITY:
                            // Found a vulnerability of the appropriate type,
                            // so use it to increment the cumulative total of
                            // vulnerability properties found so far.
                            cs_dbg_Trace("found a damage vulnerability property", debug);
                            if (vulnerabilityCost2DA == "") {
                                // Determine which 2DA we need.
                                vulnerabilityCost2DA = Get2DAString(
                                    CS_REST_IPRP_COST_TABLE,
                                    CS_REST_IPRP_NAME,
                                    GetItemPropertyCostTable(prop)
                                );
                                cs_dbg_Trace("vulnerability cost 2DA: " + vulnerabilityCost2DA);
                            }
                            // Get the vulnerability value from 2DA
                            value = GetItemPropertyCostTableValue(prop);
                            cs_dbg_Trace("property cost table value: " + IntToString(value));
                            amount = Get2DAString(vulnerabilityCost2DA, CS_REST_IPRP_VALUE, value);
                            cs_dbg_Trace("property cost table amount: " + amount);
                            resistance.vulnerability += StringToInt(amount);
                            cs_dbg_Trace(
                                "new vulnerability value " +
                                IntToString(resistance.vulnerability),
                                debug
                            );
                            cs_dbg_Trace("current vulnerability: " + IntToString(resistance.vulnerability), debug);
                            break;
                        case ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE:
                            // Found an immunity of the appropriate type,
                            // so use it to increment the cumulative total of
                            // immunity properties found so far.
                            cs_dbg_Trace("found a damage immunity property", debug);
                            if (immunityCost2DA == "") {
                                // Determine which 2DA we need.
                                immunityCost2DA = Get2DAString(
                                    CS_REST_IPRP_COST_TABLE,
                                    CS_REST_IPRP_NAME,
                                    GetItemPropertyCostTable(prop)
                                );
                                cs_dbg_Trace("immunity cost 2DA: " + immunityCost2DA);
                            }
                            // Get the immunity value from 2DA
                            value = GetItemPropertyCostTableValue(prop);
                            cs_dbg_Trace("property cost table value: " + IntToString(value));
                            amount = Get2DAString(immunityCost2DA, CS_REST_IPRP_VALUE, value);
                            cs_dbg_Trace("property cost table amount: " + amount);
                            resistance.immunity += StringToInt(amount);
                            cs_dbg_Trace(
                                "new immunity value " +
                                IntToString(resistance.immunity),
                                debug
                            );
                            cs_dbg_Trace("current immunity: " + IntToString(resistance.immunity), debug);
                            break;
                        default:
                            cs_dbg_Trace("property type: " + IntToString(itemType));
                            break;
                        }
                    }
                    prop = GetNextItemProperty(item);
                }
            }
        }
    }
    else {
        cs_dbg_Trace("unknown resistance type so not looking", debug);
    }

    cs_dbg_Exit(
        "cs_rest_GetDamageResistanceFromProperties: " +
        IntToString(resistance.resistance) + ":" +
        IntToString(resistance.vulnerability) + ":" +
        IntToString(resistance.immunity),
        debug
    );
    return resistance;
}

//----------------------------------------------------------------------------
// XXX incomplete
struct cs_rest_resistance cs_rest_GetDamageResistanceFromEffects(object pc, int damageType, struct cs_rest_resistance resistance) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    cs_dbg_Enter(
        "cs_rest_GetDamageResistanceFromEffects(" +
        GetName(pc) + ", " +
        IntToString(damageType) + ")",
        debug
    );
    effect eff = GetFirstEffect(pc);
    while (GetIsEffectValid(eff)) {
        eff = GetNextEffect(pc);
    }

    cs_dbg_Exit(
        "cs_rest_GetDamageResistanceFromEffects: " +
        IntToString(resistance.resistance) + ":" +
        IntToString(resistance.vulnerability) + ":" +
        IntToString(resistance.immunity),
        debug
    );
    return resistance;
}

//----------------------------------------------------------------------------
void cs_rest_ApplyGuaranteedDamage(object pc, int damage) {
    object debug = GetLocalObject(pc, CS_REST_VAR_DEBUG);
    cs_dbg_Enter(
        "cs_rest_ApplyGuaranteedDamage(" +
        GetName(pc) + ", " +
        IntToString(damage) + ")",
        debug
    );

    // Determine the resistances on this player.
    struct cs_rest_resistance resist = cs_rest_GetDamageResistanceFromProperties(
        pc,
        DAMAGE_TYPE_MAGICAL
    );

    // Bypass any damage immunity that may be in place. We need to calculate
    // the current net immunity or vulnerability, and apply enough of either
    // to restore the player to a cumulative balance of 0% temporarily.
    if ((resist.immunity != 0) || (resist.vulnerability != 0)) {
        cs_dbg_Trace("player has immunity or vulnerability", debug);
        int delta = resist.immunity - resist.vulnerability;
        if (delta > 0) {
            cs_dbg_Trace("immunity is positive, decreasing", debug);
            effect bypass = EffectDamageImmunityDecrease(DAMAGE_TYPE_MAGICAL, delta);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, bypass, pc, 0.1);
        }
        else {
            cs_dbg_Trace("vulnerability is positive, increasing", debug);
            effect bypass = EffectDamageImmunityIncrease(DAMAGE_TYPE_MAGICAL, abs(delta));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, bypass, pc, 0.1);
        }
    }

    // Determine the actual amount of damage to apply to penetrate any
    // resistances that may be in effect.
    int actualDamage = damage + resist.resistance;
    cs_dbg_Trace("actual damage amount: " + IntToString(actualDamage), debug);

    // Apply the damage, using enough power to penetrate any damage reduction.
    effect e = EffectDamage(
        actualDamage,
        DAMAGE_TYPE_MAGICAL,
        DAMAGE_POWER_PLUS_TWENTY
    );
    cs_dbg_Trace("hit points before: " + IntToString(GetCurrentHitPoints(pc)), debug);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, e, pc);
    cs_dbg_Trace("hit points after: " + IntToString(GetCurrentHitPoints(pc)), debug);

    cs_dbg_Exit("cs_rest_ApplyGuaranteedDamage", debug);
}

//----------------------------------------------------------------------------
// This function is used as a failsafe if, for whatever reason, the resting
// fails to stop and so the screen remains faded to black. Leaving players
// with a black screen is not friendly.
void cs_rest_fadeUpFallback(object pc, object debug) {
    cs_dbg_Enter("cs_rest_fadeUpFallback(" + GetName(pc) + ")", debug);

    if (!GetLocalInt(pc, CS_REST_VAR_FADE_DONE)) {
        cs_dbg_Trace("Fade up failed! Fallback kicked in.", debug);
        FadeFromBlack(pc);
    }
    else {
        cs_dbg_Trace("Fade up worked ok.", debug);
    }
    DeleteLocalInt(pc, CS_REST_VAR_FADE_DONE);

    cs_dbg_Exit("cs_rest_fadeUpFallback", debug);
}

//----------------------------------------------------------------------------
void cs_rest_StartResting(object pc, struct cs_rest_config cfg) {
    cs_dbg_Enter("cs_rest_StartResting(" + GetName(pc) + ")", cfg.debug);

    cfg.savedHitPoints = GetCurrentHitPoints(pc);
    cs_rest_ShowFloatingTextByID(pc, cfg, CS_REST_TXT_START);

    // If we're configured to fade the screen to black, do so here.
    if (cfg.fadeToBlack) {
        cs_dbg_Trace("Fading to black", cfg.debug);
        FadeToBlack(pc);
        // Failsafe fade just in case resting is aborted somehow.
        // Yeah yeah, I'm paranoid. I know.
        DelayCommand(25.0, cs_rest_fadeUpFallback(pc, cfg.debug));
    }

    // Apply any effects indicated by the user.
    cs_rest_ApplyEffects(pc, cfg);

    cs_rest_SetConfig(pc, cfg);

    // Store rest start time.
    struct cs_rest_time now = cs_rest_GetCurrentTime(cfg);
    string time = IntToString(now.days);
    time += ":";
    time += IntToString(now.seconds);
    cs_dbg_Trace("started resting: " + time, cfg.debug);
    SetLocalString(pc, CS_REST_VAR_START_TIME, time);

    cs_dbg_Exit("cs_rest_StartResting", cfg.debug);
}

//----------------------------------------------------------------------------
void cs_rest_StopResting(object pc, struct cs_rest_config cfg) {
    cs_dbg_Enter("cs_rest_StopResting(" + GetName(pc) + ")", cfg.debug);

    // Did the rest system actually kick in?
    if (cfg.started == CS_REST_STARTED) {
        cs_rest_ShowFloatingTextByID(pc, cfg, CS_REST_TXT_FINISH);

        // Calculate resting time.
        string time = GetLocalString(pc, CS_REST_VAR_START_TIME);
        cs_tkn_SetTokenString(time, ":");
        int startDays = StringToInt(cs_tkn_GetNextToken());
        int startSeconds = StringToInt(cs_tkn_GetNextToken());
        struct cs_rest_time startTime = cs_rest_Time(startDays, startSeconds);
        struct cs_rest_time now = cs_rest_GetCurrentTime(cfg);
        struct cs_rest_time delta = cs_rest_SubtractTime(now, startTime);
        time = IntToString(now.days);
        time += ":";
        time += IntToString(now.seconds);
        cs_dbg_Trace("stopped resting: " + time, cfg.debug);
        time = IntToString(delta.days);
        time += ":";
        time += IntToString(delta.seconds);
        cs_dbg_Trace("resting took: " + time, cfg.debug);
        DeleteLocalString(pc, CS_REST_VAR_START_TIME);

        // Determine the HP regain.
        int oldHP = cfg.savedHitPoints;
        if (oldHP > 0) {
            cs_dbg_Trace("old HP: " + IntToString(oldHP), cfg.debug);
            int maxHP = GetMaxHitPoints(pc);
            cs_dbg_Trace("max HP: " + IntToString(maxHP), cfg.debug);
            int currentHP = GetCurrentHitPoints(pc);
            cs_dbg_Trace("current HP: " + IntToString(currentHP), cfg.debug);
            int newHP;
            if (cfg.use3Ed) {
                // 3rd Edition style rules.
                // Reduce player's HP back to stored value + level.
                // Determine how many HP the PC regains.
                int gained = GetHitDice(pc);
                cs_dbg_Trace("raw regain: " + IntToString(gained), cfg.debug);
                cs_dbg_Trace("applying multiplier", cfg.debug);
                gained = FloatToInt(IntToFloat(gained) * cfg.multiplier);
                cs_dbg_Trace("regain: " + IntToString(gained), cfg.debug);

                // CON bonus is applied after the multipler.
                if (cfg.useConBonus) {
                    cs_dbg_Trace("applying CON bonus", cfg.debug);
                    gained += GetAbilityModifier(ABILITY_CONSTITUTION, pc);
                    cs_dbg_Trace("regain: " + IntToString(gained), cfg.debug);
                }

                if (gained < 1) {
                    // Player always regains at least 1 HP.
                    cs_dbg_Trace("forcing regain to 1", cfg.debug);
                    gained = 1;
                    cs_dbg_Trace("regain: " + IntToString(gained), cfg.debug);
                }
                cs_dbg_Trace("gained: " + IntToString(gained), cfg.debug);

                // Determine the number of HP the PC should now have.
                newHP = oldHP + gained;
                cs_dbg_Trace("new HP: " + IntToString(newHP), cfg.debug);
            }
            else {
                // Standard hitpoint regain.
                // The PC should have regained all HP.
                newHP = maxHP;

                cs_dbg_Trace("applying multiplier", cfg.debug);
                newHP = FloatToInt(IntToFloat(newHP) * cfg.multiplier);
                cs_dbg_Trace("new HP: " + IntToString(newHP), cfg.debug);

                // CON bonus is applied after the multipler.
                if (cfg.useConBonus) {
                    cs_dbg_Trace("applying CON bonus", cfg.debug);
                    newHP += GetAbilityModifier(ABILITY_CONSTITUTION, pc);
                    cs_dbg_Trace("new HP: " + IntToString(newHP), cfg.debug);
                }

                if (newHP < 1) {
                    // Player always will have at least 1 HP.
                    cs_dbg_Trace("forcing HP to 1", cfg.debug);
                    newHP = 1;
                    cs_dbg_Trace("new HP: " + IntToString(newHP), cfg.debug);
                }
            }

            // If the new HP value is less than full HP, we need to reduce
            // the PC's HP down again.
            if (newHP < maxHP) {
                int hp = currentHP - newHP;
                cs_dbg_Trace("reducing player HP by " + IntToString(hp), cfg.debug);
                cs_rest_ApplyGuaranteedDamage(pc, hp);

                // Calculate display value.
                newHP = newHP - oldHP;
            }
            else {
                // Calculate display value. Standard regain will have already
                // restored the player to full HP so we will only ever have
                // to take HP away, thus if we're not taking HP away, just
                // determine how many the player actually got back.
                newHP = maxHP - oldHP;
            }
            cs_dbg_Trace(
                GetName(pc) + " regained " +
                IntToString(newHP) + " hit points",
                cfg.debug
            );
        }
        else {
            cs_dbg_Trace(
                GetName(pc) + " has 0 hit points! This is bad...",
                cfg.debug
            );
        }

        // Set config that we actually want to keep for next time.
        cs_rest_SetLastRestTime(pc, cs_rest_GetCurrentTime(cfg));

        // If we faded the screen to black, fade back up again.
        if (cfg.fadeToBlack) {
            cs_dbg_Trace("Fading screen up", cfg.debug);
            FadeFromBlack(pc);
            SetLocalInt(pc, CS_REST_VAR_FADE_DONE, TRUE);
        }
    }
    else if (cfg.started != CS_REST_ABORTED) {
        cs_dbg_Trace(
            GetName(pc) + ": resting stopped after never starting!",
            cfg.debug
        );
    }

    cs_dbg_Exit("cs_rest_StopResting", cfg.debug);
}

//----------------------------------------------------------------------------
void cs_rest_CancelResting(object pc, struct cs_rest_config cfg) {
    cs_dbg_Enter("cs_rest_CancelResting(" + GetName(pc) + ")", cfg.debug);

    // Did the rest system actually kick in?
    if (cfg.started == CS_REST_STARTED) {
        cs_rest_ShowFloatingTextByID(pc, cfg, CS_REST_TXT_CANCEL);

        // Calculate resting time.
        string time = GetLocalString(pc, CS_REST_VAR_START_TIME);
        cs_tkn_SetTokenString(time, ":");
        int startDays = StringToInt(cs_tkn_GetNextToken());
        int startSeconds = StringToInt(cs_tkn_GetNextToken());
        struct cs_rest_time startTime = cs_rest_Time(startDays, startSeconds);
        struct cs_rest_time now = cs_rest_GetCurrentTime(cfg);
        struct cs_rest_time delta = cs_rest_SubtractTime(now, startTime);
        time = IntToString(now.days);
        time += ":";
        time += IntToString(now.seconds);
        cs_dbg_Trace("stopped resting: " + time, cfg.debug);
        time = IntToString(delta.days);
        time += ":";
        time += IntToString(delta.seconds);
        cs_dbg_Trace("resting took: " + time, cfg.debug);
        DeleteLocalString(pc, CS_REST_VAR_START_TIME);

        int oldHP = cfg.savedHitPoints;
        if (oldHP > 0) {
            cs_dbg_Trace("old HP: " + IntToString(oldHP), cfg.debug);
            int maxHP = GetMaxHitPoints(pc);
            cs_dbg_Trace("max HP: " + IntToString(maxHP), cfg.debug);
            int currentHP = GetCurrentHitPoints(pc);
            cs_dbg_Trace("current HP: " + IntToString(currentHP), cfg.debug);
            int newHP;
            if (cfg.use3Ed) {
                // 3rd Edition style rules.
                // Reduce player's HP to stored value + proportion of level,
                // i.e. if the player rests for half a normal rest period, she
                // gets half her level in HP. If the player is only slightly
                // injured, i.e. less than her level in damage, then the normal
                // resting is left alone which results in slower healing if
                // interrupted close to full hit points. Ah well. The usual
                // multiplier and CON bonus apply, calculated after the
                // pro rata regain is determined.
                if (oldHP != maxHP) {
                    // Determine how many HP the PC regains.
                    int gained = FloatToInt(IntToFloat(GetHitDice(pc)) *
                                 ((IntToFloat(currentHP - oldHP)) /
                                 (IntToFloat(maxHP - oldHP))));
                    cs_dbg_Trace("raw regain: " + IntToString(gained), cfg.debug);
                    cs_dbg_Trace("applying multiplier", cfg.debug);
                    gained = FloatToInt(IntToFloat(gained) * cfg.multiplier);
                    cs_dbg_Trace("regain: " + IntToString(gained), cfg.debug);

                    // CON bonus is applied after the multipler.
                    if (cfg.useConBonus) {
                        cs_dbg_Trace("applying CON bonus", cfg.debug);
                        gained += GetAbilityModifier(ABILITY_CONSTITUTION, pc);
                        cs_dbg_Trace("regain: " + IntToString(gained), cfg.debug);
                    }

                    if (gained < 1) {
                        // Player always regains at least 1 HP.
                        cs_dbg_Trace("forcing regain to 1", cfg.debug);
                        gained = 1;
                        cs_dbg_Trace("regain: " + IntToString(gained), cfg.debug);
                    }
                    cs_dbg_Trace("gained: " + IntToString(gained), cfg.debug);

                    // Determine the number of HP the PC should now have.
                    newHP = oldHP + gained;
                    cs_dbg_Trace("new HP: " + IntToString(newHP), cfg.debug);
                }
                else {
                    cs_dbg_Trace("already at maximum HP", cfg.debug);
                    newHP = currentHP;
                }
            }
            else {
                // Standard hitpoint regain.
                newHP = currentHP;

                cs_dbg_Trace("applying multiplier", cfg.debug);
                newHP = FloatToInt(IntToFloat(newHP) * cfg.multiplier);
                cs_dbg_Trace("new HP: " + IntToString(newHP), cfg.debug);

                // CON bonus is applied after the multipler.
                if (cfg.useConBonus) {
                    cs_dbg_Trace("applying CON bonus", cfg.debug);
                    newHP += GetAbilityModifier(ABILITY_CONSTITUTION, pc);
                    cs_dbg_Trace("new HP: " + IntToString(newHP), cfg.debug);
                }

                if (newHP < 1) {
                    // Player always have at least 1 HP.
                    cs_dbg_Trace("forcing HP to 1", cfg.debug);
                    newHP = 1;
                    cs_dbg_Trace("new HP: " + IntToString(newHP), cfg.debug);
                }
            }

            int displayHP;
            if (currentHP > newHP) {
                // The PC has more HP than she should, so we need to reduce
                // her HP down again.
                int hp = currentHP - newHP;
                cs_dbg_Trace("reducing player HP by " + IntToString(hp), cfg.debug);
                cs_rest_ApplyGuaranteedDamage(pc, hp);
                displayHP = newHP - oldHP;
            }
            else if (newHP > currentHP) {
                // The PC doesn't have enough HP to satisfy the configured
                // rules, so we need to give her some more.
                int hp = newHP - currentHP;
                cs_dbg_Trace("increasing player HP by " + IntToString(hp), cfg.debug);
                effect heal = EffectHeal(hp);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, heal, pc);
                displayHP = newHP - oldHP;
            }
            else {
                cs_dbg_Trace("HP are where they should be", cfg.debug);
                displayHP = currentHP - oldHP;
            }
            cs_dbg_Trace(
                GetName(pc) + " regained " +
                IntToString(displayHP) + " hit points",
                cfg.debug
            );
        }
        else {
            cs_dbg_Trace(
                GetName(pc) + " has 0 hit points! This is bad...",
                cfg.debug
            );
        }

        // Set config that we actually want to keep for next time.
        cs_rest_SetLastRestTime(pc, cs_rest_GetCurrentTime(cfg));

        // If we faded the screen to black, fade back up again.
        if (cfg.fadeToBlack) {
            cs_dbg_Trace("Fading screen up", cfg.debug);
            FadeFromBlack(pc);
            SetLocalInt(pc, CS_REST_VAR_FADE_DONE, TRUE);
        }
    }
    else if (cfg.started != CS_REST_ABORTED) {
        cs_dbg_Trace(
            GetName(pc) + ": resting cancelled after never starting!",
            cfg.debug
        );
    }

    cs_dbg_Exit("cs_rest_CancelResting", cfg.debug);
}
