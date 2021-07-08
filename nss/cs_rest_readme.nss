//============================================================================
//
// Name: CS resting Subsystem - README
// File: cs_rest_readme
// Author: Craig Smith (Galap) <craig@smith.dropbear.id.au>
//
// $Id: cs_rest_readme.nss,v 1.5 2005/09/14 12:58:42 cs Exp $
// $Source: /local/cvs/nwn/resting/cs_rest_readme.nss,v $
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
// This package constitutes the CS Resting Subsystem, a set of scripts and
// functions intended to make management of player resting easier. The
// CS Resting Subsystem provides a framework for setting various popular
// forms of resting rules in a module, and allows these resting rules to be
// changed dynamically while the module is running.
//
// The following blueprints should be included:
//
// cs_rest_trg_camp     A trigger for defining the boundary of a campsite
//                      at which players may rest.
// cs_rest_trg_room     A trigger for drawing around a room in which players
//                      may rest.
// cs_rest_trg_none     A trigger for defining zones in which resting may not
//                      occur.
// cs_rest_cfg_enbl     A configuration item enabling the resting subsystem.
// cs_rest_cfg_dsbl     A configuration item disabling the resting subsystem.
// cs_rest_cfg_prfl     A configuration item setting resting profiles.
// cs_rest_cfg_time     A configuration item setting unlimited resting.
// cs_rest_cfg_tm00     A configuration item setting the minimum rest limit.
// cs_rest_cfg_tm01     A configuration item setting the minimum rest limit.
// cs_rest_cfg_tm02     A configuration item setting the minimum rest limit.
// cs_rest_cfg_tm03     A configuration item setting the minimum rest limit.
// cs_rest_cfg_tm04     A configuration item setting the minimum rest limit.
// cs_rest_cfg_tm05     A configuration item setting the minimum rest limit.
// cs_rest_cfg_tm06     A configuration item setting the minimum rest limit.
// cs_rest_cfg_tm07     A configuration item setting the minimum rest limit.
// cs_rest_cfg_tm08     A configuration item setting the minimum rest limit.
// cs_rest_cfg_tm09     A configuration item setting the minimum rest limit.
// cs_rest_cfg_tm10     A configuration item setting the minimum rest limit.
// cs_rest_cfg_tm12     A configuration item setting the minimum rest limit.
// cs_rest_cfg_tm14     A configuration item setting the minimum rest limit.
// cs_rest_cfg_tm16     A configuration item setting the minimum rest limit.
// cs_rest_cfg_tm18     A configuration item setting the minimum rest limit.
// cs_rest_cfg_tm20     A configuration item setting the minimum rest limit.
// cs_rest_cfg_tm25     A configuration item setting the minimum rest limit.
// cs_rest_cfg_tm30     A configuration item setting the minimum rest limit.
// cs_rest_cfg_3ed      A configuration item enabling 3rd edition rules HP gain.
// cs_rest_cfg_std      A configuration item enabling standard HP gain.
// cs_rest_cfg_armn     A configuration item stopping resting in armour.
// cs_rest_cfg_army     A configuration item allowing resting in armour.
// cs_rest_cfg_bedn     A configuration item disabling the use of bedrolls.
// cs_rest_cfg_bedy     A configuration item enabling the use of bedrolls.
// cs_rest_cfg_donl     A configuration item allowing resting during the day.
// cs_rest_cfg_nonl     A configuration item allowing resting at night.
// cs_rest_cfg_allh     A configuration item allowing resting at anytime.
// cs_rest_cfg_days     A configuration item setting the first hour of the day.
// cs_rest_cfg_daye     A configuration item setting the final hour of the day.
// cs_rest_cfg_fade     A configuration item causing the screen to fade on rest.
// cs_rest_cfg_nmsg     A configuration item disabling floaty messages.
//
// The following script files should be included:
//
// cs_rest              The main resting script (including documentation).
//                      This is an include file used by other scripts within
//                      the resting subsystem and apart from reading the
//                      documentation within it, it is not intended to be
//                      used directly. Unless you intend to write your own
//                      code to hook into the resting subsystem, of course,
//                      and if you do, please let me know what you're doing
//                      as I would be interested.
// cs_rest_cmp          A profile script that handles resting at a campsite.
// cs_rest_cmp_entr     An OnEnter handler script for the campfire trigger.
// cs_rest_cnt          A profile script that handles disallowed resting.
// cs_rest_cnt_entr     An OnEnter handler script for the disallow trigger.
// cs_rest_handler      The script intended for the module's OnPlayerRest
//                      event handler.
// cs_rest_readme       Explanation of the package (this file).
// cs_rest_rom          A profile script that handles resting in safe rooms.
// cs_rest_rom_entr     An OnEnter handler script for the safe room trigger.
// cs_rest_sample       A sample script demonstrating the structure required
//                      for user scripts.
// cs_rest_text         A script containing default text strings for display
//                      to players.
// cs_rest_trg_exit     A generic OnExit handler for the resting triggers.
// cs_rest_userxmpl     An example script that shows how the Bioware HotU
//                      wandering monster system may be incorporated into
//                      the resting subsystem through the use of a user
//                      script.
//
// Where to get copies of this package
// -----------------------------------
// The primary download site for current release versions of the CS Resting
// Subsystem is Neverwinter Vault at http://nwvault.ign.com/. Archival,
// current and development versions may be available from my own site at
// http://craig.smith.dropbear.id.au/nwn/.
//
// I hope that you find this package to be useful, and if you build something
// interesting, please let me know about it.
//
// -cs
//
//============================================================================
