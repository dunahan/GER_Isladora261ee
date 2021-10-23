/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnrAnvilPublic
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
  string sKeyToRecipe;    CnrIncrementStackCount(OBJECT_SELF);

  //PrintString("cnrAnvilPublic init");

  /////////////////////////////////////////////////////////
  // CNR recipes made by cnrAnvilPublic
  /////////////////////////////////////////////////////////
  string sMenuAxes     = CnrRecipeAddSubMenu("cnrAnvilPublic", "Äxte");
  string sMenuBladed   = CnrRecipeAddSubMenu("cnrAnvilPublic", "Klingenwaffen");
  string sMenuBlunts   = CnrRecipeAddSubMenu("cnrAnvilPublic", "Stumpfe Waffen");
  string sMenuExotic   = CnrRecipeAddSubMenu("cnrAnvilPublic", "Exotische Waffen");
  string sMenuDouble   = CnrRecipeAddSubMenu("cnrAnvilPublic", "Doppelseitige Waffen");
  string sMenuPolearms = CnrRecipeAddSubMenu("cnrAnvilPublic", "Stangenwaffen");
  string sMenuThrowing = CnrRecipeAddSubMenu("cnrAnvilPublic", "Wurfwaffen");

  CnrRecipeSetDeviceSpawnItemInDevice("cnrAnvilPublic", TRUE);
  CnrRecipeSetDevicePreCraftingScript("cnrAnvilPublic", "cnr_anvil_anim");
  CnrRecipeSetDeviceEquippedTool     ("cnrAnvilPublic", "cnrSmithsHammer", CNR_FLOAT_SMITH_HAMMER_BREAKAGE_PERCENTAGE);
  CnrRecipeSetDeviceTradeskillType   ("cnrAnvilPublic", CNR_TRADESKILL_WEAPON_CRAFTING);


  /////////////// Äxte ///////////////
  // Beil
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAxes, "Beil", "NW_WAXHN001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAxes, "Beil +1", "NW_WAXMHN002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAXHN001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAxes, "Beil +2", "NW_WAXMHN010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAXMHN002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAxes, "Beil +3", "NW_WAXMHN011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAXMHN010",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Streitaxt
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAxes, "Streitaxt", "NW_WAXBT001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    5, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmedmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAxes, "Streitaxt +1", "NW_WAXMBT002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAXBT001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAxes, "Streitaxt +2", "NW_WAXMBT010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAXMBT002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAxes, "Streitaxt +3", "NW_WAXMBT011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAXMBT010",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Zweihändige Axt
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAxes, "Zweihändige Axt", "NW_WAXGR001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    6, 3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslarmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAxes, "Zweihändige Axt +1", "NW_WAXMGR002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAXGR001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 11);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAxes, "Zweihändige Axt +2", "NW_WAXMGR009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAXMGR002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 13);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 140, 140);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAxes, "Zweihändige Axt +3", "NW_WAXMGR011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAXMGR009",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 15);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 160, 160);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);


  /////////////// Klingen Waffen ///////////////
  // Dolch
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Dolch", "NW_WSWDG001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Dolch +1", "NW_WSWMDG002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWDG001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Dolch +2", "NW_WSWMDG008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWMDG002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Dolch +3", "NW_WSWMDG009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWMDG008",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Kurzschwert
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Kurzschwert", "NW_WSWSS001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    4, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmedmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Kurzschwert +1", "NW_WSWMSS002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWSS001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Kurzschwert +2", "NW_WSWMSS009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWMSS002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Kurzschwert +3", "NW_WSWMSS011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWMSS009",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Krummsäbel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Krummsäbel", "NW_WSWSC001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    4, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmedmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Krummsäbel +1", "NW_WSWMSC002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWSC001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Krummsäbel +2", "NW_WSWMSC010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWMSC002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Krummsäbel +3", "NW_WSWMSC011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWMSC010",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Rapier
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Rapier", "NW_WSWRP001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    5, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslarmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Rapier +1", "NW_WSWMRP002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWRP001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Rapier +2", "NW_WSWMRP010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWMRP002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Rapier +3", "NW_WSWMRP011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWMRP010",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Langschwert
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Langschwert", "NW_WSWLS001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    6, 3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslarmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Langschwert +1", "NW_WSWMLS002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWLS001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Langschwert +2", "NW_WSWMLS010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWMLS002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Langschwert +3", "NW_WSWMLS012", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWMLS010",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Bastardschwert
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Bastardschwert", "NW_WSWBS001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    6, 3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslarmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Bastardschwert +1", "NW_WSWMBS002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWBS001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Bastardschwert +2", "NW_WSWMBS009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWMBS002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Bastardschwert +3", "NW_WSWMBS010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWMBS009",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Zweihänder
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Zweihänder", "NW_WSWGS001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    6, 3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslarmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Zweihänder +1", "NW_WSWMGS002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWGS001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Zweihänder +2", "NW_WSWMGS011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWMGS002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBladed, "Zweihänder +3", "NW_WSWMGS012", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWMGS011",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 14);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 150, 150);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);


  /////////////// Stumpfe Waffen ///////////////
  // Leichter Hammer
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Leichter Hammer", "NW_WBLHL001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Leichter Hammer +1", "NW_WBLMFL002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBLHL001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Leichter Hammer +2", "NW_WBLMHL010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBLMFL002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Leichter Hammer +3", "NW_WBLMHL011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBLMHL010",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Streitkolben
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Streitkolben", "NW_WBLML001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    4, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmedmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Streitkolben +1", "NW_WBLMML002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBLML001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Streitkolben +2", "NW_WBLMML011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBLMML002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Streitkolben +3", "NW_WBLMML012", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBLMML011",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 11);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Morgenstern
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Morgenstern", "NW_WBLMS001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    4, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmedmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Morgenstern +1", "NW_WBLMMS002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBLMS001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Morgenstern +2", "NW_WBLMMS010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBLMMS002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Morgenstern +3", "NW_WBLMMS011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBLMMS010",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 11);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Kriegshammer
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Kriegshammer", "NW_WBLHW001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    5, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmedmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Kriegshammer +1", "NW_WBLMHW002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBLHW001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Kriegshammer +2", "NW_WBLMHW011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBLMHW002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Kriegshammer +3", "NW_WBLMHW012", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBLMHW011",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Leichter Flegel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Leichter Flegel", "NW_WBLFL001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Leichter Flegel +1", "NW_WBLMFL002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBLFL001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Leichter Flegel +2", "NW_WBLMFL010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBLMFL002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Leichter Flegel +3", "NW_WBLMFL011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBLMFL010",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 11);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Schwerer Flegel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Schwerer Flegel", "NW_WBLFH001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    5, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslarmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Schwerer Flegel +1", "NW_WBLMFH002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBLFH001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Schwerer Flegel +2", "NW_WBLMFH010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBLMFH002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuBlunts, "Schwerer Flegel +3", "NW_WBLMFH011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBLMFH010",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 14);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 150, 150);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);


  /////////////// Exotische Waffen ///////////////
  // Sichel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuExotic, "Sichel", "NW_WSPSC001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuExotic, "Sichel +1", "NW_WSPMSC002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSPSC001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuExotic, "Sichel +2", "NW_WSPMSC010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSPMSC002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuExotic, "Sichel +3", "NW_WSPMSC011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSPMSC010",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Kukri
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuExotic, "Kukri", "NW_WSPKU001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuExotic, "Kukri +1", "NW_WSPMKU002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSPKU001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuExotic, "Kukri +2", "NW_WSPMKU008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSPMKU002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuExotic, "Kukri +3", "NW_WSPMKU009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSPMKU008",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Kama
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuExotic, "Kama", "NW_WSPKA001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuExotic, "Kama +1", "NW_WSPMKA002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSPKA001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuExotic, "Kama +2", "NW_WSPMKA008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSPMKA002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledMith", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuExotic, "Kama +3", "NW_WSPMKA009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSPMKA008",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledAdam", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Zwergische Streitaxt
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuExotic, "Zwergische Streitaxt", "X2_WDWRAXE001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    5, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslarmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuExotic, "Zwergische Streitaxt +1", "X2_WMDWRAXE002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "X2_WDWRAXE001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuExotic, "Zwergische Streitaxt +2", "X2_WMDWRAXE003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",     3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "X2_WMDWRAXE002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuExotic, "Zwergische Streitaxt +3", "X2_WMDWRAXE004", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant",  3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "X2_WMDWRAXE003", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 14);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 150, 150);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Katana
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuExotic, "Katana", "NW_WSWKA001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    6, 3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslarmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuExotic, "Katana +1", "NW_WSWMKA002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWKA001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuExotic, "Katana +2", "NW_WSWMKA010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWMKA002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 14);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 150, 150);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuExotic, "Katana +3", "NW_WSWMKA011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WSWMKA010",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 16);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 170, 170);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);


  /////////////// Doppelseitige Waffen ///////////////
  // Schreckensstreitkolben
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuDouble, "Schreckensstreitkolben", "NW_WDBMA001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    6, 3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslarmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBQS001",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuDouble, "Schreckensstreitkolben +1", "NW_WDBMMA002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBMA001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuDouble, "Schreckensstreitkolben +2", "NW_WDBMMA010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBMMA002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuDouble, "Schreckensstreitkolben +3", "NW_WDBMMA011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBMMA010",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 14);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 150, 150);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Doppelaxt
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuDouble, "Doppelaxt", "NW_WDBAX001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    6, 3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslarmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBQS001",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuDouble, "Doppelaxt +1", "NW_WDBMAX002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBAX001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuDouble, "Doppelaxt +2", "NW_WDBMAX010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBMAX002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuDouble, "Doppelaxt +3", "NW_WDBMAX011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBMAX010",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 14);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 150, 150);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  //Doppelklingenschwert
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuDouble, "Doppelklingenschwert", "NW_WDBSW001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    6, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslarmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBQS001",   1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuDouble, "Doppelklingenschwert +1", "NW_WDBMSW002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBSW001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuDouble, "Doppelklingenschwert +2", "NW_WDBMSW010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBMSW002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuDouble, "Doppelklingenschwert +3", "NW_WDBMSW011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBMSW010",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 14);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 150, 150);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);


  /////////////// Stabwaffen ///////////////
  // Dreizack
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuPolearms, "Dreizack", "nw_wpltr001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslarmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBQS001",   1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuPolearms, "Dreizack +1", "nw_wpltr002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "nw_wpltr001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuPolearms, "Dreizack +2", "nw_wpltr003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "nw_wpltr002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuPolearms, "Dreizack +3", "nw_wpltr004", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "nw_wpltr003",   1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Sense
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuPolearms, "Sense", "NW_WPLSC001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBQS001",   1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuPolearms, "Sense +1", "NW_WPLMSC002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WPLSC001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuPolearms, "Sense +2", "NW_WPLMSC010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WPLMSC002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuPolearms, "Sense +3", "NW_WPLMSC011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WPLMSC010",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 14);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 150, 150);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Hellebarde
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuPolearms, "Hellebarde", "NW_WPLHB001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    4, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmedmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBQS001",   1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuPolearms, "Hellebarde +1", "NW_WPLMHB002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WPLHB001", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuPolearms, "Hellebarde +2", "NW_WPLMHB010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WPLMHB002", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuPolearms, "Hellebarde +3", "NW_WPLMHB011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WPLMHB010",  1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 14);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 150, 150);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);


  /////////////// Wurfwaffen ///////////////
  // Wurfpfeil
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuThrowing, "Wurfpfeil", "NW_WTHDT001", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",      10, 5);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrFeathers", 5);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuThrowing, "Wurfpfeil +1", "NW_WTHMDT002", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WTHDT001", 99, 99);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuThrowing, "Wurfpfeil +2", "NW_WTHMDT008", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WTHMDT002", 99, 99);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuThrowing, "Wurfpfeil +3", "NW_WTHMDT009", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 5, 3);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WTHMDT008",  99, 99);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Wurfaxt
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuThrowing, "Wurfaxt", "NW_WTHAX001", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    10, 5);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  99);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuThrowing, "Wurfaxt +1", "NW_WTHMAX002", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WTHAX001", 99, 99);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuThrowing, "Wurfaxt +2", "NW_WTHMAX008", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WTHMAX002", 99, 99);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuThrowing, "Wurfaxt +3", "NW_WTHMAX009", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 5, 3);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WTHMAX008",  99, 99);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Shuriken
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuThrowing, "Shuriken", "NW_WTHSH001", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    10, 5);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuThrowing, "Shuriken +1", "NW_WTHMSH002", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WTHSH001", 99, 99);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuThrowing, "Shuriken +2", "NW_WTHMSH008", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmith",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WTHMSH002", 99, 99);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuThrowing, "Shuriken +3", "NW_WTHMSH009", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resadamant", 5, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WTHMSH008",  99, 99);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);


  CnrDecrementStackCount(OBJECT_SELF);
}
