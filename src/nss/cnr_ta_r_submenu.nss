/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_ta_r_submenu
//
//  Desc:  Checks if the text on the menu should
//         be displayed as a submenu.
//
//  Author: David Bobeck 18Mar03
//
/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  int nOffset = GetLocalInt(oPC, "nCnrSubOffset");
  SetLocalInt(oPC, "nCnrSubOffset", nOffset+1);
  int bShowIt = CnrRecipeShowAsSubMenu(OBJECT_SELF, nOffset);
  if (bShowIt == TRUE)
  {
    string sTokenText = GetLocalString(oPC, "sCnrTokenText" + IntToString(22000+nOffset));  //PrintString(sTokenText);
    SetCustomToken(22000+nOffset, sTokenText);
    DeleteLocalString(oPC, "sCnrTokenText" + IntToString(22000+nOffset));
  }
  return bShowIt;
}
