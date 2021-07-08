/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_persist_ee
//
//  Desc:  These functions are collected together to
//         facilitate interfacing to a persistent database.
//
//  Author: David Bobeck 20Apr03
//  Addiotional include-file: Tobias Wirth 24Apr2020
//
/////////////////////////////////////////////////////////

#include "cnr_recipe_utils"

// uses those funcs from include
// void CnrLoadRecipeScript(string sDeviceTag, object oHost);
// void CnrLoadAllDeviceRecipesFromScript();
// string CnrSQLEncodeSpecialChars(string sString)
// string CnrSQLDecodeSpecialChars(string sString)

/////////////////////////////////////////////////////////

void CnrWriteDeviceToEEDatabase(int nIndex);

void CnrWriteSubmenusToEEDatabase(string sDeviceTag, string sKeyToModuleMenu);

void CnrWriteRecipesToEEDatabase(string sDeviceTag, string sKeyToModuleMenu);

void CnrWriteComponentsToEEDatabase(string sDeviceTag, string sKeyToModuleRecipe);

/////////////////////////////////////////////////////////

void dbmsg(string sMsg)
{
    WriteTimestampedLogEntry(sMsg);
}

void CnrWriteComponentsToEEDatabase(string sDeviceTag, string sKeyToModuleRecipe)
{
  object oModule = GetModule();
  string sHeader = "Module_Component_Nbr|Tag|Qty|RetainQty|Module_Menue_Recipe|Device";
  SetCampaignString("cnr_components", "0", sHeader);

  int nComponentCount = GetLocalInt(oModule, sKeyToModuleRecipe + "_RecipeComponentCount");
  if (nComponentCount > 0)
  {
    // we have components (thank goodness)
    int nComponentIndex;
    for (nComponentIndex = 1; nComponentIndex <= nComponentCount; nComponentIndex++)
    {
      string sKeyToComponent = sKeyToModuleRecipe + "_" + IntToString(nComponentIndex); dbmsg("11++ "+sKeyToComponent);
      string sTag = GetLocalString(oModule, sKeyToComponent + "_Tag");
      int nQty = GetLocalInt(oModule, sKeyToComponent + "_Qty");
      int nRetainQty = GetLocalInt(oModule, sKeyToComponent + "_RetainQty");
      string sSave = sKeyToComponent+"|"+sTag+"|"+IntToString(nQty)+"|"+IntToString(nRetainQty)+"|"+
                     sKeyToModuleRecipe+"|"+sDeviceTag;
      SetCampaignString("cnr_components", IntToString(nComponentIndex), sSave); dbmsg("12++ "+sSave);
    }
  }
}

void CnrWriteRecipesToEEDatabase(string sDeviceTag, string sKeyToModuleMenu)
{
  object oModule = GetModule();
  string sHeader = "Module_Menue_Nbr|RecipeDesc|RecipeTag|RecipeQty|RecipeFilter|"+
                   "RecipeStr|RecipeDex|RecipeCon|RecipeInt|RecipeWis|RecipeCha|"+
                   "RecipeLevel|GameXP|TradeXP|ScalarOverrideFlag|RecipePreScript|"+
                   "RecipeBiTag|RecipeBiQty|OnFailBiQty";
  SetCampaignString("cnr_recipes", "0", sHeader);

  int nSubCount = GetLocalInt(oModule, sKeyToModuleMenu + "_RecipeCount");      dbmsg("7++ "+sKeyToModuleMenu+";"+IntToString(nSubCount));
  if (nSubCount > 0)
  {
    // we have recipes
    int nRecipeIndex;
    for (nRecipeIndex = 1; nRecipeIndex <= nSubCount; nRecipeIndex++)
    {
      string sKeyToModuleRecipe = sKeyToModuleMenu + "_" + IntToString(nRecipeIndex);   dbmsg("9++ "+sKeyToModuleRecipe);
      string sDescription = GetLocalString(oModule, sKeyToModuleRecipe + "_RecipeDesc");
      string sRecipeTag = GetLocalString(oModule, sKeyToModuleRecipe + "_RecipeTag");
      int nRecipeQty = GetLocalInt(oModule, sKeyToModuleRecipe + "_RecipeQty");
      string sFilter = GetLocalString(oModule, sKeyToModuleRecipe + "_RecipeFilter");
      int nStr = GetLocalInt(oModule, sKeyToModuleRecipe + "_RecipeStr");
      int nDex = GetLocalInt(oModule, sKeyToModuleRecipe + "_RecipeDex");
      int nCon = GetLocalInt(oModule, sKeyToModuleRecipe + "_RecipeCon");
      int nInt = GetLocalInt(oModule, sKeyToModuleRecipe + "_RecipeInt");
      int nWis = GetLocalInt(oModule, sKeyToModuleRecipe + "_RecipeWis");
      int nCha = GetLocalInt(oModule, sKeyToModuleRecipe + "_RecipeCha");
      int nLevel = GetLocalInt(oModule, sKeyToModuleRecipe + "_RecipeLevel");
      int nGameXP = GetLocalInt(oModule, sKeyToModuleRecipe + "_GameXP");
      int nTradeXP = GetLocalInt(oModule, sKeyToModuleRecipe + "_TradeXP");
      int bScalarOverrideFlag = GetLocalInt(oModule, sKeyToModuleRecipe + "_ScalarOverrideFlag");
      string sAnimation = GetLocalString(oModule, sKeyToModuleRecipe + "_RecipePreScript");
      string sBiTag = GetLocalString(oModule, sKeyToModuleRecipe + "_RecipeBiTag");
      int nBiQty = GetLocalInt(oModule, sKeyToModuleRecipe + "_RecipeBiQty");
      int nOnFailBiQty = GetLocalInt(oModule, sKeyToModuleRecipe + "_OnFailBiQty");

      sDescription = CnrSQLEncodeSpecialChars(sDescription);
      string sSave = sKeyToModuleRecipe+"|"+sDeviceTag+"|"+sDescription+"|"+sRecipeTag+"|"+
                     IntToString(nRecipeQty)+"|"+sKeyToModuleMenu+"|"+sFilter+"|"+IntToString(nStr)+"|"+
                     IntToString(nDex)+"|"+IntToString(nCon)+"|"+IntToString(nInt)+"|"+IntToString(nWis)+"|"+
                     IntToString(nCha)+"|"+IntToString(nLevel)+"|"+IntToString(nGameXP)+"|"+IntToString(nTradeXP)+"|"+
                     IntToString(bScalarOverrideFlag)+"|"+sAnimation+"|"+sBiTag+"|"+IntToString(nBiQty)+"|"+IntToString(nOnFailBiQty);

      SetCampaignString("cnr_recipes", IntToString(nRecipeIndex), sSave);       dbmsg("10++ "+sSave);

      CnrWriteComponentsToEEDatabase(sDeviceTag, sKeyToModuleRecipe);
    }
  }

  // This code deferred by AssignCommand to avoid TMI errors.
  CnrDecrementStackCount(oModule);

}

void CnrWriteSubmenusToEEDatabase(string sDeviceTag, string sKeyToModuleMenu)
{
  object oModule = GetModule();
  string sHeader = "Sub_Menue|Module_Menue|Menue_Title|DeviceTag";
  SetCampaignString("cnr_submenus", "0", sHeader);
  int nSubCount = GetLocalInt(oModule, sKeyToModuleMenu + "_SubMenuCount");     dbmsg("6++ "+sKeyToModuleMenu+";"+IntToString(nSubCount));
  if (nSubCount > 0)
  {
    // we have submenus
    int nMenuIndex;
    for (nMenuIndex = 1; nMenuIndex <= nSubCount; nMenuIndex++)
    {
      string sKeyToSubMenu = sKeyToModuleMenu + "_" + IntToString(nMenuIndex);

      // Add this submenu to the database
      string sMenuTitle = GetLocalString(oModule, sKeyToSubMenu + "_RecipeDesc");   dbmsg("7++ "+sMenuTitle);
      sMenuTitle = CnrSQLEncodeSpecialChars(sMenuTitle);
      string sSave = sKeyToSubMenu+"|"+sKeyToModuleMenu+"|"+sMenuTitle+"|"+sDeviceTag; dbmsg("8++ "+sSave);
      SetCampaignString("cnr_submenus", IntToString(nMenuIndex), sSave);

      CnrWriteSubmenusToEEDatabase(sDeviceTag, sKeyToSubMenu);
    }
  }
  else
  {
    // Defer processing to avoid TMI errors.
    CnrIncrementStackCount(oModule);
    AssignCommand(OBJECT_SELF, CnrWriteRecipesToEEDatabase(sDeviceTag, sKeyToModuleMenu));
  }

  // This code deferred by AssignCommand to avoid TMI errors.
  CnrDecrementStackCount(oModule);
}

void CnrWriteDeviceToEEDatabase(int nIndex)
{
  object oModule = GetModule();                                                 dbmsg("1++ "+GetName(oModule));

  CnrSetStackCount(oModule, 0);

  int nDeviceCount = GetLocalInt(oModule, "CnrCraftingDeviceCount");            dbmsg("2++ "+IntToString(nDeviceCount));
  string sHeader = "RecipePreScript|SpawnItemInDevice|InventoryTool|EquippedTool|"+
                   "InventoryTool_BP|EquippedTool_BP|TradeskillType";
  SetCampaignString("cnr_devices", "0", sHeader);
//int nIndex;
//for (nIndex = 1; nIndex <= nDeviceCount; nIndex++)
  {
    string sDeviceTag = GetLocalString(oModule, "CnrDeviceTag_" + IntToString(nIndex));
    if (sDeviceTag != "")
    {
      int bDeviceLoaded = GetCampaignInt("cnr_misc", sDeviceTag + "_DeviceLoaded"); dbmsg("3++ "+IntToString(bDeviceLoaded));
      if (bDeviceLoaded == FALSE)
      {                                                                         dbmsg("4++ Device: "+sDeviceTag);
        // Get the settings for the device
        string sAnimation = GetLocalString(oModule, sDeviceTag + "_RecipePreScript");
        int bSpawnInDevice = GetLocalInt(oModule, sDeviceTag + "_SpawnItemInDevice");
        string sInvTool = GetLocalString(oModule, sDeviceTag + "_InventoryTool");
        string sEqpTool = GetLocalString(oModule, sDeviceTag + "_EquippedTool");
        float fInvToolBP = GetLocalFloat(oModule, sDeviceTag + "_InventoryTool_BP");
        float fEqpToolBP = GetLocalFloat(oModule, sDeviceTag + "_EquippedTool_BP");
        int nTradeType = GetLocalInt(oModule, sDeviceTag + "_TradeskillType");
        string sSave = sDeviceTag+"|"+sAnimation+"|"+IntToString(bSpawnInDevice)+"|"+sInvTool+"|"+sEqpTool+"|"+IntToString(nTradeType)+"|"+
                       FloatToString(fInvToolBP,3,2)+"|"+FloatToString(fEqpToolBP,3,2);  dbmsg("5++ "+sSave);

        // Add the device to the cnr_devices table
        SetCampaignString("cnr_devices", IntToString(nIndex), sSave);

        // Defer processing to avoid TMI errors.
        CnrIncrementStackCount(oModule);
        AssignCommand(OBJECT_SELF, CnrWriteSubmenusToEEDatabase(sDeviceTag, sDeviceTag));

        SetCampaignInt("cnr_misc", sDeviceTag + "_DeviceLoaded", TRUE);
      }
    }
  }
}


/*void CnrFetchSingleComponentFromSqlDatabase(string sDeviceTag, object oHost)
{
  if (CnrSQLFetch() == CNR_SQL_SUCCESS)
  {
    string sKeyToComponent = CnrSQLGetData(1);
    string sComponentTag = CnrSQLGetData(2);
    int nComponentQty = StringToInt(CnrSQLGetData(3));
    int nRetainOnFailQty = StringToInt(CnrSQLGetData(4));
    string sKeyToRecipe = CnrSQLGetData(5);
    //string sDeviceTag = CnrSQLGetData(6);

    // Don't call this, because the fetch may alter the component order
    //CnrRecipeAddComponent(string sKeyToRecipe, string sComponentTag, int nComponentQty, int nRetainOnFailQty=0);

    object oModule = GetModule();

    int nComponentCount = GetLocalInt(oModule, sKeyToRecipe + "_RecipeComponentCount") + 1;
    SetLocalInt(oModule, sKeyToRecipe + "_RecipeComponentCount", nComponentCount);

    SetLocalString(oModule, sKeyToComponent + "_Tag", sComponentTag);
    SetLocalInt(oModule, sKeyToComponent + "_Qty", nComponentQty);
    SetLocalInt(oModule, sKeyToComponent + "_RetainQty", nRetainOnFailQty);

    //PrintString("FetchSingleComponent success: sKeyToComponent = " + sKeyToComponent);

    // Keep fetching
    AssignCommand(OBJECT_SELF, CnrFetchSingleComponentFromSqlDatabase(sDeviceTag, oHost));
  }
  else
  {
    // We're done loading this device.
    CnrSetPersistentInt(GetModule(), sDeviceTag + "_DeviceLoaded", TRUE);

    //PrintString("FetchSingleComponent failed: decrementing stack count");

    // This code deferred by AssignCommand to avoid TMI errors.
    CnrDecrementStackCount(oHost);
  }
}*/

/*void CnrReadComponentsFromSqlDatabase(string sDeviceTag, object oHost)
{
  string sSQL = "SELECT * FROM cnr_components WHERE sDeviceTag = '" + sDeviceTag + "';";
  CnrSQLExecDirect(sSQL);

  // Defer processing to avoid TMI errors.
  AssignCommand(OBJECT_SELF, CnrFetchSingleComponentFromSqlDatabase(sDeviceTag, oHost));
}*/

/*void CnrFetchSingleRecipeFromSqlDatabase(string sDeviceTag, object oHost)
{
  if (CnrSQLFetch() == CNR_SQL_SUCCESS)
  {
    string sKeyToRecipe = CnrSQLGetData(1);
    //string sDeviceTag = CnrSQLGetData(2);
    string sRecipeDesc = CnrSQLGetData(3);
    string sRecipeTag = CnrSQLGetData(4);
    int nQtyMade = StringToInt(CnrSQLGetData(5));
    string sKeyToParent = CnrSQLGetData(6);
    string sFilter = CnrSQLGetData(7);
    int nStr = StringToInt(CnrSQLGetData(8));
    int nDex = StringToInt(CnrSQLGetData(9));
    int nCon = StringToInt(CnrSQLGetData(10));
    int nInt = StringToInt(CnrSQLGetData(11));
    int nWis = StringToInt(CnrSQLGetData(12));
    int nCha = StringToInt(CnrSQLGetData(13));
    int nLevel = StringToInt(CnrSQLGetData(14));
    int nGameXP = StringToInt(CnrSQLGetData(15));
    int nTradeXP = StringToInt(CnrSQLGetData(16));
    int bScalarOverride = StringToInt(CnrSQLGetData(17));
    string sAnimation = CnrSQLGetData(18);
    string sBiTag = CnrSQLGetData(19);
    int nBiQty = StringToInt(CnrSQLGetData(20));
    int nOnFailBiQty = StringToInt(CnrSQLGetData(21));

    // Don't call this, because the fetch may alter the recipe order
    //CnrRecipeCreateRecipe(string sDeviceTag, string sRecipeDesc, string sRecipeTag, int nQtyMade);

    object oModule = GetModule();

    int nRecipeCount = GetLocalInt(oModule, sKeyToParent + "_RecipeCount") + 1;
    SetLocalInt(oModule, sKeyToParent + "_RecipeCount", nRecipeCount);
    //PrintString(sKeyToParent + "_RecipeCount = " + IntToString(nRecipeCount));

    SetLocalString(oModule, sKeyToRecipe + "_RecipeDesc", sRecipeDesc);
    SetLocalString(oModule, sKeyToRecipe + "_RecipeTag", sRecipeTag);
    SetLocalInt(oModule, sKeyToRecipe + "_RecipeQty", nQtyMade);
    SetLocalInt(oModule, sKeyToRecipe + "_RecipeComponentCount", 0);
    SetLocalString(oModule, sKeyToRecipe + "_KeyToParent", sKeyToParent);
    CnrRecipeSetRecipeFilter(sKeyToRecipe, sFilter);
    CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, nStr, nDex, nCon, nInt, nWis, nCha);
    CnrRecipeSetRecipeLevel(sKeyToRecipe, nLevel);
    CnrRecipeSetRecipeXP(sKeyToRecipe, nGameXP, nTradeXP, bScalarOverride);
    CnrRecipeSetRecipePreCraftingScript(sKeyToRecipe, sAnimation);
    CnrRecipeSetRecipeBiproduct(sKeyToRecipe, sBiTag, nBiQty, nOnFailBiQty);

    // count the total number of recipes
    nRecipeCount = GetLocalInt(oModule, "CnrRecipeCount") + 1;
    SetLocalInt(oModule, "CnrRecipeCount", nRecipeCount);

    //PrintString("FetchSingleRecipe success: sKeyToRecipe = " + sKeyToRecipe);

    // Keep fetching
    AssignCommand(OBJECT_SELF, CnrFetchSingleRecipeFromSqlDatabase(sDeviceTag, oHost));
  }
  else
  {
    //PrintString("FetchSingleRecipe failed: Start reading components.");

    //CnrReadComponentsFromSqlDatabase(sDeviceTag, oHost);

    // Defer processing to avoid TMI errors.
    AssignCommand(OBJECT_SELF, CnrReadComponentsFromSqlDatabase(sDeviceTag, oHost));
  }
}*/

/*void CnrReadRecipesFromSqlDatabase(string sDeviceTag, object oHost)
{
  string sSQL = "SELECT * FROM cnr_recipes WHERE sDeviceTag = '" + sDeviceTag + "';";
  CnrSQLExecDirect(sSQL);

  // Defer processing to avoid TMI errors.
  AssignCommand(OBJECT_SELF, CnrFetchSingleRecipeFromSqlDatabase(sDeviceTag, oHost));
}*/

/*void CnrFetchSingleSubmenuFromSqlDatabase(string sDeviceTag, object oHost)
{
  if (CnrSQLFetch() == CNR_SQL_SUCCESS)
  {
    string sKeyToMenu = CnrSQLGetData(1);
    string sKeyToParent = CnrSQLGetData(2);
    string sTitle = CnrSQLGetData(3);
    //string sDeviceTag = CnrSQLGetData(4);

    // Don't call this, because the fetch may alter the submenu order
    //CnrRecipeAddSubMenu(string sKeyToParent, string sTitle);

    object oModule = GetModule();

    string sKeyToCount = sKeyToParent + "_SubMenuCount";
    int nSubMenuCount = GetLocalInt(oModule, sKeyToCount) + 1;
    SetLocalInt(oModule, sKeyToCount, nSubMenuCount);

    SetLocalString(oModule, sKeyToMenu + "_RecipeDesc", sTitle);
    SetLocalString(oModule, sKeyToMenu + "_KeyToParent", sKeyToParent);

    //PrintString("FetchSingleSubmenu success: sKeyToMenu = " + sKeyToMenu);

    // Keep fetching
    AssignCommand(OBJECT_SELF, CnrFetchSingleSubmenuFromSqlDatabase(sDeviceTag, oHost));
  }
  else
  {
    //PrintString("FetchSingleSubmenu failed: Start reading recipes.");

    //CnrReadRecipesFromSqlDatabase(sDeviceTag, oHost);

    // Defer processing to avoid TMI errors.
    AssignCommand(OBJECT_SELF, CnrReadRecipesFromSqlDatabase(sDeviceTag, oHost));
  }
}*/

/*void CnrReadSubmenusFromSqlDatabase(string sDeviceTag, object oHost)
{
  //PrintString("Reading submenus for device " + sDeviceTag);

  string sSQL = "SELECT * FROM cnr_submenus WHERE sDeviceTag = '" + sDeviceTag + "';";
  CnrSQLExecDirect(sSQL);

  // Defer processing to avoid TMI errors.
  AssignCommand(OBJECT_SELF, CnrFetchSingleSubmenuFromSqlDatabase(sDeviceTag, oHost));
}*/
