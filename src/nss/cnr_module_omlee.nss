/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_module_oml
//
//  Desc:  This script must be run by the module's
//         OnModuleLoad event handler.
//
//  Author: David Bobeck 12Jan03
//
/////////////////////////////////////////////////////////
#include "cnr_persist_inc"
#include "cnr_config_inc"

void main()
{
  CnrSQLExecDirect("CREATE TABLE IF NOT EXISTS cnr_misc(" +
                   "player varchar(64) DEFAULT NULL," +
                   "tag varchar(64) DEFAULT NULL, " +
                   "name varchar(64) DEFAULT NULL, " +
                   "val text, " +
                   "expire int(16) DEFAULT NULL, " +
                   "last timestamp NOT NULL DEFAULT DEFAULT_TIMESTAMP, " +
                   "PRIMARY KEY (player,tag,name))");

  if      (!SqlStep(SqlPrepareQueryCampaign("db", "SELECT player, tag, name, val, expire, last FROM cnr_misc WHERE tag = '"+GetTag(GetModule())+"'")))
  {
    CnrSQLExecDirect("INSERT INTO cnr_misc (" +
                     "last, expire, val, name, tag, player) " +
                     "VALUES (" +
                     "'DEFAULT_TIMESTAMP', NULL, '0', 'CnrBoolBuildRecipeDatabase'," +
                     "'"+GetTag(GetModule())+"', '~')");
  }


  if (CNR_BOOL_RECIPE_DATA_IS_PERSISTENT_IN_SQL_DATABASE == TRUE)
  {
    CnrSQLExecDirect("CREATE TABLE IF NOT EXISTS cnr_devices (" +
                     "sDeviceTag varchar(16) NOT NULL default ''," +
                     "sAnimation varchar(16) default NULL," +
                     "bSpawnInDevice int(12) default 0," +
                     "sInvTool varchar(16) default NULL," +
                     "sEqpTool varchar(16) default NULL," +
                     "nTradeType int(12) default 0," +
                     "fInvToolBP float default 0," +
                     "fEqpToolBP float default 0," +
                     "PRIMARY KEY (sDeviceTag)" +
                     ")" );

    CnrSQLExecDirect("CREATE TABLE IF NOT EXISTS cnr_submenus (" +
                     "sKeyToMenu varchar(64) NOT NULL default ''," +
                     "sKeyToParent varchar(64) NOT NULL default ''," +
                     "sTitle varchar(64) NOT NULL default ''," +
                     "sDeviceTag varchar(16) NOT NULL default ''," +
                     "PRIMARY KEY (sKeyToMenu)" +
                     ")" );
    CnrSQLExecDirect("CREATE INDEX IF NOT EXISTS sDeviceTag ON cnr_submenus (sDeviceTag)");

    CnrSQLExecDirect("CREATE TABLE IF NOT EXISTS cnr_recipes (" +
                     "sKeyToRecipe varchar(64) NOT NULL default ''," +
                     "sDeviceTag varchar(16) NOT NULL default ''," +
                     "sDescription varchar(64) NOT NULL default ''," +
                     "sTag varchar(16) NOT NULL default ''," +
                     "nQty int(12) default 1," +
                     "sKeyToParent varchar(64) NOT NULL default ''," +
                     "sFilter varchar(32) default NULL," +
                     "nStr int(12) default 0," +
                     "nDex int(12) default 0," +
                     "nCon int(12) default 0," +
                     "nInt int(12) default 0," +
                     "nWis int(12) default 0," +
                     "nCha int(12) default 0," +
                     "nLevel int(12) default 1," +
                     "nGameXP int(12) default 0," +
                     "nTradeXP int(12) default 0," +
                     "bScalarOverride int(12) default 0," +
                     "sAnimation varchar(16) default NULL," +
                     "sBiTag varchar(16) default NULL," +
                     "nBiQty int(12) default 0," +
                     "nOnFailBiQty int(12) default 0," +
                     "PRIMARY KEY (sKeyToRecipe)" +
                     ")" );
    CnrSQLExecDirect("CREATE INDEX IF NOT EXISTS sDeviceTag ON cnr_recipes (sDeviceTag)");

    CnrSQLExecDirect("CREATE TABLE IF NOT EXISTS cnr_components (" +
                     "sKeyToComponent varchar(64) NOT NULL default ''," +
                     "sTag varchar(16) NOT NULL default ''," +
                     "nQty int(12) default 1," +
                     "nRetainQty int(12) default 0," +
                     "sKeyToRecipe varchar(64) NOT NULL default ''," +
                     "sDeviceTag varchar(16) NOT NULL default ''," +
                     "PRIMARY KEY (sKeyToComponent)" +
                     ")" );
    CnrSQLExecDirect("CREATE INDEX IF NOT EXISTS sDeviceTag ON cnr_components (sDeviceTag)");
  }

  PrintString("Launching cnr_recipe_init");
  ExecuteScript("cnr_recipe_init", OBJECT_SELF);

  PrintString("Launching cnr_book_init");
  ExecuteScript("cnr_book_init", OBJECT_SELF);

  PrintString("Launching cnr_plant_init");
  ExecuteScript("cnr_plant_init", OBJECT_SELF);

  PrintString("Launching cnr_source_init");
  ExecuteScript("cnr_source_init", OBJECT_SELF);

  PrintString("Launching cnr_merch_init");
  ExecuteScript("cnr_merch_init", OBJECT_SELF);
}
