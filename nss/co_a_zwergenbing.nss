#include "_isla_inc"

void main() {
    object oPC = GetPCSpeaker();
    object oTarget = GetWaypointByTag("WP_BingeTempel");

    if (oTarget == OBJECT_INVALID) return;

    SendServerMessageToPC(oPC, "Die Umgebung um Euch verschwimmt und kaum einen Augenblick sp�ter Ihr findet Euch an Eurem Zielort wieder");

    DelayedJumpToObject(oPC, oTarget);
}
