//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_vergadain
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Vergadain als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Vergadain");
  SendServerMessageToPC(oRacePC, "Vergadain wurde als Gottheit eingestellt.");
}
