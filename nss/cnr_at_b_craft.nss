/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_at_b_craft
//
//  Desc:  This script is run by the cnr_c_recipebook
//         convo when the player chooses to craft
//         a recipe.
//
//  Author: David Bobeck 11Jan03
//
/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"
void main()
{
  object oPC = GetPCSpeaker();
  int nMenuPage = GetLocalInt(oPC, "nCnrMenuPage");
  int nCraftIndex = GetLocalInt(oPC, "nCnrCraftIndex");
  CnrRecipeAttemptToCraft(oPC, OBJECT_SELF, (nMenuPage*CNR_SELECTIONS_PER_PAGE)+nCraftIndex, CNR_CONVO_CRAFTING);
}
