#include "_isla_inc"

void main()
{
    object oPC     = GetLastAttacker();
    object oWeapon = GetObjectByTag("itm_feuerstich");        // benoetigte Waffe
//  int iDamage = d12(1);                                     // Schadenswuerfel Art und Anzahl
//  effect eDamage = EffectDamage(iDamage);
    if (GetIsPC(oPC) && (GetLastWeaponUsed(oPC) == oWeapon))  // Abfrage
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_FNF_FIREBALL),OBJECT_SELF, 4.5);
        DestroyObject(OBJECT_SELF);
    }
//  else
//  ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC); // Schaden zufuegen
}

