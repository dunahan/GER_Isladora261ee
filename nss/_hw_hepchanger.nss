//Notwendig um HW-EP verrechnen zu können
#include "cnr_recipe_utils"
//Ggf. für Debug-Funktion
#include "_isla_inc"

void main()
{
/*// 1++ Erfasse alle notwenigen Objekte
  object oPC = GetLastDisturbed();             // Erfasse den letzten Nutzer des Objekts
  object oItem = GetInventoryDisturbItem();    // Erfasse das letzte Item, das in dir bewegt wurde
  int nDisType = GetInventoryDisturbType();    // Erfasse die Art des Bewegens

  // Weitere wichtige Deklerationen
  int nGMValue; int nOldXP; int nNewXP; int nDeviceTradeskillType; int nTrLvl;
  string sTradeName;

  // 2++ Prüfe ob die Art des Bewegens ein Hinzufügen eines Items war
  //     Sollte es hineingelegt worden sein, fahre fort:
  if (nDisType == INVENTORY_DISTURB_TYPE_ADDED)
  {
    AssignCommand(oPC, ClearAllActions(TRUE));                       // Breche jegliche Aktion des Nutzers ab
    SendServerMessageToPC(oPC, "Bitte warten bis Verarbeitung erfolgte."); // Melde dem Nutzer, das er warten soll

    nGMValue = GetGoldPieceValue(oItem);                             // Lese den Goldwert aus

    nDeviceTradeskillType = GetItemTradeskillByType(oItem);          // Wähle mit Basistyp aus, welches Handwerk
    sTradeName = GetItemTradeskillByName(oItem);                     // Bestimme den Namen des Handwerks

    nOldXP = CnrGetTradeskillXPByType(oPC, nDeviceTradeskillType);   // Lese die Stufe des HWs aus
    nTrLvl = CnrDetermineTradeskillLevel(nOldXP);

    // Wenn der alte EP Wert gleich null ist, brich ab. Nur HW'ler mit bereits ein paar Lvln
    // sollen diese Boxen nutzen koennen"
    if (nOldXP == 0 || nTrLvl >= 20)
    { SendServerMessageToPC(oPC, "Du kannst diesen Behälter nicht nutzen."); // Melde dem Nutzer, das es so nicht geht!
      return; }

    nGMValue = (nGMValue / nTrLvl);                                  // Berechne den EP Wert des Gegenstandes
    // Berechnet sich aus Goldwert geteilt durch die Stufe des HW's des Nutzers
    nNewXP = nOldXP + nGMValue;                                      // und addiere diesen auf die alten EP

    // Teile dem Nutzer mit, das die EP Übertragen werden.
    SendServerMessageToPC(oPC, "Deine "+sTradeName+" Kunst wurde um "+IntToString(nGMValue)+" EP verbessert.");
    SendServerMessageToPC(oPC, "Du hast nun "+IntToString(nNewXP)+" EP.");

    // Zerstoere das Item, da die Werte nun aufgerechnet werden
    DestroyObject(oItem);

    // Übertrage die EP auf den Char.
    CnrSetTradeskillXPByType(oPC, nDeviceTradeskillType, nNewXP);
  }*/
}
