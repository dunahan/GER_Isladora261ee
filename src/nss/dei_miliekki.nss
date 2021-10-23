//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_miliekki
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Mielikki als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Mielikki");
  SendServerMessageToPC(oRacePC, "Mielikki wurde als Gottheit eingestellt.");
}
