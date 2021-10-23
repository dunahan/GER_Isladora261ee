#include "_debugisla"

void DoDamageHeartbeat(object oTrigger, object oTarget);

void main()
{
  object oEnter = GetEnteringObject();                                          // erfasse die betretende Kreatur

  if (GetIsDM(oEnter) || GetIsDMPossessed(oEnter) ) return;                     // Brich ab, wenn ein DM/DM besetzte Kreatur betritt

  if (GetLocalInt(oEnter, "Damaged") == TRUE) return;                           // Brich ab, wenn der SC bereits Schaden erhaelt

  DoDamageHeartbeat(OBJECT_SELF, oEnter);                                       // Schaedige den Spieler x-mal, oder bis er sich heilt

  SetLocalInt(oEnter, "Damaged", TRUE);                                         // Vermerke, er wurde bereits beschaedigt
  DelayCommand(600.0, DeleteLocalInt(oEnter, "Damaged"));                       // Loesche nach 10 min den Vermerk
}

void DoDamageHeartbeat(object oTrigger, object oTarget)
{
  int nDamageAmount = GetLocalInt(oTrigger, "DamageAmount");
  if (nDamageAmount == 0) nDamageAmount = Random(6)+1;

  int nDamageType   = GetLocalInt(oTrigger, "DamageType");
  if (nDamageType == 0) nDamageType = DAMAGE_TYPE_MAGICAL;

  int nDamagePower  = GetLocalInt(oTrigger, "DamagePower");
  if (nDamagePower == 0) nDamagePower = DAMAGE_POWER_NORMAL;

  effect eDamage = EffectDamage(nDamageAmount, nDamageType, nDamagePower);

  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDamage, oTarget, 300.0);
}
