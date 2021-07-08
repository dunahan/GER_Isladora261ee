/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnrMystPublic
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

  //PrintString("cnrMystPublic init");

  /////////////////////////////////////////////////////////
  // CNR recipes made by cnrAnvilPublic
  /////////////////////////////////////////////////////////
  string sMenuMythWeapons = CnrRecipeAddSubMenu("cnrMystPublic", "Waffen");
  string sMenuMythArmors  = CnrRecipeAddSubMenu("cnrMystPublic", "Rüstungen");
  string sMenuMythAmmo    = CnrRecipeAddSubMenu("cnrMystPublic", "Munition");
  string sMenuMythPotions = CnrRecipeAddSubMenu("cnrMystPublic", "Tränke");
  string sMenuMythTraps   = CnrRecipeAddSubMenu("cnrMystPublic", "Fallen");
  string sMenuMythMisc    = CnrRecipeAddSubMenu("cnrMystPublic", "Sonstiges");

  CnrRecipeSetDeviceSpawnItemInDevice("cnrMystPublic", TRUE);
  CnrRecipeSetDevicePreCraftingScript("cnrMystPublic", "cnr_anvil_anim");
//CnrRecipeSetDeviceEquippedTool     ("cnrMystPublic", "cnrSmithsHammer", CNR_FLOAT_SMITH_HAMMER_BREAKAGE_PERCENTAGE);
  CnrRecipeSetDeviceTradeskillType   ("cnrMystPublic", CNR_TRADESKILL_WEAPON_CRAFTING);

  /////////////// Waffen ///////////////
  //


  /////////////// Rüstungen ///////////////
  //

  /////////////// Sonstiges ///////////////
  //

  // Artefakt: Portalstein
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuMythMisc, "Artefakt: Portalstein", "art_portstone", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "itm_ridkey_ports", 1, 1);  // Kristallscherbe
  CnrRecipeAddComponent(sKeyToRecipe, "itm_ridkey_staff", 1, 1);  // abgebrochener Stab mit zerstoerter Halterung
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",     1, 1);  // Waffenschaft
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resplatin",     5, 2);  // Platinbarren
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",       3, 1);  // Mithrilbarren
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant",    2, 1);  // Adamantbarren
  CnrRecipeAddComponent(sKeyToRecipe, "cnrEssBark",       3, 1);  // Flüssigkeit, Rinde
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbaglife",    3, 1);  // Beutel (Leben)
  CnrRecipeAddComponent(sKeyToRecipe, "itm_spdauerhv",    1, 1);  // 1 Spruchrolle, Dauerhafte Verzauberung
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 18);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 180, 180);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledMith", 0, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledAdam", 0, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial",   3, 3);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 3, 3);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 40, 30, 30, 0, 0, 0);

}
