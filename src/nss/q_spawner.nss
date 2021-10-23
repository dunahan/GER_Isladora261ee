#include "_debugisla"

void SendDebugMessage(string sMessage, object oPC) {
    object oArea = GetArea(OBJECT_SELF);
    vector vPos = GetPosition(OBJECT_SELF);

    string sDMMessage = sMessage + " Gebiet: " + GetName(oArea) + "(" + GetResRef(oArea) + ")";
    sDMMessage += " Position: ";
    sDMMessage += FloatToString(vPos.x) + " " + FloatToString(vPos.y) + " " + FloatToString(vPos.z);

    SendMessageToAllDMs(sDMMessage);
    SendServerMessageToPC(oPC, sMessage);
}

void main()
{
    object oPC = GetEnteringObject();
    string sTag = GetLocalString(OBJECT_SELF, "kennzeichnung");
    string sWPTag = GetLocalString(OBJECT_SELF, "wp_kennzeichnung");
    string sResRef = GetLocalString(OBJECT_SELF, "resref");
    int nMaxCount = GetLocalInt(OBJECT_SELF, "maxanzahl");
    int bGlobal = GetLocalInt(OBJECT_SELF, "global");
    int bOnce = GetLocalInt(OBJECT_SELF, "einmalig");
    int bOncePerPlayer = GetLocalInt(OBJECT_SELF, "einmalig_pro_spieler");
    int bTalk = GetLocalInt(OBJECT_SELF, "sprechen");

    if (bOnce && GetLocalInt(OBJECT_SELF, "locked")) {
        return;
    }

    if (bOncePerPlayer && GetLocalInt(oPC, "LOCK_" + sTag)) {
        return;
    }

    if (nMaxCount) {
        int nCount = 1;
        object oSpawned;

        if (bGlobal) {
            oSpawned = GetObjectByTag(sTag);
            while (GetIsObjectValid(oSpawned)) {
                oSpawned = GetObjectByTag(sTag, ++nCount);
            }
        } else {
            sTag = GetResRef(GetArea(OBJECT_SELF)) + "_" + sTag;
            oSpawned = GetNearestObjectByTag(sTag);
            while (GetIsObjectValid(oSpawned)) {
                oSpawned = GetNearestObjectByTag(sTag, OBJECT_SELF, ++nCount);
            }
        }

        // Ergebnis von nCount ist Anzahl der Kreaturen + 1
        if (nCount > nMaxCount) {
            return;
        }
    }

    object oWP = GetNearestObjectByTag(sWPTag);

    if (!GetIsObjectValid(oWP)) {
        SendDebugMessage("Wegpunkt nicht gefunden!", oPC);
    }

    location lLoc = GetLocation(oWP);
    object oCreature = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lLoc, FALSE, sTag);

    if (!GetIsObjectValid(oCreature)) {
        SendDebugMessage("Konnte Kreatur '" + sResRef + "' nicht Erschaffen!", oPC);
    }

    if (bOnce) {
        SetLocalInt(OBJECT_SELF, "locked", TRUE);
    }

    if (bOncePerPlayer) {
        SetLocalInt(oPC, "LOCK_" + sTag, TRUE);
    }

    if (bTalk) {
        AssignCommand(oCreature, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}
