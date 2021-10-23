//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_segojan
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Segojan Erdrufer als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Segojan Erdrufer");
  SendServerMessageToPC(oRacePC, "Segojan Erdrufer wurde als Gottheit eingestellt.");
}
