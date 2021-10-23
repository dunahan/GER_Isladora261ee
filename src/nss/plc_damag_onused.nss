void main()
{
  // 1++ Deklariere notwendige Variablen
  object oTarget = GetLastUsedBy();
  object oDamage = OBJECT_SELF;
  int nDamagePower = DAMAGE_POWER_NORMAL;

  // 1.1 Lese die Schadensmenge aus
  int nDamageAmount = GetLocalInt(oDamage, "Damage");
  if (nDamageAmount == 0) nDamageAmount = Random(4) + 1;

  // 1.2 Lese die Schadensartsart aus
  int nDamageType = GetLocalInt(oDamage, "DamageType");
  int nVisualType = GetLocalInt(oDamage, "VisualType");

  // 2++ Erschaffe nun Schaden und Visueller Effekt
  // Erschaffe den Schaden
  effect eDrain = EffectDamage(nDamageAmount, nDamageType);

  // Erschaffe den visuellen Effekt zum Schaden
  effect eVis = EffectVisualEffect(nVisualType);

  // Wende den Schaden auf das Ziel an
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eDrain, oTarget);

  // Wende den visuellen Effekt am Ziel an
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
