/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_plant_onuse
//
//  Desc:  This is the OnUsed script for CNR plant
//         placeables. Spawns CNR fruit items.
//
//  Author: Dunahan
//
/////////////////////////////////////////////////////////
#include "cnr_plant_utils"
#include "cnr_config_inc"
#include "_isla_inc"

void main()
{
  string sPlantTag  = GetTag(OBJECT_SELF);
  string sFruitTag  = GetLocalString(GetModule(), sPlantTag + "_FruitTag");
  int    nRespawn   = GetLocalInt   (OBJECT_SELF, "Active");
  int    nMaxQty    = GetLocalInt   (GetModule(), sPlantTag + "_FruitMax");
  float  fSpawnSecs = GetLocalFloat (GetModule(), sPlantTag + "_SpawnSecs");
  object oUser      = GetLastUsedBy();
  string sMsg       = "Hier gibt es momentan nichts mehr. Versuche es später noch ein mal.";

  int nRandom;
  if (nMaxQty  == 1) { nRandom =      1  ; }
  if (nMaxQty  == 2) { nRandom =     d2(); }
  if (nMaxQty  == 3) { nRandom =     d3(); }
  if (nMaxQty  == 4) { nRandom =     d4(); }
  if (nMaxQty  == 6) { nRandom = 2 + d4(); }
  if (nMaxQty  == 8) { nRandom = 2 * d4(); }


  if (nRespawn == 0) { WriteTimestampedLogEntry("Spawn CNR-Item: "+sPlantTag+"|"+sFruitTag+"|"+IntToString(nRespawn)+"|"+IntToString(nMaxQty)+"|"+FloatToString(fSpawnSecs, 3, 3));
                       object oFruit = CreateItemOnObject(sFruitTag, oUser, nRandom);
                       if (!GetIsObjectValid(oFruit))  WriteTimestampedLogEntry("Spawn CNR-Item: "+sPlantTag+">"+sFruitTag+">"+IntToString(nRandom)+" couldn't be spawned!");
                       SetLocalInt(OBJECT_SELF, "Active", 1);
                       DelayCommand(fSpawnSecs, DeleteLocalInt(OBJECT_SELF, "Active")); }

  if (nRespawn == 1) { WriteTimestampedLogEntry(sMsg);
                       FloatingTextStringOnCreature(sMsg, oUser, FALSE); }
}

