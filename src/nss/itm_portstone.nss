//::///////////////////////////////////////////////
//:: Item um PortSteine darzustellen
//:: itm_portstone
//:: Copyright (c) 2012 Dunahan.
//:://////////////////////////////////////////////
/*
    Mit einem, entsprechen eingestelltem Item kann
    der Spieler, welcher es zuerst nutzt und somit
    auf sich Beschränkt hat, zwischen einer festen
    und einer veränderbaren Position hin und her
    "beamen". Dabei ist die feste Position nicht
    mehr änderbar und MUSS wohl überlegt sein!

    Benötigt: Tag-based Item-Aktivierung
*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 25.10.2010
//:: Modified On: 07.01.2013
//:://////////////////////////////////////////////

#include "x0_i0_position"
#include "_isla_inc"


void main ()
{
  // 1++ Wichtige Variablen/Objekte usw. deklarieren
  object oPC = GetItemActivator();    // Der Nutzer des Items
  object oItem = GetItemActivated();  // Das genutzte Item
  location locSelf; object oArea; string sResRefArea; int nJumpTo = -1;

  // 1.1 Bilde die ID auf die das Item gebranded wird/ist
  string sID = GetStringLeft(GetName(oPC), 5)
               + "_" +
               GetStringLeft(GetPCPlayerName(oPC), 5);

  // 1.2 Lese die gespeicherte ID des Besitzers aus
  string sBrand = GetLocalString(oItem, "Brand");



  // 2++ Start der Konfiguration des Items. Dazu gehört, Branden des Items auf den ERSTEN Nutzer UND setzen der
  //     festen Position
  // 2.1.1 Branden des Items auf den allerersten Nutzer, sollte dies noch nicht geschehen sein
  if (sBrand == "")
  {
    SetLocalString(oItem, "Brand", sID);  // Speichere den Nutzer ab und

    // teile dem Spieler das Ergebnis mit
    SendServerMessageToPC(oPC, "Dieser Portstein wurde an "+
      GetName(oPC)+" gebunden. Bitte nutze das Item erneut.");
    return;                               // Dann beende dieses Skript!
  }

  // 2.1.2 Prüf ob das Item der Person folgen würde oder nicht. Wenn nicht, brich ab!");
  if (sBrand != sID)
  {
    // teile dem Spieler das Ergebnis mit
    SendServerMessageToPC(oPC, "Dieser Portstein wurde nicht an Dich gebunden. Du kannst ihn nicht nutzen.");
    return; }

  // 2.2.1 Lese die feste Position aus UND erfasse das entsprechende Gebiet
  location locHome = GetLocalLocationOverride(oPC, "HOME", oItem); // einmalig festgesetzte Position
  string sHomeArea = GetLocalString(oItem, "HOME");                // lese die ResRef der festen Position aus
  object oHomeArea = GetAreaFromLocation(locHome);                 // die Area der festen Position

  int nHomeSaved;
  nHomeSaved = GetLocalInt(oItem, "HOME");                         // Konfiguration der Heimposition abgeschlossen

  // 2.2.2 Lese die veränderbare Position aus UND erfasse das entsprechende Gebiet
  location locSave = GetLocalLocationOverride(oPC, "SAVE", oItem); // immer wieder veränderbare Position
  string sSaveArea = GetLocalString(oItem, "SAVE");                // lese die ResRef der festen Position aus
  object oSaveArea = GetAreaFromLocation(locSave);                 // die Area der verändernbaren Position


  locSelf     = GetLocation(oPC);     // die aktuelle Position
  oArea       = GetArea(oPC);         // die aktuelle Area
  sResRefArea = GetResRef(oArea);     // die ResRef der aktuellen Area


  // 2.3 Prüf ob die feste Position gültig ist UND das Item bereits konfiguriert ist
  if (!GetIsObjectValid(oHomeArea)
    && nHomeSaved == 0)
  {
    // 2.3.1 Speichere die aktuelle Position auf den PortStein und setze ihn als Konfiguriert
    SetLocalLocationOverride(oPC, "HOME", oItem);  // Speichere die aktuelle Position ab,
    SetLocalString(oItem, "HOME", sResRefArea);        // Speichere die ResRef der aktuellen Map ab
    SetLocalInt(oItem, "HOME", 1);                     // Markiere die Konfiguration als abgeschlossen!

    // teile dem Spieler das Ergebnis mit
    SendServerMessageToPC(oPC, "Dieser Portstein wurde an "+
      GetName(oArea)+" gebunden. Der Stein ist nun bereit zur normalen Nutzung.");  // teile dies dem Spieler mit.

    return;                               // Dann beende dieses Skript!
  }
  // 2++ Ende der Konfiguration



  // 3++ Normaler Ablauf des Skriptes nachdem das Item konfiguriert wurde. Fehlermeldung wird ausgegeben, falls
  //     etwas falsches passieren sollte
  // 3.1 Prüf ob die veränderbare Position abgelegt wurde UND die Konfiguration abgeschlossen ist
  if (!GetIsObjectValid(oSaveArea)
   && nHomeSaved == 1)
  {
    // 3.1.1 Speichere die aktuelle als veränderbare Position ab
    SetLocalLocationOverride(oPC, "SAVE", oItem); // Speichere die aktuelle Position ab,
    SetLocalString(oItem, "SAVE", sResRefArea);   // Speichere die ResRef der aktuellen Map ab

    // teile dem Spieler das Ergebnis mit
    SendServerMessageToPC(oPC, "Dieser Portstein wurde an "+
      GetName(oHomeArea)+" gebunden. Du wirst nun an deine feste Positon teleportiert.");

    // 3.1.2 Beame den Charakter nun an die feste Position
    DelayCommand(4.9, AssignCommand(oPC, ClearAllActions(TRUE) ) );   // Beende alle Aktionen, auch Kampf!
    DelayCommand(5.0, AssignCommand(oPC, JumpToLocation(locHome) ) ); // Beame den Spieler an die Position!
  }

  else if (sHomeArea == sResRefArea && GetIsObjectValid(oSaveArea)
    && nHomeSaved == 1)
  {
    // 3.2 Prüf, ob die aktuelle ResRef der gespeicherten entspricht UND die veränderbare Position gültig ist
    //     UND ob die Konfiguration abgeschlossen ist
    //     teile dem Spieler das Ergebnis mit
    SendServerMessageToPC(oPC, "Du befindest Dich an deiner festen Position und wirst nun nach "+
      GetName(oArea)+" teleportiert.");  // teile dies dem Spieler mit

    // 3.2.1 Beame den Charakter nun an die veränderbare Position
    DelayCommand(4.9, AssignCommand(oPC, ClearAllActions(TRUE) ) );   // Beende alle Aktionen, auch Kampf!
    DelayCommand(5.0, AssignCommand(oPC, JumpToLocation(locSave) ) ); // Beame den Spieler an die Position
  }

  else
  {
    // 3.3 Produziere eine Fehlermeldung, sollte etwas schief laufen
    // teile dies dem Spieler mit
    SendServerMessageToPC(oPC, "Fehler im System. Bitte melde Dich im Forum per PM bei Dunahan.");
  }
}

