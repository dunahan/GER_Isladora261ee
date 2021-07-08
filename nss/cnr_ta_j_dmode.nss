/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_ta_j_dmode
//
//  Desc:  Show this if speaker is a DM
//
//  Author: dunahan@schwerterkueste.de
//
/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"
int StartingConditional()
{
  object oPC = GetPCSpeaker();

  return GetIsDM(oPC);
}

