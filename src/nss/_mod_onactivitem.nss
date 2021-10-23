// Script: _mod_onactivitem
// by Barry_1066
// Feb. 12 2008 for CEP/DLA horse systems
// Integrates BOTH old and Tag based systems
#include "x3_inc_horse"
#include "x2_inc_switches"
#include "nw_i0_generic"

//#include "zep_inc_phenos"
#include "cnr_recipe_utils"
#include "shifter_inc"
#include "_debugisla"

void main()
{
    object oItem = GetItemActivated();
    object oActivator = GetItemActivator();
    object oPC = GetItemActivator();
    object oTarget = GetItemActivatedTarget();
    string sTag = GetTag(oTarget);
    string sItem = GetTag(oItem);
    object oArea = GetArea(oTarget);
    location lActivator = GetLocation(oActivator);
    string sItemTag = GetTag(oItem);
    location lTarget = GetItemActivatedTargetLocation();

    if (GetUserDefinedItemEventNumber()==X2_ITEM_EVENT_ACTIVATE)
    {

//---------------------------------CNR ITEMS-----------------------------

      if (CnrRecipeBookOnActivateItem(oItem, oActivator))
      {
        return;
      }

      if (CnrJournalOnActivateItem(oItem, oActivator))
      {
        return;
      }

    }
//---------------------------------TAGBASED SCRIPTS-----------------------------

    //X2 Tag based system code
    //if (GetStringLeft(sItemTag, 3) == "it_")
    {
       ExecuteScript(sItemTag, oPC);  // Tag-Based Item Scripts
       DebugMode(GetTag(oItem)+" wurde aktiviert.");
       //return;
    }

     // * Generic Item Script Execution Code
     // * If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
     // * it will execute a script that has the same name as the item's tag
     // * inside this script you can manage scripts for all events by checking against
     // * GetUserDefinedItemEventNumber(). See x2_it_example.nss
     if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
     {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_ACTIVATE);
        int nRet =  ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
           return;
        }
     }

















//---------------------------------START DLA DM HORSE WIDGETS-----------------------------
/*
    if (GetTag(oItem) == "horse_dismt2")
    {
        AssignCommand(oActivator, ActionStartConversation(oActivator, "horse_dismnt_dla", TRUE));
        return;
    }
// Paladin Unsummon//
      if (GetTag(oItem) == "horse_unsummon")
    {
        object oPaladin = GetItemActivator();
        AssignCommand(oPaladin, HorseUnsummonPaladinMount());
        return;
    }

//---------------------------------START CEP HORSE WIDGETS-------------------------------

///////////////////////////////////////////////////////////////////////////////
    // Summon White Pony
///////////////////////////////////////////////////////////////////////////////
        if (sItemTag == "SummonHorse")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "henchman_pony", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Pony");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Pony"));
    }// end else (valid owyrmling)
        return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Spotted  Pony
///////////////////////////////////////////////////////////////////////////////
        if (sItemTag == "SummonHorse2")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "henchman_ponysp", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Pony");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Pony"));
    }// end else (valid owyrmling)
        return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Brown  Pony
///////////////////////////////////////////////////////////////////////////////
        if (sItemTag == "SummonHorse3")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "henchman_ponybn", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Pony");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Pony"));
    }// end else (valid owyrmling)
        return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Black Horse
///////////////////////////////////////////////////////////////////////////////
        if (sItemTag == "SummonHorse4")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "henchman_horsebk", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }// end else (valid owyrmling)
        return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Brown Horse
///////////////////////////////////////////////////////////////////////////////
        if (sItemTag == "SummonHorse5")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "henchman_horse2", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }// end else (valid owyrmling)
        return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Nightmare
///////////////////////////////////////////////////////////////////////////////
        if (sItemTag == "SummonHorse6")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "henchman_horsenm", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }// end else (valid owyrmling)
        return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon White Horse
///////////////////////////////////////////////////////////////////////////////
        if (sItemTag == "SummonHorse7")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "henchman_horsewt", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }// end else (valid owyrmling)
        return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Aurenthil Horse
///////////////////////////////////////////////////////////////////////////////
        if (sItemTag == "SummonHorse8")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "henchman_horseau", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }// end else (valid owyrmling)
        return;
    }
///////////////////////////////////////////////////////////////////////////////
    // CEP widget dismount
///////////////////////////////////////////////////////////////////////////////
        if (sItemTag == "horse_dismt")
    {
        object oPC = GetItemActivator();
        //if (GetTag (GetItemActivated ()) == "horse_dismt") {zep_Dismount (oPC, "horse_dismt");}
        string sResRef = GetLocalString(oPC,"PONY_ID");
        zep_Dismount (oPC, "horse_dismt");
        SetLocalInt(oPC,"bX3_IS_MOUNTED",FALSE);
        DeleteLocalString(oPC,"X3_HORSE_SCRIPT_DISMOUNT");
        SetLocalInt(oPC, "VAR_HORSEMOUNT", 0);//horselord class variable


    //remove horse support DLA Style
    object oRider=GetItemActivator();
    DelayCommand(1.0, HORSE_SupportOriginalSpeed(oRider));
    DelayCommand(1.0, HORSE_SupportRemoveMountedSkillDecreases(oRider));
    DelayCommand(1.0, HORSE_SupportRemoveACBonus(oRider));
    DelayCommand(1.0, HORSE_SupportRemoveHPBonus(oRider));

    object oTarget;
    location lPc = GetLocation(oPC);
    location lWyrmling = GetItemActivatedTargetLocation();

    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPC, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPC, ActionSpeakString("Invalid Horse/Pony"));
    }// end else (valid owyrmling)


        return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon CEP/DLA Horse Managemet to dismiss a Horse
///////////////////////////////////////////////////////////////////////////////
        if (GetTag(oItem) == "Horse_Management")
    {
        AssignCommand(oActivator, ActionStartConversation(oActivator, "horse_magmt", TRUE));
        return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Pack Camel
///////////////////////////////////////////////////////////////////////////////
        if (sItemTag == "SummonCamel")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "henchman_pkcamel", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Camel");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Camel"));
    }// end else (valid owyrmling)
        return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Pack Horse
///////////////////////////////////////////////////////////////////////////////
        if (sItemTag == "SummonpkHorse")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "henchman_pkhorse", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }// end else (valid owyrmling)
        return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Pack Ox
///////////////////////////////////////////////////////////////////////////////
        if (sItemTag == "SummonpkOx")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "henchman_pkox", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Ox");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Ox"));
    }// end else (valid owyrmling)
        return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Pack Pony
///////////////////////////////////////////////////////////////////////////////
        if (sItemTag == "Summonpkpony")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "henchman_pkpony", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Pony");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Pony"));
    }// end else (valid owyrmling)
        return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon CEP Flying System
///////////////////////////////////////////////////////////////////////////////
       if (GetTag(oItem) == "fly_widget")
    {
        AssignCommand(oActivator, ActionStartConversation(oActivator, "fly_control", TRUE));
        return;
    }

//---------------------------------START DLA HORSE WIDGETS-------------------------------
///////////////////////////////////////////////////////////////////////////////
    // Summon Walnut Horse Scale Barding
///////////////////////////////////////////////////////////////////////////////
    if (sItemTag == "Horse_1")
    {
    object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "dla_hvywarhorse2", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }// end else (valid owyrmling)
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Walnut Horse Leather Barding
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_2")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "dla_hvywarhorse3", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }// end else (valid owyrmling)
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Walnut Horse Red Barding
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_3")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "dla_hvywarhorse4", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }// end else (valid owyrmling)
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Walnut Horse Chain Barding
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_4")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "dla_hvywarhorse", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }// end else (valid owyrmling)
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Walnut Horse
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_5")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "dla_horse001", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }// end else (valid owyrmling)
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Purple Jousting Horse
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_6")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "dla_jousthorse1", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }// end else (valid owyrmling)
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Blue & Gold Jousting Horse
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_7")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "dla_jousthorse2", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }// end else (valid owyrmling)
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Black & White Jousting Horse
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_8")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "dla_jousthorse3", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }// end else (valid owyrmling)
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Red & Gold Jousting Horse
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_9")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "dla_jousthorse4", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }// end else (valid owyrmling)
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Red & Black  Jousting Horse
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_10")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "dla_jousthorse5", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }// end else (valid owyrmling)
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Gunpowder Grey Horse
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_11")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "horse002", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }// end else (valid owyrmling)
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Green Jousting Horse
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_12")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "jousthorse002", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }// end else (valid owyrmling)
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon White Jousting Horse
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_13")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "jousthorse003", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }// end else (valid owyrmling)
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon pink & Blue Jousting Horse
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_14")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "jousthorse004", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Horse");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Horse"));
    }// end else (valid owyrmling)
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon White Unicorn
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_15")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "cep_unicorn", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Unicorn");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Unicorn"));
    }// end else (valid owyrmling)
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Nightmare with Barding
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_16")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "dla_nightmare001", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Nightmare");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Nightmare"));
    }// end else (valid owyrmling)
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Nightmare Saddled
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_17")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "dla_nightmare003", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Nightmare");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Nightmare"));
    }// end else (valid owyrmling)
      return;
    }
///////////////////////////////////////////////////////////////////////////////
    // Summon Dark Unicorn
///////////////////////////////////////////////////////////////////////////////
    else if (sItemTag == "Horse_18")
    {
        object oPc = GetItemActivator();
    location lPc = GetLocation(oPc);
    location lWyrmling = GetItemActivatedTargetLocation();
    object oWyrmling = CreateObject(OBJECT_TYPE_CREATURE, "cep_unicorn001", lPc, TRUE);

/////////////////////////////////////// name the horse //////////////
         SetName (oWyrmling, GetName(GetItemActivator()) + "'s " + " Unicorn");
/////////////////////////////////////////////////////////////////////

    if (GetIsObjectValid(oWyrmling))
    {
        AddHenchman(oPc, oWyrmling);
    }// end then (valid owyrmling)
    else
    {
        AssignCommand(oPc, ActionSpeakString("Invalid Unicorn"));
    }// end else (valid owyrmling)
      return;
    }*/
/////////////////////END DLA HORSE WIDGETS////////////////////

}


