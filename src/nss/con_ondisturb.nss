//::///////////////////////////////////////////////
//:: Name con_ondisturb
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
  if (nRaided == 1) { return; }                                                 // Brich ab, da dieser bereits geleert wurde!

  // 1.2 Weitere notwendige Grundlagen erfassen
  float fRaids = GetLocalFloat(oContainer, "fRaids");
  if (fRaids <= 0.0) fRaids = 600.0;
                                                                                DebugMode("con_ondisturb; Next raid in "+FloatToString(fRaids));
  int nChance  = GetLocalInt(oContainer, "nChance"); int nNewChance;            // Die Chance etwas zu finden
  int nBonus   = GetLocalInt(oContainer, "nBonus");                             // Bonus auf die Schatztabelle
  int nDisType = GetInventoryDisturbType();                                     // Herausnehmen/Hineinlegen/usw

  object oTreasureTable = GetObjectByTag("TreasureTable");                      // Kontainer mit Items

  // 2++ Wenn etwas aus dem Kontainer entnommen wurde, dann
  switch (nDisType)
  {
    case INVENTORY_DISTURB_TYPE_ADDED:
      return;
    case INVENTORY_DISTURB_TYPE_STOLEN:
      return;

    case INVENTORY_DISTURB_TYPE_REMOVED:
      SetLocalInt(oContainer, "nRaided", 1);                                    // setze den Kontainer als geleert,

      nNewChance = nChance-10;                                                  // Bilde die neue Chance.
      if (nNewChance > 0)                                                       // Ist die Chance mehr als 0, dann
        SetLocalInt(oContainer, "nChance", nNewChance);                         // setze die Chance etwas zu finden auf 10% weniger.
      else                                                                      // Ansonsten,
        SetLocalInt(oContainer, "nChance", 0);                                  // setze die Chance etwas zu finden auf 0%

      if (nBonus >= 1)                                                          // wenn der Bonus > oder = 1 ist,
      {
        SetLocalInt(oContainer, "nBonus",  nBonus-1);                           // setze den Bonus um 1 Punkt niedriger an.
      }

      DelayCommand(fRaids, DeleteLocalInt(oContainer, "nRaided") );             // Setze den Kontainer nach 10 Min (600 Sekunden) auf wieder befüllbar
      break;

    default:
      break;
  }*/
}
