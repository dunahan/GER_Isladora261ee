/////////////////////////////////////////////////////////
//
//  Craftable Merchant Dialogs (CMD) by Festyx
//
//  Name:  user_merch_init
//
//  Generated by 'MerchantMaker'. A utility by Festyx.
//
/////////////////////////////////////////////////////////
#include "cnr_merch_utils"
void main()
{
  string sMenuOfBrewSupplies = CnrMerchantAddSubMenu("Adolphus", "Supplies");
  string sMenuOfDarkBeers = CnrMerchantAddSubMenu("Adolphus", "Dark Beers");
  string sMenuOfLightBeers = CnrMerchantAddSubMenu("Adolphus", "Light Beers");
  CnrMerchantAddItem(sMenuOfBrewSupplies, "Empty Brewing Bottle", "cnrBrewingBottle", 1, 1, TRUE);
  CnrMerchantAddItem(sMenuOfBrewSupplies, "Empty Water Bucket", "cnrBucketEmpty", 1, 1, TRUE);
  CnrMerchantAddItem(sMenuOfBrewSupplies, "Brewer's Yeast", "cnrYeastBrewers", 1, 1, TRUE);
  CnrMerchantAddItem(sMenuOfLightBeers, "Wine", "NW_IT_MPOTION023", 25, 25, FALSE);
  CnrMerchantAddItem(sMenuOfDarkBeers, "Iron Hammer Bock", "cnrbIronHammer", 25, 0, TRUE);
  CnrMerchantAddItem(sMenuOfLightBeers, "Pigs Ear Pilsener", "cnrbPigsEar", 25, 0, TRUE);
  CnrMerchantAddItem(sMenuOfLightBeers, "Will-o-Whiskey", "cnrbWilloWhiskey", 25, 0, TRUE);
  CnrMerchantAddItem(sMenuOfLightBeers, "Silver Buckle Gin", "cnrbSilverBuckle", 25, 0, TRUE);
  CnrMerchantAddItem(sMenuOfDarkBeers, "Dwarf's Head Ale", "cnrbDwarfsHead", 25, 0, TRUE);
  CnrMerchantAddItem(sMenuOfDarkBeers, "Black Knight Malt", "cnrbBlackKnight", 25, 0, TRUE);
  CnrMerchantAddItem(sMenuOfLightBeers, "Blue Sword Swill", "cnrbBlueSword", 25, 0, TRUE);
  CnrMerchantAddItem(sMenuOfDarkBeers, "Cherry River Lambic", "cnrbCherryRiver", 25, 0, TRUE);
  CnrMerchantAddItem(sMenuOfDarkBeers, "Jumpin' Juniper Brau", "cnrbJumpinJuniper", 25, 0, TRUE);
  CnrMerchantAddItem(sMenuOfDarkBeers, "Broken Knuckle Beer", "cnrbBrokenKnuckle", 50, 0, TRUE);
  CnrMerchantAddItem(sMenuOfLightBeers, "Wizard's Wheat Ale", "cnrbWizardsWheat", 50, 0, TRUE);

  string sMenuOfBakeSupplies = CnrMerchantAddSubMenu("DustyBaker", "Supplies");
  string sMenuOfRecipeCards = CnrMerchantAddSubMenu("DustyBaker", "Recipe Cards");
  string sMenuOfPies = CnrMerchantAddSubMenu("DustyBaker", "Pies");
  CnrMerchantAddItem(sMenuOfBakeSupplies, "Empty Juice Bottle", "cnrEmptyJuice", 1, 1, TRUE);
  CnrMerchantAddItem(sMenuOfBakeSupplies, "Baker's Yeast", "cnrYeastBakers", 1, 1, TRUE);
  CnrMerchantAddItem(sMenuOfBakeSupplies, "Honey", "cnrHoney", 1, 1, TRUE);
  CnrMerchantAddItem(sMenuOfPies, "Apple Pie", "cnrApplePie", 20, 0, TRUE);
  CnrMerchantAddItem(sMenuOfPies, "Blackberry Pie", "cnrBlkberryPie", 20, 0, TRUE);
  CnrMerchantAddItem(sMenuOfPies, "Blueberry Pie", "cnrBluberryPie", 20, 0, TRUE);
  CnrMerchantAddItem(sMenuOfPies, "Cherry Pie", "cnrCherryPie", 20, 0, TRUE);
  CnrMerchantAddItem(sMenuOfPies, "Pecan Pie", "cnrPecanPie", 20, 0, TRUE);
  CnrMerchantAddItem(sMenuOfRecipeCards, "Recipe Cards: Alchemy", "cnrCardsAlchemy", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfRecipeCards, "Recipe Cards: Weapons", "cnrCardsWeapons", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfRecipeCards, "Recipe Cards: Jewelry", "cnrCardsJewelry", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfRecipeCards, "Recipe Cards: Enchanting Alter", "cnrCardsEnchAlt", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfRecipeCards, "Recipe Cards: Enchanting Pool", "cnrCardsEnchPool", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfRecipeCards, "Recipe Cards: Enchanting Statue", "cnrCardsEnchStat", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfRecipeCards, "Recipe Cards: Wood Crafting", "cnrCardsWood", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfRecipeCards, "Recipe Cards: Tinker's Device", "cnrCardsTinkDevi", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfRecipeCards, "Recipe Cards: Tinker's Toolbox", "cnrCardsTinkTbox", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfRecipeCards, "Recipe Cards: Armor", "cnrCardsArmor", 0, 1, TRUE);

  string sMenuOfCraftingBooks = CnrMerchantAddSubMenu("Toman", "Crafting Books");
  string sMenuOfCraftingTools = CnrMerchantAddSubMenu("Toman", "Crafting Tools");
  string sMenuOfTomanSupplies = CnrMerchantAddSubMenu("Toman", "Supplies");
  string sMenuOfSuppliesMisc = CnrMerchantAddSubMenu(sMenuOfTomanSupplies, "Misc");
  string sMenuOfSuppliesPatterns = CnrMerchantAddSubMenu(sMenuOfTomanSupplies, "Patterns");
  CnrMerchantSetMerchantGreetingText("Toman", "Are you looking to negotiate on something unique? I deal in select merchandise. Are you interested?");
  CnrMerchantSetMerchantBuyText("Toman", "The following is a list of the items I will purchase. What do you wish to sell?");
  CnrMerchantSetMerchantSellText("Toman", "The following is a list of the items I will sell because you cannot make them at this time. What do you wish to buy?");
  CnrMerchantAddItem(sMenuOfCraftingBooks, "Basics of Mining", "cnrBookMining", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfCraftingBooks, "Basics of Smelting", "cnrBookSmelting", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfCraftingBooks, "Basics of Weapon Crafting", "cnrBookWeapons", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfCraftingBooks, "Basics of Armor Crafting", "cnrBookArmor", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfCraftingTools, "Miner's Pickaxe", "cnrMinersPickaxe", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfCraftingTools, "Tinker's Toolset", "cnrTinkersTools", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfCraftingTools, "Shovel", "cnrShovel", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfCraftingTools, "Gem Crafter's Chisel", "cnrGemChisel", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfCraftingTools, "Gem Crafter's Toolset", "cnrGemTools", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfCraftingTools, "Woodcutter's Axe", "cnrWoodCutterAxe", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfCraftingTools, "Carpenter's Toolset", "cnrCarpsTools", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfCraftingTools, "Smith's Hammer", "cnrSmithsHammer", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfSuppliesMisc, "Rope", "cnrRope", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfSuppliesMisc, "Holy Water", "cnrHolyWater", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfSuppliesMisc, "Belladona", "NW_IT_MSMLMISC23", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfSuppliesMisc, "Enchanting Oil", "cnrOilEnchanting", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfSuppliesMisc, "Bow String", "cnrBowString", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfSuppliesMisc, "Leather Pouch", "cnrLeatherPouch", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfSuppliesMisc, "Glass Vial", "cnrGlassVial", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfSuppliesMisc, "Poison Gas", "cnrPoisonGas", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfSuppliesMisc, "Owl Feather", "cnrFeatherOwl", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfSuppliesMisc, "Raven Feather", "cnrFeatherRaven", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfSuppliesMisc, "Falcon Feather", "cnrFeatherFalcon", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfSuppliesPatterns, "Pattern for Banded Mail", "cnrPatBandedMail", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfSuppliesPatterns, "Pattern for Chain Mail", "cnrPatChainMail", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfSuppliesPatterns, "Pattern for Chain Shirt", "cnrPatChainShirt", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfSuppliesPatterns, "Pattern for Full Plate", "cnrPatFullPlate", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfSuppliesPatterns, "Pattern for Half Plate", "cnrPatHalfPlate", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfSuppliesPatterns, "Pattern for Scale Mail", "cnrPatScaleMail", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfSuppliesPatterns, "Pattern for Splint Mail", "cnrPatSplintMail", 0, 1, TRUE);

  string sMenuOfGemboSupplies = CnrMerchantAddSubMenu("Gembo", "Supplies");
  string sMenuOfMinerals = CnrMerchantAddSubMenu("Gembo", "Minerals");
  string sMenuOfCutGems = CnrMerchantAddSubMenu("Gembo", "Cut Gems");
  string sMenuOfFlawedGems = CnrMerchantAddSubMenu("Gembo", "Flawed Gems");
  string sMenuOfFineGems = CnrMerchantAddSubMenu("Gembo", "Fine Gems");
  CnrMerchantSetMerchantGreetingText("Gembo", "Are you looking to sell gems? I just love to buy gems?");
  CnrMerchantSetMerchantBuyText("Gembo", "I only buy gems. Gems are all I buy.");
  CnrMerchantSetMerchantSellText("Gembo", "I sell very few things.");
  CnrMerchantAddItem(sMenuOfGemboSupplies, "Mystery Mineral", "cnrGemMineral000", 2, 2, TRUE);
  CnrMerchantAddItem(sMenuOfGemboSupplies, "Polishing Oil", "cnrOilPolishing", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfMinerals, "Mineral Alexandrite", "cnrGemMineral013", 28, 0, TRUE);
  CnrMerchantAddItem(sMenuOfMinerals, "Mineral Amethyst", "cnrGemMineral003", 8, 0, TRUE);
  CnrMerchantAddItem(sMenuOfMinerals, "Mineral Aventurine", "cnrGemMineral014", 4, 0, TRUE);
  CnrMerchantAddItem(sMenuOfMinerals, "Mineral Diamond", "cnrGemMineral005", 400, 0, TRUE);
  CnrMerchantAddItem(sMenuOfMinerals, "Mineral Emerald", "cnrGemMineral012", 800, 0, TRUE);
  CnrMerchantAddItem(sMenuOfMinerals, "Mineral Feldspar", "cnrGemMineral015", 10, 0, TRUE);
  CnrMerchantAddItem(sMenuOfMinerals, "Mineral Fire Agate", "cnrGemMineral002", 2, 0, TRUE);
  CnrMerchantAddItem(sMenuOfMinerals, "Mineral Fire Opal", "cnrGemMineral009", 300, 0, TRUE);
  CnrMerchantAddItem(sMenuOfMinerals, "Mineral Garnet", "cnrGemMineral011", 24, 0, TRUE);
  CnrMerchantAddItem(sMenuOfMinerals, "Mineral Greenstone", "cnrGemMineral001", 2, 0, TRUE);
  CnrMerchantAddItem(sMenuOfMinerals, "Mineral Malachite", "cnrGemMineral007", 2, 0, TRUE);
  CnrMerchantAddItem(sMenuOfMinerals, "Mineral Phenalope", "cnrGemMineral004", 4, 0, TRUE);
  CnrMerchantAddItem(sMenuOfMinerals, "Mineral Ruby", "cnrGemMineral006", 600, 0, TRUE);
  CnrMerchantAddItem(sMenuOfMinerals, "Mineral Sapphire", "cnrGemMineral008", 200, 0, TRUE);
  CnrMerchantAddItem(sMenuOfMinerals, "Mineral Topaz", "cnrGemMineral010", 50, 0, TRUE);
  CnrMerchantAddItem(sMenuOfCutGems, "Cut Alexandrite", "cnrGemCut013", 56, 0, TRUE);
  CnrMerchantAddItem(sMenuOfCutGems, "Cut Amethyst", "cnrGemCut003", 16, 0, TRUE);
  CnrMerchantAddItem(sMenuOfCutGems, "Cut Aventurine", "cnrGemCut014", 8, 0, TRUE);
  CnrMerchantAddItem(sMenuOfCutGems, "Cut Diamond", "cnrGemCut005", 800, 0, TRUE);
  CnrMerchantAddItem(sMenuOfCutGems, "Cut Emerald", "cnrGemCut012", 1600, 0, TRUE);
  CnrMerchantAddItem(sMenuOfCutGems, "Cut Feldspar", "cnrGemCut015", 20, 0, TRUE);
  CnrMerchantAddItem(sMenuOfCutGems, "Cut Fire Agate", "cnrGemCut002", 4, 0, TRUE);
  CnrMerchantAddItem(sMenuOfCutGems, "Cut Fire Opal", "cnrGemCut009", 600, 0, TRUE);
  CnrMerchantAddItem(sMenuOfCutGems, "Cut Garnet", "cnrGemCut011", 48, 0, TRUE);
  CnrMerchantAddItem(sMenuOfCutGems, "Cut Greenstone", "cnrGemCut001", 4, 0, TRUE);
  CnrMerchantAddItem(sMenuOfCutGems, "Cut Malachite", "cnrGemCut007", 4, 0, TRUE);
  CnrMerchantAddItem(sMenuOfCutGems, "Cut Phenalope", "cnrGemCut004", 8, 0, TRUE);
  CnrMerchantAddItem(sMenuOfCutGems, "Cut Ruby", "cnrGemCut006", 1200, 0, TRUE);
  CnrMerchantAddItem(sMenuOfCutGems, "Cut Sapphire", "cnrGemCut008", 400, 0, TRUE);
  CnrMerchantAddItem(sMenuOfCutGems, "Cut Topaz", "cnrGemCut010", 100, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFlawedGems, "Flawed Alexandrite", "cnrGemFlawed013", 28, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFlawedGems, "Flawed Amethyst", "cnrGemFlawed003", 8, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFlawedGems, "Flawed Aventurine", "cnrGemFlawed014", 4, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFlawedGems, "Flawed Diamond", "cnrGemFlawed005", 400, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFlawedGems, "Flawed Emerald", "cnrGemFlawed012", 800, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFlawedGems, "Flawed Feldspar", "cnrGemFlawed015", 10, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFlawedGems, "Flawed Fire Agate", "cnrGemFlawed002", 2, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFlawedGems, "Flawed Fire Opal", "cnrGemFlawed009", 300, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFlawedGems, "Flawed Garnet", "cnrGemFlawed011", 24, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFlawedGems, "Flawed Greenstone", "cnrGemFlawed001", 2, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFlawedGems, "Flawed Malachite", "cnrGemFlawed007", 2, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFlawedGems, "Flawed Phenalope", "cnrGemFlawed004", 4, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFlawedGems, "Flawed Ruby", "cnrGemFlawed006", 600, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFlawedGems, "Flawed Sapphire", "cnrGemFlawed008", 200, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFlawedGems, "Flawed Topaz", "cnrGemFlawed010", 50, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFineGems, "Fine Alexandrite", "cnrGemFine013", 290, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFineGems, "Fine Amethyst", "cnrGemFine003", 80, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFineGems, "Fine Aventurine", "cnrGemFine014", 40, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFineGems, "Fine Diamond", "cnrGemFine005", 4000, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFineGems, "Fine Emerald", "cnrGemFine012", 8000, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFineGems, "Fine Feldspar", "cnrGemFine015", 100, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFineGems, "Fine Fire Agate", "cnrGemFine002", 20, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFineGems, "Fine Fire Opal", "cnrGemFine009", 3000, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFineGems, "Fine Garnet", "cnrGemFine011", 240, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFineGems, "Fine Greenstone", "cnrGemFine001", 14, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFineGems, "Fine Malachite", "cnrGemFine007", 16, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFineGems, "Fine Phenalope", "cnrGemFine004", 40, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFineGems, "Fine Ruby", "cnrGemFine006", 6000, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFineGems, "Fine Sapphire", "cnrGemFine008", 2000, 0, TRUE);
  CnrMerchantAddItem(sMenuOfFineGems, "Fine Topaz", "cnrGemFine010", 500, 0, TRUE);

  string sMenuOfHeidiSupplies = CnrMerchantAddSubMenu("Heidi", "Supplies");
  string sMenuOfHeidiSkins = CnrMerchantAddSubMenu("Heidi", "Skins");
  CnrMerchantSetMerchantGreetingText("Heidi", "Top of the day to ya. Needin' some tailoring stuff fer yer testin?");
  CnrMerchantSetMerchantBuyText("Heidi", "Sorry, I don't have an interest in buyin' stuff.");
  CnrMerchantSetMerchantSellText("Heidi", "I carry many skins and plenty of skinnin' knives too.");
  CnrMerchantAddItem(sMenuOfHeidiSupplies, "Skinning Knife", "cnrSkinningKnife", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSupplies, "Sewing Kit", "cnrSewingKit", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSupplies, "Tanning Oil", "cnrOilTanning", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSupplies, "Tanning Acid", "cnrAcidTanning", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSupplies, "Book of Patterns", "cnrBookPatterns", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSkins, "Skin of a Bat", "cnrSkinBat", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSkins, "Skin of a Boar", "cnrSkinBoar", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSkins, "Skin of a Rat", "cnrSkinRat", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSkins, "Skin of a Wolf", "cnrSkinWolf", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSkins, "Skin of a Winter Wolf", "cnrSkinWinWolf", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSkins, "Skin of a Worg", "cnrSkinWorg", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSkins, "Skin of a Panther", "cnrSkinPanther", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSkins, "Skin of a Jaguar", "cnrSkinJaguar", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSkins, "Skin of a Leopard", "cnrSkinLeopard", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSkins, "Skin of a Crag Cat", "cnrSkinCragCat", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSkins, "Skin of a Couger", "cnrSkinCougar", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSkins, "Skin of a Malar Panther", "cnrSkinMalar", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSkins, "Skin of a Lion", "cnrSkinLion", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSkins, "Skin of a Ox", "cnrSkinOx", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSkins, "Skin of a White Stag", "cnrSkinWhiteStag", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSkins, "Skin of a Brown Bear", "cnrSkinBrnBear", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSkins, "Skin of a Black Bear", "cnrSkinBlkBear", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSkins, "Skin of a Grizzly Bear", "cnrSkinGrizBear", 0, 1, TRUE);
  CnrMerchantAddItem(sMenuOfHeidiSkins, "Skin of a Polar Bear", "cnrSkinPolarBear", 0, 1, TRUE);

  CnrMerchantSetMerchantGreetingText("Testy", "Greetings and welcome the to CNR test mod. I'm here to provide you with many of the tools you will need.");
  CnrMerchantSetMerchantBuyText("Testy", "Sorry, I'm not here to buy anything... Just to provide you with tools.");
  CnrMerchantSetMerchantSellText("Testy", "Take what you need. All I require is a small amount of gold. Gotta eat ya know!");
  CnrMerchantAddItem("Testy", "Miner's Pickaxe", "cnrMinersPickaxe", 0, 1, TRUE);
  CnrMerchantAddItem("Testy", "Tinker's Toolset", "cnrTinkersTools", 0, 1, TRUE);
  CnrMerchantAddItem("Testy", "Shovel", "cnrShovel", 0, 1, TRUE);
  CnrMerchantAddItem("Testy", "Gem Crafter's Chisel", "cnrGemChisel", 0, 1, TRUE);
  CnrMerchantAddItem("Testy", "Gem Crafter's Toolset", "cnrGemTools", 0, 1, TRUE);
  CnrMerchantAddItem("Testy", "Woodcutter's Axe", "cnrWoodCutterAxe", 0, 1, TRUE);
  CnrMerchantAddItem("Testy", "Carpenter's Toolset", "cnrCarpsTools", 0, 1, TRUE);
  CnrMerchantAddItem("Testy", "Smith's Hammer", "cnrSmithsHammer", 0, 1, TRUE);
  CnrMerchantAddItem("Testy", "Basics of Mining", "cnrBookMining", 0, 1, TRUE);
  CnrMerchantAddItem("Testy", "Basics of Smelting", "cnrBookSmelting", 0, 1, TRUE);
  CnrMerchantAddItem("Testy", "Basics of Weapon Crafting", "cnrBookWeapons", 0, 1, TRUE);
  CnrMerchantAddItem("Testy", "Basics of Armor Crafting", "cnrBookArmor", 0, 1, TRUE);
}

