//::///////////////////////////////////////////////
//:: SL Tools
//:: itm_description
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*
    SL-Tool: Beschreibung anpassen
*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 05.12.2009
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_sltools_inc"

void main()
{
  string sDescription = GetLocalString(oSpeaker, "String1");
  SetDescription(oItemTarget, sDescription, FALSE);
  SendServerMessageToPC(oItemCaster, "Neue Beschreibung: " + sDescription);
  SetDescription(oItemTarget, sDescription, TRUE);
}
