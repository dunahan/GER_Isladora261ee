void main()
{
  // 1++ Lese wichtige Variablen aus
  int nDamageType = GetLocalInt(OBJECT_SELF, "DamageType");
  float fPercent = GetLocalFloat(OBJECT_SELF, "Percent");

  // 2++ Erfassen den Schaden und berechne den Zusatzschaden, der erlitten wird.
  //     Setze diesen in einen Effekt um
  int nDamageByType = GetDamageDealtByType(nDamageType);
  int nDamageToDeal = FloatToInt(IntToFloat(nDamageByType)*fPercent);
  effect eDamage = EffectDamage(nDamageToDeal, nDamageType);

  // 3++ Sollte der Schaden mehr als 1 betragen, dann den Zusatzschaden dazu!
  if (nDamageByType >= 1)
  {
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDamage, OBJECT_SELF);
  }
}
