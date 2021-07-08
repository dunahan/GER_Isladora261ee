/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnrTailorsTable
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

  //PrintString("cnrTailorsTable init");

  /////////////////////////////////////////////////////////
  //  CNR Crafting Device "cnrTailorsTable"
  /////////////////////////////////////////////////////////
  string sMenuTailorProducts    = CnrRecipeAddSubMenu("cnrTailorsTable", "Allgemeines");

  string sMenuTailorWeapons     = CnrRecipeAddSubMenu("cnrTailorsTable", "Waffen");
  string sMenuTailorSling       = CnrRecipeAddSubMenu(sMenuTailorWeapons, "Schleudern");
  string sMenuTailorWhips       = CnrRecipeAddSubMenu(sMenuTailorWeapons, "Peitschen");

  string sMenuTailoClothing     = CnrRecipeAddSubMenu("cnrTailorsTable", "Kleidung");
  string sMenuTailorHood        = CnrRecipeAddSubMenu(sMenuTailoClothing, "Kapuzen");
  string sMenuTailorRobes       = CnrRecipeAddSubMenu(sMenuTailoClothing, "Roben");
  string sMenuTailorGaunt       = CnrRecipeAddSubMenu(sMenuTailoClothing, "Handschuhe");
  string sMenuTailorCloak       = CnrRecipeAddSubMenu(sMenuTailoClothing, "Umh�nge");
  string sMenuTailorBelt        = CnrRecipeAddSubMenu(sMenuTailoClothing, "G�rtel");
  string sMenuTailorBoots       = CnrRecipeAddSubMenu(sMenuTailoClothing, "Stiefel");

  string sMenuTailorArmor       = CnrRecipeAddSubMenu("cnrTailorsTable", "R�stungen");
  string sMenuTailorLeathArmor  = CnrRecipeAddSubMenu(sMenuTailorArmor, "Lederr�stungen");
  string sMenuTailorStdLthArmor = CnrRecipeAddSubMenu(sMenuTailorArmor, "Beschlagene Lederr�stungen");
  string sMenuTailorPaddedArmor = CnrRecipeAddSubMenu(sMenuTailorArmor, "Waffenr�cke");
  string sMenuTailorHideArmor   = CnrRecipeAddSubMenu(sMenuTailorArmor, "Fellr�stungen");

  string sMenuTailorKits        = CnrRecipeAddSubMenu("cnrTailorsTable", "Heilertaschen");

  CnrRecipeSetDeviceSpawnItemInDevice("cnrTailorsTable", TRUE);
  CnrRecipeSetDevicePreCraftingScript("cnrTailorsTable", "cnr_tailor_anim");
  CnrRecipeSetDeviceInventoryTool    ("cnrTailorsTable", "cnrSewingKit", CNR_FLOAT_SEWING_KIT_BREAKAGE_PERCENTAGE);
  CnrRecipeSetDeviceTradeskillType   ("cnrTailorsTable",  CNR_TRADESKILL_TAILORING);

  ///////////////////////// Kleidung - Grundzutaten //////////////////////////////
  // Stoff
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorProducts, "Stoff", "hw_restextile", 1);  // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "cnrCotton", 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Faden
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorProducts, "Faden", "hw_resyarn", 1);  // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "cnrCotton", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Schnittmuster (einfach)
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorProducts, "Schnittmuster (einfach)", "hw_respattern", 1);  // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Schnittmuster (leichte R�stungen)
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorProducts, "Schnittmuster (leichte R�stungen)", "hw_respatligh", 1);  // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respattern", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Schnittmuster (mittelschwere R�stungen)
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorProducts, "Schnittmuster (mittelschwere R�stungen)", "hw_respatmedi", 1);  // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respattern", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Schnittmuster (schwere R�stungen)
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorProducts, "Schnittmuster (schwere R�stungen)", "hw_respatheav", 1);  // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respattern", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Stoffpolsterung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorProducts, "Stoffpolsterung", "hw_resuphol", 1);  // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respattern", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrCotton",     1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);



  ///////////////////////// Schleudern //////////////////////////////
  // Schleuder
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorSling, "Schleuder", "NW_WBWSL001", 1); // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleath",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Schleuder +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorSling, "Schleuder +1", "NW_WBWMSL001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWSL001",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleath",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Schleuder +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorSling, "Schleuder +2", "NW_WBWMSL009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWMSL001",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Schleuder +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorSling, "Schleuder +3", "NW_WBWMSL010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_WBWMSL009",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);



  ///////////////////////// Peitschen //////////////////////////////
  // Peitsche
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorWhips, "Peitsche", "X2_IT_WPWHIP", 1); // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleath",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respattern", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",    1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Peitsche +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorWhips, "Peitsche +1", "X2_IT_WPMWHIP1", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "X2_IT_WPWHIP",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Peitsche +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorWhips, "Peitsche +2", "X2_IT_WPMWHIP2", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "X2_IT_WPMWHIP1", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Peitsche +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorWhips, "Peitsche +3", "X2_IT_WPMWHIP3", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "X2_IT_WPMWHIP2", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  ///////////////////////// Kapuzen (Beispiel) //////////////////////////////
  // Kapuze
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorHood, "Kapuze", "hw_hood001", 1);  // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respattern", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);



  ///////////////////////// Roben (Beispiel) //////////////////////////////
  // Kleidung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorRobes, "Kleidung", "hw_cloth001", 1);  // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respattern", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  // Kaempferroben +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorRobes, "K�mpferrobe +1", "isla_slg_mrb1", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_cloth001", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Kaempferroben +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorRobes, "K�mpferrobe +2", "isla_slg_mrb2", 1);  // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "isla_slg_mrb1",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirego",   3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 3);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Kaempferroben +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorRobes, "K�mpferrobe +3", "isla_slg_mrb3", 1);  // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "isla_slg_mrb2",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirepl",   5);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 5);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  // Lichtrobe
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorRobes, "Lichtrobe", "NW_MCLOTH006", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_cloth001",      1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "x2_it_lightgem07", 1);     // Lichtedelstein, weiss
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  // Robe der S�ureresistenz
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorRobes, "Robe der S�ureresistenz", "NW_MCLOTH007", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_cloth001",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Robe der K�lteresistenz
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorRobes, "Robe der K�lteresistenz", "NW_MCLOTH008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_cloth001",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Robe der Elektroresistenz
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorRobes, "Robe der Elektrizit�tsresistenz", "NW_MCLOTH010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_cloth001",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Robe der Feuerresistenz
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorRobes, "Robe der Feuerresistenz", "NW_MCLOTH009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_cloth001",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  /* Robe des Schlachtenmagus
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorRobes, "NW_MCLOTH013", "NW_MCLOTH013", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MCLOTH006",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);*/

  ///////////////////////// Handschuhe (Beispiel) //////////////////////////////
  // Handschuhe
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorGaunt, "Handschuhe", "hw_gloves001", 1);  // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respattern", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Kaempferhandschuhe +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorGaunt, "Kampfhandschuh +1", "isla_slg_mhs1", 1);  // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "hw_gloves001",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respattern",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Kaempferhandschuhe +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorGaunt, "Kampfhandschuh +2", "isla_slg_mhs2", 1);  // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "isla_slg_mhs1",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirego",   2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Kaempferhandschuhe +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorGaunt, "Kampfhandschuh +3", "isla_slg_mhs3", 1);  // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "isla_slg_mhs2",  1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_reswirepl",   3);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 3);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Handschuhe der Tierfreundschaft
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorGaunt, "Tiertrainerhandschuhe", "nw_it_mglove006", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_gloves001",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 3, 3);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // H�here Handschuhe der Tierfreundschaft
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorGaunt, "M�chtige Tiertrainerhandschuhe", "nw_it_mglove012", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "nw_it_mglove006", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",  4);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 5, 5);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  // Handschuhe der Disziplin
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorGaunt, "Handschuhe der Disziplin", "nw_it_mglove008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_gloves001",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 3, 3);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // H�here Handschuhe der Disziplin
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorGaunt, "M�chtige Handschuhe der Disziplin", "nw_it_mglove014", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "nw_it_mglove008", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",   4);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 5, 5);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  // Handschuhe der Ogerkraft
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorGaunt, "Schw�chere Panzerhandschuhe der Ogerkraft", "NW_IT_MBRACER012", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_gloves001",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 3, 3);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // H�here Handschuhe der Ogerkraft
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorGaunt, "Panzerhandschuhe der Ogerkraft", "NW_IT_MBRACER013", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MBRACER012", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",    4);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 5, 5);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);



  ///////////////////////// Umhang (Beispiel) //////////////////////////////
  // Umhang
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorCloak, "Umhang", "hw_cloak001", 1);  // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 2, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respattern", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  // Schutzumhang +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorCloak, "Schutzumhang +1", "NW_MAARCL055", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_cloak001",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Schutzumhang +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorCloak, "Schutzumhang +2", "NW_MAARCL088", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL055",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  // Resistenzumhang +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorCloak, "Resistenzumhang +1", "X0_MAARCL025", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_cloak001",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Resistenzumhang +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorCloak, "Resistenzumhang +2", "X0_MAARCL026", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "X0_MAARCL025",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 3, 3);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  // Befestigungsumhang +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorCloak, "Befestigungsumhang +1", "NW_MAARCL104", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL055",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "X0_MAARCL025",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Befestigungsumhang +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorCloak, "Befestigungsumhang +2", "NW_MAARCL105", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL088",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "X0_MAARCL026",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 4);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 16);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 170, 170);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 4, 4);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  // Nymphenumhang +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorCloak, "Nymphenumhang +1", "NW_MAARCL031", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_cloak001",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 3, 3);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Nymphenumhang +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorCloak, "Nymphenumhang +2", "NW_MAARCL092", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL031",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",  4);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 5, 5);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  ///////////////////////// G�rtel (Beispiel) //////////////////////////////
  // G�rtel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorBelt, "Lederg�rtel", "hw_belt001", 1);  // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleath",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  // G�rtel des wegweisenden Lichts
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorBelt, "G�rtel des Wegweisenden Lichts", "nw_it_mbelt016", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_belt001",        1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnr_lightgem",      1);  // Lichtedelstein
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",    1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 1, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  // G�rtel der Geschicklichkeit +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorBelt, "G�rtel der Beweglichkeit +1", "nw_it_mbelt018", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_belt001",     1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagbody",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 3, 3);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // G�rtel der Geschicklichkeit +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorBelt, "G�rtel der Beweglichkeit +2", "nw_it_mbelt019", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "nw_it_mbelt018", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagbody",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 80);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 5, 5);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  // G�rtel der H�gelriesenst�rke
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorBelt, "G�rtel der H�gelriesenst�rke", "NW_IT_MBELT002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_belt001",     1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagbody",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 3, 3);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // G�rtel der Frostriesenst�rke
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorBelt, "G�rtel der Frostriesenst�rke", "NW_IT_MBELT007", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MBELT002", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagbody",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",  2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 5, 5);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);



  ///////////////////////// Stiefel (Beispiel) //////////////////////////////
  // Stiefel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorBoots, "Lederstiefel", "hw_boots001", 1);  // Basis
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleath",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respattern", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  // Reflexstiefel +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorBoots, "Reflexstiefel +1", "nw_it_mboots010", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_boots001",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Reflexstiefel +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorBoots, "Reflexstiefel +2", "nw_it_mboots011", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "nw_it_mboots010", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  // Ausdauerstiefel +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorBoots, "Laufstiefel +1", "NW_IT_MBOOTS001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_boots001",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Ausdauerstiefel +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorBoots, "Laufstiefel +2", "NW_IT_MBOOTS006", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MBOOTS001", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",   2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",  2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 4, 4);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  // Stiefel der Sonnenseele +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorBoots, "Stiefel der Sonnenseele +1", "NW_IT_MBOOTS018", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_boots001",    1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",  1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Stiefel der Sonnenseele +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorBoots, "Stiefel der Sonnenseele +2", "NW_IT_MBOOTS019", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MBOOTS018", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagelem",   2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",  2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 4, 4);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  // Stiefel der H�rte +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorBoots, "Stiefel der Z�higkeit +1", "NW_IT_MBOOTS015", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MBOOTS018", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MBOOTS001", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",  2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Stiefel der H�rte +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorBoots, "Stiefel der Z�higkeit +2", "NW_IT_MBOOTS016", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MBOOTS019", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_IT_MBOOTS006", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic",  4);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 4, 4);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  ///////////////////////// Lederr�stung //////////////////////////////
  // Lederr�stung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorLeathArmor, "Lederr�stung", "NW_AARCL001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleath",   3, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respatligh", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",    1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Lederr�stung +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorLeathArmor, "Lederr�stung +1", "NW_MAARCL044", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_AARCL001", 1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resuphol", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",  1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Lederr�stung +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorLeathArmor, "Lederr�stung +2", "NW_MAARCL071", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL044",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Lederr�stung +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorLeathArmor, "Lederr�stung +3", "NW_MAARCL083", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL071",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 3);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 3, 3);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  ///////////////////////// Beschlagene Lederr�stung //////////////////////////////
  // Beschlagene Lederr�stung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorStdLthArmor, "Beschlagene Lederr�stung", "NW_AARCL002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleath",   5, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respatligh", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resstuds",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Beschlagene Lederr�stung +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorStdLthArmor, "Beschlagene Lederr�stung +1", "NW_MAARCL045", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_AARCL002",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resuphol",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Beschlagene Lederr�stung +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorStdLthArmor, "Beschlagene Lederr�stung +2", "NW_MAARCL075", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL045",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 7);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 80, 80);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Beschlagene Lederr�stung +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorStdLthArmor, "Beschlagene Lederr�stung +3", "NW_MAARCL087", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL075",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 3);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 9);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 100, 100);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 3, 3);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  ///////////////////////// Waffenr�cke //////////////////////////////
  // Waffenrock
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorPaddedArmor, "Waffenrock", "NW_AARCL009", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respatligh", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resuphol",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",    1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Waffenrock +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorPaddedArmor, "Waffenrock +1", "NW_MAARCL043", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_AARCL009",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleath",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Waffenrock +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorPaddedArmor, "Waffenrock +2", "NW_MAARCL072", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL043",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Waffenrock +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorPaddedArmor, "Waffenrock +3", "NW_MAARCL084", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL072",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 3);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 3, 3);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  ///////////////////////// Fellr�stungen //////////////////////////////
  // Fellr�stung
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorHideArmor, "Fellr�stung", "NW_AARCL008", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleath",   4, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respatmedi", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 4);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 50, 50);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Fellr�stung +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorHideArmor, "Fellr�stung +1", "NW_MAARCL047", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_AARCL008",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",    1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resuphol",   1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Fellr�stung +2
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorHideArmor, "Fellr�stung +2", "NW_MAARCL070", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL047",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 2, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Fellr�stung +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorHideArmor, "Fellr�stung +3", "NW_MAARCL082", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "NW_MAARCL070",   1, 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resyarn",     1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 3);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "hw_resleathbag", 3, 3);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);


  ///////////////////////// Verschiedenes //////////////////////////////
  // Bogensehne
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorProducts, "Bogensehne", "hw_resbogshn", 1);  // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "cnrSpiderSilk", 2, 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Lederb�rse
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorProducts, "Lederb�rse", "hw_resleathbag", 1);  // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "hw_respattern", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleath",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 2);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 30, 30);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Seil
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorProducts, "Seil", "hw_resrope", 1);  // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleath",   1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Verstrickungsbeutel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorProducts, "Verstrickungsbeutel", "x1_wmgrenade006", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleathbag", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrSpiderSilk",  5);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 5);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 60, 60);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);

  // Magischer Beutel
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorProducts, "Magischer Beutel", "NW_IT_CONTAIN002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resleathbag", 1, 2);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_resbagmagic", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_enchantoil",  2);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 8);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 90, 90);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 35, 0, 0);



  ///////////////////////// Heilertaschen //////////////////////////////
  // Heilertasche +1
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorKits, "Heilertasche +1", "NW_IT_MEDKIT001", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 2, 0);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 1);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 20, 20);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 0, 35, 0);

  // Heilertasche +3
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorKits, "Heilertasche +3", "NW_IT_MEDKIT002", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrAloeLeaf",   2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrComfryRoot", 2, 0);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 3);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 40, 40);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 0, 35, 0);

  // Heilertasche +6
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorKits, "Heilertasche +6", "NW_IT_MEDKIT003", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrAloeLeaf",   3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrComfryRoot", 3, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGingerRoot", 3, 0);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 6);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 70, 70);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 0, 35, 0);

  // Heilertasche +10
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorKits, "Heilertasche +10", "NW_IT_MEDKIT004", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile", 2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrAloeLeaf",   4, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrComfryRoot", 4, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGingerRoot", 4, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrginsengroot",4, 0);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 10);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 110, 110);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 0, 35, 0);

  // Heilertasche +12
  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuTailorKits, "Heilertasche +12", "itm_heilert_12", 1);  // Selbsterstellt
  CnrRecipeAddComponent(sKeyToRecipe, "hw_restextile",  2, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrAloeLeaf",    5, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrComfryRoot",  5, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrGingerRoot",  5, 0);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrginsengroot", 5, 0);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 0, 65, 0, 0, 35, 0);

}
