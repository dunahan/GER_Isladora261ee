//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_plccresave
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript um ein Objekt lokal abzuspeichern


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

void main()
{
  if (GetIsPC(oSpeakTarg) == TRUE)
  { string sToBeam = GetName(oSpeakTarg) + "_" + GetPCPlayerName(oSpeakTarg);
    SetLocalString(oSpeaker, "Stored", sToBeam); }
  else
  { string sToBeam = GetResRef(oSpeakTarg);
    SetLocalString(oSpeaker, "Stored", sToBeam);  }
}
