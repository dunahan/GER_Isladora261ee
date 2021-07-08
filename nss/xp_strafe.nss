#include "_isla_inc"

void main()
{
  // SL Vergab dem SC eine XP-Strafe. Betrifft nur Moschen. RP weiterhin normal!
  object  oSpeakTarg = GetSpellTargetObject();
  // Item suchen
  object oItem = GetItemPossessedBy(oSpeakTarg, "itm_questbuch");
  int nRestricted = GetLocalInt(oItem, "Restricted");

  if (nRestricted == 1)
    SetLocalInt(oItem, "Restricted", 0);                                        // Setzen der Variable auf Falsch, bedeutet Strafe aufgehoben!
  else
    SetLocalInt(oItem, "Restricted", 1);                                        // Setzen der Variable auf Wahr, bedeutet Strafe empfangen!

}
