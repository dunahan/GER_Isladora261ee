//::///////////////////////////////////////////////
//:: Item Riddles, OnExit-Script für Auslöser
//:: _tri_itmriddles
//:: Copyright (c) 2011 dunahan@schwerterkueste.de
//:://////////////////////////////////////////////
/*
    Prüft nach Verlassen des Auslösers, ob sich in
    dessen direkter Nähe das zu suchende Objekt
    befindet
*/
//:://////////////////////////////////////////////
//:: Created By:  dunahan@schwerterkueste.de
//:: Created On:  15.10.2011
//:://////////////////////////////////////////////
#include "_isla_inc"

void main()
{
  // 1++ Deklarieren der notwendigsten Dinge
  object oItem; string sItem;  // Das notwendige Objekt definieren
  float fDistance;             // Entfernung des Abzulegenden Objekts definieren
  object oDoor;                // Die zu öffnende Tür

  // 1.1 Erfasse das herausgehende Objekt
  object oExiting = GetExitingObject();

  // 1.2 Sollte dieses NICHT existent UND ein Spieler sein, brich ab!
  if (!GetIsObjectValid(oExiting) && !GetIsPC(oExiting))
  { return; }

  // 1.3 Anderenfalls prüfe ob das Placeable, das darauf abgelegt wurde,
  //     das gesuchte ist
  else
  {
    // 1.3.1 Erfasse das nächste Objekt, mit den Objekt-Typ Item
    //       zu Dir selbst
    oItem = GetNearestObject(OBJECT_TYPE_ITEM);
    fDistance = GetDistanceToObject(oItem);

    // 1.3.2 Lese den Tag des gesuchten Objektes aus
    sItem = GetLocalString(OBJECT_SELF, "Item");

    // 1.3.3 Vergleiche den Tag des gefundenen Placeables mit
    //       dem abgelegten zum suchenden Objekts UND
    //       messe die Distanz
    if (GetTag(oItem) == sItem &&
        fDistance <= 0.8f )
    {
      // 1.3.3.1 Lese den Tag der Tür aus und suche diese
      oDoor = GetNearestObjectByTag(GetLocalString(OBJECT_SELF, "Door"));

      // 1.3.3.2 Sollte die Tür verschlossen sein,
      //         schließ auf und öffne sie dann
      SetLocked(oDoor, FALSE);
      AssignCommand(oDoor, ActionOpenDoor(oDoor));
    }
  }
}
