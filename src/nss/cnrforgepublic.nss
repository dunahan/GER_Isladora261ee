/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnrForgePublic
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

  //PrintString("cnrForgePublic init");

  /////////////////////////////////////////////////////////
  // CNR recipes made by cnrForgePublic
  /////////////////////////////////////////////////////////
  string sMenuForgeMetal = CnrRecipeAddSubMenu("cnrForgePublic", "Metall");
  string sMenuForgeMolds = CnrRecipeAddSubMenu("cnrForgePublic", "Ton");
  string sMenuForgeGlass = CnrRecipeAddSubMenu("cnrForgePublic", "Glas");

  CnrRecipeSetDeviceSpawnItemInDevice("cnrForgePublic", TRUE);
  CnrRecipeSetDevicePreCraftingScript("cnrForgePublic", "cnr_forge_anim");
  CnrRecipeSetDeviceTradeskillType   ("cnrForgePublic", CNR_TRADESKILL_SMELTING);

  ///// Metall /////
  // Eisen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuForgeMetal, "Eisen", "hw_resiron", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrNuggetIron", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 20, 20, 20, 20, 20, 0);

  // Silber
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuForgeMetal, "Silber", "hw_ressilver", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrNuggetSilv", 2, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 20, 20, 20, 20, 20, 0);

  // Gold
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuForgeMetal, "Gold", "hw_resgold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrNuggetGold", 2, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 20, 20, 20, 20, 20, 0);

  // Platin
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuForgeMetal, "Platin", "hw_resplatin", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrNuggetPlat", 2, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 20, 20, 20, 20, 20, 0);

  // Mithril
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuForgeMetal, "Mithril", "hw_resmith", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrNuggetMith", 3, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 20, 20, 20, 20, 20, 0);

  // Adamant
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuForgeMetal, "Adamant", "hw_resadamant", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrNuggetAdam", 4, 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 20, 20, 20, 20, 20, 0);

  //// Ton ////
  // Kleiner Guﬂrohling
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuForgeMolds, "Kleiner Guﬂrohling", "hw_reslilmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrLumpOfClay", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 20, 20, 20, 20, 20, 0);

  // Mittlerer Guﬂrohling
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuForgeMolds, "Mittlerer Guﬂrohling", "hw_resmedmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrLumpOfClay", 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 20, 20, 20, 20, 20, 0);

  // Groﬂer Guﬂrohling
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuForgeMolds, "Groﬂer Guﬂrohling", "hw_reslarmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrLumpOfClay", 3);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 20, 20, 20, 20, 20, 0);

  //// Glass ////
  // Glasrohling
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuForgeGlass, "Glasrohling", "hw_resglass", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagosand", 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 20, 20, 20, 20, 20, 0);

  // Phiole
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuForgeGlass, "Phiole", "hw_glassphio", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resglass", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 20, 20, 20, 20, 20, 0);

  // Flasche
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuForgeGlass, "Flasche", "hw_glassvial", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resglass", 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 20, 20, 20, 20, 20, 0);

}
