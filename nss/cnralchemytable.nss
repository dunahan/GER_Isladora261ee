/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnrAlchemyTable
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

  //PrintString("cnrAlchemyTable init");

  /////////////////////////////////////////////////////////
  // CNR recipes made by cnrAlchemyTable
  /////////////////////////////////////////////////////////
  string sMenuAlchemyMisc     = CnrRecipeAddSubMenu("cnrAlchemyTable",   "Verschiedenes");
  string sMenuAlchemyEssenses = CnrRecipeAddSubMenu("cnrAlchemyTable",   "Essenzen");
  string sMenuAlchemyPotions  = CnrRecipeAddSubMenu("cnrAlchemyTable",   "Tränke");

  string sMenuAlchemyPotHeal  = CnrRecipeAddSubMenu(sMenuAlchemyPotions, "Heilung");
  string sMenuAlchemyPotAttr  = CnrRecipeAddSubMenu(sMenuAlchemyPotions, "Attributssteigernd");
  string sMenuAlchemyPotMisc  = CnrRecipeAddSubMenu(sMenuAlchemyPotions, "Verschiedenes");


  CnrRecipeSetDeviceSpawnItemInDevice("cnrAlchemyTable", TRUE);
  CnrRecipeSetDevicePreCraftingScript("cnrAlchemyTable", "cnr_alchemy_anim");
  CnrRecipeSetDeviceTradeskillType   ("cnrAlchemyTable", CNR_TRADESKILL_ALCHEMY);

  ///////////////////////// Verschiedenes //////////////////////////////
  // Säureflasche
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyMisc, "Säureflasche", "X1_WMGRENADE001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrBellBomb",  1);  // Bombadierkäferbauch
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Erstickungspulver
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyMisc, "Erstickungspulver", "X1_WMGRENADE004", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassphio",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrStinkGland", 1);  // Stinkkäferbauch
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Alchemistenfeuer
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyMisc, "Alchemistenfeuer", "X1_WMGRENADE002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassphio",     1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MSMLMISC08", 1);  // Feuerkäferbauch
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Öl der Verzauberung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyMisc, "Öl der Verzauberung", "hw_enchantoil", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",     1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MSMLMISC13", 1);  // Skelettknöchel
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);
  ////////////////////////////////////////////////////////////////////////////////////////////////////////



  ///////////////////////// Flüssigkeiten //////////////////////////////
  // Essenz, Rein
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyEssenses, "Essenz, Rein", "hw_resessenz", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrChamomileFwr", 1);  // Kamille
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Essenz, Magie
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyEssenses, "Essenz, Magie", "hw_resessmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust007",   1); // Malachit
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessenz",    1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Essenz, Elemente
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyEssenses, "Essenz, Elemente", "hw_resesselem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust002", 1);  // Feuerachat
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust001", 1);  // Grünstein
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust004", 1);  // Phenalope
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust007", 1);  // Malachit
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessenz",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Essenz, Körper
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyEssenses, "Essenz, Körper", "hw_resessbody", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust004", 1); // Phenalope
  CnrRecipeAddComponent(sKeyToRecipe, "cnrAloeLeaf",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessenz",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Essenz, Geist
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyEssenses, "Essenz, Geist", "hw_resessspirit", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust002",  2);    // Feuerachat
  CnrRecipeAddComponent(sKeyToRecipe, "cnrSageLeaf", 2);       // Salbeiblatt
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessenz",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Essenz, Leben
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyEssenses, "Essenz, Leben", "hw_resesslife", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust013",  4);    // Alexandrit
  CnrRecipeAddComponent(sKeyToRecipe, "cnrHopsFlower",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessenz",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Essenz, Tod
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyEssenses, "Essenz, Tod", "hw_resessdeath", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust008",   4);  // Saphir
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGraveyardDirt",2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessenz",    1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  ////////////////////////////////////////////////////////////////////////////////////////////////////////



  ///////////////////////// Tränke //////////////////////////////
  // Trank: Leichte Wunden heilen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyPotHeal, "Trank: Leichte Wunden heilen", "NW_IT_MPOTION001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGarlicClove", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Trank: Gegengift
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyPotHeal, "Trank: Gegengift", "NW_IT_MPOTION006", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMushroomBlk", 3);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Trank: Mittlere Wunden heilen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyPotHeal, "Trank: Mittlere Wunden heilen", "NW_IT_MPOTION020", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrComfryRoot", 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Trank: Beistand
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyPotHeal, "Trank: Beistand", "NW_IT_MPOTION016", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust015", 3);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Trank: Teilweise Genesung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyPotHeal, "Trank: Teilweise Genesung", "NW_IT_MPOTION011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust003", 3);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Trank: Schwere Wunden heilen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyPotHeal, "Trank: Schwere Wunden heilen", "NW_IT_MPOTION002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody", 4);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGingerRoot", 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Trank: Kritische Wunden heilen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyPotHeal, "Trank: Kritische Wunden heilen", "NW_IT_MPOTION003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody", 5);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust012", 4);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Trank: Heilung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyPotHeal, "Trank: Heilung", "NW_IT_MPOTION012", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resesslife", 4);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust005", 4);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);


  // Trank: Stärke
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyPotAttr, "Trank: Bärenstärke", "NW_IT_MPOTION015", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrHawthornFwr", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Trank: Konstitution
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyPotAttr, "Trank: Ausdauer", "NW_IT_MPOTION013", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust013", 3);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Trank: Geschicklichkeit
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyPotAttr, "Trank: Katzenhafte Anmut", "NW_IT_MPOTION014", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrCatnipLeaf", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Trank: Intelligenz
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyPotAttr, "Trank: Verschlagenheit des Fuchses", "NW_IT_MPOTION017", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",     1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGraveyardDirt", 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Trank: Weisheit
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyPotAttr, "Trank: Weisheit der Eule", "NW_IT_MPOTION018", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrFeathers", 3);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Trank: Charisma
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyPotAttr, "Trank: Adlerhafte Pracht", "NW_IT_MPOTION010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrHazelLeaf",  3);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);


  // Trank: Segen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyPotMisc, "Trank: Segnen", "NW_IT_MPOTION009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessspirit", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust007",   2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Trank: Rindenhaut
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyPotMisc, "Trank: Rindenhaut", "NW_IT_MPOTION005", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resesselem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrBirchBark",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Trank: Klarheit
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyPotMisc, "Trank: Klarheit", "NW_IT_MPOTION007", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessspirit", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust006",   4);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Trank: Unsichtbarkeit
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyPotMisc, "Trank: Unsichtbarkeit", "NW_IT_MPOTION008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessspirit", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust010",   3);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Trank: Wissen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyPotMisc, "Trank: Wissen", "NW_IT_MPOTION019", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessspirit", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrSageLeaf",     1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

  // Trank: Schnelligkeit
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuAlchemyPotMisc, "Trank: Schnelligkeit", "NW_IT_MPOTION004", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassvial",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessbody", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemDust008", 3);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 0, 0, 40, 60, 0);

}
