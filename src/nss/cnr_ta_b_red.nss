/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_ta_b_red
//
//  Desc:  Checks if the recipe on the menu should
//         be displayed as red. (if it's not craftable)
//
//  Author: David Bobeck 08Jan03
//
/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int nOffset = GetLocalInt(oPC, "nCnrRedOffset");
  SetLocalInt(oPC, "nCnrRedOffset", nOffset+1);
  int bShowIt = CnrRecipeBookShowAsRed(OBJECT_SELF, nOffset);
  if (bShowIt == TRUE)
  {
    string sTokenText = GetLocalString(oPC, "sCnrTokenText" + IntToString(22000+nOffset));  //PrintString(sTokenText);
    SetCustomToken(22000+nOffset, sTokenText);
    DeleteLocalString(oPC, "sCnrTokenText" + IntToString(22000+nOffset));
  }
  return bShowIt;
}
