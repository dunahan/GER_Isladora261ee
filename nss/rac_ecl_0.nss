#include "_isla_inc"

void main()
{ object oSpeakTarg = GetSpellTargetObject();
  object oItem = GetItemPossessedBy(oSpeakTarg, "itm_questbuch");
  int nECL = GetLocalInt(oItem, "ECL");

  SetLocalInt(oItem, "ECL", 0);
}
