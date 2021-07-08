/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_plant_init
//
//  Desc:  Plant initialization. This script is
//         executed from "cnr_module_oml".
//
//  Author: David Bobeck 12Dec02
//
/////////////////////////////////////////////////////////
#include "cnr_plant_utils"
#include "cnr_config_inc"
void main()
{
  PrintString("cnr_plant_init");

  // Module builders: You should put your plant initialization
  // into a file named "user_plant_init" so that future
  // versions of CNR do not over-write any resources you define.
  ExecuteScript("user_plant_init", OBJECT_SELF);

  /////////////////////////////////////////////////////////
  // Default CNR plant initialization
  /////////////////////////////////////////////////////////

  CnrPlantInitialize("cnrApplePlant",    "cnrAppleFruit",      6, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
//CnrPlantInitialize("cnrPearPlant",     "cnrPearFruit",       6, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
//CnrPlantInitialize("cnrCherryPlant",   "cnrCherryFruit",     6, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrGrapePlant",    "cnrGrapeFruit",      6, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
//CnrPlantInitialize("cnrEldberryPlant", "cnrEldberryFruit",   6, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrcocoon",        "cnrspidersilk",      6, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);

//CnrPlantInitialize("cnrCrnberryPlant", "cnrCrnberryFruit",   4, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrBlkberryPlant", "cnrBlkberryFruit",   4, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrBluberryPlant", "cnrBluberryFruit",   4, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrHopsPlant",     "cnrHopsFlower",      4, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);

  CnrPlantInitialize("cnrCottonPlant",   "cnrCotton",          8, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrBirdFeather",   "cnrFeathers",        4, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrPileOfSalt",    "cnrSalt",            4, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrSacksOfSalt",   "cnrSalt",            8, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrSacksOfSugar",  "cnrSugar",           8, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);

  CnrPlantInitialize("cnrCornPlant",     "cnrCornRaw",         4, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
//CnrPlantInitialize("cnrBarleyPlant",   "cnrBarleyRaw",       4, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
//CnrPlantInitialize("cnrOatsPlant",     "cnrOatsRaw",         4, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
//CnrPlantInitialize("cnrRicePlant",     "cnrRiceRaw",         4, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
//CnrPlantInitialize("cnrRyePlant",      "cnrRyeRaw",          4, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
//CnrPlantInitialize("cnrWheatPlant",    "cnrWheatRaw",        4, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);

//CnrPlantInitialize("cnrRspberryPlant", "cnrRspberryFruit",   3, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrJuniperPlant",  "cnrJuniperFruit",    3, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrHazelnutPlant", "cnrHazelnutFruit",   3, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
//CnrPlantInitialize("cnrWalnutPlant",   "cnrWalnutFruit",     3, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
//CnrPlantInitialize("cnrPecanPlant",    "cnrPecanFruit",      3, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
//CnrPlantInitialize("cnrChestnutPlant", "cnrChestnutFruit",   3, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
//CnrPlantInitialize("cnrAlmondPlant",   "cnrAlmondFruit",     3, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);

  CnrPlantInitialize("cnrAloePlant",     "cnrAloeLeaf",        2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrAngelicaPlant", "cnrAngelicaLeaf",    2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrBkCohoshPlant", "cnrBlkCohoshRoot",   2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrCalendulaPlant","cnrCalendulaFwr",    2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrCatnipPlant",   "cnrCatnipLeaf",      2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrChamomilePlant","cnrChamomileFwr",    2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrComfreyPlant",  "cnrComfryRoot",      2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
//CnrPlantInitialize("cnrEchinaceaPlant","cnrEchinaceaRoot",   2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrGarlicPlant",   "cnrGarlicClove",     2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrGingerPlant",   "cnrGingerRoot",      2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrGinsengPlant",  "cnrginsengroot",     2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrHawthornPlant", "cnrHawthornFwr",     2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrThistlePlant",  "cnrThistleLeaf",     2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrNettlePlant",   "cnrNettleLeaf",      2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrPepmintPlant",  "cnrPepmintLeaf",     2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrCoverPlant",    "cnrCloverLeaf",      2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrSagePlant",     "cnrSageLeaf",        2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrSkullcapPlant", "cnrSkullcapLeaf",    2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrHazelPlant",    "cnrHazelLeaf",       2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrBirchPlant",    "cnrBirchBark",       2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrSpiderCocoon",  "cnrSpiderSilk",      2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
//CnrPlantInitialize("cnrBeehive",       "cnrHoney",           2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrBeeNest",       "cnrHoney",           2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
//CnrPlantInitialize("cnrMaplePlant",    "cnrMapleSyrup",      2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrPatchMushBlk",  "cnrMushroomBlk",     2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrPatchMushWht",  "cnrMushroomWht",     2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrPatchMushRed",  "cnrMushroomRed",     2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrPatchMushPurp", "cnrMushroomPurp",    2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrPatchMushSpot", "cnrMushroomSpot",    2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);
  CnrPlantInitialize("cnrPatchMushYel",  "cnrMushroomYel",     2, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);

  CnrPlantInitialize("cnrPileOfDirt",    "cnrGraveyardDirt",   1, 900.0, CNR_INT_ALWAYS_RESPAWN_FRUIT);

}


