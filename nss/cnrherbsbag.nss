/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnrHerbsBag
//
//  Desc:  Recipe initialization.
//
//  Author: Dunahan@schwerterkueste.de
//  Modified: Dunahan@schwerterkueste.de
//  Version: 1.0 (30.11.2010)
//
/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"
#include "_isla_inc"

void main()
{
  string sKeyToRecipe;

  //PrintString("cnrHerbsBag init");

  /////////////////////////////////////////////////////////
  // CNR recipes made by cnrHerbsBag
  /////////////////////////////////////////////////////////
  string sMenuHerbsHeal   = CnrRecipeAddSubMenu("cnrHerbsBag", "Heilendes");
  string sMenuHerbsProtec = CnrRecipeAddSubMenu("cnrHerbsBag", "Sch�tzendes");
  string sMenuHerbsMisc   = CnrRecipeAddSubMenu("cnrHerbsBag", "Verschiedenes");

  CnrRecipeSetDeviceSpawnItemInDevice("cnrHerbsBag", TRUE);
  CnrRecipeSetDevicePreCraftingScript("cnrHerbsBag", "cnr_herbs_anim");
//CnrRecipeSetDeviceInventoryTool    ("cnrHerbsBag", "");
  CnrRecipeSetDeviceTradeskillType   ("cnrHerbsBag", CNR_TRADESKILL_HERBS);

// - - - - - - - - - - - - - - - - - - - - Pasten - - - - - - - - - - - - - - - - - - - -//
// Paste: Kleinere Wunden heilen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuHerbsHeal, "Paste: Kleinere Wunden heilen", "hw_CurMinWnd", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrHawthornFwr", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGarlicClove", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 10, 10);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

// Paste: Leichte Wunden heilen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuHerbsHeal, "Paste: Leichte Wunden heilen", "hw_CurLigWnd", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrHawthornFwr", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGarlicClove", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrComfryRoot",  2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

// Kr�uterball: Leichte Krankheiten kurieren
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuHerbsHeal, "Kr�uterball: Leichte Krankheiten kurieren", "hw_CurMinIll", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrAloeLeaf",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrChamomileFwr", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 10, 10);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

// Kr�uterball: Schwere Krankheiten kurieren
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuHerbsHeal, "Kr�uterball: Schwere Krankheiten kurieren", "hw_CurMajIll", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrAloeLeaf",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrChamomileFwr", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrNettleLeaf",   2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

// Kr�uterball: Einfaches Gegengift
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuHerbsHeal, "Kr�uterball: Einfaches Gegengift", "hw_CurLigPoi", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMushroomBlk",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrHoney",         1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrChamomileFwr",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 10, 10);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

// Kr�uterball: St�rkeres Gegengift
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuHerbsHeal, "Kr�uterball: St�rkeres Gegengift", "hw_CurMajPoi", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMushroomBlk",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMushroomRed",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrHoney",        1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrChamomileFwr", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

// - - - - - - - - - - - - - - - - - - - - Zweite - - - - - - - - - - - - - - - - - - - -//



// - - - - - - - - - - - - - - - - - - - - Dritte - - - - - - - - - - - - - - - - - - - -//
// Paste: Rindenhaut
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuHerbsHeal, "Paste: Rindenhaut", "hw_PasteBark", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrBirchBark",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrHoney",      1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 10, 10);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

}

