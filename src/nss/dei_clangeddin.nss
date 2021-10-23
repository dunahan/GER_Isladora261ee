//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_clangeddin
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Clangeddin Silberbart als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Clangeddin Silberbart");
  SendServerMessageToPC(oRacePC, "Clangeddin Silberbart wurde als Gottheit eingestellt.");
}
