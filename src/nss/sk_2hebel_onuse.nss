//::///////////////////////////////////////////////
//:: Raetsel
//:: sk_2hebel_onuse
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Raetsel anhand Hebeln
    Hier zwei Hebel oeffnen eine Tuer.
    Es koennen auch gewisse Items zur
    Loesung benotigt werden
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
string sLeverA = GetLocalString(OBJECT_SELF, "s_LeverA");                        // Kennzeichnung Hebel 1
object oLeverA = GetObjectByTag(sLeverA);                                        // Hebel 1
string sLeverB = GetLocalString(OBJECT_SELF, "s_LeverB");                        // Kennzeichnung Hebel 2
object oLeverB = GetObjectByTag(sLeverB);                                        // Hebel 2
object oTuer   = GetObjectByTag(GetLocalString(OBJECT_SELF, "s_Door"));          // Kennzeichnung Tuer
object oArea   = GetArea(OBJECT_SELF);                                           // Die Area in der sich das Placable befindet


// Gesprächsfetzen falls etwas davon notwendig sein sollte
string sNeedSom = GetLocalString(OBJECT_SELF, "sNeedSom");  // Du brauchst XYZ um dieses Rätsel zu lösen
string sItem    = GetLocalString(OBJECT_SELF, "sItem");     // TAG des Items
string sUseSom  = GetLocalString(OBJECT_SELF, "sUseSom");   // Du hast das Item XYZ genutzt
string sUsed    = GetLocalString(OBJECT_SELF, "sUsed");     // Was passiert nun?







// - - Beginn des Skripts - - //
  if (GetIsPC(oPC))
  {
    if      (GetLocalInt(OBJECT_SELF,    "sRiddle") == 0) // Es wird nichts benötigt
    {
      DebugMode("Option 1, betaetigen und Tuer oeffnen.");

      if ( sLeverB == "" )                                // Ein zweiter Hebel ist nicht Existent
      {
        if (GetLocalInt(OBJECT_SELF, "nLockOpen") == 0)   // Placeble ist nicht aktiviert
        {
          SetLocalInt(OBJECT_SELF, "nLockOpen", 1);       // Placeble wurde aktiviert
          PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);    // Spiele Animation ab, wenn vorhanden

          SendServerMessageToPC(oPC, "Du hörst ein Knirschen in der Entfernung.");

          SetLocked(oTuer, FALSE);                        // Aufschliessen
          ActionOpenDoor(oTuer);                          // Oeffnen
        }

        else                                              // Placeble ist aktiviert
        {
          SetLocalInt(OBJECT_SELF, "nLockOpen", 0);       // Placeble wurde deaktiviert
          PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);  // Spiele Animation ab, wenn vorhanden

          ActionSpeakString("Nichts geschieht.");         // Gib dem Spieler eine Notiz, das es falsch war...

          ActionCloseDoor(oTuer);                         // Schliessen
          SetLocked(oTuer, TRUE);                         // Zuschliessen
        }
      } // Ende if ( sLeverB == "" )

      else                                                // Es existiert ein zweiter Hebel
      {
        if ((GetLocalInt(oLeverA, "nLockOpen") == 0)      // Erstes Placeble ist deaktiviert UND
        &&  (GetLocalInt(oLeverB, "nLockOpen") == 1))     // zweites Placeble ist aktiviert
        {
          SetLocalInt(oLeverA, "nLockOpen", 0);           // Placeble wurde aktiviert
          SetLocalInt(oLeverB, "nLockOpen", 0);           // Placeble wurde aktiviert
          PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);  // Spiele Animation ab, wenn vorhanden
          ActionSpeakString("Nichts geschieht.");         // Gib dem Spieler eine Notiz, das es falsch war...
          ActionCloseDoor(oTuer);                         // Schliessen
          SetLocked(oTuer, TRUE);                         // Zuschliessen
        }

        if ((GetLocalInt(oLeverA, "nLockOpen") == 1)      // Erstes Placeble ist deaktiviert UND
        &&  (GetLocalInt(oLeverB, "nLockOpen") == 1))     // zweites Placeble ist aktiviert
        {
          SetLocalInt(oLeverA, "nLockOpen", 0);           // Placeble wurde aktiviert
          SetLocalInt(oLeverB, "nLockOpen", 0);           // Placeble wurde aktiviert
          PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);  // Spiele Animation ab, wenn vorhanden
          ActionSpeakString("Nichts geschieht.");         // Gib dem Spieler eine Notiz, das es falsch war...
          ActionCloseDoor(oTuer);                         // Schliessen
          SetLocked(oTuer, TRUE);                         // Zuschliessen
        }

        if ((GetLocalInt(OBJECT_SELF, "nLockOpen") == 0)  // Placeble ist nicht aktiviert UND
        &&  (GetTag(OBJECT_SELF) == sLeverA ))            // es ist das erste Placeable
        {
          SetLocalInt(oLeverA, "nLockOpen", 1);           // Placeble wurde aktiviert
          PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);    // Spiele Animation ab, wenn vorhanden

          SendServerMessageToPC(oPC, "Du hörst ein Knirschen.");
        }

        if ((GetLocalInt(OBJECT_SELF, "nLockOpen") == 0)  // Placeble ist nicht aktiviert UND
        &&  (GetTag(OBJECT_SELF) == sLeverB ))            // es ist das zweite Placeable
        {
          SetLocalInt(oLeverB, "nLockOpen", 1);           // Placeble wurde aktiviert
          PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);    // Spiele Animation ab, wenn vorhanden
          SetLocked(oTuer, FALSE);                        // Aufschliessen
          ActionOpenDoor(oTuer);                          // Oeffnen
          SendServerMessageToPC(oPC, "Du hörst ein Knirschen in der Entfernung.");
        }
      } // Ende else
    }


    else if (GetLocalInt(OBJECT_SELF, "sRiddle") == 1)    // Es wird etwas benoetigt
    {
      DebugMode("Option 2");

      ActionSpeakString(sNeedSom);                        // Hier fehlt etwas
      SetLocalInt(OBJECT_SELF,      "sRiddle", 2);        // Setze Raetsel auf die naechste Ebene
    }

    else if (GetLocalInt(OBJECT_SELF, "sRiddle") == 2     // Naechste Ebene ist erreicht UND
    && HasItem(oPC, sItem))                               // das benoetigte Item ist im Besitz
    {
      DebugMode("Option 3");

      ActionSpeakString(sUseSom);                          // Item wird benutzt
      DestroyObject(GetItemPossessedBy(oPC, sItem));       // und wird nun zerstoert

      // EP an alle in der Naehe vergeben
      if (GetIsPC(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC)))
      {
        DebugMode("Option XP's");

        int    nPC     = 0;                                // Anzahl SC auf Null
        int    nXP     = GetLocalInt(OBJECT_SELF, "nXP");  // EP Menge auslesen
        object oXPtoPC = GetFirstPC();                     // Ersten SC scannen

        while (GetIsObjectValid(oXPtoPC) == TRUE)          // Existiert der SC
        {
          nPC        = nPC + 1;                            // nPCs++;

          //GiveXPToCreature(oXPtoPC, nXP);                // Vergib EP an SC
          SetXPImproved(oXPtoPC, GetXP(oPC)+nXP);          // Vergib EP an SC

          oXPtoPC    = GetNextPC();                        // Scanne naechsten SC
        }
      }
      SetLocalInt(OBJECT_SELF, "sRiddle", 0);              // Raetsel ist geloest
    }
  }
}
