//::///////////////////////////////////////////////
//:: Raetsel
//:: sk_2hebel_onuse
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Raetsel anhand Hebeln
    Hier zwei Hebel oeffnen eine Tuer.
    Es koennen auch gewisse Items zur
    Loesung benoetigt werden
*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 14.11.2010
//:://////////////////////////////////////////////
#include "x2_inc_toollib"
#include "nw_i0_2q4luskan"
#include "_isla_inc"

void main()
{
// Suche die wichtigen Objekte
object oPC     = GetLastAttacker();                                              // Der Angreifer des Placeables
object oLeverA = GetObjectByTag(GetLocalString(OBJECT_SELF, "s_LeverA"));        // Kennzeichnung Hebel 1
object oLeverB = GetObjectByTag(GetLocalString(OBJECT_SELF, "s_LeverB"));        // Kennzeichnung Hebel 2
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
    if (GetLocked(oTuer) == TRUE) SetLocked(oTuer, FALSE);
    {
      AssignCommand(oTuer, ActionOpenDoor(oTuer));
      SendServerMessageToPC(oPC, "Du hörst ein Knirschen in der Entfernung.");
    }
  }
}

