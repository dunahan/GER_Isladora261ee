/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnrTinkersDevice
//
//  Desc:  Recipe initialization.
//
//  Author: David Bobeck 15May03
//  Modified: dunahan@schwerterkueste.de
//
/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"
#include "_isla_inc"

void main()
{
  string sKeyToRecipe;

  //PrintString("cnrTinkersDevice init");

  /////////////////////////////////////////////////////////
  // CNR recipes made by cnrTinkersDevice
  /////////////////////////////////////////////////////////
  string sMenuTinkerAmmo         = CnrRecipeAddSubMenu("cnrTinkersDevice", "Projektile");

  string sMenuTinkerTraps        = CnrRecipeAddSubMenu("cnrTinkersDevice", "Fallen");
  string sMenuTinkerTrapsMinor   = CnrRecipeAddSubMenu(sMenuTinkerTraps,    "Normale");
  string sMenuTinkerTrapsAverage = CnrRecipeAddSubMenu(sMenuTinkerTraps,    "Gefährliche");
  string sMenuTinkerTrapsStrong  = CnrRecipeAddSubMenu(sMenuTinkerTraps,    "Sehr Gefährliche");
  string sMenuTinkerTrapsDeadly  = CnrRecipeAddSubMenu(sMenuTinkerTraps,    "Tötliche");

  string sMenuTinkerMisc         = CnrRecipeAddSubMenu("cnrTinkersDevice", "Verschiedenes");
  string sMenuTinkerTools        = CnrRecipeAddSubMenu("cnrTinkersDevice", "Werkzeuge");

  CnrRecipeSetDeviceSpawnItemInDevice("cnrTinkersDevice", TRUE);
  CnrRecipeSetDevicePreCraftingScript("cnrTinkersDevice", "cnr_tinker_anim");
  CnrRecipeSetDeviceInventoryTool    ("cnrTinkersDevice", "cnrTinkersTools", CNR_FLOAT_TINKERS_TOOLS_BREAKAGE_PERCENTAGE);
  CnrRecipeSetDeviceTradeskillType   ("cnrTinkersDevice", CNR_TRADESKILL_TINKERING);
  ////////////////////////////////////////////////////////////////////////////////

  //// Projektile ////
  // Ein Satz Pfeilspitzen
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerAmmo, "Pfeilspitzen (99)", "hw_respfspitz", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    4);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 10, 10);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);


  // Schleuderkugel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerAmmo, "Schleuderkugel ", "NW_WAMBU001", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    5);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Schleuderkugel +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerAmmo, "Schleuderkugel +1", "NW_WAMMBU008", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMBU001",   99, 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Schleuderkugel +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerAmmo, "Schleuderkugel +2", "NW_WAMMBU009", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMBU008",  99, 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  // Schleuderkugel +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerAmmo, "Schleuderkugel +3", "NW_WAMMBU010", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMBU009",  99, 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);


  // Schleuderkugel des Zerschmetterns
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerAmmo, "Schleuderkugeln des Niederstreckens", "NW_WAMMBU004", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMBU001",   99, 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Schleuderkugel des Durchdringens
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerAmmo, "Schleuderkugel des Durchdringens", "NW_WAMMAR004", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMBU001",   99, 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Geweihte Schleuderkugel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerAmmo, "Geweihte Schleuderkugel", "hw_wammbu011", 99);  // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMBU001",    99, 99);
  CnrRecipeAddComponent(sKeyToRecipe, "x1_wmgrenade005", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);


  // Feuerschleuderkugel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerAmmo, "Feuerschleuderkugel", "NW_WAMMBU005", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMBU008", 99, 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Eisschleuderkugel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerAmmo, "Eisschleuderkugel", "NW_WAMMBU006", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMBU008",  99, 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Blitzschleuderkugel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerAmmo, "Blitzschleuderkugel", "NW_WAMMBU007", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMBU008",  99, 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Donnerschleuderkugel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerAmmo, "Donnerschleuderkugel", "hw_wammbu012", 99);  // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMBU009",  99, 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Giftschleuderkugel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerAmmo, "Giftschleuderkugel", "hw_wammbu013", 99);  // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMBU009",  99, 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Säureschleuderkugel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerAmmo, "Säureschleuderkugel", "hw_wammbu014", 99);  // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMBU009", 99, 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

    // Feuerballschleuderkugel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerAmmo, "Feuerballschleuderkugel", "hw_firebbul", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMAR011", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);

  // Todeschleuderkugel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerAmmo, "Todeschleuderkugel", "hw_deathbul", 99);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resessdeath", 5);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WAMMAR011", 99, 99);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 15);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 150, 150);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 45, 55, 0, 0, 0, 0);
  ////////////////////////////////////////////////////////////////////////////////


  //// Drähte, Federn & Zahnräder ////
  // Eisendraht
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerMisc, "Eisendraht", "hw_reswireir", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Silberdraht
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerMisc, "Silberdraht", "hw_reswiresi", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_ressilver", 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Golddraht
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerMisc, "Golddraht", "hw_reswirego", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resgold", 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Platindraht
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerMisc, "Platindraht", "hw_reswirepl", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resplatin", 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  //// Verschiedenes ////
  // Sprungfedern
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerMisc, "Sprungfedern", "hw_resspring", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswireir", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Nieten
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerMisc, "Nieten", "hw_resstuds", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Zahnräder
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerMisc, "Zahnräder", "hw_resgears", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    4);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Umlenkrolle
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerMisc, "Umlenkrolle für Kompositbogen", "hw_resbgrol", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswireir", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resgears",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Scharnier
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerMisc, "Scharnier", "hw_reshinge", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resstuds", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Schloß
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerMisc, "Schloß", "hw_reslock", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resstuds",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Tinte
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerMisc, "Tinte", "cnrInk", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_glassphio",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrBluberryFruit",2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Schriftrolle
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerMisc, "Leere Schriftrolle", "x2_it_cfm_bscrl", 5);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagosdust", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Fußangeln
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerMisc, "Fußangeln", "X1_WMGRENADE003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resstuds",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);
  ////////////////////////////////////////////////////////////////////////////////


  //// Werkzeuge ////
  // Schaufel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTools, "Schaufel", "cnrShovel", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 50, 25, 0, 25, 0, 0);

  // Jagdmesser
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTools, "Jagdmesser", "cnrCarvingKnife", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 50, 25, 0, 25, 0, 0);

  // Holzfällerssichel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTools, "Holzfällersichel", "cnrwoodcuttersic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 50, 25, 0, 25, 0, 0);

  // Holzfällerbeil
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTools, "Holzfällerbeil", "cnrWoodCutterAxe", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 50, 25, 0, 25, 0, 0);

  // Spitzhacke
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTools, "Spitzhacke", "cnrMinersPickaxe", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 50, 25, 0, 25, 0, 0);

  // Schmiedehammer
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTools, "Schmiedehammer", "cnrSmithsHammer", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 50, 25, 0, 25, 0, 0);

  // Meißel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTools, "Meißel", "cnrGemChisel", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 50, 25, 0, 25, 0, 0);

  // Juwelierwerkzeug
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTools, "Juwelierwerkzeug", "cnrGemTools", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",     2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Bastlerwerkzeug
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTools, "Bastlerwerkzeug", "cnrTinkersTools", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",     2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Tischlerwerkzeug
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTools, "Tischlerwerkzeug", "cnrCarpsTools", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",    2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reslilmold", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Nähwerkzeug
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTools, "Nähwerkzeug", "cnrSewingKit", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resiron",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrSpiderSilk",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Schreiberutensilien
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTools, "Schreiberutensilien", "cnrScribeTools", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswschft",  2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reseichp",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrSpiderSilk", 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Verzauberungsstab
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTools, "Magischer Stab der Verzauberung", "cnrEnchTool", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resestab",      1, 1); // Eichenstab
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemMineral014" ,2, 1); // Aventurin
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemMineral001" ,2, 1); // Grünstein
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGemMineral003" ,2, 1); // Amethyst
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MSMLMISC13" ,5, 2); // Skelettknöchel
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Kräuterbeutel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTools, "Kräuterbeutel", "itm_cnrherbsbag", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrSpiderSilk",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrAloeLeaf",    2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);
  ////////////////////////////////////////////////////////////////////////////////


  //
  // -------------------------   Normale Fallen   ------------------------------
  // Normal gefährliche Falle: Speere
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsMinor, "Normal gefährliche Falle: Speere", "NW_IT_TRAP001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respfspitz", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resstuds",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswireir",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Normal gefährliche Falle: Säure
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsMinor, "Normal gefährliche Falle: Säuresprühfalle", "NW_IT_TRAP033", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswireir", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Normal gefährliche Falle: Kälte
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsMinor, "Normal gefährliche Falle: Kälte", "NW_IT_TRAP029", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswireir",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Normal gefährliche Falle: Schall
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsMinor, "Normal gefährliche Falle: Schall", "NW_IT_TRAP037", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswireir",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Normal gefährliche Falle: Heiliges Feuer
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsMinor, "Normal gefährliche Falle: Heiliges Feuer", "NW_IT_TRAP005", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "X1_WMGRENADE005", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswireir",    1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_glassphio", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Normal gefährliche Falle: Verstrickung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsMinor, "Normal gefährliche Falle: Verstrickung", "NW_IT_TRAP009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resrope",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswireir", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Normal gefährliche Falle: Feuer
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsMinor, "Normal gefährliche Falle: Feuer", "NW_IT_TRAP017", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswireir",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Normal gefährliche Falle: Elektrizität
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsMinor, "Normal gefährliche Falle: Elektrizität", "NW_IT_TRAP021", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswireir",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Normal gefährliche Falle: Giftgas
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsMinor, "Normal gefährliche Falle: Giftgas", "NW_IT_TRAP025", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswireir",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);
  ////////////////////////////////////////////////////////////////////////////////


  //
  // -------------------------   Gefährliche Fallen   ------------------------------
  // Gefährliche Falle: Speere
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsAverage, "Gefährliche Falle: Speere", "NW_IT_TRAP002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respfspitz", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resstuds",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswiresi",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Gefährliche Falle: Säure
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsAverage, "Gefährliche Falle: Säuresprühfalle", "NW_IT_TRAP034", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswiresi",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Gefährliche Falle: Kälte
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsAverage, "Gefährliche Falle: Kälte", "NW_IT_TRAP030", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswiresi",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Gefährliche Falle: Schall
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsAverage, "Gefährliche Falle: Schall", "NW_IT_TRAP038", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswiresi",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Gefährliche Falle: Heiliges Feuer
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsAverage, "Gefährliche Falle: Heiliges Feuer", "NW_IT_TRAP006", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "X1_WMGRENADE005", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswiresi",    1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Gefährliche Falle: Verstrickung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsAverage, "Gefährliche Falle: Verstrickung", "NW_IT_TRAP010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resrope",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswiresi", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Gefährliche Falle: Feuer
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsAverage, "Gefährliche Falle: Feuer", "NW_IT_TRAP018", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswiresi",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Gefährliche Falle: Elektrizität
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsAverage, "Gefährliche Falle: Elektrizität", "NW_IT_TRAP022", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswiresi",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Gefährliche Falle: Giftgas
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsAverage, "Gefährliche Falle: Giftgas", "NW_IT_TRAP026", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswiresi",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);
  ////////////////////////////////////////////////////////////////////////////////


  //
  // -------------------------   Sehr gefährliche Fallen   ------------------------------
  // Sehr Gefährliche Falle: Speere
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsStrong, "Sehr gefährliche Falle: Speere", "NW_IT_TRAP003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respfspitz", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resstuds",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirego", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Sehr Gefährliche Falle: Säure
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsStrong, "Sehr gefährliche Falle: Säuresprühfalle", "NW_IT_TRAP035", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirego",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Sehr Gefährliche Falle: Kälte
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsStrong, "Sehr gefährliche Falle: Kälte", "NW_IT_TRAP031", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirego",    1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Sehr Gefährliche Falle: Schall
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsStrong, "Sehr gefährliche Falle: Schall", "NW_IT_TRAP039", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirego",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Sehr Gefährliche Falle: Heiliges Feuer
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsStrong, "Sehr gefährliche Falle: Heiliges Feuer", "NW_IT_TRAP007", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "X1_WMGRENADE005", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirego",    1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Sehr Gefährliche Falle: Verstrickung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsStrong, "Sehr gefährliche Falle: Verstrickung", "NW_IT_TRAP011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resrope",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirego", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Sehr Gefährliche Falle: Feuer
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsStrong, "Sehr gefährliche Falle: Feuer", "NW_IT_TRAP019", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirego",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Sehr Gefährliche Falle: Elektrizität
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsStrong, "Sehr gefährliche Falle: Elektrizität", "NW_IT_TRAP023", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirego",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Sehr Gefährliche Falle: Giftgas
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsStrong, "Sehr gefährliche Falle: Giftgas", "NW_IT_TRAP027", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirego",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);
  ////////////////////////////////////////////////////////////////////////////////


  //
  // -------------------------   Tödliche Fallen   ------------------------------
  // Tötliche Falle: Speere
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsDeadly, "Tödliche Falle: Speere", "NW_IT_TRAP004", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resstuds",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resgears",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswiresi", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirego", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 11);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Tötliche Falle: Säure
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsDeadly, "Tödliche Falle: Säuresprühfalle", "NW_IT_TRAP036", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resgears",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswiresi",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirego",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Tötliche Falle: Kälte
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsDeadly, "Tödliche Falle: Kälte", "NW_IT_TRAP032", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resgears",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswiresi",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirego",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Tötliche Falle: Schall
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsDeadly, "Tödliche Falle: Schall", "NW_IT_TRAP040", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resgears",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswiresi",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirego",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Tötliche Falle: Heiliges Feuer
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsDeadly, "Tödliche Falle: Heiliges Feuer", "NW_IT_TRAP008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "X1_WMGRENADE005", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resgears",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswiresi",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirego",    1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 14);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 150, 150);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Tötliche Falle: Verstrickung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsDeadly, "Tödliche Falle: Verstrickung", "NW_IT_TRAP012", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resrope",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resgears",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswiresi", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirego", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 15);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 160, 160);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Tötliche Falle: Feuer
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsDeadly, "Tödliche Falle: Feuer", "NW_IT_TRAP020", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resgears",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswiresi",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirego",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 16);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 170, 170);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Tötliche Falle: Elektrizität
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsDeadly, "Tödliche Falle: Elektrizität", "NW_IT_TRAP024", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resgears",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswiresi",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirego",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 16);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 170, 170);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);

  // Tötliche Falle: Giftgas
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTinkerTrapsDeadly, "Tödliche Falle: Giftgas", "NW_IT_TRAP028", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resspring",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resgears",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswiresi",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirego",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 18);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 190, 190);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 60, 0, 40, 0, 0);
  ////////////////////////////////////////////////////////////////////////////////

}
