//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_garl
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Garl Glitzergold als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Garl Glitzergold");
  SendServerMessageToPC(oRacePC, "Garl Glitzergold wurde als Gottheit eingestellt.");
}
