#include "_area_inc"

const float RESET_AREA_DAMAGE = 5.0;
const float WAIT_FOR_DAMAGE_TO_SET = 6.0;
const float AREA_HEARTBEAT = 6.0;
const int OVERRIDE_DAMAGE_AMOUNT = 3;

void DoAreaDamage(object oTarget);
void DoCheckAgain();

void main()
{
  // 1++ Deklariere notwendige Variablen
  object oTarget = GetEnteringObject();

  if (GetIsObjectValid(oTarget) == TRUE)
  {
    if (GetLocalInt(oTarget, "DamageOk") == 0)
    {
      DelayCommand(WAIT_FOR_DAMAGE_TO_SET, DoAreaDamage(oTarget));
    }
    else
      DoCheckAgain();
  }
}

void DoAreaDamage(object oTarget)
{
  // 1++ Deklariere notwendige Variablen
  object oArea = GetArea(oTarget);

  // 1.1 Lese die Schadensmenge aus
  int nDamageAmount = GetLocalInt(oArea, "Damage");
  if (nDamageAmount == 0)
    nDamageAmount = Random(OVERRIDE_DAMAGE_AMOUNT) + 1;

  // 1.2 Lese die Schadensartsart aus
  int nDamageType = GetLocalInt(oArea, "DamageType");
  int nVisualType = GetLocalInt(oArea, "VisualType");

  // 2++ Liess aus, ob der Spieler den Schaden erhalten kann, ansonsten lass es!
  if (GetLocalInt(oTarget, "DamageOk") == 0)
  {
    // Erschaffe den Schaden
    effect eDrain = EffectDamage(nDamageAmount, nDamageType);

    // Erschaffe den visuellen Effekt zum Schaden
    effect eVis = EffectVisualEffect(nVisualType);

    // Wende den Schaden auf das Ziel an
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDrain, oTarget);

    // Wende den visuellen Effekt am Ziel an
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

    // Setze den Schaden erst wieder nach vorgegebener Zeit an
    SetLocalInt(oTarget, "DamageOk", 1);

    DelayCommand(RESET_AREA_DAMAGE, DeleteLocalInt(oTarget, "DamageOk"));

    DoCheckAgain();
  }
}

void DoCheckAgain()
{
  DelayCommand(AREA_HEARTBEAT, ExecuteScript("_area_damag_onen", GetModule()));
}

