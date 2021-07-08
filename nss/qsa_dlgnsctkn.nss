//::///////////////////////////////////////////////
//:: Questsystem per Notizbuch
//:: qsa_dlgnsctkn
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*  Ein Questsystem per Item, hier für den NSC.
    Einsetzbar bei einem Gespräch bei OnTextAppear
    - Aktualisieren des Headers */
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 05.12.2009
//:: Last Modified On: 15.04.2013
//:://////////////////////////////////////////////
#include "qsa_include"

int StartingConditional()
{
  object oData = OBJECT_SELF;
  object oSpawn = GetWaypointByTag(GetResRef(oData));
  if (GetIsObjectValid(oSpawn))  oData = oSpawn;

  // Grundlegendes Anfangsgeplaenkel                                  // Nur bei Questobjekten aktiv
  SetCustomToken(40000, GetLocalString(oData, "40000") );       SetCustomToken(40003, GetLocalString(oData, "40003") );
  SetCustomToken(40001, GetLocalString(oData, "40001") );       SetCustomToken(40004, GetLocalString(oData, "40004") );
  SetCustomToken(40002, GetLocalString(oData, "40002") );       SetCustomToken(40005, GetLocalString(oData, "40005") );
  // Start der Quest                                                  // Waehrend der Quest
  SetCustomToken(40010, GetLocalString(oData, "40010") );       SetCustomToken(40020, GetLocalString(oData, "40020") );
  SetCustomToken(40011, GetLocalString(oData, "40011") );       SetCustomToken(40021, GetLocalString(oData, "40021") );
  SetCustomToken(40012, GetLocalString(oData, "40012") );       SetCustomToken(40022, GetLocalString(oData, "40022") );
  // Schluss der Quest
  SetCustomToken(40030, GetLocalString(oData, "40030") );       SetCustomToken(40031, GetLocalString(oData, "40031") );

  return TRUE;  // Immer einen Wert zurueckgeben.
}
