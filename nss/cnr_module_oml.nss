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
  ExecuteScript("aps_onload", OBJECT_SELF);

  // if cnr_misc table does not exist, create it
  CnrSQLExecDirect("DESCRIBE cnr_misc");
  //if (CnrSQLFetch() != CNR_SQL_SUCCESS)
  {
    // for MySQL
    /* CnrSQLExecDirect("CREATE TABLE cnr_misc (" +
                  "player VARCHAR(64) default NULL," +
                  "tag VARCHAR(64) default NULL," +
                  "name VARCHAR(64) default NULL," +
                  "val TEXT," +
                  "expire SMALLINT UNSIGNED default NULL," +
                  "last TIMESTAMP(14) NOT NULL," +
                  "KEY idx (player,tag,name)" +
                  ")" );
    */

    // for SQLite
    CnrSQLExecDirect("CREATE TABLE IF NOT EXISTS cnr_misc(" +
                  "player PRIMARY KEY TEXT NULL," +
                  "tag PRIMARY KEY TEXT NULL," +
                  "name PRIMARY KEY TEXT NULL," +
                  "val TEXT NULL," +
                  "expire INTEGER NULL," +
                  "last NUMERIC NOT NULL," +
                  ")" );
  }

  //if (CNR_BOOL_RECIPE_DATA_IS_PERSISTENT_IN_SQL_DATABASE == TRUE)
  {
    // if cnr_devices table does not exist, create it
    CnrSQLExecDirect("DESCRIBE cnr_devices");
    //if (CnrSQLFetch() != CNR_SQL_SUCCESS)
    {
      // for MySQL
      /* CnrSQLExecDirect("CREATE TABLE cnr_devices (" +
                    "sDeviceTag varchar(16) NOT NULL default ''," +
                    "sAnimation varchar(16) default NULL," +
                    "bSpawnInDevice integer default '0'," +
                    "sInvTool varchar(16) default NULL," +
                    "sEqpTool varchar(16) default NULL," +
                    "nTradeType integer default '0'," +
                    "fInvToolBP float default '0'," +
                    "fEqpToolBP float default '0'," +
                    "PRIMARY KEY  (sDeviceTag)" +
                    ")" );
      */

      // for SQLite
      CnrSQLExecDirect("CREATE TABLE IF NOT EXISTS cnr_devices(" +
                    "sDeviceTag TEXT PRIMARY KEY ''," +
                    "sAnimation TEXT NULL," +
                    "bSpawnInDevice INTEGER '0'," +
                    "sInvTool TEXT NULL," +
                    "sEqpTool TEXT NULL," +
                    "nTradeType INTEGER '0'," +
                    "fInvToolBP REAL '0'," +
                    "fEqpToolBP REAL '0'," +
                    ")" );
    }

    // if cnr_submenus table does not exist, create it
    CnrSQLExecDirect("DESCRIBE cnr_submenus");
    //if (CnrSQLFetch() != CNR_SQL_SUCCESS)
    {
      // for MySQL
      /* CnrSQLExecDirect("CREATE TABLE cnr_submenus (" +
                    "sKeyToMenu varchar(64) NOT NULL default ''," +
                    "sKeyToParent varchar(64) NOT NULL default ''," +
                    "sTitle varchar(64) NOT NULL default ''," +
                    "sDeviceTag varchar(16) NOT NULL default ''," +
                    "PRIMARY KEY  ('sKeyToMenu')," +
                    "INDEX sDeviceTag ('sDeviceTag')" +
                    ")" );
      */

      // for SQLite
      CnrSQLExecDirect("CREATE TABLE IF NOT EXISTS cnr_submenus(" +
                    "sKeyToMenu PRIMARY KEY TEXT NOT NULL," +
                    "sKeyToParent TEXT NOT NULL," +
                    "sTitle TEXT NOT NULL," +
                    "sDeviceTag PRIMARY KEY TEXT NOT NULL," +
                    ")" );
    }

    // if cnr_recipes table does not exist, create it
    CnrSQLExecDirect("DESCRIBE cnr_recipes");
    //if (CnrSQLFetch() != CNR_SQL_SUCCESS)
    {
      // for MySQL
      /* CnrSQLExecDirect("CREATE TABLE cnr_recipes (" +
                    "sKeyToRecipe varchar(64) NOT NULL default ''," +
                    "sDeviceTag varchar(16) NOT NULL default ''," +
                    "sDescription varchar(64) NOT NULL default ''," +
                    "sTag varchar(16) NOT NULL default ''," +
                    "nQty integer default '1'," +
                    "sKeyToParent varchar(64) NOT NULL default ''," +
                    "sFilter varchar(32) default NULL," +
                    "nStr integer default '0'," +
                    "nDex integer default '0'," +
                    "nCon integer default '0'," +
                    "nInt integer default '0'," +
                    "nWis integer default '0'," +
                    "nCha integer default '0'," +
                    "nLevel integer default '1'," +
                    "nGameXP integer default '0'," +
                    "nTradeXP integer default '0'," +
                    "bScalarOverride integer default '0'," +
                    "sAnimation varchar(16) default NULL," +
                    "sBiTag varchar(16) default NULL," +
                    "nBiQty integer default '0'," +
                    "nOnFailBiQty integer default '0'," +
                    "PRIMARY KEY  ('sKeyToRecipe')," +
                    "INDEX sDeviceTag ('sDeviceTag')" +
                    ")" );
      */

      // for SQLite
      CnrSQLExecDirect("CREATE TABLE IF NOT EXISTS cnr_recipes(" +
                    "sKeyToRecipe PRIMARY KEY TEXT ''," +
                    "sDeviceTag PRIMARY KEY TEXT ''," +
                    "sDescription TEXT ''," +
                    "sTag TEXT ''," +
                    "nQty INTEGER '1'," +
                    "sKeyToParent TEXT ''," +
                    "sFilter TEXT NULL," +
                    "nStr INTEGER '0'," +
                    "nDex INTEGER '0'," +
                    "nCon INTEGER '0'," +
                    "nInt INTEGER '0'," +
                    "nWis INTEGER '0'," +
                    "nCha INTEGER '0'," +
                    "nLevel INTEGER '1'," +
                    "nGameXP INTEGER '0'," +
                    "nTradeXP INTEGER '0'," +
                    "bScalarOverride INTEGER '0'," +
                    "sAnimation TEXT NULL," +
                    "sBiTag TEXT NULL," +
                    "nBiQty INTEGER '0'," +
                    "nOnFailBiQty INTEGER '0'," +
                    ")" );
    }

    // if cnr_components table does not exist, create it
    CnrSQLExecDirect("DESCRIBE cnr_components");
    //if (CnrSQLFetch() != CNR_SQL_SUCCESS)
    {
      // for MySQL
      /* CnrSQLExecDirect("CREATE TABLE cnr_components (" +
                    "sKeyToComponent varchar(64) NOT NULL default ''," +
                    "sTag varchar(16) NOT NULL default ''," +
                    "nQty integer default '1'," +
                    "nRetainQty integer default '0'," +
                    "sKeyToRecipe varchar(64) NOT NULL default ''," +
                    "sDeviceTag varchar(16) NOT NULL default ''," +
                    "PRIMARY KEY  ('sKeyToComponent')," +
                    "INDEX sDeviceTag ('sDeviceTag')" +
                    ")" );
      */

      // for SQLite
      CnrSQLExecDirect("CREATE TABLE IF NOT EXISTS cnr_components(" +
                    "sKeyToComponent PRIMARY KEY TEXT ''," +
                    "sTag TEXT ''," +
                    "nQty INTEGER '1'," +
                    "nRetainQty INTEGER '0'," +
                    "sKeyToRecipe TEXT ''," +
                    "sDeviceTag PRIMARY KEY TEXT default ''," +
                    ")" );
    }
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
