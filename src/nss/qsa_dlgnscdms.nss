//::///////////////////////////////////////////////
//:: FileName qsa_dlgnscdms
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 0
//:://////////////////////////////////////////////
#include "qsa_include"

int StartingConditional()
{                                                                               // sammle nur die Daten wenn wirklich notwendig!
  if (GetIsDM(GetPCSpeaker()))
  {
    object oData = OBJECT_SELF;
    object oSpawn = GetWaypointByTag(GetResRef(oData));
    if (GetIsObjectValid(oSpawn))  oData = oSpawn;

    SetCustomToken(40006, qsa_PrintDebug(oData));

    return TRUE;
  }
  else
    return FALSE;
}
