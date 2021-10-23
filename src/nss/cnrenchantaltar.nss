/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnrEnchantAltar
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

  //PrintString("cnrEnchantAltar init");

  /////////////////////////////////////////////////////////
  // CNR recipes made by cnrEnchantAltar
  /////////////////////////////////////////////////////////
  string sMenuAltarBags     = CnrRecipeAddSubMenu("cnrEnchantAltar", "Elementarstaub");
  string sMenuAltarEnchMat  = CnrRecipeAddSubMenu("cnrEnchantAltar", "Verzaubertes Material");
  string sMenuAltarLight    = CnrRecipeAddSubMenu("cnrEnchantAltar", "Lichtedelsteine");
  string sMenuAltarIoun     = CnrRecipeAddSubMenu("cnrEnchantAltar", "Ionensteine");
  string sMenuAltarLesIou   = CnrRecipeAddSubMenu(sMenuAltarIoun,    "Schwache Ionensteine");
  string sMenuAltarGreIou   = CnrRecipeAddSubMenu(sMenuAltarIoun,    "Glühende Ionensteine");
  string sMenuAltarRods     = CnrRecipeAddSubMenu("cnrEnchantAltar", "Zauberstäbe");
  string sMenuAltarStaves   = CnrRecipeAddSubMenu("cnrEnchantAltar", "Zauberstecken");
  string sMenuAltarSceptre  = CnrRecipeAddSubMenu("cnrEnchantAltar", "Zauberzepter");

  CnrRecipeSetDeviceSpawnItemInDevice("cnrEnchantAltar", TRUE);
  CnrRecipeSetDevicePreCraftingScript("cnrEnchantAltar", "cnr_enchant_anim");
  CnrRecipeSetDeviceInventoryTool    ("cnrEnchantAltar", "cnrEnchTool");
  CnrRecipeSetDeviceTradeskillType   ("cnrEnchantAltar", CNR_TRADESKILL_ENCHANTING);


  ///////////////////////// Elementarstaub //////////////////////////////
  // Beutel, Magie
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarBags, "Beutel, Magie", "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust007",  1); // Malachit
  CnrRecipeAddComponent(sKeyToRecipe, "cnrCornFlour",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Beutel (Elemente)
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarBags, "Beutel, Elemente", "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust002",  1);  // Feuerachat
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust001",  1);  // Grünstein
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust004",  1);  // Phenalope
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust007",  1);  // Malachit
  CnrRecipeAddComponent(sKeyToRecipe, "cnrCornFlour",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Beutel (Körper)
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarBags, "Beutel, Körper", "hw_resbagbody", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust004",  1); // Phenalope
  CnrRecipeAddComponent(sKeyToRecipe, "cnrCornFlour",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Beutel (Geist)
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarBags, "Beutel, Geist", "hw_resbagspirit", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleathbag",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust002",  2);    // Feuerachat
  CnrRecipeAddComponent(sKeyToRecipe, "cnrCornFlour",     1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Beutel (Leben)
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarBags, "Beutel, Leben", "hw_resbaglife", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleathbag",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust013",    1);      // Alexandrit
  CnrRecipeAddComponent(sKeyToRecipe, "cnrBlkCohoshRoot", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Beutel (Tod)
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarBags, "Beutel, Tod", "hw_resbagdeath", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleathbag",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust008",    4);    // Saphir
  CnrRecipeAddComponent(sKeyToRecipe, "nw_it_msmlmisc13", 1);    // Skeleton knuckle
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);
  //////////////////////////////////////////////////////////////////////////////////////////////////////////


  ///////////////////////// Verzauberte Metalle //////////////////////////////
  // Verzaubertes Silber
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarEnchMat, "Verzaubertes Silber", "hw_resensilvr", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_ressilver",  1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Verzaubertes Gold
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarEnchMat, "Verzaubertes Gold", "hw_resengold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resgold",   1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Verzaubertes Platin
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarEnchMat, "Verzaubertes Platin", "hw_resenplatin", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resplatin",  1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);
  ////////////////////////////////////////////////////////////////////////////////////////////////////////


  ///////////////////////// Verzauberte Edelsteine //////////////////////////////
  // Verzauberter Grünstein
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarEnchMat, "Verzauberter Grünstein", "cnrGemEnchant001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM001",  1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Verzauberter Malachit
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarEnchMat, "Verzauberter Malachit", "cnrGemEnchant007", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM007",  1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Verzauberter Feuerachat
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarEnchMat, "Verzauberter Feuerachat", "cnrGemEnchant002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM002",  1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Verzauberter Phenalope
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarEnchMat, "Verzauberter Phenalope", "cnrGemEnchant004", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM004",  1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Verzauberter Aventurin
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarEnchMat, "Verzauberter Aventurin", "cnrGemEnchant014", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM014",  1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Verzauberter Amethyst
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarEnchMat, "Verzauberter Amethyst", "cnrGemEnchant003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM003",  1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Verzauberter Feldspat
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarEnchMat, "Verzauberter Feldspat", "cnrGemEnchant015", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM015",  1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Verzauberter Granat
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarEnchMat, "Verzauberter Granat", "cnrGemEnchant011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM011",  1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Verzauberter Alexandrit
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarEnchMat, "Verzauberter Alexandrit", "cnrGemEnchant013", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM013",  1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Verzauberter Topas
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarEnchMat, "Verzauberter Topas", "cnrGemEnchant010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM010",  1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Verzauberter Saphir
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarEnchMat, "Verzauberter Saphir", "cnrGemEnchant008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM008",  1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Verzauberter Feueropal
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarEnchMat, "Verzauberter Feueropal", "cnrGemEnchant009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM009",  1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Verzauberter Diamant
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarEnchMat, "Verzauberter Diamant", "cnrGemEnchant005", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM005",  1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 11);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Verzauberter Rubin
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarEnchMat, "Verzauberter Rubin", "cnrGemEnchant006", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM006",  1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Verzauberter Smaragd
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarEnchMat, "Verzauberter Smaragd", "cnrGemEnchant012", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_GEM012",  1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 13);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 140, 140);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);
  //////////////////////////////////////////////////////////////////////////////////////////////////////////


  ///////////////////////// Lichtedelsteine //////////////////////////////
  // Blauer Lichtedelstein
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarLight, "Lichtedelstein, Blau", "x2_it_lightgem01", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant003", 1, 1);            // Amethyst
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_LIGHT);  // Licht
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Gelber Lichtedelstein
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarLight, "Lichtedelstein, Gelb", "x2_it_lightgem02", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant014", 1, 1);            // Aventurin
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_LIGHT);  // Licht
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Lilaner Lichtedelstein
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarLight, "Lichtedelstein, Lila", "x2_it_lightgem03", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant013", 1, 1);            // Alexandrit
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_LIGHT);  // Licht
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Roter Lichtedelstein
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarLight, "Lichtedelstein, Rot", "x2_it_lightgem04", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant011", 1, 1);            // Granat
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_LIGHT);  // Licht
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Grüner Lichtedelstein
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarLight, "Lichtedelstein, Grün", "x2_it_lightgem05", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant001", 1, 1);            // Grünstein
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_LIGHT);  // Licht
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Oranger Lichtedelstein
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarLight, "Lichtedelstein, Orange", "x2_it_lightgem06", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant002", 1, 1);            // Feuerachat
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_LIGHT);  // Licht
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Weisser Lichtedelstein
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarLight, "Lichtedelstein, Weiß", "x2_it_lightgem07", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant015", 1, 1);            // Feldspat
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_LIGHT);  // Licht
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);


  ///////////////////////// Ionensteine - Schwache //////////////////////////////
  // Schwacher Ionenstein - Stärke
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarLesIou, "Schwacher Ionenstein - Hellorange", "bf_ioun_lighoran", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant003", 1, 1);    // Verzauberter Aventurin
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagbody",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BULLS_STRENGTH); // Stärke
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Schwacher Ionenstein - Geschicklichkeit
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarLesIou, "Schwacher Ionenstein - Hellrot", "bf_ioun_lightred", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant003", 1, 1);    // Verzauberter Aventurin
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagbody",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CATS_GRACE); // Geschicklichkeit
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Schwacher Ionenstein - Konstitution
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarLesIou, "Schwacher Ionenstein - Helllila", "bf_ioun_liglilac", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant003", 1, 1);    // Verzauberter Aventurin
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagbody",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ENDURANCE); // Konstitution
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Schwacher Ionenstein - Intelligenz
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarLesIou, "Schwacher Ionenstein - Hellrosa", "bf_ioun_lighpink", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant003", 1, 1);    // Verzauberter Aventurin
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagbody",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_FOXS_CUNNING); // Intelligenz
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Schwacher Ionenstein - Weisheit
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarLesIou, "Schwacher Ionenstein - Hellblau", "bf_ioun_ligblue", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant003", 1, 1);    // Verzauberter Aventurin
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagbody",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_OWLS_WISDOM); // Weisheit
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Schwacher Ionenstein - Charisma
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarLesIou, "Schwacher Ionenstein - Hellgelb", "bf_ioun_ligyello", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant003", 1, 1);    // Verzauberter Aventurin
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagbody",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_EAGLE_SPLEDOR); // Charisma
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);
  ////////////////////////////////////////////////////////////////////////////////////////////////////////


  ///////////////////////// Ionensteine - Glühende //////////////////////////////
  // Glühender Ionenstein - Stärke
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarGreIou, "Glühender Ionenstein - Orange", "bf_ioun_orange", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",    3);
  CnrRecipeAddComponent(sKeyToRecipe, "bf_ioun_lighoran", 2, 1);    // Schwacher Ionenstein - Stärke
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagbody",    3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   3);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_BULLS_STRENGTH); // Stärke
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 3, 3);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 6, 6);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 16);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 170, 170);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Glühender Ionenstein - Geschick
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarGreIou, "Glühender Ionenstein - Rot", "bf_ioun_red", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",    3);
  CnrRecipeAddComponent(sKeyToRecipe, "bf_ioun_lightred", 2, 1);    // Schwacher Ionenstein - Geschicklichkeit
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagbody",    3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   3);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CATS_GRACE); // Geschicklichkeit
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 3, 3);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 6, 6);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 16);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 170, 170);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Glühender Ionenstein - Konstitution
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarGreIou, "Glühender Ionenstein - Lila", "bf_ioun_lilac", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",    3);
  CnrRecipeAddComponent(sKeyToRecipe, "bf_ioun_liglilac", 2, 1);    // Schwacher Ionenstein - Konstitution
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagbody",    3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   3);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ENDURANCE); // Konstitution
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 3, 3);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 6, 6);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 16);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 170, 170);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Glühender Ionenstein - Intelligenz
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarGreIou, "Glühender Ionenstein - Rosa", "bf_ioun_pink", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",    3);
  CnrRecipeAddComponent(sKeyToRecipe, "bf_ioun_lighpink", 2, 1);    // Schwacher Ionenstein - Intelligenz
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagbody",    3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   3);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_FOXS_CUNNING); // Intelligenz
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 3, 3);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 6, 6);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 16);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 170, 170);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Glühender Ionenstein - Weisheit
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarGreIou, "Glühender Ionenstein - Blau", "bf_ioun_blue", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",    3);
  CnrRecipeAddComponent(sKeyToRecipe, "bf_ioun_ligblue",  2, 1);    // Schwacher Ionenstein - Weisheit
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagbody",    3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   3);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_OWLS_WISDOM); // Weisheit
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 3, 3);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 6, 6);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 16);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 170, 170);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Glühender Ionenstein - Charisma
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarGreIou, "Glühender Ionenstein - Gelb", "bf_ioun_yellow", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",    3);
  CnrRecipeAddComponent(sKeyToRecipe, "bf_ioun_ligyello", 2, 1);    // Schwacher Ionenstein - Charisma
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagbody",    3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   3);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_EAGLE_SPLEDOR); // Charisma
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 3, 3);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 6, 6);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 16);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 170, 170);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);


  // Glühender Ionenstein - Fertigkeiten
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarGreIou, "Glühender Ionenstein - Grün", "bf_ioun_green", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",    3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant005", 2, 1);    // Verzauberter Diamant
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbaglife",    3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   3);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_AID); // Beistand
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 3, 3);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 6, 6);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 16);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 170, 170);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Glühender Ionenstein - Regeneration
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarGreIou, "Glühender Ionenstein - Weiß", "bf_ioun_white", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",    3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant005", 2, 1);    // Verzauberter Diamant
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbaglife",    3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   3);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MONSTROUS_REGENERATION); // Monströse Regeneration
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 3, 3);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 6, 6);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 17);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 180, 180);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Glühender Ionenstein - Zauberspruchresistenz
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarGreIou, "Glühender Ionenstein - Purpur", "bf_ioun_purple", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",    3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemEnchant005", 2, 1);    // Verzauberter Diamant
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbaglife",    3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   3);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SPELL_RESISTANCE); // Zauberresistenz
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 3, 3);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 6, 6);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 18);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 190, 190);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);
  ////////////////////////////////////////////////////////////////////////////////////////////////////////


  ///////////////////////// Zauberstäbe //////////////////////////////
  // Stab der negativen Energie
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarRods, "Stab der negativen Energie", "NW_WMGWN006", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resestab",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_NEGATIVE_ENERGY_RAY);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Stab der niederen Beschwörung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarRods, "Stab der niederen Beschwörung", "NW_WMGWN013", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resestab",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SUMMON_CREATURE_II);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Stab der Geschosse
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarRods, "Stab der Geschosse", "NW_WMGWN004", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resestab",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MAGIC_MISSILE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Stab des Schlafs
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarRods, "Stab des Schlafs", "nw_wmgwn012", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resestab",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SLEEP);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Stab des Feuers
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarRods, "Stab des Feuers", "NW_WMGWN002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbstab",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_FIREBALL);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Stab der Blitze
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarRods, "Stab der Blitze", "NW_WMGWN007", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbstab",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_LIGHTNING_BOLT);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Stab der Furcht
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarRods, "Stab der Furcht", "NW_WMGWN003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbstab",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_FEAR);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Stab der stinkenden Wolke
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarRods, "Stab der stinkenden Wolke", "NW_WMGWN010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbstab",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_STINKING_CLOUD);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Stab des Magie bannens
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarRods, "Stab des Magie bannens", "NW_WMGWN011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resfstab",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DISPEL_MAGIC);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Stab der Lähmung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarRods, "Stab der Lähmung", "NW_WMGWN005", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resfstab",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_HOLD_MONSTER);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Stab der höheren Beschwörung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarRods, "Stab der höheren Beschwörung", "NW_WMGWN008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resfstab",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SUMMON_CREATURE_IV);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Stab der Himmel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarRods, "Stab der Himmel", "NW_WMGWN009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resfstab",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_FLAME_STRIKE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 1, 1);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);
  ////////////////////////////////////////////////////////////////////////////////////////////////////////


  ///////////////////////// Zauberstecken //////////////////////////////
  // Heiligenstecken
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarStaves, "Heiligenstecken", "NW_WMGST006", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",  3);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBQS001",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_AID);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CURE_LIGHT_WOUNDS);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CURE_MODERATE_WOUNDS);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 3, 3);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 3, 3);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Stecken des Schutzes
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarStaves, "Stecken des Schutzes", "NW_WMGST004", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",  3);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WMGRD002",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_MAGE_ARMOR);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, 321);   // Schutz vor ...
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 3, 3);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Stecken der Macht
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarStaves, "Stecken der Macht", "NW_WMGST005", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",  3);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WMGWN002",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WMGWN004",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_RAY_OF_ENFEEBLEMENT);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 3, 3);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 3, 3);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Befehlsstecken
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarStaves, "Befehlsstecken", "NW_WMGST002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WMGMRD004",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CHARM_MONSTER);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 2, 2);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Stecken des Magisters
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarStaves, "Stecken des Magisters", "NW_WMGST003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",  4);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WMGST004",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WMGWN011",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WMGWN002",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_LIGHT);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_ICE_STORM);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_INVISIBILITY);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_LIGHTNING_BOLT);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 4, 4);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 3, 3);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 14);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 150, 150);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);
  ////////////////////////////////////////////////////////////////////////////////////////////////////////


  ///////////////////////// Zepter //////////////////////////////
  // Zepter der Kälte
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarSceptre, "Zepter der Kälte", "nw_wmgmrd006", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBQS001",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_RAY_OF_FROST);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 2, 2);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Zepter des Geistes
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarSceptre, "Zepter des Geistes", "NW_WMGRD002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBQS001",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_GHOSTLY_VISAGE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 2, 2);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Schreckenszepter
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarSceptre, "Schreckenszepter", "NW_WMGMRD003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WMGWN003",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_SCARE);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 2, 2);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Aufhebungszepters
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarSceptre, "Aufhebungszepters", "NW_WMGMRD005", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WMGWN011",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_GREATER_DISPELLING);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 2, 2);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Betörungszepter
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarSceptre, "Betörungszepter", "NW_WMGMRD004", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBQS001",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_CHARM_PERSON);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_DOMINATE_PERSON);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 2, 2);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

  // Zepter der Auferstehung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAltarSceptre, "Zepter der Auferstehung", "NW_WMGMRD002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WDBQS001",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbaglife", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "CNR_RECIPE_SPELL", 1, SPELL_RESURRECTION);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassvial", 2, 2);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 14);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 150, 150);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 60, 40, 0);

}
