//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_grabnearest
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript um das nächste Placeable usw zu erfassen
    und dieses später weiter zu verarbeiten, löschen
    usw...
*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

void main()
{
  // Lese benötigte Daten aus Int1 und Int2
  int nType = GetLocalInt(oSkin, "Int1");  // Was wird gesucht?
  int nNth  = GetLocalInt(oSkin, "Int2");  // Das wievielte wird gesucht?

  // Sollte eine der Integers Null sein, ersetze sie mit Standards
  if (nType == 0) { nType = 32767; } if (nNth == 0) { nNth = 1; }

  // Suche das jeweilige Objekt zum Ziel
  object oFound = GetNearestObjectToLocation(nType, locSpeakTarg, nNth);
  string sPlayerID;

  // Speichere dieses Objekt auf dem SL ab
  if ( (GetIsObjectValid(oFound) == TRUE) && (!GetIsPC(oFound)) ) // Objekt existiert und ist kein Spieler
  { SendServerMessageToPC(oSpeaker, "Objekt " + GetName(oFound) + " wurde gespeichert.");
    SetLocalObject(oSpeaker, "Stored", oFound); }

  else if ((GetIsObjectValid(oFound) == TRUE) && (GetIsPC(oFound)) ) // Spieler gefunden
  { SendServerMessageToPC(oSpeaker, "Figur " + GetName(oFound) + " wurde gespeichert.");
    sPlayerID = GetStringLeft(GetName(oFound), 5) +"_"+ GetStringLeft(GetPCPlayerName(oFound), 5); // Begrenzte ID speichern!
    SetLocalString(oSpeaker, "Stored", sPlayerID); }

  else { SendServerMessageToPC(oSpeaker, "Fehler in der Verarbeitung. Kein Objekt gefunden."); } // Nichts wurde gefunden!

}
