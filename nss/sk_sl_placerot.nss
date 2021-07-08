//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_placerot
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript um ein ausgewähltes Placeable in der
    Ansicht zu drehen.

*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

void main()
{
  // Das zuvor ausgewählte/gefundene Objekt auslesen
  object oTarRot = GetLocalObject(oSpeaker,"LocalObject");  //Variable noch abändern ;)

  if ( (GetIsObjectValid(oTarRot) == FALSE) && (GetObjectType(oTarRot) != OBJECT_TYPE_PLACEABLE) )
  { SendServerMessageToPC(oSpeaker, "Fehler in der Verarbeitung: " + GetName(oTarRot) + "ist kein Placeable."); return; } // Abbruch!

  // Lese die ResRef aus
  string sGRef = GetResRef(oTarRot);

  // Die Position bestimmen
  object oGArea     = GetArea(oTarRot);
  vector vGPosition = GetPosition(oTarRot);
  float  fGfacing   = GetFacing(oTarRot);

  // Die Vektoren berechnen
  float vX = vGPosition.x;
  float vY = vGPosition.y;
  float vZ = vGPosition.z;
  // In neuen Vektor wandeln
  vector vNewPos = Vector(vX, vY,vZ);

  // Neue Ansicht generieren
  float fNewFace = fGfacing+90.0;

  location locNew = Location(oGArea, vNewPos, fGfacing);

  object oNew = CreateObject(OBJECT_TYPE_PLACEABLE, sGRef, locNew, FALSE);
  DestroyObject(oTarRot, 1.0);
}
