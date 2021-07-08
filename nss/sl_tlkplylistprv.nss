#include "_sltools_inc"
#include "_isla_inc"

void main()
{
  // 1++ Deklariere notwendige Variablen
  int nTokenNumber = GetLocalInt(GetPCSpeaker(), "PlayerToEdit");                             // Aktuelle Spieler-Nummer
  int nMaxNbrOfEntries = GetTokenCount(GetCampaignString("PlayerDB", "PlayerList"));          // Maximale Anzahl an Spieler

  // 2++ Pruefe ab, sind die Begrenzungen ueberschritten, dann addiere nichts
  if (nTokenNumber-1 > 0 || nTokenNumber <= nMaxNbrOfEntries)                                 // Ist die Max. und groesser 0
    SetLocalInt(GetPCSpeaker(), "PlayerToEdit", nTokenNumber-1);                              // Addiere 1
  else                                                                                        // Ansonsten
    SetLocalInt(GetPCSpeaker(), "PlayerToEdit", nMaxNbrOfEntries);                            // Setze Maximum
}
