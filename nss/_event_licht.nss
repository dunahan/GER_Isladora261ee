#include "_debugisla"

void main()
{
  if (GetLocalInt(OBJECT_SELF, "Done") == TRUE) return;                         // sollte das skript gelaufen sein, ende dessen!

  object oEnter = GetEnteringObject();                                          // erfasse die betretende Kreatur

  if (GetIsDM(oEnter) || GetIsDMPossessed(oEnter) ) return;                     // Brich ab, wenn ein DM/DM besetzte Kreatur betritt

  string sTag = GetLocalString(OBJECT_SELF, "kennzeichnung");                   // erfasse den tag der zu beleuchtenden objekte

  if (sTag == "") sTag = "lichtquelle";                                         // Wenn kennezeichnung nicht gesetzt ist, standardwert setzen

  int nIndex = 1;
  object oLichtquelle = GetNearestObjectByTag(sTag);                            //erfasse das erste objekt
  while (GetIsObjectValid(oLichtquelle))                                        // ist dies gueltig
  {
    AssignCommand(oLichtquelle, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));   // aktiviere es
    SetPlaceableIllumination (oLichtquelle, TRUE);                              // setze den lichtwert aktiv

    SetLocalInt(oLichtquelle, "NW_L_AMION", 1);                                 // vergebe entsprechenden lichtwert

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_20), oLichtquelle); // setze einen visuellen effekt

    oLichtquelle = GetNearestObjectByTag(sTag, OBJECT_SELF, ++nIndex);          // und gehe zu naechsten objekt
  }

  // Sollte auf der Map gerade kein Berechnen der Lichtquellen statt finden, fahre fort (Lag-Quelle!)
  if (GetLocalInt(GetArea(OBJECT_SELF), "Recompute") == FALSE)
  {
    RecomputeStaticLighting(GetArea(OBJECT_SELF));                              // Berechne Lichtquellen neu
    SetLocalInt(GetArea(OBJECT_SELF), "Recompute", TRUE);                       // Setze, das Lichtquellen neu berechnet werden
    DelayCommand(600.0, SetLocalInt(GetArea(OBJECT_SELF), "Recompute", FALSE)); // Erst nach 10 min erneute Berechnung moegl.
  }

  // Setze das Skript bei diesem Ausloeser als beendet
  SetLocalInt(OBJECT_SELF, "Done", TRUE);
}
