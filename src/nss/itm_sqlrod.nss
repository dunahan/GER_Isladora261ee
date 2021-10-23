#include "_isla_inc"
#include "aps_include"

void main()
{
  SQLExecDirect("DESCRIBE cnr_misc");
    SQLExecDirect("CREATE TABLE cnr_misc (" +
                  "`player` VARCHAR(64) default NULL," +
                  "`tag` VARCHAR(64) default NULL," +
                  "`name` VARCHAR(64) default NULL," +
                  "`val` TEXT," +
                  "`expire` SMALLINT UNSIGNED default NULL," +
                  "`last` TIMESTAMP(14) NOT NULL," +
                  "KEY idx (player,tag,name)" +
                  ")" );

    SQLExecDirect("DESCRIBE cnr_devices");
      SQLExecDirect("CREATE TABLE `cnr_devices` (" +
                    "`sDeviceTag` varchar(16) NOT NULL default ''," +
                    "`sAnimation` varchar(16) default NULL," +
                    "`bSpawnInDevice` integer default '0'," +
                    "`sInvTool` varchar(16) default NULL," +
                    "`sEqpTool` varchar(16) default NULL," +
                    "`nTradeType` integer default '0'," +
                    "`fInvToolBP` float default '0'," +
                    "`fEqpToolBP` float default '0'," +
                    "PRIMARY KEY  (sDeviceTag)" +
                    ")" );

    SQLExecDirect("DESCRIBE cnr_submenus");
      SQLExecDirect("CREATE TABLE `cnr_submenus` (" +
                    "`sKeyToMenu` varchar(64) NOT NULL default ''," +
                    "`sKeyToParent` varchar(64) NOT NULL default ''," +
                    "`sTitle` varchar(64) NOT NULL default ''," +
                    "`sDeviceTag` varchar(16) NOT NULL default ''," +
                    "PRIMARY KEY  (`sKeyToMenu`)," +
                    "INDEX `sDeviceTag` (`sDeviceTag`)" +
                    ")" );

    SQLExecDirect("DESCRIBE cnr_recipes");
      SQLExecDirect("CREATE TABLE `cnr_recipes` (" +
                    "`sKeyToRecipe` varchar(64) NOT NULL default ''," +
                    "`sDeviceTag` varchar(16) NOT NULL default ''," +
                    "`sDescription` varchar(64) NOT NULL default ''," +
                    "`sTag` varchar(16) NOT NULL default ''," +
                    "`nQty` integer default '1'," +
                    "`sKeyToParent` varchar(64) NOT NULL default ''," +
                    "`sFilter` varchar(32) default NULL," +
                    "`nStr` integer default '0'," +
                    "`nDex` integer default '0'," +
                    "`nCon` integer default 0," +
                    "`nInt` integer default '0'," +
                    "`nWis` integer default '0'," +
                    "`nCha` integer default '0'," +
                    "`nLevel` integer default '1'," +
                    "`nGameXP` integer default '0'," +
                    "`nTradeXP` integer default '0'," +
                    "`bScalarOverride` integer default '0'," +
                    "`sAnimation` varchar(16) default NULL," +
                    "`sBiTag` varchar(16) default NULL," +
                    "`nBiQty` integer default '0'," +
                    "`nOnFailBiQty` integer default '0'," +
                    "PRIMARY KEY  (`sKeyToRecipe`)," +
                    "INDEX `sDeviceTag` (`sDeviceTag`)" +
                    ")" );

    SQLExecDirect("DESCRIBE cnr_components");
      SQLExecDirect("CREATE TABLE `cnr_components` (" +
                    "`sKeyToComponent` varchar(64) NOT NULL default ''," +
                    "`sTag` varchar(16) NOT NULL default ''," +
                    "`nQty` integer default '1'," +
                    "`nRetainQty` integer default '0'," +
                    "`sKeyToRecipe` varchar(64) NOT NULL default ''," +
                    "`sDeviceTag` varchar(16) NOT NULL default ''," +
                    "PRIMARY KEY  (`sKeyToComponent`)," +
                    "INDEX `sDeviceTag` (`sDeviceTag`)" +
                    ")" );
}
