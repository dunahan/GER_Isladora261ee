//::///////////////////////////////////////////////
//:: Name con_ondestroy
//:: Dunahan für Isladora.
//:://////////////////////////////////////////////
/*
     Schatzskript für Isladora-Behälter
     Einsetzbar bei OnDisturbed
*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 12-11-2009
//:://////////////////////////////////////////////
#include "trea_inc"

void main ()
{
  /* 1++ Grundlagen des Skripts erfassen
  object oContainer = OBJECT_SELF;
  object oArea = GetArea(oContainer);
  int nRaided  = GetLocalInt(oContainer, "nRaided");                            // Wurde der Behälter vor kurzem geleert?

  // 1.1 Prüfung ob der Behälter bereits geleert wurde. Soll das ganze etwas verkürzen und Exploits verhindern
  if (nRaided == 1)  return;                                                    // Brich ab, da dieser bereits geleert wurde!

  // 1.2 Weitere notwendige Grundlagen erfassen
  //int nChance  = GetLocalInt(oContainer, "nChance");                            // Die Chance etwas zu finden
  //int nBonus   = GetLocalInt(oContainer, "nBonus");                             // Bonus auf die Schatztabelle
  int nNewChance, nChance, nBonus;
  string sBoni = TreaGetAreaBonus(GetResRef(oArea));                            // bringt "BossBonus|0|NormBonus|0|BossChance|25|NormChance|35|"
  nBonus = StringToInt(GetTokenFromString(4, sBoni));
  nChance = StringToInt(GetTokenFromString(8, sBoni));

  object oTreasureTable = GetObjectByTag("TreasureTable");                      // Kontainer mit Items

  // 2++ Letzte Sicherheitsabfrage, bevor das Objekt erschaffen wird
  // 2.1 Ist noch ein Objekt im Kontainer, brich das Skript ab
  object oItem = GetFirstItemInInventory();
  if (GetIsObjectValid(oItem) == TRUE)  return;

  // 2.2 Bestimme das zu erschaffende Objekt und erschaffe es im Kontainer
  TreaGetTreasure(oTreasureTable, oContainer, nChance, nBonus);                 DebugMode("con_ondestroy; Found this: "+GetName(GetFirstItemInInventory(oContainer)));
  */
}
