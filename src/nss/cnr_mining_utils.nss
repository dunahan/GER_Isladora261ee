/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_mining_utils
//
//  Desc:  This is an include file. These funtions are
//         for some of CNR's minable placeables.
//
//  Author: David Bobeck 09May03
//
/////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////
//  sTreeTag = the tag of the bashable tree placeable.
//  sBranchTag = the tag of the item the tree will drop.
//  Mining these trees requires a woodcutter's axe be equipped.
/////////////////////////////////////////////////////////
void CnrBashableTreeInitialize(string sTreeTag, string sBranchTag);
/////////////////////////////////////////////////////////
void CnrBashableTreeInitialize(string sTreeTag, string sBranchTag)
{
  SetLocalString(GetModule(), sTreeTag + "_BranchTag", sBranchTag);
}

/////////////////////////////////////////////////////////
//  sDepositTag = the tag of the diggable deposit placeable.
//  sMiscTag = the tag of the item the deposit will produce.
//  Mining these deposits requires a shovel be in inventory
/////////////////////////////////////////////////////////
void CnrShoveledDepositInitialize(string sDepositTag, string sMiscTag);
/////////////////////////////////////////////////////////
void CnrShoveledDepositInitialize(string sDepositTag, string sMiscTag)
{
  SetLocalString(GetModule(), sDepositTag + "_MiscTag", sMiscTag);
}

/////////////////////////////////////////////////////////
//  sDepositTag = the tag of the chiselable deposit placeable.
//  sMineralTag = the tag of the item the deposit will produce.
//  Mining these deposits requires a chisel be equipped
/////////////////////////////////////////////////////////
void CnrChiseledDepositInitialize(string sDepositTag, string sMineralTag);
/////////////////////////////////////////////////////////
void CnrChiseledDepositInitialize(string sDepositTag, string sMineralTag)
{
  SetLocalString(GetModule(), sDepositTag + "_MineralTag", sMineralTag);
}

/////////////////////////////////////////////////////////
//  sRockTag = the tag of the minable rock placeable.
//  sNuggetTag = the tag of the item the deposit will produce.
//  Mining these rocks requires a pickaxe be equipped
/////////////////////////////////////////////////////////
void CnrMinableRockInitialize(string sRockTag, string sNuggetTag);
/////////////////////////////////////////////////////////
void CnrMinableRockInitialize(string sRockTag, string sNuggetTag)
{
  SetLocalString(GetModule(), sRockTag + "_NuggetTag", sNuggetTag);
}

/////////////////////////////////////////////////////////
//  sBirdTag = the tag of the bird that will drop a feather OnDeath
//  sFeatherTag = the tag of the feather the bird will drop.
//  Mining these rocks requires a pickaxe be equipped
/////////////////////////////////////////////////////////
void CnrBirdOnDeathInitialize(string sBirdTag, string sFeatherTag);
/////////////////////////////////////////////////////////
void CnrBirdOnDeathInitialize(string sBirdTag, string sFeatherTag)
{
  SetLocalString(GetModule(), sBirdTag + "_FeatherTag", sFeatherTag);
}

