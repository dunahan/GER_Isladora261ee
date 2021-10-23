// Isladora Include
#include "_isla_inc"

void BeamHenchman(object oHenchman, object oPC);
void TransitionDebug(string sToSpeak);

const int TRANSITIONDEBUG = 0;
const float OPEN_TRANSITIONS = 10.0;
const float BEAM_HENCHMAN = 5.0;

void main ()
{
  // 1++ Allgemeine Abfragen (Notwendig, da nicht nur in Auslösern genutzt)
  // 1.1 Grundlegende Objekte erfassen, Auslöser/Tür und Modul
  object oTrigger = OBJECT_SELF;  object oModule = GetModule();

  // 1.2 Anlegen der Marker für Reittiere. !!Grundlegende Einstellungen!!
  // 1.2.1 Marker, welches System soll genutzt werden
  int bJumpTo = FALSE;

  // 1.2.2 Marker, keine Reittiere erlaubt
  int bNoMounts = FALSE;

  // 1.2.3 Marker, Reittiere nur Außen! Grundlegend nur AUßEN möglich!
  int bMountsExterior   = TRUE;  //int bMountsExterior   = GetLocalInt(oModule,"X3_MOUNTS_EXTERNAL_ONLY");

  // 1.2.4 Marker, keine Reittiere im Untergrund! Grundlegend nicht im Untergrund erlaubt!
  int bMountsOverground = TRUE;  //int bMountsOverground = GetLocalInt(oModule,"X3_MOUNTS_NO_UNDERGROUND");

  // 1.3 Erfassen und Prüfen der nutzenden Figur
  // 1.3.1 Erfasse die auslösende Figur des Skripts
  object oPC = GetClickingObject();   // hier der klickende Nutzer (Standard)

  // 1.3.2 Sollte wider erwarten der Nutzer nicht in Frage kommen, dann
  if ( !GetIsObjectValid(oPC) )
  { TransitionDebug("Kein klickendes Objekt gefunden. Nehme betretendes Objekt.");
    oPC = GetEnteringObject(); }      // untersuche den betretenden Nutzer

  // 1.3.3 Sollte dieser AUCH nicht in Frage kommen,
  if ( !GetIsObjectValid(oPC) )
  { TransitionDebug("Kein betretendes Objekt gefunden. Nehme letzten Benutzer.");
    oPC = GetLastUsedBy(); }          // den letzten Nutzer erfassen


  // 2++ Grundlegendes bevor mit Skript fortgefahren wird
  // 2.1 Prüf, bevor weiter ausgeführt/weitere Daten gesammelt werden
  //     Ist der Nutzer existent? Nein, dann abbrechen!
  if ( !GetIsObjectValid(oPC) )
  { TransitionDebug("Kein Objekt gefunden. Beende Skript.");
    return; }

  // 2.2 Prüf, ob der Nutzer ein feindlich gestelltes Monster ist? Wenn Ja, dann sollte das Monster das Objekt
  //     nicht nutzen! Dies schließt nun auch SL als auch von SL besessene Monster aus.
  int nReps = GetStandardFactionReputation(STANDARD_FACTION_HOSTILE, oPC);

  if ( nReps >= 11 )
  {
    TransitionDebug("Monster gefunden. Verfolgung beenden und Abbruch des Skripts.");
    AssignCommand(oPC, ClearAllActions(TRUE));        // beende alle Tätigkeiten, besonders Kampf!
    return;                                           // beende das Skript
  }

  // 2.3 Prüf, wird ein Schlüssel benötigt um durchzuschreiten?
  // 2.3.1 Lies den Tag des Schlüssels aus
  string sKeyTag = GetLocalString(oTrigger, "KeyTag");

  // 2.3.2 Wenn ein Tag vorgegeben UND
  //       dieser im Inv vorliegt UND
  //       der Übergang "abgeschlossen" ist, dann
  if ( (sKeyTag != "")
    && (GetItemPossessedBy(oPC, sKeyTag)  == OBJECT_INVALID)
    && (GetLocalInt(oTrigger, "Open") == 0)
     )
  {
    TransitionDebug("Schluessel benoetigt aber nicht gefunden.");
    // hat der Spieler keinen Schlüssel. Also teile ihm das mit und beende das Skript
    SendServerMessageToPC(oPC, "Du kannst diesen Übergang nicht nutzen. Dir fehlt der entsprechende Schlüssel!");
    return;
  }

  // 2.3.3 Der Schlüssel ist also vorhanden, also "öffne" den Übergang für 10 Sekunden
  else
  {
    TransitionDebug("K/Ein Schluessel benoetigt und ggf. gefunden. Oeffne den Uebergang fuer 10 Sekunden.");
    // ansonsten, setze den Übergang auf "offen" und lösche diese Option nach 10 Sekunden wieder
    SetLocalInt(oTrigger, "Open", 1);
    DelayCommand(OPEN_TRANSITIONS, DeleteLocalInt(oTrigger, "Open"));
  }


  // 3++ Berechnungen des Beamvorgangs vor. Dazu zählt, zB das Erfassen des Zielobjekts,
  //     der Alternative ODER gib dem Nutzer weiter, dass hier nichts geht
  // 3.1.1 Erfasse das Zielobjekt
  object oTarget = GetTransitionTarget(oTrigger);  // Zielbereich erfassen, per Wizard auf Objekt abgelegt (TAG)

  // 3.1.2 Weitere Variablen deklarieren, die zur Lagebestimmung für die Alternative benötigt werden
  string sTarTag;                                       // für die Alternative, Tag des Auslösers
  string sTarLeft; string sTarRight; string sTarget;    // für Hilfe bei der Festlegung
  location locTarget; vector vecLocation; string facLocation; object areLocation;  // Position des Ziels
  location locNewLoc; vector vecNewLocat; string sLocation; float facOrientation;  // Hilfsvariablen für Berechnung
  float fX; float fY; float fZ;
  int bLocation;

  // 3.2.1 Prüf ob das Ziel per Wizard auf dem Objekt abgelegt wurde
  if ( GetIsObjectValid(oTarget) )                    // Ja, dann setze Marker, das Beamen nach NWN Art!
  { TransitionDebug("Ziel im Ausloeser vorgegeben und existent. Setze Wahr.");
    bJumpTo = TRUE;
    bLocation = FALSE; }                              // Modus Objekt gewaehlt

  // 3.2.2 Nein, dann wähle die Alternative mit dem Auslöser aus
  else
  {
    // 3.2.2.1 Dazu lese Deinen Tag aus, den das Ziel definiert und bilde dadurch den Anfang des Ziel-Tag's
    sTarTag   = GetTag(oTrigger);
    sTarLeft  = GetStringLeft(sTarTag, GetStringLength(sTarTag)-1);
    sTarRight = GetStringRight(sTarTag, 1);

    // 3.2.2.2 Ergänze den Tag um das jeweilige Ende
    if (sTarRight == "a")
    { TransitionDebug("Tag des Objekts: "+sTarTag+". Ziel mit b-Ende wird gesucht");
      sTarget = sTarLeft+"b"; } // Tag endet mit a, so setze Zielpunkt auf (TAG)_b
    else
    { TransitionDebug("Tag des Objekts: "+sTarTag+". Ziel mit a-Ende wird gesucht");
      sTarget = sTarLeft+"a"; } // Ansonsten, setze Zielpunkt auf (TAG)_a

    // 3.2.2.3 Suche das Zielobjekt
    oTarget = GetObjectByTag(sTarget);

    // 3.2.2.4.1 Prüfe, ist das Zielobjekt existent,
    if ( !GetIsObjectValid(oTarget) )                         // Nein,
    { TransitionDebug("Kein Ziel vorgefunden. Abbruch des Skripts.");
      SendServerMessageToPC(oPC, "Übergang momentan nicht aktiv."); // dann Meldung an den Nutzer und
      WriteTimestampedLogEntry(GetName(oTrigger) + "funktioniert nicht und liegt in Area " +
                               GetName(GetArea(oTrigger)));
      return; }                                               // abbrechen!

    // 3.2.2.4.2 Prüfe, ist das Zielobjekt ein Wegpunkt,
    else if (GetObjectType(oTarget) == OBJECT_TYPE_WAYPOINT)
    { TransitionDebug("Das Zielobjekt ist ein Wegpunkt: "+GetTag(oTarget)+". Setze Wahr.");
      bJumpTo = TRUE;                                 // Ja, dann setze Marker
      bLocation = FALSE; }                            // Modus Objekt gewaehlt

    // 3.2.2.5 Auslesen der aktuellen Position des Ziels und Berechnung der neuen.
    else if (GetObjectType(oTarget) == OBJECT_TYPE_TRIGGER)
    {
      locTarget = GetLocation(oTarget);                 // Lese die aktuelle Position des Ziels aus

      areLocation = GetAreaFromLocation(locTarget);     // Lese die Area aus der Postion
      vecLocation = GetPositionFromLocation(locTarget); // Lese die Koordinaten aus der Position
      facLocation = GetLocalString(oTarget, "Facing");  // Lese die Blickrichtung aus der Position

      // 3.2.2.6 Vektor der Zielpositon so verändern, dass SC nicht im Auslöser steht
      //         Dazu wird die Verschiebung der jeweiligen Achse als Variable auf dem Auslöser definiert
      facLocation = GetStringLowerCase(facLocation);

      // 3.2.2.6.1 Prüfe, welche Verschiebung ist anzuwenden
      if (facLocation == "n")  // y-Koordinate +1
      { TransitionDebug("Koordinate Nord gefunden. Berechne neuen Vektor.");
        fX = (vecLocation.x); fY = (vecLocation.y); fZ = (vecLocation.z);
        vecNewLocat = Vector(fX, fY+1.0, fZ);
        facOrientation = DIRECTION_NORTH; }

      if (facLocation == "o")  // x-Koordinate +1
      { TransitionDebug("Koordinate Ost gefunden. Berechne neuen Vektor.");
        fX = (vecLocation.x); fY = (vecLocation.y); fZ = (vecLocation.z);
        vecNewLocat = Vector(fX+1.0, fY, fZ);
        facOrientation = DIRECTION_EAST; }

      if (facLocation == "s")  // x-Koordinate -1
      { TransitionDebug("Koordinate Süd gefunden. Berechne neuen Vektor.");
        fX = (vecLocation.x); fY = (vecLocation.y); fZ = (vecLocation.z);
        vecNewLocat = Vector(fX, fY-1.0, fZ);
        facOrientation = DIRECTION_SOUTH; }

      if (facLocation == "w")  // y-Koordinate -1
      { TransitionDebug("Koordinate West gefunden. Berechne neuen Vektor.");
        fX = (vecLocation.x); fY = (vecLocation.y); fZ = (vecLocation.z);
        vecNewLocat = Vector(fX-1.0, fY, fZ);
        facOrientation = DIRECTION_WEST; }

      // 3.2.2.7 Neue Position aus den Daten berechnen und damit die Zielposition überschreiben.
      //         Beachte dabei jedoch: Die Blickrichtung MUSS immer um 90 Grad erweitert werden!
      TransitionDebug("Errechne nun neue Position.");
      locNewLoc = Location(areLocation, vecNewLocat, facOrientation);
      TransitionDebug("Neue Position "+LocationToString(locNewLoc));

      bJumpTo = TRUE;
      bLocation = TRUE;                           // Modus Positon gewaehlt
    }
  }


  // 4++ Letzte Prüfungen, Reiten und Reittiere folgen
  //     Ein Automatisches Absteigen der Figuren wird nicht folgen. Dieser Arbeitsschritt (wenn auch recht simpel
  //     in "NW_G0_Transition" beschrieben und nachvollziehbar) wird der Figur erspart. Berechnung und Einstellung
  //     der jeweiligen Variablen sehr umfangreich und unübersichtlich.
  //
  // 4.1 Prüf, ob grundlegend Pferde nur draußen erlaubt und vom Untergrund ausgeschlossen sind
  object oArea = GetArea(oTarget);        // Erfasse die Area
  object oAssociate;                      // Dekleration evtl. Begleiter
  int nNum = 1;                           // Dekleration Anzahl Begleiter

  // 4.1.1 Prüf, sind allgemein Reittiere nur draußen erlaubt UND
  //       ist die Ziel-Map eine Innenmap?
  if ( bMountsExterior                    // Marker: RT bleiben draußen? Müssen draußen bleiben! Siehe 1.2!
    && GetIsAreaInterior(oArea) )         // Abfrage: Innengebiet?
  { TransitionDebug("Abfrage, Reittiere muessen draussen bleiben und ist dies ein Innengebeit? Vergebe Wahr, wenn zutrifft.");
    bNoMounts = TRUE; }

  // 4.1.2 Prüf, sind allgemein Reittiere vom Untergrund ausgeschlossen UND
  //       ist die Ziel-Map eine Untergrundmap?
  else if ( bMountsOverground             // Marker: RT vom Untergrund ausgeschlossen? Sind ausgeschlossen! S. 1.2!
        && !GetIsAreaAboveGround(oArea))  // Abfrage: Map ist Unterirdisch?
  { TransitionDebug("Abfrage, Reittiere muessen an der Oberflaeche bleiben und ist dies der Untergrund? Vergebe Wahr, wenn zutrifft");
    bNoMounts = TRUE; }

  // 4.1.3 Prüf, handelt es sich bei der Zielmap um eine spezielle Map?
  //       OOC_Räume usw? Dann überschreibe jegliche Konfiguration, hier ist es ausnahmsweise erlaubt!
  else if ( GetStringLowerCase(GetStringLeft(GetTag(oArea), 3)) == "ooc" )
  { TransitionDebug("Dies ist ein OOC Gebiet. Reiten ist Ausnahmsweise erlaubt. Setze alle Flaggen auf Falsch.");
    bMountsExterior   = FALSE;
    bMountsOverground = FALSE;
    bNoMounts         = FALSE; }

  // 4.2 Prüf, sind folgende Marker auf der Map gesetzt:
  //     Marker: Reiten nicht erlaubt ? ODER
  //     Marker: Keine Pferde         ? ODER
  //     Marker: Keine Pferde erlaubt ?
  if ( GetLocalInt(oArea,"X3_NO_MOUNTING")  // unter 1.2 def.; evtl. durch Map überschrieben?
    || GetLocalInt(oArea,"X3_NO_HORSES")    // unter 1.2 def.; evtl. durch Map überschrieben?
    || bNoMounts )                          // bei 4.1 grundlegender Prüfung abgeklärt!
  {
    TransitionDebug("Abfrage, ist das reiten und sind Pferde erlaubt?");
    // 4.2.1 Prüf, ob eine Figur reitet
    //       Wenn ja, dann teile dem Spieler mit, das er absteigen muss! Danach Ende des Skriptes
    if ( HorseGetIsMounted(oPC) )
    {
      TransitionDebug("Der Spieler reitet und es ist nicht erlaubt. Beende Skript.");
      SendServerMessageToPC(oPC, "Im Zielgebiet kannst Du nicht reiten."); // Meldung an Nutzer, kann nicht reiten!

      AssignCommand(oPC, ClearAllActions(TRUE));                     // Dann beende alle Tätigkeiten, auch Kampf!
      return;                                                        // Abbruch des Skriptes!
    }

    // 4.2.2 Ansonsten prüf, wird ein Pferd mitgeführt
    //       Wenn ja, dann teile dem Spieler mit, das er dieses zurück lassen muss, dann Ende des Skriptes
    else
    {
      TransitionDebug("Abfrage, wird ein Reittier mitgefuehrt?");
      // 4.2.2.1 Erfasse den ersten Begleiter
      oAssociate = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, nNum);

      // 4.2.2.2 Während dieses Objekt existiert
      while ( GetIsObjectValid(oAssociate) )
      {
        TransitionDebug("Pruefe alle Begleiter durch.");
        // 4.2.2.2.1 Prüf ob dies ein Pferd ist, wenn ja melde es und beende das Skript
        if ( HorseGetIsAMount (oAssociate) )
        {
          TransitionDebug("Es ist ein Reittier. Beende Skript.");
          SendServerMessageToPC(oPC, "Dein Reittier kann Dir nicht folgen.");// Meldung an Nutzer, Pferd folgt nicht!
          SendServerMessageToPC(oPC, "Du musst Dein Pferd zurück lassen.");  // Meldung an Nutzer, Pferd zurücklassen!

          AssignCommand(oPC, ClearAllActions(TRUE));                   // Dann beende alle Tätigkeiten, auch Kampf!
          return;                                                      // Abbruch des Skriptes!
        }

        // Anzahl der Begleiter +1
        nNum++;

        // Nächsten Begleiter erfassen
        oAssociate = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, nNum);
      }
    }
  }


  // 5++ Endgültiges Beamen des Nutzers.
  // 5.1 Prüf, ob der Marker gesetzt wurde, das ein Ziel per Wizard abgelegt wurde
  //     Wenn ja, dann Beame wie im Skript "NW_G0_Transition"
  if (bJumpTo)
  {
    TransitionDebug("Nach Abschluss aller Abfragen, beame den Spieler.");
    AssignCommand(oPC, ClearAllActions(TRUE));   // Beende alle Tätigkeiten und

    if (bLocation == FALSE)                      // Modus Objekt
    {
      TransitionDebug("Modus Objekt, somit Position eindeutig vorgegeben.");
      AssignCommand(oPC, JumpToObject(oTarget)); // springe zum Ziel
    }

    if (bLocation == TRUE)                       // Modus Position
    {
      TransitionDebug("Modus Position, somit neu berechnete Position samt Ausrichtung.");
      AssignCommand(oPC, JumpToLocation(locNewLoc)); // springe zum Ziel
    }


    // Hier sollten nun auch noch alle Anhängsel teleportiert werden, theoretisch
    object oHenchman; int nAssociateType, nTh = 1;

    TransitionDebug("Frage nun jeden Begleiter ab, um diesen zu beamen.");

    // Hier beginnt die naechste Schleife, diesmal prueftdie Funktion die einzelnen
    // Henchmen Typen durch, bis zum letzten und beamt diese einzeln zum Spieler
    for (nAssociateType = 1; nAssociateType <= 5; nAssociateType++)
    {
      oHenchman = GetAssociate(nAssociateType, oPC, nTh);
      TransitionDebug("Suche Begleiter Typ "+IntToString(nAssociateType));

      if (GetIsObjectValid(oHenchman) == TRUE)
      {
        TransitionDebug("Begleiter gefunden. Beame diesen dann.");
        DelayCommand(BEAM_HENCHMAN, BeamHenchman(oHenchman, oPC));    // dann beamen, 10 Sekunden spaeter
      }
    }
  }

  // 5.2 Gib aus, das etwas nicht stimmte und vermerke dies im Log!
  else
  {
    TransitionDebug("Fehler im Skript oder Uebergang gefunden. Somit vermerke es.");
    //SpeakString("//OOC: Dieser Uebergang ist nicht korrekt definiert, melde dies bitte im Forum. Danke, Dunahan");
    ExecuteScript("NW_G0_Transition", oPC);    // Ggf. normales Skript ausführen. Wird nicht mehr benötigt
    WriteTimestampedLogEntry(GetName(OBJECT_SELF)+" ist nicht korrekt definiert, muss geaendert werden!");
  }
}

void BeamHenchman(object oHenchman, object oPC)
{
  AssignCommand(oHenchman, ClearAllActions(TRUE)); // Beende alle Tätigkeiten und
  AssignCommand(oHenchman, JumpToObject(oPC));     // springe zum Ziel
}

void TransitionDebug(string sToSpeak)
{
  if (TRANSITIONDEBUG == 1)
    SpeakString(sToSpeak, TALKVOLUME_SHOUT);
}
