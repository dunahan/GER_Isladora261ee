/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnrIngotRecycler
//
//  Desc:  Recipe initialization.
//
//  Author: David Bobeck 15May03
//  Modified: Dunahan@schwerterkueste.de
//  Version: 1.0 (30.11.2010)
//
/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"

void InitIngotRecyclerMangled()
{
  string sKeyToRecipe;

  sKeyToRecipe = CnrRecipeCreateRecipe("cnrIngotRecycler", "Barren Eisen", "hw_resiron", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMangledIron", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 5, 5);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 20, 20, 20, 20, 20, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe("cnrIngotRecycler", "Barren Silber", "hw_ressilver", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMangledSilv", 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 5, 5);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 20, 20, 20, 20, 20, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe("cnrIngotRecycler", "Barren Gold", "hw_resgold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMangledGold", 3);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 5, 5);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 20, 20, 20, 20, 20, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe("cnrIngotRecycler", "Barren Platin", "hw_resplatin", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMangledPlat", 3);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 5, 5);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 20, 20, 20, 20, 20, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe("cnrIngotRecycler", "Barren Mithril", "hw_resmith", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMangledMith", 4);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 5, 5);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 20, 20, 20, 20, 20, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe("cnrIngotRecycler", "Barren Adamant", "hw_resadamant", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMangledAdam", 5);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 5, 5);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 20, 20, 20, 20, 20, 0);

  CnrDecrementStackCount(OBJECT_SELF);
}

void main()
{
  //PrintString("cnrIngotRecycler init");

  /////////////////////////////////////////////////////////
  // CNR recipes made by cnrIngotRecycler
  /////////////////////////////////////////////////////////
  CnrRecipeSetDevicePreCraftingScript("cnrIngotRecycler", "cnr_recycle_anim");
  CnrRecipeSetDeviceTradeskillType("cnrIngotRecycler", CNR_TRADESKILL_NONE);

  CnrIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, InitIngotRecyclerMangled());

}
