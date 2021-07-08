//::///////////////////////////////////////////////
//:: Allumfassendes R�tselskript
//:: sk_islaraet_all
//:: Copyright (c) 2011 Dunahan.
//:://////////////////////////////////////////////
/*
    Ein Skript f�r alle R�tselarten:
    Betrifft Hebelr�tsel f�r einen Benutzbaren,
    einen Angreifbaren, zwei Nutzbare
    Hebelr�tsel mit ben�tigten Items
    TileMagic Effekte
    Erstellen von Schl�sselobjekten
*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 09.07.2011
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "ll_include"

// F�r TileMagic L�sungen
// G�ltige Werte f�r BodenTiles
// const int X2_TL_GROUNDTILE_ICE = 426;
// const int X2_TL_GROUNDTILE_WATER = 401;
// const int X2_TL_GROUNDTILE_GRASS = 402;
// const int X2_TL_GROUNDTILE_LAVA_FOUNTAIN = 349; // h�sslich!
// const int X2_TL_GROUNDTILE_LAVA = 350;
// const int X2_TL_GROUNDTILE_CAVEFLOOR = 406;
// const int X2_TL_GROUNDTILE_SEWER_WATER = 461;

void main()
{
// Bestimme, welcher Teil des Skripts auszul�sen ist
int nUseScript = GetLocalInt(OBJECT_SELF, "UseScript");

  if ( nUseScript == 1) // Ein einzelner Hebel f�r OnUsed
  {
    // Suche die wichtigen Objekte
    object oPC     = GetLastUsedBy();                                           // Der Nutzer des Placeables
    object oTuer   = GetObjectByTag(GetLocalString(OBJECT_SELF, "s_Door"));     // Kennzeichnung Tuer

    if (GetIsPC(oPC))
    {
      if (GetLocked(oTuer) == TRUE) SetLocked(oTuer, FALSE);
      {
        AssignCommand(oTuer, ActionOpenDoor(oTuer));
        SendServerMessageToPC(oPC, "Du h�rst ein Knirschen in der Entfernung.");

        return; // Ende des Skripts
      }
    }
  }

  if ( nUseScript == 2 ) // Ein einzelner Hebel f�r OnAttacked
  {
    // Suche die wichtigen Objekte
    object oPC     = GetLastAttacker();                                         // Der Angreifer des Placeables
    object oTuer   = GetObjectByTag(GetLocalString(OBJECT_SELF, "s_Door"));     // Kennzeichnung Tuer

    if (GetIsPC(oPC))
    {
      if (GetLocked(oTuer) == TRUE) SetLocked(oTuer, FALSE);
      {
        AssignCommand(oTuer, ActionOpenDoor(oTuer));
        SendServerMessageToPC(oPC, "Du h�rst ein Knirschen in der Entfernung.");

        return; // Ende des Skripts
      }
    }
  }

  if ( nUseScript == 3 ) // Zwei Hebel f�r OnUsed
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

      ActionCloseDoor(oTuer);                                                   // Schliessen der T�r
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

      ActionCloseDoor(oTuer);                                                   // Schliessen der T�r
      SetLocked(oTuer, TRUE);                                                   // und Abschliessen dieser

      ActionSpeakString("Nichts geschieht.");                                   // Gib dem Spieler eine Notiz, das es falsch war...

      return; // Ende des Skripts
    }

    if ( GetLocalInt(OBJECT_SELF, "nLockOpen") == 0 &&                          // Placeble ist nicht aktiviert UND
         GetTag(OBJECT_SELF) == sLeverA )                                       // es ist das Placeable A
    {
      SetLocalInt(oLeverA, "nLockOpen", 1);                                     // Placeble A wird aktiviert
      PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);                              // Spiele Animation ab, wenn vorhanden

      SendServerMessageToPC(oPC, "Du h�rst ein Knirschen.");
    }

    if ( GetLocalInt(OBJECT_SELF, "nLockOpen") == 0 &&                          // Placeble ist nicht aktiviert UND
         GetTag(OBJECT_SELF) == sLeverB )                                       // es ist das Placeable B
    {
      SetLocalInt(oLeverB, "nLockOpen", 1);                                     // Placeble B wird aktiviert
      PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);                              // Spiele Animation ab, wenn vorhanden

      SetLocked(oTuer, FALSE);                                                  // Aufschliessen der T�r
      ActionOpenDoor(oTuer);                                                    // und anschlie�endes �ffnen dieser

      SendServerMessageToPC(oPC, "Du h�rst ein Knirschen in der Entfernung.");

      return; // Ende des Skripts
    }
  }

  if ( nUseScript == 4 ) // Ein Hebel mit ben�tigten Items, OnUsed einzusetzen
  {
    // Suche die wichtigen Objekte
    object oPC     = GetLastUsedBy();                                           // Der Nutzer des Placeables
    object oTuer   = GetObjectByTag(GetLocalString(OBJECT_SELF, "s_Door"));     // Kennzeichnung Tuer

    // Gespr�chsfetzen falls etwas davon notwendig sein sollte
    string sNeedSom = GetLocalString(OBJECT_SELF, "sNeedSom");                  // Du brauchst XYZ um dieses R�tsel zu l�sen
    string sItem    = GetLocalString(OBJECT_SELF, "sItem");                     // TAG des Items
    string sUseSom  = GetLocalString(OBJECT_SELF, "sUseSom");                   // Du hast das Item XYZ genutzt

    if ( GetLocalInt(OBJECT_SELF, "sRiddle") == 1 &&                            // Es wird etwas ben�tigt UND
         HasItem(oPC, sItem))                                                   // das ben�tigte Item ist im Besitz
    {
      ActionSpeakString(sUseSom);                                               // Item wird benutzt
      DestroyObject(GetItemPossessedBy(oPC, sItem));                            // und wird nun zerstoert

      // Vergabe der EP f�r das L�sen dieses R�tsels
      int nXP = GetLocalInt(OBJECT_SELF, "nXP");                                // Anzahl EP auslesen
      //GiveXPToCreature(oPC, nXP);                                             // Vergib EP an SC
      SetXPImproved(oPC, GetXP(oPC)+nXP);                                       // Vergib EP an SC
      SetLocalInt(OBJECT_SELF, "sRiddle", 0);                                   // Raetsel ist geloest

      PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);                              // Spiele Animation ab, wenn vorhanden

      SetLocked(oTuer, FALSE);                                                  // Aufschliessen der T�r
      ActionOpenDoor(oTuer);                                                    // und anschlie�endes �ffnen dieser

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

    // Gespr�chsfetzen falls etwas davon notwendig sein sollte
    string sNeedSom = GetLocalString(OBJECT_SELF, "sNeedSom");                  // Du brauchst XYZ um dieses R�tsel zu l�sen
    string sItem    = GetLocalString(OBJECT_SELF, "sItem");                     // TAG des Items
    string sUseSom  = GetLocalString(OBJECT_SELF, "sUseSom");                   // Du hast das Item XYZ genutzt
    string sUsed    = GetLocalString(OBJECT_SELF, "sUsed");                     // Was passiert nun?

    // Position der Wand speichern, da diese zerst�rt wird und sp�ter wieder hergestellt werden soll
    object oArea = GetArea(OBJECT_SELF);                                        // Die Area in der sich das Placable befindet
    vector vSink = GetPosition(oSink);                                          // Den Vektor auslesen
    float fSink = GetFacing(oSink);                                             // Die Ausrichung auslesen
    location locSink = Location( oArea, vSink, fSink);                          // Zielkoordinaten generieren
    SetLocalLocation(oArea, "location", locSink);                               // Abspeichern der Daten

    if ( GetLocalInt(OBJECT_SELF, "sRiddle") == 0 )                             // Es wird nichts ben�tigt
    {
      if ( GetLocalInt(OBJECT_SELF, "nLockOpen") == 0 )                         // Placeble ist nicht aktiviert
      {
        SetLocalInt(OBJECT_SELF, "nLockOpen", 1);                               // Placeble wurde aktiviert
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);                            // Spiele Animation ab, wenn vorhanden
        ActionSpeakString(sUsed);                                               // Gib dem Spieler eine Notiz, das es funktionierte

        AssignCommand(oArea, DelayCommand(3.0, DestroyObject(oSink)));          // Zerst�re die behindernde Wand
        DelayCommand(4.0, TLResetAreaGroundTilesEx(oArea));                     // Setze alle Tiles zur�ck auf Standard

        // UND versp�tetes Erstellen der unsichbaren Wand
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

    if ( GetLocalInt(OBJECT_SELF, "sRiddle") == 1 )                             // Es wird etwas dazu ben�tigt
    { ActionSpeakString(sNeedSom); return; }                                    // Sprich aus, dass das Item fehlt und Ende des Skripts

    else if ( GetLocalInt(OBJECT_SELF, "sRiddle") == 1 &&                       // R�tsel wurde aktiviert UND
              HasItem(oPC, sItem) )                                             // Spieler besitzt den gesuchten Gegenstand
    {
      ActionSpeakString(sUseSom);                                               // Sprich aus, dass das Item passt
      DestroyObject(GetItemPossessedBy(oPC, sItem));                            // Zerst�re es

      AssignCommand(oArea, DelayCommand(3.0, DestroyObject(oSink)));            // Zerst�re die behindernde Wand
      DelayCommand(4.0, TLResetAreaGroundTilesEx(oArea));                       // Setze alle Tiles zurueck auf Standard

      // Vergabe der EP f�r das L�sen dieses R�tsels
      int nXP = GetLocalInt(OBJECT_SELF, "nXP");                                // Anzahl EP auslesen
      //GiveXPToCreature(oPC, nXP);                                             // Vergib die EP
      SetXPImproved(oPC, GetXP(oPC)+nXP);                                       // Vergib die EP

      DeleteLocalInt(OBJECT_SELF, "sRiddle");                                   // zur�cksetzen des R�tsels
      AssignCommand(oArea, DelayCommand(600.0,
      CreateObjectVoid(64, sResRef, GetLocalLocation(oArea, "location"))));     // UND versp�tetes Erstellen der unsichbaren Wand

      return; // Ende des Skripts
    }
  }

  if ( nUseScript == 6 ) // Kleines CNR, da der Spieler ein Schl�sselitem herstellen muss. OnClosed einzusetzen!
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
