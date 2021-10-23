//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_eilistraee
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Eilistraee als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Eilistraee");
  SendServerMessageToPC(oRacePC, "Eilistraee wurde als Gottheit eingestellt.");
}
