//::///////////////////////////////////////////////
//:: Besondere Items, hier Visuelle Effekte erzeugen
//:: itm_visplayers
//:: Copyright (c) 2013 Dunahan.
//:://////////////////////////////////////////////
/*
    Ein Item, das visuelle Effekte f�r Spieler
    erzeugen kann



*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 16.04.2013
//:: Last Modified On: 16.04.2013
//:://////////////////////////////////////////////
#include "x0_i0_position"

void Debugger(string sString, int DEBUG);

void main()
{
  int DEBUG = 1;

  // 1++ Sammle Daten, die f�r das Skript notwendig sind
  object oPlayer = GetItemActivator();  // Der Nutzer/Spieler
  object oItem   = GetItemActivated();  // Das Item, das genutzt wird
  location locPlayer = GetLocation(oPlayer);  // Die Positon des Spielers

  Debugger("Spieler erfasst, "+GetName(oPlayer), DEBUG);
  Debugger("Item erfasst, "+GetName(oItem), DEBUG);
  Debugger("Position Spieler, "+LocationToString(locPlayer), DEBUG);


  // 1.1 Bilde die ID f�r den Spieler
  string sID     = GetPCPlayerName(oPlayer)+"_"+GetPCPublicCDKey(oPlayer);
  Debugger("ID des Spielers, "+sID, DEBUG);

  // 1.2 Erfasse das Ziel
  object oTarget = GetItemActivatedTarget();
  location locTarget;                   // Position des Ziels
  Debugger("Ziel erfasst, "+GetName(oTarget), DEBUG);

  // 1.2.1 Wenn das Ziel nicht als Objekt existiert, dann
  if (GetIsObjectValid(oTarget) == FALSE)
    locTarget = GetItemActivatedTargetLocation();  // erfasse die Position

  //       Ansonsten, Erfasse die Position des Ziels
  else
    locTarget = GetLocation(oTarget);
  Debugger("Position Ziel, "+LocationToString(locTarget), DEBUG);


  // 1.3 Pr�fe ab, ob der Nutzer die Person ist, die das Item nutzen kann.
  // 1.3.1 Ist die Variable bisher noch nicht gesetzt sein, dann setze sie
  if (GetLocalString(oItem, "Branded") == "")
  { SetLocalString(oItem, "Branded", sID);
    Debugger("Pr�fung ob bereits genutzt", DEBUG); }

  // 1.3.2 Stimmt die gesetzte Variable nicht mit der gebildeten ID �berein,
  if (GetLocalString(oItem, "Branded") != sID)
  {
    SetPlotFlag(oItem, FALSE);        // so setze das Item als nicht Handlung,
    SetStolenFlag(oItem, FALSE);      // als nicht gestohlen und
    SetItemCursedFlag(oItem, FALSE);  // als nicht verflucht
    DestroyObject(oItem);             // Danach l�sche es aus dem Inventar
    Debugger("Falscher Nutzer, gel�scht und beende Skript", DEBUG);

    return;                           // Beende nun das Skript vorab!
  }

  // 2++ Eigentlicher Skriptablauf
  // 2.1 Sammle nun alle anderen notwendigen Daten
  int nVisualEffectId = GetLocalInt(oItem, "VisualID"); // f�r VFX
  effect eEffectToAdd;

  string sResRef = GetLocalString(oItem, "Placeable");  // f�r Placeables
  int nCreated = GetLocalInt(oItem, "Placeable");
  object oCreate;

  Debugger("Viseller Effekt mit Nummer: "+IntToString(nVisualEffectId), DEBUG);
  Debugger("Placeable mit ResRef: "+sResRef+". Bisherig erschaffte, "+IntToString(nCreated), DEBUG);

  // 2.2 Stelle einen visuellen Effekt dar
  if (nVisualEffectId != 0)
  {
    switch (nVisualEffectId)
    {
      // Im Falle des VFX_BEAM_xxx
      case  73:
      case 210: case 211: case 212: case 213: case 214: case 215: case 216:
      case 307: case 308: case 309: case 310: case 311: case 312: case 313:
      case 447:
      case 482: case 483: case 484: case 485:
      {
        eEffectToAdd = EffectBeam(nVisualEffectId, oPlayer, 0);
        Debugger("Beam Effekt festgestellt, deswegen andere Funktion nutzen", DEBUG);
        break;
      }

      default:
      {
        eEffectToAdd = EffectVisualEffect(nVisualEffectId);
        Debugger("Standard Effekt festgestellt, deswegen Standard Funktion nutzen", DEBUG);
        break;
      }
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffectToAdd, oTarget, 60.0f);
    Debugger("Effekt erschafft, deswegen Skript beenden", DEBUG);
    return;
  }

  // 2.3 Stelle ein Placeable dar
  if (sResRef != "")
  {
    oCreate = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, locTarget, FALSE, "Created"+IntToString(nCreated));
    nCreated ++; SetLocalInt(oItem, "Placeable", nCreated);
    Debugger("Objekt erschafft, deswegen Skript beenden", DEBUG);
    return;
  }
}

void Debugger(string sString, int DEBUG)
{
  if (DEBUG == 1)
    SpeakString(sString);
}
