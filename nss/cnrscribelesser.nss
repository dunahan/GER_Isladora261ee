/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnrScribeLesser
//
//  Desc:  Recipe initialization.
//
//  Author: Gary Corcoran 19May03
//
/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"
#include "_isla_inc"

void main()
{
  string sKeyToRecipe;

  //PrintString("cnrScribeLesser init");

  /////////////////////////////////////////////////////////
  // Default CNR recipes made in cnrScribeLesser
  /////////////////////////////////////////////////////////
  string sMenuLevel0Scrolls = CnrRecipeAddSubMenu("cnrScribeLesser", "Zaubertricks" );
  string sMenuLevel1Scrolls = CnrRecipeAddSubMenu("cnrScribeLesser", "Erster Grad"  );
  string sMenuLevel2Scrolls = CnrRecipeAddSubMenu("cnrScribeLesser", "Zweiter Grad" );
  string sMenuLevel3Scrolls = CnrRecipeAddSubMenu("cnrScribeLesser", "Dritter Grad" );
  string sMenuLevel4Scrolls = CnrRecipeAddSubMenu("cnrScribeLesser", "Vierter Grad" );

  CnrRecipeSetDeviceSpawnItemInDevice("cnrScribeLesser", TRUE);
  CnrRecipeSetDevicePreCraftingScript("cnrScribeLesser", "cnr_scribe_anim");
  CnrRecipeSetDeviceInventoryTool    ("cnrScribeLesser", "cnrScribeTools");
  CnrRecipeSetDeviceTradeskillType   ("cnrScribeLesser", CNR_TRADESKILL_SCRIBING);


// Zaubertricks
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel0Scrolls, "Aufblitzen", "X1_IT_SPARSCR001", 1);
//CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GOLD001", 100, 100);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_FLARE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel0Scrolls, "Benommenheit", "NW_IT_SPARSCR003", 1);
//CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GOLD001", 100, 100);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DAZE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel0Scrolls, "Elektrischer Schlag", "X1_IT_SPARSCR003", 1);
//CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GOLD001", 100, 100);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ELECTRIC_JOLT);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel0Scrolls, "Kältestrahl", "NW_IT_SPARSCR002", 1);
//CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GOLD001", 100, 100);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_RAY_OF_FROST);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel0Scrolls, "Kleinere Wunde heilen", "X2_IT_SPDVSCR001", 1);
//CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GOLD001", 100, 100);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CURE_MINOR_WOUNDS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel0Scrolls, "Kleinere Wunde verursachen", "X1_IT_SPDVSCR001", 1);
//CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GOLD001", 100, 100);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_INFLICT_MINOR_WOUNDS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel0Scrolls, "Licht", "NW_IT_SPARSCR004", 1);
//CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GOLD001", 100, 100);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_LIGHT);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel0Scrolls, "Resistenz", "NW_IT_SPARSCR001", 1);
//CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GOLD001", 100, 100);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_RESISTANCE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel0Scrolls, "Säurespritzer", "X1_IT_SPARSCR002", 1);
//CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GOLD001", 100, 100);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ACID_SPLASH);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  /* Eigener Zauber,
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel0Scrolls, "Tanzende Lichter", "itm_sparscr901", 1);
//CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GOLD001", 100, 100);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, 852);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);
*/
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel0Scrolls, "Tugend", "X2_IT_SPDVSCR002", 1);
//CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GOLD001", 100, 100);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_VIRTUE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);


// Grad 1 Zauber
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, "Brennende Hände", "NW_IT_SPARSCR112", 1);
//CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GOLD001", 100, 100);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BURNING_HANDS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  /* Eigener Zauber, Böses entdecken
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, "Böses entdecken", "itm_spclscr900", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, 853);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);
  */

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X2_IT_SPARSCR104"), "X2_IT_SPARSCR104", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ICE_DAGGER);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X2_IT_SPARSCR102"), "X2_IT_SPARSCR102", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_IRONGUTS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("NW_IT_SPARSCR101"), "NW_IT_SPARSCR101", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ENDURE_ELEMENTS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X1_IT_SPDVSCR103"), "X1_IT_SPDVSCR103", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ENTROPIC_SHIELD);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  /*
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("cromaticorb"), "cromaticorb", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, 854);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);
  */

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("NW_IT_SPARSCR210"), "NW_IT_SPARSCR210", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SCARE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("NW_IT_SPARSCR210"), "NW_IT_SPARSCR210", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SCARE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X2_IT_SPDVSCR107"), "X2_IT_SPDVSCR107", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_REMOVE_FEAR);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X1_IT_SPDVSCR102"), "X1_IT_SPDVSCR102", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DIVINE_FAVOR);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X2_IT_SPDVSCR108"), "X2_IT_SPDVSCR108", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SANCTUARY);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X2_IT_SPARSCR101"), "X2_IT_SPARSCR101", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_HORIZIKAULS_BOOM);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("NW_IT_SPARSCR106"), "NW_IT_SPARSCR106", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_IDENTIFY);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  /* Eigener Zauber, Larlocs Minor Drain
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("minordrain"), "minordrain", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, 855);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);
  */

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X2_IT_SPDVSCR104"), "X2_IT_SPDVSCR104", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CURE_LIGHT_WOUNDS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X1_IT_SPDVSCR104"), "X1_IT_SPDVSCR104", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_INFLICT_LIGHT_WOUNDS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("NW_IT_SPARSCR104"), "NW_IT_SPARSCR104", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MAGE_ARMOR);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X1_IT_SPDVSCR106"), "X1_IT_SPDVSCR106", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MAGIC_FANG);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X2_IT_SPARSCR105"), "X2_IT_SPARSCR105", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MAGIC_WEAPON);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("NW_IT_SPARSCR109"), "NW_IT_SPARSCR109", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MAGIC_MISSILE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("NW_IT_SPARSCR105"), "NW_IT_SPARSCR105", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SUMMON_CREATURE_I);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("nw_it_sparscr113"), "nw_it_sparscr113", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_NEGATIVE_ENERGY_RAY);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X2_IT_SPDVSCR101"), "X2_IT_SPDVSCR101", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DEAFENING_CLANG);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("NW_IT_SPARSCR107"), "NW_IT_SPARSCR107", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CHARM_PERSON);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X1_IT_SPARSCR101"), "X1_IT_SPARSCR101", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_EXPEDITIOUS_RETREAT);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X1_IT_SPARSCR103"), "X1_IT_SPARSCR103", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SHIELD);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X1_IT_SPDVSCR105"), "X1_IT_SPDVSCR105", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SHIELD_OF_FAITH);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("NW_IT_SPARSCR108"), "NW_IT_SPARSCR108", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SLEEP);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("NW_IT_SPARSCR103"), "NW_IT_SPARSCR103", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_GREASE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  // Multispruch, Schutz vor Gesinnung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("NW_IT_SPARSCR102"), "NW_IT_SPARSCR102", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, 321);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("NW_IT_SPARSCR111"), "NW_IT_SPARSCR111", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_RAY_OF_ENFEEBLEMENT);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X2_IT_SPDVSCR103"), "X2_IT_SPDVSCR103", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BLESS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X2_IT_SPARSCR103"), "X2_IT_SPARSCR103", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SHELGARNS_PERSISTENT_BLADE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("NW_IT_SPARSCR110"), "NW_IT_SPARSCR110", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_COLOR_SPRAY);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X1_IT_SPDVSCR107"), "X1_IT_SPDVSCR107", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CAMOFLAGE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  /* Eigener Zauber, Tenser's schwebende Scheibe
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("itm_sparscr900"), "itm_sparscr900", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, 851);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);
  */

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X2_IT_SPDVSCR105"), "X2_IT_SPDVSCR105", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DOOM);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X1_IT_SPDVSCR101"), "X1_IT_SPDVSCR101", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BANE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X1_IT_SPARSCR102"), "X1_IT_SPARSCR102", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_AMPLIFY);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X2_IT_SPDVSCR106"), "X2_IT_SPDVSCR106", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ENTANGLE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X2_IT_SPDVSCR102"), "X2_IT_SPDVSCR102", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BLESS_WEAPON);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel1Scrolls, GetObjectName("X1_IT_SPARSCR104"), "X1_IT_SPARSCR104", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_TRUE_STRIKE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);


// Grad 2 Zauber
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("nw_it_sparscr219"), "nw_it_sparscr219", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_EAGLE_SPLEDOR);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("X1_IT_SPDVSCR204"), "X1_IT_SPDVSCR204", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_AURAOFGLORY);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("NW_IT_SPARSCR215"), "NW_IT_SPARSCR215", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ENDURANCE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("X1_IT_SPARSCR201"), "X1_IT_SPARSCR201", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BALAGARNSIRONHORN);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("NW_IT_SPARSCR212"), "NW_IT_SPARSCR212", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BULLS_STRENGTH);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("X2_IT_SPDVSCR201"), "X2_IT_SPDVSCR201", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_AID);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("NW_IT_SPARSCR211"), "NW_IT_SPARSCR211", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BLINDNESS_AND_DEAFNESS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("X1_IT_SPDVSCR202"), "X1_IT_SPDVSCR202", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BLOOD_FRENZY);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("X1_IT_SPDVSCR301"), "X1_IT_SPDVSCR301", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CONTINUAL_FLAME);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("NW_IT_SPARSCR206"), "NW_IT_SPARSCR206", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DARKNESS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("X1_IT_SPDVSCR203"), "X1_IT_SPDVSCR203", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ONE_WITH_THE_LAND);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("NW_IT_SPARSCR201"), "NW_IT_SPARSCR201", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_RESIST_ELEMENTS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("X2_IT_SPARSCR201"), "X2_IT_SPARSCR201", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_COMBUST);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("X1_IT_SPDVSCR205"), "X1_IT_SPDVSCR205", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_FLAME_LASH);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("X2_IT_SPARSCR205"), "X2_IT_SPARSCR205", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_FLAME_WEAPON);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("X2_IT_SPARSCR203"), "X2_IT_SPARSCR203", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_GEDLEES_ELECTRIC_LOOP);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("NW_IT_SPARSCR208"), "NW_IT_SPARSCR208", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_GHOSTLY_VISAGE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("NW_IT_SPDVSCR204"), "NW_IT_SPDVSCR204", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SOUND_BURST);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("NW_IT_SPARSCR209"), "NW_IT_SPARSCR209", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_GHOUL_TOUCH);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("X2_IT_SPARSCR207"), "X2_IT_SPARSCR207", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CATS_GRACE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("NW_IT_SPARSCR216"), "NW_IT_SPARSCR216", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_KNOCK);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("X2_IT_SPDVSCR205"), "X2_IT_SPDVSCR205", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_REMOVE_PARALYSIS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("NW_IT_SPARSCR202"), "NW_IT_SPARSCR202", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MELFS_ACID_ARROW);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("X2_IT_SPDVSCR203"), "X2_IT_SPDVSCR203", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CURE_MODERATE_WOUNDS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("X1_IT_SPDVSCR201"), "X1_IT_SPDVSCR201", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_INFLICT_MODERATE_WOUNDS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("NW_IT_SPARSCR203"), "NW_IT_SPARSCR203", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SUMMON_CREATURE_II);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("NW_IT_SPDVSCR202"), "NW_IT_SPDVSCR202", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CHARM_PERSON_OR_ANIMAL);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("X2_IT_SPDVSCR202"), "X2_IT_SPDVSCR202", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BARKSKIN);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("NW_IT_SPARSCR218"), "NW_IT_SPARSCR218", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_LESSER_DISPEL);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  /* Eigener Zauber, Snillocs Schneebaelle
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("snowballs"), "snowballs", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, 856);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);
  */

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("NW_IT_SPARSCR204"), "NW_IT_SPARSCR204", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_WEB);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("X2_IT_SPARSCR204"), "X2_IT_SPARSCR204", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_STONE_BONES);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("NW_IT_SPDVSCR203"), "NW_IT_SPDVSCR203", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SILENCE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("X1_IT_SPARSCR202"), "X1_IT_SPARSCR202", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_TASHAS_HIDEOUS_LAUGHTER);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("NW_IT_SPDVSCR201"), "NW_IT_SPDVSCR201", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_LESSER_RESTORATION);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("X2_IT_SPDVSCR204"), "X2_IT_SPDVSCR204", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_HOLD_ANIMAL);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("X2_IT_SPARSCR202"), "X2_IT_SPARSCR202", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DEATH_ARMOR);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("NW_IT_SPARSCR214"), "NW_IT_SPARSCR214", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DARKVISION);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("NW_IT_SPARSCR205"), "NW_IT_SPARSCR205", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SEE_INVISIBILITY);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("NW_IT_SPARSCR207"), "NW_IT_SPARSCR207", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_INVISIBILITY);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("nw_it_sparscr220"), "nw_it_sparscr220", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_FOXS_CUNNING);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName("nw_it_sparscr221"), "nw_it_sparscr221", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_OWLS_WISDOM);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel2Scrolls, GetObjectName( "X2_IT_SPARSCR206" ), "X2_IT_SPARSCR206", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CLOUD_OF_BEWILDERMENT);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);


// Grad 3 Zauber
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "NW_IT_SPARSCR310"), "NW_IT_SPARSCR310", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_LIGHTNING_BOLT);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X2_IT_SPDVSCR307"), "X2_IT_SPDVSCR307", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CALL_LIGHTNING);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X1_IT_SPDVSCR304"), "X1_IT_SPDVSCR304", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SPIKE_GROWTH);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X2_IT_SPDVSCR305"), "X2_IT_SPDVSCR305", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DARKFIRE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X2_IT_SPDVSCR303"), "X2_IT_SPDVSCR303", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BLADE_THIRST);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X2_IT_SPARSCR305"), "X2_IT_SPARSCR305", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_FIND_TRAPS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "NW_IT_SPARSCR309"), "NW_IT_SPARSCR309", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_FIREBALL);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "NW_IT_SPARSCR304"), "NW_IT_SPARSCR304", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_FLAME_ARROW);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X2_IT_SPDVSCR312"), "X2_IT_SPDVSCR312", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_PRAYER);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X2_IT_SPDVSCR313"), "X2_IT_SPDVSCR313", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SEARING_LIGHT);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X2_IT_SPDVSCR306"), "X2_IT_SPDVSCR306", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_GLYPH_OF_WARDING);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "NW_IT_SPARSCR312"), "NW_IT_SPARSCR312", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_HASTE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X2_IT_SPDVSCR302"), "X2_IT_SPDVSCR302", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_HEALING_STING);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "NW_IT_SPARSCR307"), "NW_IT_SPARSCR307", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "NW_IT_SPARSCR217"), "NW_IT_SPARSCR217", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CLARITY);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "NW_IT_SPDVSCR302"), "NW_IT_SPDVSCR302", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_REMOVE_DISEASE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X1_IT_SPDVSCR303"), "X1_IT_SPDVSCR303", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_GREATER_MAGIC_FANG);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X2_IT_SPARSCR304"), "X2_IT_SPARSCR304", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_GREATER_MAGIC_WEAPON);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X2_IT_SPDVSCR301"), "X2_IT_SPDVSCR301", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_INFESTATION_OF_MAGGOTS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "NW_IT_SPARSCR301"), "NW_IT_SPARSCR301", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DISPEL_MAGIC);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X2_IT_SPDVSCR304"), "X2_IT_SPDVSCR304", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MAGIC_VESTMENT);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X2_IT_SPARSCR301"), "X2_IT_SPARSCR301", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MESTILS_ACID_BREATH);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "NW_IT_SPARSCR306"), "NW_IT_SPARSCR306", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SUMMON_CREATURE_III);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "nw_it_sparscr315"), "nw_it_sparscr315", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_NEGATIVE_ENERGY_BURST);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "NW_IT_SPARSCR308"), "NW_IT_SPARSCR308", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_HOLD_PERSON);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X2_IT_SPARSCR303"), "X2_IT_SPARSCR303", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_KEEN_EDGE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X2_IT_SPARSCR302"), "X2_IT_SPARSCR302", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SCINTILLATING_SPHERE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "NW_IT_SPARSCR303"), "NW_IT_SPARSCR303", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_PROTECTION_FROM_ELEMENTS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X2_IT_SPDVSCR311"), "X2_IT_SPDVSCR311", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_NEGATIVE_ENERGY_PROTECTION);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  //Multispruch, Schutzkreis gg Gesinnung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X2_IT_SPARSCRMC"), "X2_IT_SPARSCRMC", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, 322);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X2_IT_SPDVSCR308"), "X2_IT_SPDVSCR308", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CURE_SERIOUS_WOUNDS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X1_IT_SPDVSCR302"), "X1_IT_SPDVSCR302", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_INFLICT_SERIOUS_WOUNDS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "NW_IT_SPARSCR314"), "NW_IT_SPARSCR314", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_INVISIBILITY_SPHERE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X1_IT_SPDVSCR305"), "X1_IT_SPDVSCR305", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_QUILLFIRE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X1_IT_SPARSCR301"), "X1_IT_SPARSCR301", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DISPLACEMENT);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "NW_IT_SPARSCR305"), "NW_IT_SPARSCR305", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_STINKING_CLOUD);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X2_IT_SPDVSCR309"), "X2_IT_SPDVSCR309", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DOMINATE_ANIMAL);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X2_IT_SPDVSCR310"), "X2_IT_SPDVSCR310", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_INVISIBILITY_PURGE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "NW_IT_SPARSCR311"), "NW_IT_SPARSCR311", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_VAMPIRIC_TOUCH);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "NW_IT_SPARSCR313"), "NW_IT_SPARSCR313", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SLOW);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X1_IT_SPARSCR302"), "X1_IT_SPARSCR302", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_WOUNDING_WHISPERS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel3Scrolls, GetObjectName( "X1_IT_SPARSCR303"), "X1_IT_SPARSCR303", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_GUST_OF_WIND);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);


// Grad 4 Zauber
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("NW_IT_SPARSCR411"), "NW_IT_SPARSCR411", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CONTAGION);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("X2_IT_SPDVSCR405"), "X2_IT_SPDVSCR405", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_FREEDOM_OF_MOVEMENT);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("X2_IT_SPARSCR401"), "X2_IT_SPARSCR401", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ICE_STORM);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("NW_IT_SPARSCR416"), "NW_IT_SPARSCR416", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ELEMENTAL_SHIELD);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("NW_IT_SPARSCR412"), "NW_IT_SPARSCR412", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ENERVATION);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("NW_IT_SPARSCR408"), "NW_IT_SPARSCR408", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_IMPROVED_INVISIBILITY);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("NW_IT_SPARSCR418"), "NW_IT_SPARSCR418", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_EVARDS_BLACK_TENTACLES);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("NW_IT_SPARSCR407"), "NW_IT_SPARSCR407", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_WALL_OF_FIRE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("NW_IT_SPARSCR414"), "NW_IT_SPARSCR414", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BESTOW_CURSE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("NW_IT_SPARSCR402"), "NW_IT_SPARSCR402", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_REMOVE_CURSE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("NW_IT_SPARSCR413"), "NW_IT_SPARSCR413", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_FEAR);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("NW_IT_SPDVSCR401"), "NW_IT_SPDVSCR401", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_RESTORATION);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("NW_IT_SPDVSCR402"), "NW_IT_SPDVSCR402", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_NEUTRALIZE_POISON);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("X2_IT_SPDVSCR404"), "X2_IT_SPDVSCR404", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DIVINE_POWER);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("X2_IT_SPDVSCR406"), "X2_IT_SPDVSCR406", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_HAMMER_OF_THE_GODS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("X2_IT_SPDVSCR401"), "X2_IT_SPDVSCR401", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_HOLY_SWORD);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("X1_IT_SPARSCR401"), "X1_IT_SPARSCR401", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ISAACS_LESSER_MISSILE_STORM);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("NW_IT_SPARSCR401"), "NW_IT_SPARSCR401", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MINOR_GLOBE_OF_INVULNERABILITY);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("X2_IT_SPDVSCR402"), "X2_IT_SPDVSCR402", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CURE_CRITICAL_WOUNDS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("X1_IT_SPDVSCR401"), "X1_IT_SPDVSCR401", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_INFLICT_CRITICAL_WOUNDS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("X1_IT_SPDVSCR402"), "X1_IT_SPDVSCR402", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MASS_CAMOFLAGE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("NW_IT_SPARSCR405"), "NW_IT_SPARSCR405", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CHARM_MONSTER);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("NW_IT_SPARSCR404"), "NW_IT_SPARSCR404", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SUMMON_CREATURE_IV);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  // Multispruch, Schattenbeschwörung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("NW_IT_SPARSCR410"), "NW_IT_SPARSCR410", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, 159);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("X2_IT_SPDVSCR403"), "X2_IT_SPDVSCR403", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DEATH_WARD);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("NW_IT_SPARSCR417"), "NW_IT_SPARSCR417", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_LESSER_SPELL_BREACH);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("NW_IT_SPARSCR415"), "NW_IT_SPARSCR415", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_POLYMORPH_SELF);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("NW_IT_SPARSCR403"), "NW_IT_SPARSCR403", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_STONESKIN);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("NW_IT_SPARSCR409"), "NW_IT_SPARSCR409", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_PHANTASMAL_KILLER);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("X2_IT_SPDVSCR407"), "X2_IT_SPDVSCR407", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_POISON);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLevel4Scrolls, GetObjectName("NW_IT_SPARSCR406"), "NW_IT_SPARSCR406", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_cfm_bscrl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CONFUSION);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 50, 50, 0);

}
