void CopyPC(object oPC, object oSelf=OBJECT_SELF);
void CopyPC(object oPC, object oSelf=OBJECT_SELF)
{
    int iNewApp;

/*WINGS:*/ iNewApp = GetCreatureWingType(oPC); SetCreatureWingType(iNewApp, oSelf);  // Kopiere Flügel

/*TAIL:*/  iNewApp = GetCreatureTailType(oPC); SetCreatureTailType(iNewApp, oSelf);  // Kopiere Schweif

/*HEAD:*/  iNewApp = GetCreatureBodyPart(CREATURE_PART_HEAD, oPC); SetCreatureBodyPart(CREATURE_PART_HEAD, iNewApp, oSelf);  // Kopiere Kopf

/*BODY:*/  iNewApp = GetCreatureBodyPart(CREATURE_PART_LEFT_BICEP, oPC); SetCreatureBodyPart(CREATURE_PART_LEFT_BICEP, iNewApp, oSelf); // Kopiere den Körper nach und nach
  iNewApp = GetCreatureBodyPart(CREATURE_PART_LEFT_FOOT, oPC); SetCreatureBodyPart(CREATURE_PART_LEFT_FOOT, iNewApp, oSelf);
  iNewApp = GetCreatureBodyPart(CREATURE_PART_LEFT_FOREARM, oPC); SetCreatureBodyPart(CREATURE_PART_LEFT_FOREARM, iNewApp, oSelf);
  iNewApp = GetCreatureBodyPart(CREATURE_PART_LEFT_HAND, oPC); SetCreatureBodyPart(CREATURE_PART_LEFT_HAND, iNewApp, oSelf);
  iNewApp = GetCreatureBodyPart(CREATURE_PART_LEFT_SHIN, oPC); SetCreatureBodyPart(CREATURE_PART_LEFT_SHIN, iNewApp, oSelf);
  iNewApp = GetCreatureBodyPart(CREATURE_PART_LEFT_THIGH, oPC); SetCreatureBodyPart(CREATURE_PART_LEFT_THIGH, iNewApp, oSelf);

  iNewApp = GetCreatureBodyPart(CREATURE_PART_RIGHT_BICEP, oPC); SetCreatureBodyPart(CREATURE_PART_RIGHT_BICEP, iNewApp, oSelf);
  iNewApp = GetCreatureBodyPart(CREATURE_PART_RIGHT_FOOT, oPC); SetCreatureBodyPart(CREATURE_PART_RIGHT_FOOT, iNewApp, oSelf);
  iNewApp = GetCreatureBodyPart(CREATURE_PART_RIGHT_FOREARM, oPC); SetCreatureBodyPart(CREATURE_PART_RIGHT_FOREARM, iNewApp, oSelf);
  iNewApp = GetCreatureBodyPart(CREATURE_PART_RIGHT_HAND, oPC); SetCreatureBodyPart(CREATURE_PART_RIGHT_HAND, iNewApp, oSelf);
  iNewApp = GetCreatureBodyPart(CREATURE_PART_RIGHT_SHIN, oPC); SetCreatureBodyPart(CREATURE_PART_RIGHT_SHIN, iNewApp, oSelf);
  iNewApp = GetCreatureBodyPart(CREATURE_PART_RIGHT_THIGH, oPC); SetCreatureBodyPart(CREATURE_PART_RIGHT_THIGH, iNewApp, oSelf);

  iNewApp = GetCreatureBodyPart(CREATURE_PART_NECK, oPC); SetCreatureBodyPart(CREATURE_PART_NECK, iNewApp, oSelf);
  iNewApp = GetCreatureBodyPart(CREATURE_PART_PELVIS, oPC); SetCreatureBodyPart(CREATURE_PART_PELVIS, iNewApp, oSelf);
  iNewApp = GetCreatureBodyPart(CREATURE_PART_TORSO, oPC); SetCreatureBodyPart(CREATURE_PART_TORSO, iNewApp, oSelf);

/*PHENO:*/ SetPhenoType(GetPhenoType(oPC), oSelf);  // Kopiere den Typus

/*Color:*/ iNewApp = GetColor(oPC, COLOR_CHANNEL_SKIN); SetColor(oSelf, COLOR_CHANNEL_SKIN, iNewApp);  // Übernehme alle Farben
  iNewApp = GetColor(oPC, COLOR_CHANNEL_HAIR); SetColor(oSelf, COLOR_CHANNEL_HAIR, iNewApp);
  iNewApp = GetColor(oPC, COLOR_CHANNEL_TATTOO_1); SetColor(oSelf, COLOR_CHANNEL_TATTOO_1, iNewApp);
  iNewApp = GetColor(oPC, COLOR_CHANNEL_TATTOO_2); SetColor(oSelf, COLOR_CHANNEL_TATTOO_2, iNewApp);

/*Armor*/
  object oHelmet = GetItemInSlot(0, oPC); object oChest = GetItemInSlot(1, oPC); object oRHand = GetItemInSlot(4, oPC);
  object oLHand = GetItemInSlot(5, oPC); object oCloak = GetItemInSlot(6, oPC); // Scanne jeden einzelnen und visuellen Gegenstand

  object oModHelm; object oModChes; object oModRHan; object oModLHan; object oModCloa;  // Deklariere die zu kopierenden Gegenstände

  AssignCommand(OBJECT_SELF, ClearAllActions(TRUE));
  if (GetIsObjectValid(oHelmet)) { oModHelm = CopyItem(oHelmet, oSelf, TRUE); SetDroppableFlag(oModHelm, FALSE);
                                   AssignCommand(OBJECT_SELF, ActionEquipItem(oModHelm, 0)); }  // Ist der Helm vorhanden, kopiere diesen und ziehe ihn an
  if (GetIsObjectValid(oChest))  { oModChes = CopyItem(oChest,  oSelf, TRUE); SetDroppableFlag(oModChes, FALSE);
                                   AssignCommand(OBJECT_SELF, ActionEquipItem(oModChes, 1)); }  // Ist eine Rüssi vorhanden, kopiere diese und ziehe sie an
  if (GetIsObjectValid(oRHand))  { oModRHan = CopyItem(oRHand,  oSelf, TRUE); SetDroppableFlag(oModRHan, FALSE);
                                   AssignCommand(OBJECT_SELF, ActionEquipItem(oModRHan, 4)); }  // Ist ein Gegenstand in der rechten Hand vorhanden, kopiere diesen und ziehe ihn an
  if (GetIsObjectValid(oLHand))  { oModLHan = CopyItem(oLHand,  oSelf, TRUE); SetDroppableFlag(oModLHan, FALSE);
                                   AssignCommand(OBJECT_SELF, ActionEquipItem(oModLHan, 5)); }  // Ist ein Gegenstand in der linken Hand vorhanden, kopiere diesen und ziehe ihn an
  if (GetIsObjectValid(oCloak))  { oModCloa = CopyItem(oCloak,  oSelf, TRUE); SetDroppableFlag(oModCloa, FALSE);
                                   AssignCommand(OBJECT_SELF, ActionEquipItem(oModCloa, 6)); }  // Ist ein Umhang vorhanden, kopiere diesen und ziehe ihn an
}

void main()
{
  object oToClone = GetLastPerceived(); int nAppType = GetAppearanceType(oToClone);  // Scanne das erkannte Objekt
  location locDoppel = GetLocation(OBJECT_SELF);                                     // Erfasse die Koordinaten des Doppelgängers

  // Skript für den männlichen Doppelgänger
  if (GetObjectSeen(oToClone) &&                   // Wurde das Objekt gesehen? UND
      GetIsObjectValid(oToClone) &&                // Ist das Objekt vorhanden? UND
      GetLocalInt(OBJECT_SELF, "Cloned")==0 &&     // Hat der Doppelgänger nicht bereits eine Gestalt angenommen hat UND
      GetGender(oToClone) == GENDER_MALE)          // Ist das Objekt Männlich?

  { SetName(OBJECT_SELF, GetName(oToClone));       // Kopiere den Namen UND gib ihm den Doppelänger

    SetCreatureAppearanceType(OBJECT_SELF , nAppType);  // Übernehme die Rasse des gescannten Objekts

    CopyPC(oToClone, OBJECT_SELF);                 // Kopiere das gescannte Objekt und dessen sichtbare Ausrüstung

    DelayCommand(5.0, ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE));  // deaktiviert für Übungszwecke

    SetLocalInt(OBJECT_SELF, "Cloned", 1); }       // Setze den Doppelgänger als "kopiert"

  else
  { ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE); }  // deaktiviert für Übungszwecke

  ExecuteScript("x2_def_percept", OBJECT_SELF);  // Führe das Standard-Skript aus
}
