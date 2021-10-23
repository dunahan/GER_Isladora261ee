/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnrAnvilArmor
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

  //PrintString("cnrAnvilArmor init");

  /////////////////////////////////////////////////////////
  // CNR recipes made by cnrAnvilArmor
  /////////////////////////////////////////////////////////
  string sMenuHelme      = CnrRecipeAddSubMenu("cnrAnvilArmor", "Helme");
  string sMenuShieldAlle = CnrRecipeAddSubMenu("cnrAnvilArmor", "Schilde");

  string sMenuShieldLitl = CnrRecipeAddSubMenu(sMenuShieldAlle, "Kleine Schilde");
  string sMenuShieldGrea = CnrRecipeAddSubMenu(sMenuShieldAlle, "Große Schilde");
  string sMenuShieldTowr = CnrRecipeAddSubMenu(sMenuShieldAlle, "Turmschilde");

  string sMenuLeicht     = CnrRecipeAddSubMenu("cnrAnvilArmor", "Leichte Rüstungen");
  string sMenuMittel     = CnrRecipeAddSubMenu("cnrAnvilArmor", "Mittlere Rüstungen");
  string sMenuSchwer     = CnrRecipeAddSubMenu("cnrAnvilArmor", "Schwere Rüstungen");

  CnrRecipeSetDeviceSpawnItemInDevice("cnrAnvilArmor", TRUE);
  CnrRecipeSetDevicePreCraftingScript("cnrAnvilArmor", "cnr_anvil_anim");
  CnrRecipeSetDeviceEquippedTool     ("cnrAnvilArmor", "cnrSmithsHammer", CNR_FLOAT_SMITH_HAMMER_BREAKAGE_PERCENTAGE);
  CnrRecipeSetDeviceTradeskillType   ("cnrAnvilArmor", CNR_TRADESKILL_ARMOR_CRAFTING);


  ///////////////////////// Helme //////////////////////////////
  // Helm
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuHelme, "Topfhelm", "NW_ARHE001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron", 4, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmedmold", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuHelme, "Topfhelm +1", "hw_arhe001", 1);  // Topfhelm +1
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron", 2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_ARHE001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuHelme, "Topfhelm +2", "hw_arhe002", 1);  // Topfhelm +2
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith", 2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_arhe001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);


  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuHelme, "Topfhelm +3", "hw_arhe003", 1);  // Topfhelm +3
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_arhe002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);
  
  /////////////////////////////////////////////////////////////////////////////////////////////////////////


  ///////////////////////// Schilde //////////////////////////////
  // Kleines Schild
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuShieldLitl, "Kleiner Schild", "NW_ASHSW001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  4, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resstuds", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuShieldLitl, "Kleiner Schild +1", "NW_ASHMSW002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_ASHSW001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuShieldLitl, "Kleiner Schild +2", "NW_ASHMSW008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_ASHMSW002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuShieldLitl, "Kleiner Schild +3", "NW_ASHMSW009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_ASHMSW008",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Großer Schild
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuShieldGrea, "Großer Schild", "NW_ASHLW001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  5, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resstuds", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuShieldGrea, "Großer Schild +1", "NW_ASHMLW002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_ASHLW001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuShieldGrea, "Großer Schild +2", "NW_ASHMLW008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_ASHMLW002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuShieldGrea, "Großer Schild +3", "NW_ASHMLW009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_ASHMLW008",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Turmschild
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuShieldTowr, "Turmschild", "NW_ASHTO001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  7, 3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resstuds", 4);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuShieldTowr, "Turmschild +1", "NW_ASHMTO002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  4, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_ASHTO001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuShieldTowr, "Turmschild +2", "NW_ASHMTO008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   4, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_ASHMTO002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuShieldTowr, "Turmschild +3", "NW_ASHMTO009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 4, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_ASHMTO008",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);
  ////////////////////////////////////////////////////////////////////////////////////////////////////////


  ///////////////////////// Leichte Rüstungen //////////////////////////////
  // Kettenhemd
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLeicht, "Kettenhemd", "NW_AARCL012", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    6, 3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respatligh", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLeicht, "Kettenhemd +1", "NW_MAARCL046", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_AARCL012", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLeicht, "Kettenhemd +2", "NW_MAARCL067", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL046", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuLeicht, "Kettenhemd +3", "NW_MAARCL079", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL067",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 11);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);
  ////////////////////////////////////////////////////////////////////////////////////////////////////////


  ///////////////////////// Mittelschwere Rüstungen //////////////////////////////
  // Brustplatte
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuMittel, "Brustplatte", "NW_AARCL010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    6, 3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respatmedi", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuMittel, "Brustplatte +1", "NW_MAARCL049", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_AARCL010", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuMittel, "Brustplatte +2", "NW_MAARCL065", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL049", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuMittel, "Brustplatte +3", "NW_MAARCL077", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL065",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 11);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Schuppenpanzer
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuMittel, "Schuppenpanzer", "NW_AARCL003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    6, 3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respatmedi", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuMittel, "Schuppenpanzer +1", "NW_MAARCL048", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_AARCL003", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuMittel, "Schuppenpanzer +2", "NW_MAARCL073", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL048", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuMittel, "Schuppenpanzer +3", "NW_MAARCL085", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL073",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Kettenpanzer
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuMittel, "Kettenpanzer", "NW_AARCL004", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    7, 3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respatmedi", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuMittel, "Kettenpanzer +1", "NW_MAARCL035", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_AARCL004", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuMittel, "Kettenpanzer +2", "NW_MAARCL066", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL035", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuMittel, "Kettenpanzer +3", "NW_MAARCL078", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL066",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);
  ////////////////////////////////////////////////////////////////////////////////////////////////////////


  ///////////////////////// Schwere Rüstungen //////////////////////////////
  // Bänderpanzer
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSchwer, "Bänderpanzer", "NW_AARCL011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    7, 3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respatheav", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSchwer, "Bänderpanzer +1", "NW_MAARCL051", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_AARCL011", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSchwer, "Bänderpanzer +2", "NW_MAARCL064", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL051", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 11);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSchwer, "Bänderpanzer +3", "NW_MAARCL076", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL064",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 13);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 140, 140);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Schienenpanzer
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSchwer, "Schienenpanzer", "NW_AARCL005", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    8, 4);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respatheav", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSchwer, "Schienenpanzer +1", "NW_MAARCL050", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  4, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_AARCL005", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSchwer, "Schienenpanzer +2", "NW_MAARCL074", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   4, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL050", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 11);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSchwer, "Schienenpanzer +3", "NW_MAARCL086", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 4, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL074",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 13);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 140, 140);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Plattenpanzer
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSchwer, "Plattenpanzer", "NW_AARCL006", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    8, 4);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respatheav", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSchwer, "Plattenpanzer +1", "NW_MAARCL052", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  4, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_AARCL006", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSchwer, "Plattenpanzer +2", "NW_MAARCL069", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   4, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL052", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSchwer, "Plattenpanzer +3", "NW_MAARCL081", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 4, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL069",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 14);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 150, 150);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Ritterrüstung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSchwer, "Ritterrüstung", "NW_AARCL007", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",   10, 5);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respatheav", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSchwer, "Ritterrüstung +1", "NW_MAARCL053", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  5, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_AARCL007", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSchwer, "Ritterrüstung +2", "NW_MAARCL068", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   5, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL053", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 14);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 150, 150);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSchwer, "Ritterrüstung +3", "NW_MAARCL080", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 5, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL068",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 16);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 170, 170);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

}
