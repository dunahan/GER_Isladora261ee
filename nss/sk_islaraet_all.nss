//::///////////////////////////////////////////////
//:: Allumfassendes Rätselskript
//:: sk_islaraet_all
//:: Copyright (c) 2011 Dunahan.
//:://////////////////////////////////////////////
/*
    Ein Skript für alle Rätselarten:
    Betrifft Hebelrätsel für einen Benutzbaren,
    einen Angreifbaren, zwei Nutzbare
    Hebelrätsel mit benötigten Items
    TileMagic Effekte
    Erstellen von Schlüsselobjekten
*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 09.07.2011
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "ll_include"

// Für TileMagic Lösungen
// Gültige Werte für BodenTiles
// const int X2_TL_GROUNDTILE_ICE = 426;
// const int X2_TL_GROUNDTILE_WATER = 401;
// const int X2_TL_GROUNDTILE_GRASS = 402;
// const int X2_TL_GROUNDTILE_LAVA_FOUNTAIN = 349; // hässlich!
// const int X2_TL_GROUNDTILE_LAVA = 350;
// const int X2_TL_GROUNDTILE_CAVEFLOOR = 406;
// const int X2_TL_GROUNDTILE_SEWER_WATER = 461;

void main()
{
// Bestimme, welcher Teil des Skripts auszulösen ist
int nUseScript = GetLocalInt(OBJECT_SELF, "UseScript");

  if ( nUseScript == 1) // Ein einzelner Hebel für OnUsed
  {
    // Suche die wichtigen Objekte
    object oPC     = GetLastUsedBy();                                           // Der Nutzer des Placeables
    object oTuer   = GetObjectByTag(GetLocalString(OBJECT_SELF, "s_Door"));     // Kennzeichnung Tuer

    if (GetIsPC(oPC))
    {
      if (GetLocked(oTuer) == TRUE) SetLocked(oTuer, FALSE);
      {
        AssignCommand(oTuer, ActionOpenDoor(oTuer));
        SendServerMessageToPC(oPC, "Du hörst ein Knirschen in der Entfernung.");

        return; // Ende des Skripts
      }
    }
  }

  if ( nUseScript == 2 ) // Ein einzelner Hebel für OnAttacked
  {
    // Suche die wichtigen Objekte
    object oPC     = GetLastAttacker();                                         // Der Angreifer des Placeables
    object oTuer   = GetObjectByTag(GetLocalString(OBJECT_SELF, "s_Door"));     // Kennzeichnung Tuer

    if (GetIsPC(oPC))
    {
      if (GetLocked(oTuer) == TRUE) SetLocked(oTuer, FALSE);
      {
        AssignCommand(oTuer, ActionOpenDoor(oTuer));
        SendServerMessageToPC(oPC, "Du hörst ein Knirschen in der Entfernung.");

        return; // Ende des Skripts
      }
    }
  }

  if ( nUseScript == 3 ) // Zwei Hebel für OnUsed
  {
    // Suche die wichtigen Objekte
    object oPC     = GetLastUsedBy();                                           // Der Nutzer des Placeables
    string sLeverA = GetLocalString(OBJECT_SELF, "s_LeverA");                   // Kennzeichnung Hebel 1
    object oLeverA = GetObjectByTag(sLeverA);                                   // Hebel 1
    string sLeverB = GetLocalString(OBJECT_SELF, "s_LeverB");                   // Kennzeichnung Hebel 2
    object oLeverB = GetObjectByTag(sLeverB);                                   // Hebel 2
    object oTuer   = GetObjectByTag(GetLocalString(OBJECT_SELF, "s_Door"));     // Kennzeichnung Tuer

    if ( GetLocalInt(oLeverA, "nLockOpen") == 0 &&                              // Placeble A ist deaktiviert UND
         GetLocalInt(oLeverB, "nLockOpen") == 1 )                               // Placeble B ist aktiviert => Falsche Reihenfolge!
    {
      SetLocalInt(oLeverA, "nLockOpen", 0);                                     // Placeble A wird deaktiviert
      SetLocalInt(oLeverB, "nLockOpen", 0);                                     // Placeble B wird deaktiviert

        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);                          // Spiele Animation ab, wenn vorhanden

      ActionCloseDoor(oTuer);                                                   // Schliessen der Tür
      SetLocked(oTuer, TRUE);                                                   // und Abschliessen dieser

      ActionSpeakString("Da stimmt was nicht!");                                // Gib dem Spieler eine Notiz, das es falsch war...

      return; // Ende des Skripts
    }

    if ( GetLocalInt(oLeverA, "nLockOpen") == 1 &&                              // Placeble A ist aktiviert UND
         GetLocalInt(oLeverB, "nLockOpen") == 1 )                               // Placeble B ist aktiviert => Reset
    {
      SetLocalInt(oLeverA, "nLockOpen", 0);                                     // Placeble A wird deaktiviert
      SetLocalInt(oLeverB, "nLockOpen", 0);                                     // Placeble B wird deaktiviert

        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);                          // Spiele Animation ab, wenn vorhanden

      ActionCloseDoor(oTuer);                                                   // Schliessen der Tür
      SetLocked(oTuer, TRUE);                                                   // und Abschliessen dieser

      ActionSpeakString("Nichts geschieht.");                                   // Gib dem Spieler eine Notiz, das es falsch war...

      return; // Ende des Skripts
    }

    if ( GetLocalInt(OBJECT_SELF, "nLockOpen") == 0 &&                          // Placeble ist nicht aktiviert UND
         GetTag(OBJECT_SELF) == sLeverA )                                       // es ist das Placeable A
    {
      SetLocalInt(oLeverA, "nLockOpen", 1);                                     // Placeble A wird aktiviert
      PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);                              // Spiele Animation ab, wenn vorhanden

      SendServerMessageToPC(oPC, "Du hörst ein Knirschen.");
    }

    if ( GetLocalInt(OBJECT_SELF, "nLockOpen") == 0 &&                          // Placeble ist nicht aktiviert UND
         GetTag(OBJECT_SELF) == sLeverB )                                       // es ist das Placeable B
    {
      SetLocalInt(oLeverB, "nLockOpen", 1);                                     // Placeble B wird aktiviert
      PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);                              // Spiele Animation ab, wenn vorhanden

      SetLocked(oTuer, FALSE);                                                  // Aufschliessen der Tür
      ActionOpenDoor(oTuer);                                                    // und anschließendes öffnen dieser

      SendServerMessageToPC(oPC, "Du hörst ein Knirschen in der Entfernung.");

      return; // Ende des Skripts
    }
  }

  if ( nUseScript == 4 ) // Ein Hebel mit benötigten Items, OnUsed einzusetzen
  {
    // Suche die wichtigen Objekte
    object oPC     = GetLastUsedBy();                                           // Der Nutzer des Placeables
    object oTuer   = GetObjectByTag(GetLocalString(OBJECT_SELF, "s_Door"));     // Kennzeichnung Tuer

    // Gesprächsfetzen falls etwas davon notwendig sein sollte
    string sNeedSom = GetLocalString(OBJECT_SELF, "sNeedSom");                  // Du brauchst XYZ um dieses Rätsel zu lösen
    string sItem    = GetLocalString(OBJECT_SELF, "sItem");                     // TAG des Items
    string sUseSom  = GetLocalString(OBJECT_SELF, "sUseSom");                   // Du hast das Item XYZ genutzt

    if ( GetLocalInt(OBJECT_SELF, "sRiddle") == 1 &&                            // Es wird etwas benötigt UND
         HasItem(oPC, sItem))                                                   // das benötigte Item ist im Besitz
    {
      ActionSpeakString(sUseSom);                                               // Item wird benutzt
      DestroyObject(GetItemPossessedBy(oPC, sItem));                            // und wird nun zerstoert

      // Vergabe der EP für das Lösen dieses Rätsels
      int nXP = GetLocalInt(OBJECT_SELF, "nXP");                                // Anzahl EP auslesen
      //GiveXPToCreature(oPC, nXP);                                             // Vergib EP an SC
      SetXPImproved(oPC, GetXP(oPC)+nXP);                                       // Vergib EP an SC
      SetLocalInt(OBJECT_SELF, "sRiddle", 0);                                   // Raetsel ist geloest

      PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);                              // Spiele Animation ab, wenn vorhanden

      SetLocked(oTuer, FALSE);                                                  // Aufschliessen der Tür
      ActionOpenDoor(oTuer);                                                    // und anschließendes öffnen dieser

      return; // Ende des Skripts
    }

    else                                                                        // Hier fehlt etwas und dem Spieler mitteilen
    { ActionSpeakString(sNeedSom); return; }                                    // Daraufhin Ende des Skripts
  }

  if ( nUseScript == 5 ) // TileMagic ohne und mit notwendigen Items, OnUsed einzusetzen!
  {
    // Suche die wichtigen Objekte
    object oPC     = GetLastUsedBy();                                                // Der Nutzer des Placeables
    object oTuer   = GetObjectByTag(GetLocalString(OBJECT_SELF, "sDoor"));           // Kennzeichnung Tuer
    object oSink   = GetNearestObjectByTag(GetLocalString(OBJECT_SELF, "sDestroy")); // Die behindernde Wand
    string sResRef = GetResRef(oSink);

    // Gesprächsfetzen falls etwas davon notwendig sein sollte
    string sNeedSom = GetLocalString(OBJECT_SELF, "sNeedSom");                  // Du brauchst XYZ um dieses Rätsel zu lösen
    string sItem    = GetLocalString(OBJECT_SELF, "sItem");                     // TAG des Items
    string sUseSom  = GetLocalString(OBJECT_SELF, "sUseSom");                   // Du hast das Item XYZ genutzt
    string sUsed    = GetLocalString(OBJECT_SELF, "sUsed");                     // Was passiert nun?

    // Position der Wand speichern, da diese zerstört wird und später wieder hergestellt werden soll
    object oArea = GetArea(OBJECT_SELF);                                        // Die Area in der sich das Placable befindet
    vector vSink = GetPosition(oSink);                                          // Den Vektor auslesen
    float fSink = GetFacing(oSink);                                             // Die Ausrichung auslesen
    location locSink = Location( oArea, vSink, fSink);                          // Zielkoordinaten generieren
    SetLocalLocation(oArea, "location", locSink);                               // Abspeichern der Daten

    if ( GetLocalInt(OBJECT_SELF, "sRiddle") == 0 )                             // Es wird nichts benötigt
    {
      if ( GetLocalInt(OBJECT_SELF, "nLockOpen") == 0 )                         // Placeble ist nicht aktiviert
      {
        SetLocalInt(OBJECT_SELF, "nLockOpen", 1);                               // Placeble wurde aktiviert
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);                            // Spiele Animation ab, wenn vorhanden
        ActionSpeakString(sUsed);                                               // Gib dem Spieler eine Notiz, das es funktionierte

        AssignCommand(oArea, DelayCommand(3.0, DestroyObject(oSink)));          // Zerstöre die behindernde Wand
        DelayCommand(4.0, TLResetAreaGroundTilesEx(oArea));                     // Setze alle Tiles zurück auf Standard

        // UND verspätetes Erstellen der unsichbaren Wand
        AssignCommand(oArea, DelayCommand(600.0,
           CreateObjectVoid(64, sResRef, GetLocalLocation(oArea, "location"))));

          return; // Ende des Skripts
      }

      else                                                                      // Placeble ist aktiviert
      {
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);                          // Spiele Animation ab, wenn vorhanden
        ActionSpeakString("Nichts geschieht.");                                 // Gib dem Spieler eine Notiz, das es falsch war...

        return; // Ende des Skripts
        }
    }

    if ( GetLocalInt(OBJECT_SELF, "sRiddle") == 1 )                             // Es wird etwas dazu benötigt
    { ActionSpeakString(sNeedSom); return; }                                    // Sprich aus, dass das Item fehlt und Ende des Skripts

    else if ( GetLocalInt(OBJECT_SELF, "sRiddle") == 1 &&                       // Rätsel wurde aktiviert UND
              HasItem(oPC, sItem) )                                             // Spieler besitzt den gesuchten Gegenstand
    {
      ActionSpeakString(sUseSom);                                               // Sprich aus, dass das Item passt
      DestroyObject(GetItemPossessedBy(oPC, sItem));                            // Zerstöre es

      AssignCommand(oArea, DelayCommand(3.0, DestroyObject(oSink)));            // Zerstöre die behindernde Wand
      DelayCommand(4.0, TLResetAreaGroundTilesEx(oArea));                       // Setze alle Tiles zurueck auf Standard

      // Vergabe der EP für das Lösen dieses Rätsels
      int nXP = GetLocalInt(OBJECT_SELF, "nXP");                                // Anzahl EP auslesen
      //GiveXPToCreature(oPC, nXP);                                             // Vergib die EP
      SetXPImproved(oPC, GetXP(oPC)+nXP);                                       // Vergib die EP

      DeleteLocalInt(OBJECT_SELF, "sRiddle");                                   // zurücksetzen des Rätsels
      AssignCommand(oArea, DelayCommand(600.0,
      CreateObjectVoid(64, sResRef, GetLocalLocation(oArea, "location"))));     // UND verspätetes Erstellen der unsichbaren Wand

      return; // Ende des Skripts
    }
  }

  if ( nUseScript == 6 ) // Kleines CNR, da der Spieler ein Schlüsselitem herstellen muss. OnClosed einzusetzen!
  {
    object oPC = GetLastClosedBy();
    object oItem = GetFirstItemInInventory(OBJECT_SELF);                        // Das Item, das hineingelegt wurde erfassen
    string sTag = GetTag(oItem);                                                // Lese den Tag aus

    string sItem1 = GetLocalString(OBJECT_SELF, "Item1");                       // Zutat 1
    string sItem2 = GetLocalString(OBJECT_SELF, "Item2");                       // Zutat 2
    string sItem3 = GetLocalString(OBJECT_SELF, "Item3");                       // Zutat 3
    string sItem4 = GetLocalString(OBJECT_SELF, "Item4");                       // ResRef des hergestellten Items

    string sDefMsg = GetLocalString(OBJECT_SELF, "DefMSG");                     // Standardnachricht
    string sFalMsg = GetLocalString(OBJECT_SELF, "FalMSG");                     // Fehlermeldung

    int nStatus = GetLocalInt(OBJECT_SELF, "Status");                           // Status auslesen

    if ( GetIsObjectValid(oItem) )                                              // Ist das Item vorhanden?
    {
      if ( sTag == sItem1 && nStatus == 0 )                                     // Pruefe ob Tag des Items gleich der Zutat 1 ist
      {
        SetLocalInt(OBJECT_SELF, "Status", 1);                                  // Richtiges Item eingelegt, deswegen Status 1 setzen!

          FloatingTextStringOnCreature( GetName(oItem)+" "+sDefMsg, oPC );      // MSG schicken

           DestroyObject(oItem);                                                // Daraufhin dieses vernichten...

        return; // Ende des Skripts
      }

      else if ( sTag == sItem2 &&                                               // Pruefe ob Tag des Items gleich der Zutat 2 ist UND
                   nStatus == 1 )                                               // der Status 1 erreicht ist
      {
        SetLocalInt(OBJECT_SELF, "Status", 2);                                  // Richtiges Item eingelegt, deswegen Status 2 setzen!

          FloatingTextStringOnCreature( GetName(oItem)+" "+sDefMsg, oPC );      // MSG schicken

          DestroyObject(oItem);                                                 // Daraufhin dieses vernichten...

        return; // Ende des Skripts
        }

      else if ( sTag == sItem3 &&                                               // Pruefe ob Tag des Items gleich der Zutat 3 ist UND
                   nStatus == 2)                                                // der Status 2 erreicht ist
      {
        SetLocalInt(OBJECT_SELF, "Status", 0);                                  // Richtiges Item eingelegt, deswegen Status 0 setzen!

        FloatingTextStringOnCreature( GetName(oItem)+" "+sDefMsg, oPC );        // MSG schicken

          DestroyObject(oItem);                                                 // Daraufhin dieses vernichten...
        CreateItemOnObject(sItem4);                                             // Hergestellter Gegenstand erstellen

        return; // Ende des Skripts
      }
    }

    else
    { FloatingTextStringOnCreature( sFalMsg, oPC ); return; } // Ende des Skripts
  }
}
