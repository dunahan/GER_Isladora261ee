//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_savestands
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript um Standardeinstellungen des Sl zu laden
    und in der DatenBank zu speichern.

*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

void main()
{
  SaveSlDBVariables(oSpeaker);

  DestroyObject(GetNearestObjectByTag("sl_listener", oSpeaker));
}
