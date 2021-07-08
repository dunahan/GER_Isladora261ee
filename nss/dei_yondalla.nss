//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: dei_yondalla
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Gottheiten
    Stelle Yondalla die Gesegnete als Gott ein


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

void main()
{
  SetDeity(oRacePC, "Yondalla die Gesegnete");
  SendServerMessageToPC(oRacePC, "Yondalla die Gesegnete wurde als Gottheit eingestellt.");
}
