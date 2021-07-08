//::///////////////////////////////////////////////
//:: Tilemagic von NWN
//:: sk_tilemagic_off
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Tilemagic von NWN
    Aenderung der Grundtiles eines Gebietes.
    Zuruecksetzen dieses Gebietes.

*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 14.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "ll_include"

void main()
{
// Suche die wichtigen Objekte
object oPC     = GetLastUsedBy();                                                // Der Nutzer des Placeables
object oLeverA = GetObjectByTag(GetLocalString(OBJECT_SELF, "sLeverA"));         // Kennzeichnung Hebel 1
object oLeverB = GetObjectByTag(GetLocalString(OBJECT_SELF, "sLeverB"));         // Kennzeichnung Hebel 2
object oTuer   = GetObjectByTag(GetLocalString(OBJECT_SELF, "sDoor"));           // Kennzeichnung Tuer
object oArea   = GetArea(OBJECT_SELF);                                           // Die Area in der sich das Placable befindet
object oSink   = GetNearestObjectByTag(GetLocalString(OBJECT_SELF, "sDestroy")); // Die behindernde Wand
string sResRef = GetResRef(oSink);

// Gesprächsfetzen falls etwas davon notwendig sein sollte
string sNeedSom = GetLocalString(OBJECT_SELF, "sNeedSom");  // Du brauchst XYZ um dieses Rätsel zu lösen
string sItem    = GetLocalString(OBJECT_SELF, "sItem");     // TAG des Items
string sUseSom  = GetLocalString(OBJECT_SELF, "sUseSom");   // Du hast das Item XYZ genutzt
string sUsed    = GetLocalString(OBJECT_SELF, "sUsed");     // Was passiert nun?

// Position der Wand speichern, da diese zerstoert wird und wieder hergestellt werden soll
vector vSink = GetPosition(oSink);  // Den Vektor auslesen
float fSink = GetFacing(oSink);     // Die Ausrichung auslesen
location locSink = Location( oArea, vSink, fSink);  // Zielkoordinaten generieren
SetLocalLocation(oArea, "location", locSink); // Abspeichern

// - - Beginn des Skripts - - //
  if (GetIsPC(oPC))
  {
    if      (GetLocalInt(OBJECT_SELF,    "sRiddle") == 0)   // Es wird nichts benötigt
    {
      DebugMode("Option 1, betaetigen und Grund zuruecksetzen.");

      if ( GetIsObjectValid(oLeverB) == FALSE )             // Ein zweiter Hebel ist nicht Existent
      {
        if (GetLocalInt(OBJECT_SELF, "nLockOpen") == 0)     // Placeble ist nicht aktiviert
        {
          SetLocalInt(OBJECT_SELF, "nLockOpen", 1);         // Placeble wurde aktiviert
          PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);      // Spiele Animation ab, wenn vorhanden
          ActionSpeakString(sUsed);                         // Gib dem Spieler eine Notiz, das es funktionierte

          AssignCommand(oArea, DelayCommand(3.0, DestroyObject(oSink))); // Zerstoere die behindernde Wand
          DelayCommand(4.0, TLResetAreaGroundTilesEx(oArea)); // Setze alle Tiles zurueck auf Standard
        }

        else                                                // Placeble ist aktiviert
        {
          PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);    // Spiele Animation ab, wenn vorhanden
          ActionSpeakString("Nichts geschieht.");           // Gib dem Spieler eine Notiz, das es falsch war...
        }
      }

      else                                                  // Ein Zweiter Hebel ist da und wird benoetigt
      {
        if ((GetLocalInt(oLeverA, "nLockOpen") == 1)        // Hebel 1 ist aktiviert UND
        &&  (GetLocalInt(oLeverB, "nLockOpen") == 1))       // Hebel 2 ist aktiviert
        {
          SendServerMessageToPC(oPC, "Du hörst ein Knirschen in der Entfernung.");

          AssignCommand(oArea, DelayCommand(3.0, DestroyObject(oSink))); // Zerstoere die behindernde Wand
          DelayCommand(4.0, TLResetAreaGroundTilesEx(oArea)); // Setze alle Tiles zurueck auf Standard
        }

        if ((GetLocalInt(oLeverA, "nLockOpen") == 0)        // Hebel 1 ist deaktiviert ODER
        ||  (GetLocalInt(oLeverB, "nLockOpen") == 0))       // Hebel 2 ist deaktiviert
        {
          DeleteLocalInt(oLeverA,"nLockOpen");
          DeleteLocalInt(oLeverA,"nLockOpen");
          SendServerMessageToPC(oPC, "Du meinst, das da was nicht stimmen kann.");
        }
      }
    }

    else if (GetLocalInt(OBJECT_SELF, "sRiddle") == 1)     // Es wird etwas dazu benötigt
    {
      DebugMode("Option 2, betaetigen und merken das was fehlt.");
      ActionSpeakString(sNeedSom);                         // Sprich aus, dass das Item fehlt
      SetLocalInt(OBJECT_SELF,      "sRiddle", 2);         // Das Rätsel zum nächsten Status bringen
    }

    else if (GetLocalInt(OBJECT_SELF, "sRiddle") == 2      // Rätsel wurde aktiviert UND
          && HasItem(oPC, sItem))                          // Spieler besitzt den gesuchten Gegenstand
    {
      DebugMode("Option 3, betaetigen mit dem richtigen Item und Grund zuruecksetzen.");

      ActionSpeakString(sUseSom);                          // Sprich aus, dass das Item passt
      DestroyObject(GetItemPossessedBy(oPC, sItem));       // Zerstöre es

      AssignCommand(oArea, DelayCommand(3.0, DestroyObject(oSink))); // Zerstoere die behindernde Wand
      DelayCommand(4.0, TLResetAreaGroundTilesEx(oArea)); // Setze alle Tiles zurueck auf Standard

      // Vergabe der EP für das Lösen dieses Rätsels
      if (GetIsPC(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC)))
      {
        DebugMode("Option XP Verteilung, da geloest.");

        int    nPC     = 0;                                // Die Anzahl SC auf Null
        int    nXP     = GetLocalInt(OBJECT_SELF, "nXP");  // Anzahl EP auslesen
        object oXPtoPC = GetFirstPC();                     // Erster SC scannen

        while (GetIsObjectValid(oXPtoPC) == TRUE)          // SC existiert
        {
          nPC        = nPC + 1;                            // nPCs++;
          //GiveXPToCreature(oXPtoPC, nXP);                // Vergib die EP
          SetXPImproved(oXPtoPC, GetXP(oPC)+nXP);          // Vergib die EP
          oXPtoPC    = GetNextPC();                        // Scanne naechsten SC
        }
      }
    DelayCommand(600.0, DeleteLocalInt(OBJECT_SELF, "sRiddle")); // zuruecksetzen des Raetsels
    }
  }
  DelayCommand(600.0, DeleteLocalInt(oArea, "nActive"));         // zuruecksetzen des Raetsels
  AssignCommand(oArea, DelayCommand(600.0, CreateObjectVoid(64, sResRef, GetLocalLocation(oArea, "location"))));
}
