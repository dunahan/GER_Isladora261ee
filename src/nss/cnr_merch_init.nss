/////////////////////////////////////////////////////////
//
//  Craftable Merchant Dialog (CMD) is a subset of
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_merch_init
//
//  Desc:  merchant initialization. This script should
//  executed from the module's OnModuleLoad handler. If
//  you are using CNR, this script is called from
//  "cnr_module_oml"
//
//  Author: David Bobeck 15Dec02
//
/////////////////////////////////////////////////////////
#include "cnr_merch_utils"

void main()
{
  PrintString("cnr_merch_utils");

  /////////////////////////////////////////////////////////
  // DO NOT ADD YOUR CODE TO THIS FILE.....
  // Module builders: You should create and add your merchant lists
  // to the file "user_merch_init" so that future versions
  // of CMD or CNR don't over-write your work - Your call thou.
  ExecuteScript("user_merch_init", OBJECT_SELF);

  // The newline char for use in convo dialogs since
  // carriage returns produce ugly boxes.
  SetCustomToken(500, "\n");

  /////////////////////////////////////////////////////////
  // This is the code used in the sample module. It is
  // here for demonstration purposes only.  I encourage
  // you to use MerchantMaker to generate the code for you.
  /////////////////////////////////////////////////////////
  /*
  CnrMerchantEnablePersistentInventory("Dusty");
  CnrMerchantAddItem("Dusty", "Bless Potion", "NW_IT_MPOTION009", 30, 35, TRUE);
  CnrMerchantAddPersistentItem("Dusty", "Skeleton's Knuckle", "NW_IT_MSMLMISC13", 20, 20, 2, 5);
  CnrMerchantAddItem("Dusty", "Empty Bottle", "NW_IT_THNMISC001", 0, 1, TRUE);
  CnrMerchantAddItem("Dusty", "Wine", "NW_IT_MPOTION023", 5, 0, FALSE, 2);
  CnrMerchantAddPersistentItem("Dusty", "Silver Ring", "NW_HEN_GRI1QT", 0, 10, 2, 2);
  // AddItem2 is used here because the tag and resref have different spellings
  CnrMerchantAddItem2("Dusty", "Stinky Fish", "TestFishTag", "testfishresref", 1, 1, TRUE);

  CnrMerchantSetMerchantGreetingText("Sandy", "Sandy's custom greeting text!");
  CnrMerchantSetMerchantBuyText("Sandy", "Sandy's custom buy text!");
  CnrMerchantSetMerchantSellText("Sandy", "Sandy's custom sell text!");
  CnrMerchantAddItem("Sandy", "Bless Potion", "NW_IT_MPOTION009", 30, 35, TRUE);
  CnrMerchantAddItem("Sandy", "Skeleton's Knuckle", "NW_IT_MSMLMISC13", 20, 20, FALSE);
  CnrMerchantAddItem("Sandy", "Empty Bottle", "NW_IT_THNMISC001", 1, 0, TRUE);
  CnrMerchantAddItem("Sandy", "Wine", "NW_IT_MPOTION023", 0, 5, TRUE);
  CnrMerchantAddItem("Sandy", "Silver Ring", "NW_HEN_GRI1QT", 0, 10, FALSE);
  // AddItem2 is used here because the tag and resref have different spellings
  CnrMerchantAddItem2("Sandy", "Stinky Fish", "TestFishTag", "testfishresref", 1, 1, TRUE);
  */
}

