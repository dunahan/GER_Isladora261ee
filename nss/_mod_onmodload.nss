//::///////////////////////////////////////////////
//:: Example XP2 OnLoad Script
//:: x2_mod_def_load
//:: zep_on_mod_load (addition CEP CRP 11/07/2008
//:: (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Put into: OnModuleLoad Event

    This example script demonstrates how to tweak the
    behavior of several subsystems in your module.

    For more information, please check x2_inc_switches
    which holds definitions for several variables that
    can be set on modules, creatures, doors or waypoints
    to change the default behavior of Bioware scripts.

    Warning:
    Using some of these switches may change your games
    balancing and may introduce bugs or instabilities. We
    recommend that you only use these switches if you
    know what you are doing. Consider these features
    unsupported!

    Please do NOT report any bugs you experience while
    these switches have been changed from their default
    positions.

    Make sure you visit the forums at nwn.bioware.com
    to find out more about these scripts.

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-16
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
#include "eds_include"
#include "_isla_inc"
#include "aps_include"

#include "x2_inc_switches"
#include "x2_inc_restsys"
#include "nw_i0_generic"

void main()
{
//----------------------------Isladoras Wanderer--------------------------------
  object   oWander = GetWaypointByTag("hw_travshop00" + IntToString(d8()) );
  location locWand = GetLocation(oWander);
  CreateObjectVoid(OBJECT_TYPE_CREATURE, "hw_travshop", locWand);
  DebugMode("Wanderer spawnte in: "+GetName(GetArea(oWander)));

//----------------------------Isladora HW-System--------------------------------
  object   oHwCont = GetWaypointByTag("hw_container00" + IntToString(d8()) );
  location locHwCn = GetLocation(oHwCont);
  CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "hw_container", locHwCn);
  DebugMode("HW-Kontainer spawnte in: "+GetName(GetArea(oHwCont)));

//---------------------------- NWNX2 Fky_ChatLog -------------------------------

//ExecuteScript("fky_chat_modload", OBJECT_SELF);

//----------------------------Isladora PerisTime--------------------------------

  Time_Load();

//--------------------------Isladora Wettersystem-------------------------------

  DebugMode("Beginne damit, alle ausgezeichneten Area's mit dem jeweiligen Wetter zu versehen.");
  SetGlobalWeather(16);

//--------------------------Isladora Per.PC.Shops-------------------------------

  ExecuteScript ("shop_mod_load",  OBJECT_SELF);

//------------------------------Isladora CNR------------------------------------

  ExecuteScript ("cnr_module_oml", OBJECT_SELF);

//----------------------------Isladora Treasures--------------------------------

  ExecuteScript ("trea_mod_load", OBJECT_SELF);
  //TreaInitTables();

//------------------------------- NWNX 2 SQL -----------------------------------

  SQLInit();

///////////////////crap/////////////////////
    // Variable declarations
    int nNth, nDC, nReset;
    string sTag, sResRef, sDestination, sMSG1, sMSG2, sMSG3;
    object oMarker, oItem, oHolder;
    location lLoc;

    // Hide and mark all the hidden objects
    location lSavedObjects = GetLocation(GetObjectByTag("CRP_HIDDEN_OBJECTS"));
    object oHidden = GetObjectByTag("secret", nNth);
    while(GetIsObjectValid(oHidden))
    {
        lLoc = GetLocation(oHidden);
        sTag = GetLocalString(oHidden, "TAG");
        sResRef = GetResRef(oHidden);
        sDestination = GetLocalString(oHidden, "DESTINATION");
        nDC = GetLocalInt(oHidden, "DC");
        nReset = GetLocalInt(oHidden, "RESET");
        sMSG1 = GetLocalString(oHidden, "MSG1");
        sMSG2 = GetLocalString(oHidden, "MSG2");
        sMSG3 = GetLocalString(oHidden, "MSG3");
        oMarker = CreateObject(OBJECT_TYPE_WAYPOINT, "crpw_hidden_obj", lLoc, FALSE, "SC"+sTag);

        //store a hidden item
        if(GetObjectType(oHidden) == OBJECT_TYPE_ITEM)
        {
            oItem = CopyObject(oHidden, lSavedObjects, OBJECT_INVALID, "hidden_item");
            SetLocalObject(oMarker, "ITEM", oItem);
        }

        //store a placeable and all its inventory items
        else if(GetHasInventory(oHidden))
        {
            oHolder = CreateObject(OBJECT_TYPE_PLACEABLE, "crpp_holdbag", lSavedObjects);
            SetLocalObject(oMarker, "HOLDER", oHolder);
            oItem = GetFirstItemInInventory(oHidden);
            while(GetIsObjectValid(oItem))
            {
                AssignCommand(oHolder, ActionTakeItem(oItem, oHidden));
                oItem = GetNextItemInInventory(oHidden);
            }
        }

        SetLocalString(oMarker, "TAG", sTag);
        SetLocalString(oMarker, "RESREF", sResRef);
        SetLocalString(oMarker, "DESTINATION", sDestination);
        SetLocalInt(oMarker, "DC", nDC);
        SetLocalInt(oMarker, "RESET", nReset);
        SetLocalString(oMarker, "MSG1", sMSG1);
        SetLocalString(oMarker, "MSG2", sMSG2);
        SetLocalString(oMarker, "MSG3", sMSG3);
        DelayCommand(1.0, DestroyObject(oHidden));

        nNth++;
        oHidden = GetObjectByTag("secret", nNth);
    }

///////////////////crap////////////////////

    //ExecuteScript("crpz_hide_sobjs", OBJECT_SELF);//CRAP

      SetMaxHenchmen(2);

//:://////////////////////////////////////////////
   if (GetGameDifficulty() ==  GAME_DIFFICULTY_CORE_RULES || GetGameDifficulty() ==  GAME_DIFFICULTY_DIFFICULT)
   {
        // * Setting the switch below will enable a seperate Use Magic Device Skillcheck for
        // * rogues when playing on Hardcore+ difficulty. This only applies to scrolls
        SetModuleSwitch (MODULE_SWITCH_ENABLE_UMD_SCROLLS, FALSE);

       // * Activating the switch below will make AOE spells hurt neutral NPCS by default
       SetModuleSwitch (MODULE_SWITCH_AOE_HURT_NEUTRAL_NPCS, FALSE);
   }

   // * AI: Activating the switch below will make the creaures using the WalkWaypoint function
   // * able to walk across areas
   SetModuleSwitch (MODULE_SWITCH_ENABLE_CROSSAREA_WALKWAYPOINTS, TRUE);

   // * Spells: Activating the switch below will make the Glyph of Warding spell behave differently:
   // * The visual glyph will disappear after 6 seconds, making them impossible to spot
   SetModuleSwitch (MODULE_SWITCH_ENABLE_INVISIBLE_GLYPH_OF_WARDING, FALSE);

   // * Craft Feats: Want 50 charges on a newly created wand? We found this unbalancing,
   // * but since it is described this way in the book, here is the switch to get it back...
   SetModuleSwitch (MODULE_SWITCH_ENABLE_CRAFT_WAND_50_CHARGES, FALSE);

   // * Craft Feats: Use this to disable Item Creation Feats if you do not want
   // * them in your module
   SetModuleSwitch (MODULE_SWITCH_DISABLE_ITEM_CREATION_FEATS, TRUE);

   // * Palemaster: Deathless master touch in PnP only affects creatures up to a certain size.
   // * We do not support this check for balancing reasons, but you can still activate it...
   SetModuleSwitch (MODULE_SWITCH_SPELL_CORERULES_DMASTERTOUCH, FALSE);

   // * Epic Spellcasting: Some Epic spells feed on the liveforce of the caster. However this
   // * did not fit into NWNs spell system and was confusing, so we took it out...
   SetModuleSwitch (MODULE_SWITCH_EPIC_SPELLS_HURT_CASTER, FALSE);

   // * Epic Spellcasting: Some Epic spells feed on the liveforce of the caster. However this
   // * did not fit into NWNs spell system and was confusing, so we took it out...
   SetModuleSwitch (MODULE_SWITCH_RESTRICT_USE_POISON_TO_FEAT, FALSE);

    // * Spellcasting: Some people don't like caster's abusing expertise to raise their AC
    // * Uncommenting this line will drop expertise mode whenever a spell is cast by a player
    SetModuleSwitch (MODULE_VAR_AI_STOP_EXPERTISE_ABUSE, FALSE);


    // * Item Event Scripts: The game's default event scripts allow routing of all item related events
    // * into a single file, based on the tag of that item. If an item's tag is "test", it will fire a
    // * script called "test" when an item based event (equip, unequip, acquire, unacquire, activate,...)
    // * is triggered. Check "x2_it_example.nss" for an example.
    // * This feature is disabled by default.
   SetModuleSwitch (MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS, TRUE);

   if (GetModuleSwitchValue (MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
   {
        // * If Tagbased scripts are enabled, and you are running a Local Vault Server
        // * you should use the line below to add a layer of security to your server, preventing
        // * people to execute script you don't want them to. If you use the feature below,
        // * all called item scrips will be the prefix + the Tag of the item you want to execute, up to a
        // * maximum of 16 chars, instead of the pure tag of the object.
        // * i.e. without the line below a user activating an item with the tag "test",
        // * will result in the execution of a script called "test". If you uncomment the line below
        // * the script called will be "1_test.nss"
         SetUserDefinedItemEventPrefix("itm_");

   }

   // * This initializes Bioware's wandering monster system as used in Hordes of the Underdark
   // * You can deactivate it, making your module load faster if you do not use it.
   // * If you want to use it, make sure you set "x2_mod_def_rest" as your module's OnRest Script
   SetModuleSwitch (MODULE_SWITCH_USE_XP2_RESTSYSTEM, FALSE);

   if (GetModuleSwitchValue(MODULE_SWITCH_USE_XP2_RESTSYSTEM) == TRUE)
   {

       // * This allows you to specify a different 2da for the wandering monster system.
       // SetWanderingMonster2DAFile("des_restsystem");

       //* Do not change this line.
       WMBuild2DACache();
   }

   DelayCommand(360.0, SleepMode());
}
