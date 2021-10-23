/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnrFarmersMill
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

void InitFarmersMill()
{
  string sKeyToRecipe;

  sKeyToRecipe = CnrRecipeCreateRecipe("cnrFarmersMill", "Getreidemehl", "cnrCornFlour", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrCornRaw", 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 5, 5);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 20, 20, 20, 20, 20, 0);

  CnrDecrementStackCount(OBJECT_SELF);
}

void main()
{
  //PrintString("cnrFarmersMill init");

  /////////////////////////////////////////////////////////
  // CNR recipes made by cnrIngotRecycler
  /////////////////////////////////////////////////////////
  CnrRecipeSetDeviceTradeskillType("cnrFarmersMill", CNR_TRADESKILL_NONE);

  CnrIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, InitFarmersMill());

}

