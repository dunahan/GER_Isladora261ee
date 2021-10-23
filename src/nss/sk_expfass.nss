#include "NW_I0_SPELLS"
#include "_isla_inc"

void Explode()
{
  effect   eExplode = EffectVisualEffect(VFX_FNF_FIREBALL);
  int      nDamage;
  effect   eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
  effect   eDam;
  float    fDelay;
  location lHere = GetLocation(OBJECT_SELF);
  ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lHere);

  // Deklariere die Zauberform, Groesse und Ort. Nimm das erste Zielobjekt im Radius.
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lHere, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);

  // Gehe durch die moeglichen Ziele bis ein unzulaessiges Objekt genommen ist.
  while (GetIsObjectValid(oTarget))
  {
    if (oTarget != OBJECT_SELF)
    {
      if ( !MyResistSpell(OBJECT_SELF, oTarget) )
      {
        // Schaden fuer jedes Objekt auswuerfeln
        nDamage = d6(2);

        // Den Schaden nach Reflexwurf, Ausweichen und verbesserten Ausweichen berechnen.
        nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_FIRE);

        // Schadenseffekt bestimmen
        eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
        fDelay = GetDistanceToObject(oTarget)/20;

        if (nDamage > 0)
        {
          // Den Effekt zum momentan genommmenen Objekt geben.
          DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
          DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        }
      }
    }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lHere, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
  }
  DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(100, DAMAGE_TYPE_BLUDGEONING), OBJECT_SELF));
}

void main()
{
    if (!GetLocalInt(OBJECT_SELF, "exploding"))
    {
        SetLocalInt(OBJECT_SELF, "exploding", TRUE);
        DelayCommand(0.1, Explode());
    }
}

