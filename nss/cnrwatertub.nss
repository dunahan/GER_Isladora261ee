/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnrWaterTub
//
//  Desc:  Recipe initialization.
//
//  Author: David Bobeck 15May03
//
/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"

void main()
{
  string sKeyToRecipe;

  //PrintString("cnrWaterTub init");

  /////////////////////////////////////////////////////////
  // Default CNR recipes made in cnrWaterTub
  /////////////////////////////////////////////////////////

  sKeyToRecipe = CnrRecipeCreateRecipe("cnrWaterTub", "Eimer mit Wasser", "cnrBucketWater", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrBucketEmpty", 1);

}
