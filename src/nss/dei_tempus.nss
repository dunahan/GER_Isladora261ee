//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_tempus
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Tempus als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Tempus");
  SendServerMessageToPC(oRacePC, "Tempus wurde als Gottheit eingestellt.");
}