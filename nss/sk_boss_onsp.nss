#include "trea_inc"

void main()
{
  string sOldName = GetName(OBJECT_SELF);                                       // Lese den Namen des Bosses aus
  int nLength = GetStringLength(sOldName);                                      // Erfasse die Anzahl Buchstaben in dessen Namen
  int nToGive = nLength-7;                                                      // Ziehe 7 wegen " (BOSS)" ab und bilde daraus x-Zeichen

  string sNewName = GetStringLeft(sOldName, nToGive);                           // Lese von links x-Zeichen aus
  SetName(OBJECT_SELF, sNewName);                                               // Schreibe nun diesen Namen auf die Kreatur

  object      oArea = GetArea(OBJECT_SELF);
  location locSpawn = GetLocation(OBJECT_SELF);
  SetLocalLocation(oArea, "sSpawn" ,locSpawn);

  DebugMode("sk_boss_onsp, Spawn boss: "+GetName(TreaGetTreasureTable(OBJECT_SELF)));

   // Schatz erstellen
   if (GetStandardFactionReputation(STANDARD_FACTION_COMMONER, OBJECT_SELF) <= 10)
   {
     int nHitDice = GetHitDice(OBJECT_SELF); object oTreasureTable; int nNewChance, nChance, nBonus;

     if (GetLocalInt(OBJECT_SELF, "GotIt") == 0)
     {
        string sBoni = TreaGetAreaBonus(GetResRef(GetArea(OBJECT_SELF)));       // bringt "BossBonus|0|NormBonus|0|BossChance|25|NormChance|35|"
        nBonus = StringToInt(GetTokenFromString(4, sBoni));
        nChance = StringToInt(GetTokenFromString(8, sBoni));

       //nChance = GetLocalInt(GetArea(OBJECT_SELF), "BossChance");
       DebugMode("sk_boss_onsp, Boss Chance: "+IntToString(nChance));
       //nBonus  = GetLocalInt(GetArea(OBJECT_SELF), "BossBonus");
       DebugMode("sk_boss_onsp, Boss Bonus: "+IntToString(nBonus));

       oTreasureTable = TreaGetTreasureTable(OBJECT_SELF);
       DebugMode("sk_boss_onsp, Modifizierte Chance: "+IntToString(nChance));
       DebugMode("sk_boss_onsp, Modifizierter Bonus: "+IntToString(nBonus));
     }
     TreaGetTreasure(oTreasureTable, OBJECT_SELF, nChance, nBonus);
     SetLocalInt(OBJECT_SELF, "GotIt", 1);
     DebugMode("sk_boss_onsp, Boss got it: "+IntToString(GetLocalInt(OBJECT_SELF, "GotIt")));
   }

  ExecuteScript("x2_def_spawn", OBJECT_SELF);
}
