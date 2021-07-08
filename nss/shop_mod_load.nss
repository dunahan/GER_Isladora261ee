/* Script Created By Rami_Ahmed */
void main()
{ WriteTimestampedLogEntry("Starting Player-owned shops script");

  // ExecuteScript("x2_mod_def_load", OBJECT_SELF);
  // ExecuteScript("eds_mod_load", OBJECT_SELF);
  // ExecuteScript("aps_onload", OBJECT_SELF);

  int nShopStartingPrice = 40000;
  // * This is the starting price for any shop throughout the module.

  int nMaxShopItems = 64;
  // * This is the maximum amount of items possible to store for the player.
  // ** Do not set this number too high - when opening the store the players will recieve some lag.

  int nSalesmanWage = 50;
  // * This is the wage (in gold pieces) that the salesmen will want for working 1 day (ingame)

  int nLongestNameAllowed = 36;
  // * This is the number of digits that shop names maximum may have.
  // ** Set to 0 or any negative integer to disable name-changing.

  /* Do not edit anything below */
  object oMod = GetModule();
  SetLocalInt(oMod, "ShopStartPrice", nShopStartingPrice);
  SetLocalInt(oMod, "ShopMaxItems", nMaxShopItems);
  SetLocalInt(oMod, "ShopMinSalary", nSalesmanWage);
  SetLocalInt(oMod, "ShopRuleMaxNam", nLongestNameAllowed);
}
