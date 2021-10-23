//::///////////////////////////////////////////////
//:: Name con_onopen
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

float fDelay = 3600.0;
void d(string s);
void TreaCreateTreasureInContainer(object oTreasureTable, object oContainer=OBJECT_SELF, int nChance=0, int nBonus=0);

void main ()
{
  // 1++ Grundlagen des Skripts erfassen
  object oContainer = OBJECT_SELF;
  object oArea = GetArea(oContainer);
  int nRaided  = GetLocalInt(oContainer, "nRaided");

  // 1.1 Prüfung ob der Behälter bereits geleert wurde. Soll das ganze etwas verkürzen und Exploits verhindern
  if (nRaided == 1)  return;                                                    // Brich ab, da dieser bereits geleert wurde!

  // 1.2 Weitere notwendige Grundlagen erfassen
  string sBoni = TreaGetAreaBonus(GetResRef(oArea));                            // bringt "BossBonus|0|NormBonus|0|BossChance|25|NormChance|35|"
  int nBonus = StringToInt(GetTokenFromString(4, sBoni));
  int nChance = StringToInt(GetTokenFromString(8, sBoni));
  object oTreasureTable = GetObjectByTag("Loot_Norm_01_20");                    // Kontainer mit Items, aktuell generell nur der niedrigste!

  // 2++ Letzte Sicherheitsabfrage, bevor das Objekt erschaffen wird
  // 2.1 Ist noch ein Objekt im Kontainer, brich das Skript ab
  if (GetIsObjectValid(GetFirstItemInInventory()) == TRUE)  return;

  // 2.2 Bestimme das zu erschaffende Objekt und erschaffe es im Kontainer
  if (HasItem(oContainer, "NW_IT_GOLD001") == FALSE)
    TreaCreateTreasureInContainer(oTreasureTable, oContainer, nChance, nBonus);

  SetLocalInt(oContainer, "nRaided", 1);                                        // Gespawnt, fertig!
  DelayCommand(fDelay, DeleteLocalInt(oContainer, "nRaided"));                  // Löschen nach einer InGame Stunde
}

void TreaCreateTreasureInContainer(object oTreasureTable, object oContainer=OBJECT_SELF, int nChance=0, int nBonus=0)
{
  int nRandom = Random(GetLocalInt(oTreasureTable, "Treasures"))+1;
  string sResRef = GetTokenFromString(nRandom+nBonus, GetLocalString(oTreasureTable, "TreasureTable"));
  string sTag = GetTokenFromString(nRandom+nBonus, GetLocalString(oTreasureTable, "TagTable"));
  object oTreasure = CreateItemOnObject(sResRef, oContainer);

  if (!GetIsObjectValid(oTreasure))  oTreasure = CreateItemOnObject(sTag, oContainer);

  SetIdentified(oTreasure, TRUE);
}

