/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnrGemStone
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

  //PrintString("cnrGemStone init");

  /////////////////////////////////////////////////////////
  //  CNR recipes made by cnrGemStone
  /////////////////////////////////////////////////////////
  string sMenuGemCut  = CnrRecipeAddSubMenu("cnrGemStone", "Edelsteine");

  CnrRecipeSetDeviceSpawnItemInDevice("cnrGemStone", TRUE);
  CnrRecipeSetDevicePreCraftingScript("cnrGemStone", "cnr_gemcut_anim");
  CnrRecipeSetDeviceInventoryTool    ("cnrGemStone", "cnrGemTools", CNR_FLOAT_GEM_CRAFTERS_TOOLS_BREAKAGE_PERCENTAGE);
  CnrRecipeSetDeviceTradeskillType   ("cnrGemStone", CNR_TRADESKILL_GEM_CRAFTING);

  //// Edelsteine ////
  // Grünstein
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuGemCut, "Grünstein", "NW_IT_GEM001", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemMineral001",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagosand",      1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrGemDust001", 2, 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Malachit
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuGemCut, "Malachit", "NW_IT_GEM007", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemMineral007",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagosand",      1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrGemDust007", 2, 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Feuerachat
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuGemCut, "Feuerachat", "NW_IT_GEM002", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemMineral002",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagosand",      1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrGemDust002", 2, 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Phenalope
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuGemCut, "Phenalope", "NW_IT_GEM004", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemMineral004",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagosand",      1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrGemDust004", 2, 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Aventurin
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuGemCut, "Aventurin", "NW_IT_GEM014", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemMineral014",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagosand",      1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrGemDust014", 2, 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Amethyst
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuGemCut, "Amethyst", "NW_IT_GEM003", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemMineral003",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagosand",      1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrGemDust003", 2, 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Feldspat
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuGemCut, "Feldspat", "NW_IT_GEM015", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemMineral015",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagosand",      1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrGemDust015", 2, 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Granat
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuGemCut, "Granat", "NW_IT_GEM011", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemMineral011",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagosand",      1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrGemDust011", 2, 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Alexandrit
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuGemCut, "Alexandrit", "NW_IT_GEM013", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemMineral013",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagosand",      1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrGemDust013", 2, 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Topas
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuGemCut, "Topas", "NW_IT_GEM010", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemMineral010",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagosand",      1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrGemDust010", 2, 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Saphir
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuGemCut, "Saphir", "NW_IT_GEM008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemMineral008",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagosand",      1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrGemDust008", 2, 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Feueropal
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuGemCut, "Feueropal", "NW_IT_GEM009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemMineral009",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagosand",      1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrGemDust009", 2, 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 14);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 150, 150);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Diamant
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuGemCut, "Diamant", "NW_IT_GEM005", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemMineral005",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagosand",      1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrGemDust005", 2, 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 14);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 150, 150);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Rubin
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuGemCut, "Rubin", "NW_IT_GEM006", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemMineral006",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagosand",      1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrGemDust006", 2, 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 17);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 180, 180);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Smaragd
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuGemCut, "Smaragd", "NW_IT_GEM012", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemMineral012",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagosand",      1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrGemDust012", 2, 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 18);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 190, 190);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

}
