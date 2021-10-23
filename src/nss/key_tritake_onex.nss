#include "_key_include"
string s = "key_tritake_onex: ";

void main()
{
  object oPC = GetExitingObject(), oKey;                                        DebugMode(s+"PC "+GetName(oPC));
  int k = GetNbrOfItemsInInventoryByResRef(oPC, KEYSYS_TEMPLATE), i;            DebugMode(s+"NbrOfKeys "+IntToString(k));

  for (i=1; i<=k; i++)
  {
    oKey = GetItemPossessedByResRefWise(oPC, KEYSYS_TEMPLATE, i);               DebugMode(s+"rented room "+GetName(oKey));
    CalcFeeAndTakeIt(oKey, GetPCSpeaker());                                     DebugMode(s+"act. fee: "+IntToString(CalcFee(oKey, oPC)));
  }
}
