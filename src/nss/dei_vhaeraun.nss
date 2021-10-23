//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_vhaeraun
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Vhaeraun als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Vhaeraun");
  SendServerMessageToPC(oRacePC, "Vhaeraun wurde als Gottheit eingestellt.");
}
