#include "ll_include"

void main()
{
  // 1++ Erfasse wichtige Objekte
  // 1.1 letzter Angreifer und genutzte Waffe
  object oPC     = GetLastDamager();
  object oWeapon = GetLastWeaponUsed(oPC);

  // 1.2 Pruef ob es sich um eine Fernwaffe handelt
  if (GetWeaponRanged(oWeapon) == TRUE)
  {
    // 1.2.1 Wenn ja, dann sammle alles notwendige fuer
    //       die Trefferberechnung
    int nDice20 = d20();                         // Trefferwuerfel 1W20
    int nBaseAttack = GetBaseAttackBonus(oPC);   // Bonus/Malus
    int nAC = GetHardness();                     // Die Ruestungsklasse
    int nAbility = GetAbilityModifier(1, oPC);   // Bonus/Malus durch Geschick

    // 1.2.2 Wenn 1W20+Bonus/Malus+Geschick groesser/gleich RK, dann
    if (nDice20+nBaseAttack+nAbility >= nAC)
    {
      // 1.2.2.1 Lese aus, wann etwas getroffen werden kann
      int nDropZone = d10();
      int nDC = GetLocalInt(OBJECT_SELF, "DC");

      // 1.2.2.2 Berechne nun, ob getroffen wurde mit
      //         Trefferzone+Bonus/Malus groesser/gleich Schwierigkeitsgrad
      if (nDropZone+nAbility >= nDC)
        // 1.2.2.2.1 Es wurde etwas getroffen, so teile dies mit,
        //           ggf. gib eine Belohnung
      { SpeakString(GetLocalString(OBJECT_SELF, "onHit"));
        if (GetHitDice(oPC)  <= nDC)
          //GiveXPToCreature(oPC, GetLocalInt(OBJECT_SELF, "onHit"));
          SetXPImproved(oPC, GetXP(oPC)+GetLocalInt(OBJECT_SELF, "onHit")) ;
      }
      else
      { SpeakString(IntToString(nDropZone)+" wurde getroffen."); }
    }
    // 1.2.3 Nichts wurde getroffen, so teile dies dem Spieler mit
    else
    {
      SpeakString(GetLocalString(OBJECT_SELF, "onMiss"));
    }
  }
  else
  {
    AssignCommand(oPC, ClearAllActions(TRUE));
  }
}


