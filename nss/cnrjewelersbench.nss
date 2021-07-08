/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnrJewelersBench
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

  //PrintString("cnrJewelersBench init");

  /////////////////////////////////////////////////////////
  //  CNR Crafting Device "cnrJewelersBench"
  /////////////////////////////////////////////////////////
  string sMenuRings     = CnrRecipeAddSubMenu("cnrJewelersBench", "Ringe");
  string sMenuAmulets   = CnrRecipeAddSubMenu("cnrJewelersBench", "Amulette");
  string sMenuArmBracer = CnrRecipeAddSubMenu("cnrJewelersBench", "Armschienen");


  CnrRecipeSetDeviceSpawnItemInDevice("cnrJewelersBench", TRUE);
  CnrRecipeSetDevicePreCraftingScript("cnrJewelersBench", "cnr_jeweler_anim");
  CnrRecipeSetDeviceInventoryTool    ("cnrJewelersBench", "cnrGemTools", CNR_FLOAT_GEM_CRAFTERS_TOOLS_BREAKAGE_PERCENTAGE);
  CnrRecipeSetDeviceTradeskillType   ("cnrJewelersBench", CNR_TRADESKILL_GEM_CRAFTING);

  //////////// Ringe ////////////
  // Ring des Versteckens
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuRings, "Ring des Versteckens", "X0_IT_MRING002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold",  1);  // kleiner Gussrohling
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resensilvr",  1);  // Verzaubertes Silber
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM007",   1);  // Malachit
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);  // Beutel (Magie)
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);


  // Ring of Fortitude +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuRings, "Zähigkeitsring +1", "nw_it_mring024", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",   1);  // Verzaubertes Gold
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM002",   1);  // Feuerachat
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Ring of Fortitude +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuRings, "Zähigkeitsring +2", "nw_it_mring025", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "nw_it_mring024",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resenplatin",   1);     // Verzaubertes Platin
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant002", 1, 1);  // Verzauberter Feuerachat
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);


  // Schutzring +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuRings, "Schutzring +1", "NW_IT_MRING001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resensilvr",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM014",   1);  // Aventurin
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Schutzring +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuRings, "Schutzring +2", "NW_IT_MRING008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MRING001",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant014", 1, 1);  // Verzauberter Aventurin
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Schutzring +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuRings, "Schutzring +3", "NW_IT_MRING018", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MRING008",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resenplatin",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant014", 1, 1);  // Verzauberter Aventurin
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);


  // Ring des Diebes +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuRings, "Ring des Schurken +1", "hw_itrgrg001", 1); // Ring des Diebes +1 kopieren
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resensilvr", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM004",  1);  // Phenalope
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody", 1);  // Essenz, Körper
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial",  1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Ring des Diebes +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuRings, "Ring des Schurken +2", "hw_itrgrg002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_itrgrg001",     1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant004", 1, 1); // Verzauberter Phenalope
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",    3);    // Beutel (Funken)
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 3, 3);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);


  // Ring des klaren Gedankens +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuRings, "Ring des Klaren Denkens +1", "NW_IT_MRING006", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resensilvr",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM003",    1); // Amethyst
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessspirit", 1); // Essenz, Geist
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial",  1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Ring des klaren Gedankens +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuRings, "Ring des Klaren Denkens +2", "NW_IT_MRING014", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MRING006",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant003", 1, 1); // Verzauberter Amethyst
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",    2);    // Beutel (Blitze)
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);


  // Ring der Immunität gg Krankheiten
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuRings, "Ring der Immunität gegen Krankheiten", "X0_IT_MRING010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant015", 1);  // Verzauberter Feldspat
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial",   1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);


  // Knochenring
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuRings, "Knochenring", "X0_IT_MRING008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resenplatin",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resensilvr",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant015", 1);  // Verzauberter Feldspat
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial",   1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);


  // Ring der Tierfreundschaft
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuRings, "Ring der Tierfreundschaft", "X0_IT_MRING001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resenplatin",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant001", 2, 1);  // Verzauberter Grünstein
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody",    2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial",   2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);


  // Regerationsring
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuRings, "Regenerationsring", "X3_IT_RINGREGEN", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resenplatin",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant011", 2, 1);  // Verzauberter Granat
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody",    1);     // Essenz, Körper
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbaglife",    1);     // Beutel (Leben)
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial",   1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);


  // Eisenhautring
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuRings, "Ring: Eisenhaut", "X2_IT_MRING017", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resenplatin",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resensilvr",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant008", 2, 1);  // Verzauberter Saphir
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody",    2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbaglife",    1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial",   2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);
  ////////////////////////////////////////////////////////////////////////////////////////////////////////


  //////////// Amulette ////////////
  // Amulett des Willens +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAmulets, "Willensamulett +1", "nw_it_mneck024", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmedmold",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resensilvr",  2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM004",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Amulett des Willens +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAmulets, "Willensamulett +2", "nw_it_mneck025", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "nw_it_mneck024",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",     2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant004", 2, 1);  // Verzauberter Phenalope
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);


  // Amulett der natürlichen RK +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAmulets, "Amulett der Natürlichen Rüstungsklasse +1", "NW_IT_MNECK001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmedmold",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM004",   2, 1);  // Phenalope
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial",   2, 2);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Amulett der natürlichen RK +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAmulets, "Amulett der Natürlichen Rüstungsklasse +2", "NW_IT_MNECK012", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MNECK001",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resenplatin",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant004", 2, 1);  //Verzauberter Phenalope
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial",   1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Amulett der natürlichen RK +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAmulets, "Amulett der Natürlichen Rüstungsklasse +3", "NW_IT_MNECK013", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MNECK012",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resenplatin",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resensilvr",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant004", 2, 1);  // Verzauberter Phenalope
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial",   1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);


  // Pendant der Weisheit +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAmulets, "Amulett der Weisheit +1", "NW_IT_MNECK007", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmedmold",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM014",   2, 1);  // Aventurin
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial",   2, 2);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Pendant der Weisheit +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAmulets, "Amulett der Weisheit +2", "NW_IT_MNECK008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MNECK007",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resenplatin",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant014", 1, 1);  // Verzauberter Aventurin
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial",   1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);


  // Amulett der Vitalität +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAmulets, "Gesundheitsamulett +1", "hw_itamvi001", 1);  // Selbsterstellt, Kopie von +2
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmedmold",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM015",   2, 1);  // Feldspat
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial",   2, 2);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Amulett der Vitalität +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAmulets, "Gesundheitsamulett +2", "X2_IT_MNECK001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_itamvi001",     1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resenplatin",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant015", 2, 1);  // Verzauberter Feldspat
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial",   1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);


  // Amulett der Säureresistenz
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAmulets, "Amulett der Säureresistenz", "nw_it_mneck032", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmedmold",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resenplatin",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",     2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant001", 2, 1);  // Verzauberter Grünstein
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",    2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Amulett der Feuerresistenz
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAmulets, "Amulett der Feuerresistenz", "nw_it_mneck029", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmedmold",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resenplatin",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",     2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant002", 2, 1);  // Verzauberter Feuerachat
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",    2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Amulett der Kälteresistenz
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAmulets, "Amulett der Kälteresistenz", "nw_it_mneck030", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmedmold",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resenplatin",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",     2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant004", 2, 1);  // Verzauberter Phenalope
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",    2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Amulett der Elektroresistenz
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAmulets, "Amulett der Elektrizitätsresistenz", "nw_it_mneck031", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmedmold",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resenplatin",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",     2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant003", 2, 1);  // Verzauberter Amethyst
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",    2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);


  // Amulett des Untoten Vertreibens
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAmulets, "Amulett zur Vertreibung Untoter", "X0_IT_MNECK001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmedmold",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resenplatin",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",     2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant013", 2, 1); // Verzauberter Alexandrit
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessspirit",  2);    // Essenz Geist
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   4);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial",   2, 2);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 4, 4);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);


  // Niederes Amulett des Meisters
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAmulets, "Schwaches Amulett des Meisters", "NW_IT_MNECK033", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resmedmold",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resenplatin",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",     2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resensilvr",    2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant009", 3, 1);  // Verzauberter Feueropal
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody",    2);     // Essenz Körper
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   4);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 11);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial",   2, 2);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 4, 4);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);
  ////////////////////////////////////////////////////////////////////////////////////////////////////////


  //////////// Armschienen ////////////
  // Rüstungsarmschienen +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuArmBracer, "Rüstungsarmschienen +1", "NW_IT_MBRACER002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslarmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",  5, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM004",  3, 1);  // Phenalope
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Rüstungsarmschienen +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuArmBracer, "Rüstungsarmschienen +2", "NW_IT_MBRACER007", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MBRACER002", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resenplatin",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",     2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant004", 1);    // Verzauberter Phenalope
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Rüstungsarmschienen +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuArmBracer, "Rüstungsarmschienen +3", "NW_IT_MBRACER008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MBRACER007", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resenplatin",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",     2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resensilvr",    2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant004", 1);    // Verzauberter Phenalope
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);


  // Geschicklichkeitsarmschienen +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuArmBracer, "Geschicklichkeitsarmschienen +1", "NW_IT_MBRACER001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslarmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",  2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resensilvr", 2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM003",  2, 1);  // Amethyst
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

  // Geschicklichkeitsarmschienen +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuArmBracer, "Geschicklichkeitsarmschienen +2", "NW_IT_MBRACER003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MBRACER001", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resenplatin",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant002", 1);    // Verzauberter Amethyst
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);


  // Armschienen des festen Griffs
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuArmBracer, "Armschienen des Festen Griffs", "NW_IT_MBRACER011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslarmold",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resenplatin",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",     3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resensilvr",    2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant011", 3, 1);  // Verzauberter Granat
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);


  // Armschienen des Bogenschützen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuArmBracer, "Armschienen des Bogenschützen", "X0_IT_MBRACER001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslarmold",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resenplatin",   2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resengold",     2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resensilvr",    3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant010", 3, 1);  // Verzauberter Topas
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 80, 0, 0, 0, 20);

}
