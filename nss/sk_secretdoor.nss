//::///////////////////////////////////////////////
//:: sk_secretdoor
//:: sk_secretdoor
//:: Copyright (c) 2011 Dunahan.
//:://////////////////////////////////////////////
/*
    Ausl�serskript f�r Geheimt�ren/Placeables
    Bei einem erfolgreichen Wurf auf Suchen/Entdecken
    spawnt das Placeable und es werden EP vergeben.
    Bei OnEnter eines Ausl�sers einzusetzen
*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 10.11.2011
//:://////////////////////////////////////////////

/* Grundscript generiert mit
// Lilac Soul's NWN Script Generator, v. 2.3
// http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625
//
// Grundlagen:
// - Ausl�ser mit <einzigartigem> Tag!
// - Spawnpunkt des Placeables "LOC_<Tag des Ausl�sers>"
//
// SG <s_diff> und Placeable <s_place> sind als Variablen auf dem Ausl�ser zu
// definieren. Aktiv setzen des Ausl�sers durch die Variable <s_aktiv> = 0.
// <s_destroy> und <s_reset> sind als float anzugeben, damit der Spawn der
// Geheimt�r funktioniert!
*/
#include "_isla_inc"
#include "ll_include"

void main()
{
    d("sk_secretdoor: starting");                                               // 1++ Wichtige Variablen/Objekte usw erfassen
  object oPC = GetEnteringObject();                                             // Betretende Kreatur erfassen
  object oTrigger = OBJECT_SELF;                                                // Der Ausl�ser selbst
    d("sk_secretdoor: "+GetName(oPC)+" | "+GetName(oTrigger));
  string sTag = GetTag(oTrigger);                                               // TAG des Ausl�sers erfassen
  string sPlace = GetLocalString(oTrigger, "s_place");                          // TAG des Placeables auslesen
    d("sk_secretdoor: "+sTag+" | "+sPlace);
  object oTarget = GetWaypointByTag("LOC_" + sTag);                             // Spawnpunkt erfassen
  location locTarget = GetLocation(oTarget);                                    // Position des Spawnpunkts auslesen
    d("sk_secretdoor: "+GetName(oTarget)+" | "+DebugLocation(locTarget));
  int nDiff = GetLocalInt(oTrigger, "s_diff");                                  // SchwierigkeitsGrad auslesen
  float fDestroy = GetLocalFloat(oTrigger, "s_destroy");                        // Resetzeitraum des Placeables auslesen
  float fReset = GetLocalFloat(oTrigger, "s_reset");                            // Resetzeitraum des Ausl�sers
    d("sk_secretdoor: "+IntToString(nDiff)+" | "+FloatToString(fDestroy)+" | "+FloatToString(fReset));

  // 1.1 Pr�f ob der TAG des Placeables vorhanden ist.
  //     Wenn nicht dann nimm ein Allgemeines!
  if (sPlace == "") sPlace = "plc_every_sec";
    d("sk_secretdoor: "+sPlace);

  // 2++ Beginn des Skriptes
  // 2.1 Pr�f ob der Ausl�ser bereits aktiviert wurde.
  //     Wenn Ja, brich ab!
  if (GetLocalInt(oTrigger, "s_aktiv") != 0) return;

  // 2.2 Pr�f ob der Betretende ein Spieler ist.
  //     Wenn Nein, dann brich ab. Nur f�r Spieler!
  if (!GetIsPC(oPC)) return;

  // 2.3 EP nach SG berechnen
  int iMultiplier = 20/5;
  int iXPawarddc = GetLocalInt(oTrigger, "s_diff") * iMultiplier;
  int iXPaward = (iXPawarddc - ((GetHitDice(oPC)-1) * iMultiplier))*2;
    d("sk_secretdoor: "+IntToString(iMultiplier)+" | "+IntToString(iXPawarddc)+" | "+IntToString(iXPaward));

  // 3++ Pr�fung gegen die entsprechenden Skills.
  // 3.1 Pr�f ob ein Wurf auf W20 + Int-Bonus Punkte gr��er
  //     oder gleich des SG's ist. Wenn Ja, erstelle das Placeable.
  if (d20()+GetAbilityModifier(ABILITY_INTELLIGENCE, oPC) >= nDiff)
  {
    // Die Spielerfigur zur Info einen Satz sprechen lassen
    PlayVoiceChat(VOICE_CHAT_LOOKHERE, oPC);

    //Am Spawnpunkt das Placeable setzen
    CreateObjectVoid(OBJECT_TYPE_PLACEABLE, sPlace, locTarget);

    // Lokale Variable setzen, wenn er aktivert wurde
    SetLocalInt(oTrigger, "s_aktiv", 1);

    // EP vergeben
    //GiveXPToCreature(oPC, ((iXPaward > 1) ? iXPaward : 1));
    SetXPImproved(oPC, GetXP(oPC)+((iXPaward > 1) ? iXPaward : 1));

    // Placeable zerst�ren
    DelayCommand(fDestroy, DestroyObject(GetNearestObjectByTag(sPlace)));
    // Trigger zur�cksetzen
    DelayCommand(fReset, SetLocalInt(oTrigger, "s_aktiv", 0));

    // Beenden des Skripts, da Pr�fung erfolgreich!
    return;
  }

  // 3.2 Pr�f ob "Entdecken" erfolgreich angewand wurde.
  //     Wenn Ja, erstelle das Placeable.
  else if (GetIsSkillSuccessfulPrivate(oPC, SKILL_SPOT, nDiff))
  {
    // Die Spielerfigur zur Info einen Satz sprechen lassen
    PlayVoiceChat(VOICE_CHAT_LOOKHERE, oPC);

    //Am Spawnpunkt das Placeable setzen
    CreateObjectVoid(OBJECT_TYPE_PLACEABLE, sPlace, locTarget);

    // Lokale Variable setzen, wenn er aktivert wurde
    SetLocalInt(oTrigger, "s_aktiv", 1);

    // EP vergeben
    //GiveXPToCreature(oPC, ((iXPaward > 1) ? iXPaward : 1));
    SetXPImproved(oPC, GetXP(oPC)+((iXPaward > 1) ? iXPaward : 1));

    // Placeable zerst�ren
    DelayCommand(fDestroy, DestroyObject(GetNearestObjectByTag(sPlace)));
    // Trigger zur�cksetzen
    DelayCommand(fReset, SetLocalInt(oTrigger, "s_aktiv", 0));

    // Beenden des Skripts, da Pr�fung erfolgreich!
    return;
  }

  // 3.3 Pr�f ob "Suchen" erfolgreich angewand wurde.
  //     Wenn Ja, erstelle das Placeable.
  else if (GetIsSkillSuccessfulPrivate(oPC, SKILL_SEARCH, nDiff))
  {
    // Die Spielerfigur zur Info einen Satz sprechen lassen
    PlayVoiceChat(VOICE_CHAT_LOOKHERE, oPC);

    //Am Spawnpunkt das Placeable setzen
    CreateObjectVoid(OBJECT_TYPE_PLACEABLE, sPlace, locTarget);

    // Lokale Variable setzen, wenn er aktivert wurde
    SetLocalInt(oTrigger, "s_aktiv", 1);

    // EP vergeben
    //GiveXPToCreature(oPC, ((iXPaward > 1) ? iXPaward : 1));
    SetXPImproved(oPC, GetXP(oPC)+((iXPaward > 1) ? iXPaward : 1));

    // Placeable zerst�ren
    DelayCommand(fDestroy, DestroyObject(GetNearestObjectByTag(sPlace)));
    // Trigger zur�cksetzen
    DelayCommand(fReset, SetLocalInt(oTrigger, "s_aktiv", 0));

    // Beenden des Skripts, da Pr�fung erfolgreich!
    return;
  }
}
