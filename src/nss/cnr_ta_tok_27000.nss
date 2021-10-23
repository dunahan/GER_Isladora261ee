/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_ta_tok_27000
//
//  Desc:  Updates the custom token 27000.
//
//  Author: David Bobeck 24May03
//
/////////////////////////////////////////////////////////
int StartingConditional()
{
  object oPC = GetPCSpeaker();
  string sTokenText = GetLocalString(oPC, "sCnrTokenText27000");                //PrintString(sTokenText);
  SetCustomToken(27000, sTokenText);
  DeleteLocalString(oPC, "sCnrTokenText27000");
  return TRUE;
}

