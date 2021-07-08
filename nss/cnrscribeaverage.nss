/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnrScribeAverage
//
//  Desc:  Recipe initialization.
//
//  Author: Gary Corcoran 19May03
//  Modified: Dunahan@schwerterkueste.de
//
/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"
#include "_isla_inc"

void main()
{
  string sKeyToRecipe;

  //PrintString("cnrScribeAverage init");

  /////////////////////////////////////////////////////////
  // Default CNR recipes made in cnrScribeAverage
  /////////////////////////////////////////////////////////
  string sMenuLevel5Scrolls = CnrRecipeAddSubMenu("cnrScribeAverage", "Fünfter Grad");
  string sMenuLevel6Scrolls = CnrRecipeAddSubMenu("cnrScribeAverage", "Sechster Grad");
  string sMenuLevel7Scrolls = CnrRecipeAddSubMenu("cnrScribeAverage", "Siebter Grad");
  string sMenuLevel8Scrolls = CnrRecipeAddSubMenu("cnrScribeAverage", "Achter Grad");
  string sMenuLevel9Scrolls = CnrRecipeAddSubMenu("cnrScribeAverage", "Neunter Grad");

  CnrRecipeSetDeviceSpawnItemInDevice("cnrScribeAverage", TRUE);
  CnrRecipeSetDevicePreCraftingScript("cnrScribeAverage", "cnr_scribe_anim");
  CnrRecipeSetDeviceInventoryTool    ("cnrScribeAverage", "cnrScribeTools");
  CnrRecipeSetDeviceTradeskillType   ("cnrScribeAverage", CNR_TRADESKILL_SCRIBING);


// Grad 5 Zauber
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "X1_IT_SPARSCR502"), "X1_IT_SPARSCR502", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BIGBYS_INTERPOSING_HAND);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "X2_IT_SPARSCR501"), "X2_IT_SPARSCR501", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BALL_LIGHTNING);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "X2_IT_SPDVSCR509"), "X2_IT_SPDVSCR509", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, 566);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "X2_IT_SPARSCR503"), "X2_IT_SPARSCR503", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ENERGY_BUFFER);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "X2_IT_SPDVSCR508"), "X2_IT_SPDVSCR508", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_AWAKEN);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "X1_IT_SPARSCR501"), "X1_IT_SPARSCR501", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_FIREBRAND);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "X1_IT_SPDVSCR403"), "X1_IT_SPDVSCR403", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_FLAME_STRIKE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "NW_IT_SPARSCR501"), "NW_IT_SPARSCR501", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DISMISSAL);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "NW_IT_SPARSCR506"), "NW_IT_SPARSCR506", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MIND_FOG);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  // Multispruch, Höhere Schattenbeschwörung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "NW_IT_SPARSCR508"), "NW_IT_SPARSCR508", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, 71);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "X1_IT_SPDVSCR501"), "X1_IT_SPDVSCR501", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_INFERNO);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "NW_IT_SPARSCR507"), "NW_IT_SPARSCR507", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CONE_OF_COLD);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "X2_IT_SPDVSCR505"), "X2_IT_SPDVSCR505", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_HEALING_CIRCLE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "X2_IT_SPDVSCR504"), "X2_IT_SPDVSCR504", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CIRCLE_OF_DOOM);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "X2_IT_SPARSCR502"), "X2_IT_SPARSCR502", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MESTILS_ACID_SHEATH);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "NW_IT_SPARSCR505"), "NW_IT_SPARSCR505", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_HOLD_MONSTER);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "NW_IT_SPARSCR510"), "NW_IT_SPARSCR510", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SUMMON_CREATURE_V);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "X2_IT_SPDVSCR502" ), "X2_IT_SPDVSCR502", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MONSTROUS_REGENERATION);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "NW_IT_SPARSCR503"), "NW_IT_SPARSCR503", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DOMINATE_PERSON);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "X2_IT_SPDVSCR503"), "X2_IT_SPDVSCR503", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_VINE_MINE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "X2_IT_SPDVSCR501"), "X2_IT_SPDVSCR501", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BATTLETIDE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "X2_IT_SPDVSCR506"), "X2_IT_SPDVSCR506", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SLAY_LIVING);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "NW_IT_SPARSCR511"), "NW_IT_SPARSCR511", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_LESSER_MIND_BLANK);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "NW_IT_SPARSCR512"), "NW_IT_SPARSCR512", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_LESSER_PLANAR_BINDING);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "NW_IT_SPARSCR513"), "NW_IT_SPARSCR513", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_LESSER_SPELL_MANTLE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "NW_IT_SPARSCR504"), "NW_IT_SPARSCR504", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_FEEBLEMIND);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "NW_IT_SPARSCR502"), "NW_IT_SPARSCR502", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CLOUDKILL);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "NW_IT_SPARSCR509"), "NW_IT_SPARSCR509", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ANIMATE_DEAD);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "NW_IT_SPDVSCR501"), "NW_IT_SPDVSCR501", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_RAISE_DEAD);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "X1_IT_SPDVSCR502"), "X1_IT_SPDVSCR502", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_OWLS_INSIGHT);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel5Scrolls, GetObjectName( "X2_IT_SPDVSCR507"), "X2_IT_SPDVSCR507", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SPELL_RESISTANCE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);


// Grad 6 Zauber
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "NW_IT_SPARSCR608"), "NW_IT_SPARSCR608", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ETHEREAL_VISAGE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "X1_IT_SPARSCR602"), "X1_IT_SPARSCR602", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BIGBYS_FORCEFUL_HAND);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "NW_IT_SPARSCR604"), "NW_IT_SPARSCR604", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_PLANAR_BINDING);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "X1_IT_SPDVSCR604"), "X1_IT_SPDVSCR604", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DROWN);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "X1_IT_SPARSCR604"), "X1_IT_SPARSCR604", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_STONE_TO_FLESH);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "X1_IT_SPARSCR601"), "X1_IT_SPARSCR601", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DIRGE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "X2_IT_SPDVSCR605"), "X2_IT_SPDVSCR605", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_HEAL);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "X1_IT_SPARSCR603"), "X1_IT_SPARSCR603", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ISAACS_GREATER_MISSILE_STORM);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "X2_IT_SPDVSCR603"), "X2_IT_SPDVSCR603", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BLADE_BARRIER);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "NW_IT_SPARSCR601"), "NW_IT_SPARSCR601", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_GLOBE_OF_INVULNERABILITY);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "NW_IT_SPARSCR607"), "NW_IT_SPARSCR607", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CHAIN_LIGHTNING);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "X2_IT_SPDVSCR604"), "X2_IT_SPDVSCR604", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_HARM);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "NW_IT_SPARSCR602"), "NW_IT_SPARSCR602", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_GREATER_DISPELLING);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "NW_IT_SPARSCR612"), "NW_IT_SPARSCR612", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_GREATER_SPELL_BREACH);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "NW_IT_SPARSCR613"), "NW_IT_SPARSCR613", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_GREATER_STONESKIN);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "NW_IT_SPARSCR611"), "NW_IT_SPARSCR611", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MASS_HASTE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "NW_IT_SPARSCR605"), "NW_IT_SPARSCR605", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SUMMON_CREATURE_VI);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "X2_IT_SPARSCR602"), "X2_IT_SPARSCR602", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_LEGEND_LORE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "NW_IT_SPARSCR603"), "NW_IT_SPARSCR603", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ACID_FOG);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  // Multispruch, Schatten
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "NW_IT_SPARSCR609"), "NW_IT_SPARSCR609", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, 158);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "X1_IT_SPARSCR605"), "X1_IT_SPARSCR605", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_FLESH_TO_STONE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "X2_IT_SPDVSCR602"), "X2_IT_SPDVSCR602", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_STONEHOLD);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "nw_it_sparscr614"), "nw_it_sparscr614", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_TENSERS_TRANSFORMATION);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "X2_IT_SPARSCR601"), "X2_IT_SPARSCR601", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_UNDEATH_TO_DEATH);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "NW_IT_SPARSCR610"), "NW_IT_SPARSCR610", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CIRCLE_OF_DEATH);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "X1_IT_SPDVSCR603"), "X1_IT_SPDVSCR603", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_PLANAR_ALLY);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "NW_IT_SPARSCR606"), "NW_IT_SPARSCR606", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_TRUE_SEEING);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel6Scrolls, GetObjectName( "X2_IT_SPDVSCR601" ), "X2_IT_SPDVSCR601", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CRUMBLE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);


// Grad 7 Zauber
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel7Scrolls, GetObjectName( "NW_IT_SPDVSCR702"), "NW_IT_SPDVSCR702", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_RESURRECTION);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel7Scrolls, GetObjectName( "X1_IT_SPDVSCR701"), "X1_IT_SPDVSCR701", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_AURA_OF_VITALITY);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel7Scrolls, GetObjectName( "X1_IT_SPARSCR701"), "X1_IT_SPARSCR701", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BIGBYS_GRASPING_HAND);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel7Scrolls, GetObjectName( "NW_IT_SPARSCR708"), "NW_IT_SPARSCR708", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_FINGER_OF_DEATH);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel7Scrolls, GetObjectName( "X2_IT_SPARSCR701"), "X2_IT_SPARSCR701", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_GREAT_THUNDERCLAP);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel7Scrolls, GetObjectName( "X1_IT_SPDVSCR702"), "X1_IT_SPDVSCR702", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CREEPING_DOOM);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel7Scrolls, GetObjectName( "X1_IT_SPDVSCR602"), "X1_IT_SPDVSCR602", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ETHEREALNESS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel7Scrolls, GetObjectName( "NW_IT_SPARSCR703"), "NW_IT_SPARSCR703", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SUMMON_CREATURE_VII);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel7Scrolls, GetObjectName( "NW_IT_SPARSCR705"), "NW_IT_SPARSCR705", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MORDENKAINENS_SWORD);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel7Scrolls, GetObjectName( "NW_IT_SPARSCR706" ), "NW_IT_SPARSCR706", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_PRISMATIC_SPRAY);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel7Scrolls, GetObjectName( "X2_IT_SPDVSCR702"), "X2_IT_SPDVSCR702", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_REGENERATE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel7Scrolls, GetObjectName( "X2_IT_SPARSCR703"), "X2_IT_SPARSCR703", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SHADOW_SHIELD);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel7Scrolls, GetObjectName( "NW_IT_SPARSCR802"), "NW_IT_SPARSCR802", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_PROTECTION_FROM_SPELLS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel7Scrolls, GetObjectName( "NW_IT_SPARSCR701"), "NW_IT_SPARSCR701", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SPELL_MANTLE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel7Scrolls, GetObjectName( "NW_IT_SPARSCR704"), "NW_IT_SPARSCR704", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DELAYED_BLAST_FIREBALL);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel7Scrolls, GetObjectName( "NW_IT_SPARSCR707"), "NW_IT_SPARSCR707", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CONTROL_UNDEAD);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel7Scrolls, GetObjectName( "X1_IT_SPDVSCR601"), "X1_IT_SPDVSCR601", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, 430);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel7Scrolls, GetObjectName( "NW_IT_SPDVSCR701"), "NW_IT_SPDVSCR701", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_GREATER_RESTORATION);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel7Scrolls, GetObjectName( "NW_IT_SPARSCR702"), "NW_IT_SPARSCR702", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_POWER_WORD_STUN);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel7Scrolls, GetObjectName( "X2_IT_SPDVSCR701"), "X2_IT_SPDVSCR701", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_WORD_OF_FAITH);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel7Scrolls, GetObjectName( "X1_IT_SPDVSCR703" ), "X1_IT_SPDVSCR703", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DESTRUCTION);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);


// Grad 8 Zauber
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel8Scrolls, GetObjectName( "X1_IT_SPARSCR801"), "X1_IT_SPARSCR801", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BIGBYS_CLENCHED_FIST);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel8Scrolls, GetObjectName( "X1_IT_SPDVSCR803"), "X1_IT_SPDVSCR803", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BOMBARDMENT);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel8Scrolls, GetObjectName( "X1_IT_SPDVSCR801"), "X1_IT_SPDVSCR801", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_EARTHQUAKE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel8Scrolls, GetObjectName( "X1_IT_SPDVSCR704"), "X1_IT_SPDVSCR704", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_FIRE_STORM);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel8Scrolls, GetObjectName( "NW_IT_SPARSCR804"), "NW_IT_SPARSCR804", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_INCENDIARY_CLOUD);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel8Scrolls, GetObjectName( "NW_IT_SPARSCR801"), "NW_IT_SPARSCR801", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MIND_BLANK);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel8Scrolls, GetObjectName( "X2_IT_SPDVSCR802"), "X2_IT_SPDVSCR802", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_NATURES_BALANCE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel8Scrolls, GetObjectName( "NW_IT_SPARSCR803"), "NW_IT_SPARSCR803", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_GREATER_PLANAR_BINDING);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel8Scrolls, GetObjectName( "X1_IT_SPDVSCR804"), "X1_IT_SPDVSCR804", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CREATE_GREATER_UNDEAD);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel8Scrolls, GetObjectName( "NW_IT_SPARSCR806"), "NW_IT_SPARSCR806", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MASS_CHARM);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel8Scrolls, GetObjectName( "NW_IT_SPARSCR807"), "NW_IT_SPARSCR807", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MASS_BLINDNESS_AND_DEAFNESS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel8Scrolls, GetObjectName( "X2_IT_SPDVSCR801"), "X2_IT_SPDVSCR801", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MASS_HEAL);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel8Scrolls, GetObjectName( "NW_IT_SPARSCR805"), "NW_IT_SPARSCR805", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SUMMON_CREATURE_VIII);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  // Multispruch, Schutzaura gg. Gesinnung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel8Scrolls, GetObjectName( "X2_IT_SPDVSCR804"), "X2_IT_SPDVSCR804", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, 323);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel8Scrolls, GetObjectName( "X2_IT_SPARSCR801"), "X2_IT_SPARSCR801", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BLACKSTAFF);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel8Scrolls, GetObjectName( "X1_IT_SPDVSCR802"), "X1_IT_SPDVSCR802", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, 427);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel8Scrolls, GetObjectName( "X2_IT_SPDVSCR803"), "X2_IT_SPDVSCR803", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SUNBEAM);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel8Scrolls, GetObjectName( "NW_IT_SPARSCR809"), "NW_IT_SPARSCR809", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_HORRID_WILTING);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel8Scrolls, GetObjectName( "NW_IT_SPARSCR808" ), "NW_IT_SPARSCR808", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_PREMONITION);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);


// Grad 9 Zauber
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel9Scrolls, GetObjectName( "X1_IT_SPARSCR901"), "X1_IT_SPARSCR901", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BIGBYS_CRUSHING_HAND);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel9Scrolls, GetObjectName( "X2_IT_SPDVSCR901"), "X2_IT_SPDVSCR901", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ELEMENTAL_SWARM);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel9Scrolls, GetObjectName( "NW_IT_SPARSCR908"), "NW_IT_SPARSCR908", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ENERGY_DRAIN);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel9Scrolls, GetObjectName( "X1_IT_SPDVSCR901"), "X1_IT_SPDVSCR901", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_UNDEATHS_ETERNAL_FOE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel9Scrolls, GetObjectName( "NW_IT_SPARSCR910"), "NW_IT_SPARSCR910", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SHAPECHANGE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel9Scrolls, GetObjectName( "X2_IT_SPDVSCR902"), "X2_IT_SPDVSCR902", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_IMPLOSION);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel9Scrolls, GetObjectName( "NW_IT_SPARSCR912"), "NW_IT_SPARSCR912", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_GREATER_SPELL_MANTLE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel9Scrolls, GetObjectName( "NW_IT_SPARSCR906"), "NW_IT_SPARSCR906", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_METEOR_SWARM);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel9Scrolls, GetObjectName( "NW_IT_SPARSCR905"), "NW_IT_SPARSCR905", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DOMINATE_MONSTER);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel9Scrolls, GetObjectName( "NW_IT_SPARSCR904"), "NW_IT_SPARSCR904", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SUMMON_CREATURE_IX);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel9Scrolls, GetObjectName( "NW_IT_SPARSCR901"), "NW_IT_SPARSCR901", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MORDENKAINENS_DISJUNCTION);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel9Scrolls, GetObjectName( "X2_IT_SPARSCR901"), "X2_IT_SPARSCR901", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BLACK_BLADE_OF_DISASTER);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel9Scrolls, GetObjectName( "X2_IT_SPDVSCR903"), "X2_IT_SPDVSCR903", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_STORM_OF_VENGEANCE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel9Scrolls, GetObjectName( "NW_IT_SPARSCR902"), "NW_IT_SPARSCR902", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_GATE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel9Scrolls, GetObjectName( "NW_IT_SPARSCR907"), "NW_IT_SPARSCR907", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_WEIRD);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel9Scrolls, GetObjectName( "NW_IT_SPARSCR909"), "NW_IT_SPARSCR909", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_WAIL_OF_THE_BANSHEE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel9Scrolls, GetObjectName( "NW_IT_SPARSCR903"), "NW_IT_SPARSCR903", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_POWER_WORD_KILL);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel9Scrolls, GetObjectName( "NW_IT_SPARSCR911"), "NW_IT_SPARSCR911", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_TIME_STOP);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

}
