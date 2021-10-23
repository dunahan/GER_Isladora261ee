#include "x3_inc_horse"
#include "x3_inc_skin"

#include "habd_include"
#include "eds_include"
#include "_isla_inc"
#include "_isla_races"
#include "ll_include"
#include "cnr_recipe_utils"

#include "_debugisla"

void main()
{
  object oPC = GetEnteringObject();                                             DebugMode(GetName(oPC)+"\n"+GetPCIPAddress(oPC)+"\n"+GetPCPlayerName(oPC)+"\n"+GetPCPublicCDKey(oPC, TRUE)+"\n");
  int i, n; object oQuestbuch, oPlayerSkin;

  if (!GetIsObjectValid(oPC)) return;                                           // stop script if player disconnects or isn't available!

  ExecuteScript("x3_mod_pre_enter", OBJECT_SELF);                               // Override for other skin systems from "x3_mod_def_enter"

//------------------------------ Isladoras Schlafmodus -------------------------
  UnpauseModule();                                                              DebugMode("Wake the module from sleeping phase."+"\n");

//------------------------------------ Isladora SL -----------------------------
//---------------------------- from "x3_mod_def_enter" -------------------------
  if ((GetIsPC(oPC) || GetIsDM(oPC)) && !GetHasFeat(FEAT_HORSE_MENU, oPC))      // only for pc/dm if they haven't got horse menu?
  {                                                                             DebugMode("Starting snippet from x3_mod_def_enter."+"\n");
    HorseAddHorseMenu(oPC);                                                     // add horse menu
                                                                                DebugMode("Added horse Menu if not available.");
    if (GetLocalInt(GetModule(), "X3_ENABLE_MOUNT_DB"))                         // restore PC horse status from database
      DelayCommand(2.0, HorseReloadFromDatabase(oPC, X3_HORSE_DATABASE));       DebugMode("Restored horse status from database.");
  }

  n = GetLocalInt(GetModule(), "PC_Notes");                                     // currently seven
  for (i=1;i<=n;i++)
    AddJournalQuestEntry("PC_Notes00"+IntToString(i), 1, oPC, FALSE, FALSE, FALSE);

  if (GetIsDM(oPC)                                                                  ||
     (GetPCPublicCDKey(oPC) == "")                                                  ||
     (GetPCPlayerName(oPC) == "dunahan"     && GetPCPublicCDKey(oPC) == "UPW9NCE4") ||
     (GetPCPlayerName(oPC) == "dun_android" && GetPCPublicCDKey(oPC) == "UPRC7UHQ") ||
     (GetPCPlayerName(oPC) == "Antoss"      && GetPCPublicCDKey(oPC) == "UXFFHRPN") ||
     (GetPCPlayerName(oPC) == "Draghetto"   && GetPCPublicCDKey(oPC) == "UPEPJH6L")
     )
  {
    n = GetLocalInt(GetModule(), "SL_Notes");
    for (i=1;i<=n;i++)
      AddJournalQuestEntry("SL_Notes00"+IntToString(i), 1, oPC, FALSE, FALSE, FALSE);

    DebugMode("A DM entered, so give him the needed tools."+"\n");
    if(!HasItem(oPC, "itm_slcreaturwiz")) CreateItemOnObject("itm_slcreaturwiz", oPC);  // (OOC) Aussehen beeinflussen
    if(!HasItem(oPC, "itm_slgivesep"))    CreateItemOnObject("itm_slgivesep", oPC);     // (OOC) EP-Vergabe
    if(!HasItem(oPC, "itm_slportspawn"))  CreateItemOnObject("itm_slportspawn", oPC);   // (OOC) Portal erschaffen
    if(!HasItem(oPC, "i_dm_tink"))        CreateItemOnObject("i_dm_tink", oPC);         // (OOC) Tinkerbells Windspiel
    if(!HasItem(oPC, "port_metotargets")) CreateItemOnObject("port_metotargets", oPC);  // (OOC) Portstein

    if(!HasItem(oPC, "itm_areacleanstp")) CreateItemOnObject("itm_areacleanstp", oPC);  // (SL) Area-Cleanstopper erschaffen
    if(!HasItem(oPC, "igi_modn_itm"))     CreateItemOnObject("igi_modn_itm", oPC);      // (SL) Gegenstand (Verändern)
    if(!HasItem(oPC, "msc_modn_itm"))     CreateItemOnObject("msc_modn_itm", oPC);      // (SL) Gegenstand (Verschiedenes)
  //if(!HasItem(oPC, "cnrxpadjrod"))      CreateItemOnObject("cnrxpadjrod", oPC);       // (SL) HW Zepter der Erfahrung
  //if(!HasItem(oPC, "lwjb_p_jukebox"))   CreateItemOnObject("lwjb_p_jukebox", oPC);    // (SL) Jukebox-System
    if(!HasItem(oPC, "itm_copyall"))      CreateItemOnObject("itm_copyall", oPC);       // (SL) Kopieren
    if(!HasItem(oPC, "spawn_ban_rod"))    CreateItemOnObject("spawn_ban_rod", oPC);     // (SL) Spawnsystem beeinflussen
  //if(!HasItem(oPC, "x3_dm_tool01"))     CreateItemOnObject("x3_dm_tool01", oPC);      // (SL) Tool
    if(!HasItem(oPC, "itm_destroyall"))   CreateItemOnObject("itm_destroyall", oPC);    // (SL) Zerstoeren
    if(!HasItem(oPC, "tele_container"))   CreateItemOnObject("tele_container", oPC);    // (SL) Teleportkontainer rufen
    if(!HasItem(oPC, "key_ultimate"))     CreateItemOnObject("key_ultimate", oPC);      // (SL) Zentralschluessel

    if (GetIsDM(oPC)) return;                                                   // stop script if it was a dm
  }

  if (GetIsPC(oPC))                                                             // more details
  {                                                                             DebugMode("PC; Get was mounted from last exit?");
    oPlayerSkin = SKIN_SupportGetSkin(oPC);

    if (!GetSkinInt(oPC,"bX3_IS_MOUNTED"))                                      // restore appearance in case you export your character in mounted form, etc.
      HorseIfNotDefaultAppearanceChange(oPC);                                   DebugMode("Eventually, set to defaults.");

    HorsePreloadAnimations(oPC);                                                // pre-cache horse animations for player as attaching a tail to the model
    DelayCommand(3.0, HorseRestoreHenchmenLocations(oPC));                      DebugMode("Pre-cached anims and restore horse?");

//--------------------------------Isladora Commands-----------------------------
    SetLocalInt(oPC, "SaveOnExit", 0);                                            // Reset saving funcs

    if (!HasItem(oPC, "itm_questbuch"))
      oQuestbuch = CreateItemOnObject("itm_questbuch", oPC);

    WriteTimestampedLogEntry(GetName(oPC)+" has "+GetName(oQuestbuch));

/*  if (!GetHasFeat(FEAT_PLAYER_TOOL_01, oPC))
    {
      if (GetIsObjectValid(oPlayerSkin))
      {
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(IP_CONST_FEAT_PLAYER_TOOL_01), oPlayerSkin);
        SendServerMessageToPC(oPC, "Feat Spielerwerkzeug 1 erhalten. Nutze dies um deine Begleiter zu kommandieren.");
      }
    }

    if (!HasItem(oPC, "x3_pl_tool01"))
    {
      SendServerMessageToPC(oPC, "Spielerwerkzeug 1 erhalten. Nutze dies um deine Begleiter zu kommandieren.");
      CreateItemOnObject("x3_pl_tool01", oPC);
    }
*/
//---------------------------------Isladora Questline---------------------------
    if (GetXP(oPC) <= 0)
    {                                                                           DebugMode("Entered the first time. We're giving the starting goods."+"\n");
      GiveGoldToCreature(oPC, (1500-GetGold(oPC)));                             // Gold geben
      CreateItemOnObject("cnrrationen_food", oPC, 5);                           // Rationen geben
    //SubraceOnClientEnter(oPC);                                                // Subrasse prüfen und Char anpassen

      GiveXPToCreature(oPC, 1);                                                 DebugMode("First entry done, so make shure this doesn't occour twice."+"\n");
    }

//-------------------------------- Legendary Levels ----------------------------
    LegendaryLevelsRecalculate(oPC);                                            DebugMode("Legendary levels."+"\n");

//--------------------------------- Isladora AFKsys ----------------------------
    AFKCheck(oPC);                                                              DebugMode("AFK check."+"\n");

//------------------------------ Isladora Positionssys -------------------------
    SendPositionToDB(oPC);                                                      DebugMode("Save positions."+"\n");
    DelayedSavePosition(oPC, oQuestbuch);

//--------------------------------- Isladora Timesys ---------------------------
    Time_Update();                                                              DebugMode("Update time."+"\n");

//------------------------------ Isladora HABD & CNR ---------------------------
    HABDGetDBOnClientEnter(oPC);
    ExecuteScript("cnr_module_oce", oPC);                                       DebugMode("A PC entered, so check CNR and HABD."+"\n");

//---------------------------------Isladora PC Log------------------------------
    DebugMode("Spieler "+GetPCPlayerName(oPC) +" mit der IP "+GetPCIPAddress(oPC)+" betrat den Server.");
  }

//--------------------------------- CRAP & norm  -------------------------------//not needed, is included above, see horses
//ExecuteScript("x3_mod_def_enter", OBJECT_SELF);                               //Normal OnClientEnter Skript
}
