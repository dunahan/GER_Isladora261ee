/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnrCarpsBench
//
//  Desc:  Recipe initialization.
//
//  Author: David Bobeck 15May03
//  Modified: Dunahan@schwerterkueste.de
//  Version: 1.0 (30.11.2010)
//
/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"
#include "_isla_inc"

void main()
{
  string sKeyToRecipe;

  //PrintString("cnrCarpsBench init");

  /////////////////////////////////////////////////////////
  // CNR recipes made by cnrCarpsBench
  /////////////////////////////////////////////////////////
  string sMenuCarpTimbers = CnrRecipeAddSubMenu("cnrCarpsBench", "Nutzholz");
  string sMenuCarpWeapons = CnrRecipeAddSubMenu("cnrCarpsBench", "Waffen");

  string sMenuCarpBows    = CnrRecipeAddSubMenu("cnrCarpsBench", "Bögen");
  string sMenuCarpSBows   = CnrRecipeAddSubMenu(sMenuCarpBows, "Kurz");
  string sMenuCarpLBows   = CnrRecipeAddSubMenu(sMenuCarpBows, "Lang");
  string sMenuCarpCross   = CnrRecipeAddSubMenu("cnrCarpsBench", "Armbrüste");
  string sMenuCarpLCros   = CnrRecipeAddSubMenu(sMenuCarpCross, "Leichte");
  string sMenuCarpHCros   = CnrRecipeAddSubMenu(sMenuCarpCross, "Schwere");

  string sMenuCarpArrows  = CnrRecipeAddSubMenu("cnrCarpsBench", "Pfeile");
  string sMenuCarpBolts   = CnrRecipeAddSubMenu("cnrCarpsBench", "Bolzen");
  string sMenuCarpMisc    = CnrRecipeAddSubMenu("cnrCarpsBench", "Verschiedenes");

  CnrRecipeSetDeviceSpawnItemInDevice("cnrCarpsBench", TRUE);
  CnrRecipeSetDevicePreCraftingScript("cnrCarpsBench", "cnr_carp_anim");
  CnrRecipeSetDeviceInventoryTool    ("cnrCarpsBench", "cnrCarpsTools", CNR_FLOAT_CARPS_TOOLS_BREAKAGE_PERCENTAGE);
  CnrRecipeSetDeviceTradeskillType   ("cnrCarpsBench", CNR_TRADESKILL_WOOD_CRAFTING);

  ///////////////////////// Schreiner - Nutzholz //////////////////////////////
  // Eichenplanke
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpTimbers, "Eichenplanke", "hw_reseichp", 1);    // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "cnrBranchOak", 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resbagosdust", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Buchenplanke
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpTimbers, "Buchenplanke", "hw_resbuchp", 1);    // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "cnrBranchHic", 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resbagosdust", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Fichtenplanke
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpTimbers, "Fichtenplanke", "hw_resfichp", 1);    // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "cnrBranchMah", 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resbagosdust", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);


  ///////////////////////// Schreiner - Schäfte Bolzen/Pfeile //////////////////////////////
  // Pfeilschaft (99)
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpTimbers, "Pfeilschaft (99)", "hw_respfschft", 1);    // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "cnrBranchOak", 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resbagosdust", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Bolzenschaft (99)
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpTimbers, "Bolzenschaft (99)", "hw_resboschft", 1);    // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "cnrBranchOak", 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resbagosdust", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Waffenschaft
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpTimbers, "Waffenschaft", "hw_reswschft", 2);    // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "cnrBranchOak", 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resbagosdust", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);


  ///////////////////////// Schreiner - Stäbe für Verzauberung (Mag.Geschoss) //////////////////////////////
  // Eichenstab
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpTimbers, "Eichenstab", "hw_resestab", 2);    // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resbagosdust", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Buchenstab
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpTimbers, "Buchenstab", "hw_resbstab", 2);   // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbuchp", 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resbagosdust", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Fichtenstab
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpTimbers, "Fichtenstab", "hw_resfstab", 2);    // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resfichp", 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resbagosdust", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 11);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);


  ///////////////////////// Schreiner - Waffen //////////////////////////////
  // Keule
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpWeapons, "Keule", "NW_WBLCL001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrBranchOak", 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resbagosdust", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Keule +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpWeapons, "Keule +1", "NW_WBLMCL002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBLCL001", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Keule +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpWeapons, "Keule +2", "NW_WBLMCL010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBLMCL002", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbuchp", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Keule +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpWeapons, "Keule +3", "NW_WBLMCL011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBLMCL010", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resfichp", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Kampfstab
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpWeapons, "Kampfstab", "NW_WDBQS001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrBranchOak", 2);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resbagosdust", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Kampfstab +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpWeapons, "Kampfstab +1", "NW_WDBMQS002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBQS001", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Kampfstab +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpWeapons, "Kampfstab +2", "NW_WDBMQS008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBMQS002", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbuchp", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Kampfstab +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpWeapons, "Kampfstab +3", "NW_WDBMQS009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBMQS008", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resfichp", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);


  // Speer
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpWeapons, "Speer", "NW_WPLSS001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrBranchOak", 2);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resbagosdust", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Speer +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpWeapons, "Speer +1", "NW_WPLMSS002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WPLSS001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Speer +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpWeapons, "Speer +2", "NW_WPLMSS010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbuchp", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WPLMSS002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Speer +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpWeapons, "Speer +3", "NW_WPLMSS011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resfichp", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WPLMSS010", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);


  ///////////////////////// Schreiner - Bogen //////////////////////////////
  // Kurzbogen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpSBows, "Kurzbogen", "NW_WBWSH001", 1); // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbogshn", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resbagosdust", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Kurzbogen +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpSBows, "Kurzbogen +1", "NW_WBWMSH002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWSH001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Kurzbogen +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpSBows, "Kurzbogen +2", "NW_WBWMSH008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbuchp", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWMSH002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Kurzbogen +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpSBows, "Kurzbogen +3", "NW_WBWMSH009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resfichp", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWMSH008", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Kompositbogen (kurz) +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpSBows, "Kompositbogen (kurz) +1", "NW_WBWMSH010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWSH001", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbgrol", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Kompositbogen (kurz) +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpSBows, "Kompositbogen (kurz) +2", "NW_WBWMSH011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbuchp", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWMSH010", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Kompositbogen (kurz) +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpSBows, "Kompositbogen (kurz) +3", "NW_WBWMSH012", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resfichp", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWMSH011", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);


  // Langbogen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpLBows, "Langbogen", "NW_WBWLN001", 1); // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbogshn", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resbagosdust", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Langbogen +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpLBows, "Langbogen +1", "NW_WBWMLN002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWLN001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Langbogen +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpLBows, "Langbogen +2", "NW_WBWMLN008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbuchp", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWMLN002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Langbogen +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpLBows, "Langbogen +3", "NW_WBWMLN009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resfichp", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWMLN008", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 11);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);


  // Kompositbogen (lang) +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpLBows, "Kompositbogen (lang) +1", "NW_WBWMLN010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWLN001", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbgrol", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Kompositbogen (lang) +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpLBows, "Kompositbogen (lang) +2", "NW_WBWMLN011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWMLN010", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbuchp", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Kompositbogen (lang) +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpLBows, "Kompositbogen (lang) +3", "NW_WBWMLN012", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWMLN011", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resfichp", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);


  ///////////////////////// Schreiner - Armbrust //////////////////////////////
  // Leichte Armbrust
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpLCros, "Leichte Armbrust", "NW_WBWXL001", 1); // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbogshn", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resbagosdust", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Leichte Armbrust +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpLCros, "Leichte Armbrust +1", "NW_WBWMXL002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWXL001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Leichte Armbrust +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpLCros, "Leichte Armbrust +2", "NW_WBWMXL008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbuchp", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWMXL002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Leichte Armbrust +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpLCros, "Leichte Armbrust +3", "NW_WBWMXL009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resfichp", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWMXL008", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);


  // Kompositarmbrust (Leicht) +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpLCros, "Kompositarmbrust (Leicht) +1", "itm_leicarmbr001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWXL001", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbgrol", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Kompositarmbrust (Leicht) +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpLCros, "Kompositarmbrust (Leicht) +2", "itm_leicarmbr002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "itm_leicarmbr001", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbuchp", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Kompositarmbrust (Leicht) +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpLCros, "Kompositarmbrust (Leicht) +2", "itm_leicarmbr003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "itm_leicarmbr002", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resfichp", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);


  // Schwere Armbrust
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpHCros, "Schwere Armbrust", "NW_WBWXH001", 1); // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 5);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbogshn", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resbagosdust", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Schwere Armbrust +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpHCros, "Schwere Armbrust +1", "NW_WBWMXH002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWXH001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Schwere Armbrust +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpHCros, "Schwere Armbrust +2", "NW_WBWMXH008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbuchp", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWMXH002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Schwere Armbrust +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpHCros, "Schwere Armbrust +3", "NW_WBWMXH009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resfichp", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWMXH008", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);


  // Kompositarmbrust (Schwer) +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpHCros, "Kompositarmbrust (Schwer) +1", "itm_schwarmbr001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWXH001", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbgrol", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Kompositarmbrust (Schwer) +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpHCros, "Kompositarmbrust (Schwer) +2", "itm_schwarmbr002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "itm_schwarmbr001", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbuchp", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Kompositarmbrust (Schwer) +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpHCros, "Kompositarmbrust (Schwer) +3", "itm_schwarmbr003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "itm_schwarmbr002", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resfichp", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);


  ///////////////////////// Schreiner - Pfeile //////////////////////////////
  // Pfeil
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpArrows, "Pfeil", "NW_WAMAR001", 99); // Basis, erschafft 99 Pfeile!
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respfschft",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respfspitz",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrFeathers", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Pfeil +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpArrows, "Pfeil +1", "NW_WAMMAR009", 99); // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMAR001",    99, 99);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrFeathers", 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Pfeil +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpArrows, "Pfeil +2", "NW_WAMMAR010", 99); // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMAR009",   99, 99);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrFeathers", 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Pfeil +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpArrows, "Pfeil +3", "NW_WAMMAR011", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMAR010",   99, 99);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrFeathers", 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);


  // Pfeil des Zerschmetterns
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpArrows, "Pfeil des Zerschmetterns", "hw_wamar012", 99);   // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMAR001", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Durchdringungspfeil
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpArrows, "Durchdringungspfeil", "NW_WAMMAR004", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMAR001", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Geweihter Pfeil
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpArrows, "Geweihter Pfeil", "hw_wamar013", 99);  // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "X1_WMGRENADE005", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMAR001", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);


  // Feuerpfeil
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpArrows, "Feuerpfeil", "NW_WAMMAR002", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMAR009", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Kältepfeil
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpArrows, "Kältepfeil", "NW_WAMMAR005", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMAR009", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Blitzpfeil
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpArrows, "Blitzpfeil", "NW_WAMMAR006", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMAR009", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);


  // Donnerpfeil
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpArrows, "Donnerpfeil", "hw_wamar014", 99);  // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMAR010", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Giftpfeil
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpArrows, "Giftpfeil", "NW_WAMMAR008", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMAR010", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Säurepfeil
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpArrows, "Säurepfeil", "NW_WAMMAR003", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMAR010", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Feuerballpfeil
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpArrows, "Feuerballpfeil", "hw_firebarr", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMAR011", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Todespfeil
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpArrows, "Todespfeil", "hw_deatharr", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessdeath", 5);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMAR011", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 15);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 150, 150);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  ///////////////////////// Schreiner - Bolzen //////////////////////////////
  // Bolzen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpBolts, "Bolzen", "NW_WAMBO001", 99); // Basis, erschafft 99 Bolzen
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resboschft", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbospitz", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrFeathers", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Bolzen +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpBolts, "Bolzen +1", "NW_WAMMBO008", 99); // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMBO001", 99, 99);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrFeathers", 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Bolzen +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpBolts, "Bolzen +2", "NW_WAMMBO009", 99); // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMBO008", 99, 99);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrFeathers", 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Bolzen +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpBolts, "Bolzen +3", "NW_WAMMBO010", 99); // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMBO009", 99, 99);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrFeathers", 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);


  // Bolzen des Zerschmetterns
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpBolts, "Bolzen des Zerschmetterns", "hw_wammbo011", 99);  // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMBO001", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Durchdringungsbolzen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpBolts, "Durchdringungsbolzen", "NW_WAMMBO004", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMBO001", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Geweihter Bolzen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpBolts, "Geweihter Bolzen", "hw_wammbo012", 99);  // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "x1_wmgrenade005", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMBO001", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);


  // Feuerbolzen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpBolts, "Feuerbolzen", "NW_WAMMBO005", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMBO008", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Frostbolzen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpBolts, "Frostbolzen", "NW_WAMMBO001", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMBO008", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Blitzbolzen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpBolts, "Blitzbolzen", "NW_WAMMBO002", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMBO008", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);


  // Donnerbolzen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpBolts, "Donnerbolzen", "hw_wammbo013", 99);  // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMBO009", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Giftbolzen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpBolts, "Giftbolzen", "NW_WAMMBO007", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMBO009", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Säurebolzen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpBolts, "Säurebolzen", "hw_wammbo014", 99);  // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMBO009", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Feuerballbolzen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpBolts, "Feuerballbolzen", "hw_firebbol", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMAR011", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Todesbolzen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpBolts, "Todesbolzen", "hw_deathbol", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessdeath", 5);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMAR011", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 15);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 150, 150);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);


  ///////////////////////// Schreiner - Verschiedenes //////////////////////////////
  // Leerer Wassereimer
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpMisc, "Leerer Wassereimer", "hw_resempbuck", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 4);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswireir", 2);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resbagosdust", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Fackel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpMisc, "Fackel", "NW_IT_TORCH001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resrope",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Großer Behälter
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuCarpMisc, "Großer Behälter", "NW_IT_CONTAIN001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 4);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resbagosdust", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

}
