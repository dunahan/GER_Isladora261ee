#include "x3_inc_skin"

const string CUSTOM_APPEARANCE = "CustomAppearance";
const string CUSTOM_TAIL = "CustomTail";
const string CUSTOM_WINGS = "CustomWings";

// Gibt das Standardaussehen des Spielers zurück
int GetDefaultAppearance(object oPC);

// Gibt das Standardaussehen des Spielers zurück
int GetDefaultTail(object oPC);

// Gibt das Standardaussehen des Spielers zurück
int GetDefaultWings(object oPC);

// Setzt das Standardaussehen des Spielers
// -1 Löscht das angepasste Standardaussehen
void SetDefaultAppearance(object oPC, int nAppearance);

// Setzt das Standardaussehen des Spielers
// -1 Löscht das angepasste Standardaussehen
void SetDefaultTail(object oPC, int nTail);

// Setzt das Standardaussehen des Spielers
// -1 Löscht das angepasste Standardaussehen
void SetDefaultWings(object oPC, int nWings);

int GetDefaultAppearance(object oPC) {
    // Angepasstes Aussehen gesetzt?
    int nCustomAppearance = GetSkinInt(oPC, CUSTOM_APPEARANCE) - 1;

    if (nCustomAppearance != -1) {
        // Ja, zurückgeben
        return nCustomAppearance;
    }

    int nRace = GetRacialType(oPC);
    int nDefApp = StringToInt(Get2DAString("racialtypes","Appearance",nRace));
    return nRace;
}

int GetDefaultTail(object oPC)
{
    int nCustomTail = GetSkinInt(oPC, CUSTOM_TAIL) - 1;                         // Angepasstes Aussehen gesetzt?
    if (nCustomTail != -1)  return nCustomTail;                                 // Ja, zurückgeben
    return CREATURE_TAIL_TYPE_NONE;
}

int GetDefaultWings(object oPC)
{
    int nCustomWings = GetSkinInt(oPC, CUSTOM_WINGS) - 1;                       // Angepasstes Aussehen gesetzt?
    if (nCustomWings != -1) return nCustomWings;                                // Ja, zurückgeben
    if (GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE, oPC) > 8)
        return CREATURE_WING_TYPE_DRAGON;
    return CREATURE_WING_TYPE_NONE;
}

void SetDefaultAppearance(object oPC, int nAppearance)
{
    if (nAppearance == -1)  DeleteSkinInt(oPC, CUSTOM_APPEARANCE);
    else                    SetSkinInt(oPC, CUSTOM_APPEARANCE, nAppearance + 1);
}

void SetDefaultTail(object oPC, int nTail)
{
    if (nTail == -1)    DeleteSkinInt(oPC, CUSTOM_TAIL);
    else                SetSkinInt(oPC, CUSTOM_TAIL, nTail + 1);
}

void SetDefaultWings(object oPC, int nWings)
{
    if (nWings == -1)   DeleteSkinInt(oPC, CUSTOM_WINGS);
    else                SetSkinInt(oPC, CUSTOM_WINGS, nWings + 1);
}
