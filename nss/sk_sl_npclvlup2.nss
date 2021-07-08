//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_npclvlup2
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript um Npc Lvl positiv zu beeinflussen


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

void main()
{
  int nClNbr    = GetLocalInt(oSpeaker, "Int1");            // Neue Klasse
  int nFstClass = GetClassByPosition(1, oSpeakTarg);        // Klasse auslesen
  int nSndClass = GetClassByPosition(2, oSpeakTarg);        // Klasse auslesen
  int nTrdClass = GetClassByPosition(3, oSpeakTarg);        // Klasse auslesen
  int nLvlFstCl = GetLevelByPosition(1, oSpeakTarg);        // Level der ersten Klasse auslesen
  int nLvlSndCl = GetLevelByPosition(2, oSpeakTarg);        // Level der zweiten Klasse auslesen
  int nLvlTrdCl = GetLevelByPosition(3, oSpeakTarg);        // Level der dritten Klasse auslesen
  int nPackage  = GetCreatureStartingPackage(oSpeakTarg);   // Lvlpacket der Kreatur auslesen

  if (nLvlTrdCl >=1) nClNbr = nSndClass;

  // Neue zweite Standardklasse hinzufügen
  if (nClNbr ==  0 && nSndClass !=  0 && nFstClass !=  0)
  { AdjustAlignment(oSpeakTarg, ALIGNMENT_NEUTRAL, 50, FALSE);
    SendServerMessageToPC(oSpeaker, "Klasse Barbar wird hinzugefügt. Gesinnung wurde angepasst.");
    LevelUpHenchman(oSpeakTarg, nSndClass, FALSE, nPackage); }

  if (nClNbr ==  1 && nSndClass !=  1 && nFstClass !=  1)
  { AdjustAlignment(oSpeakTarg, ALIGNMENT_NEUTRAL, 50, FALSE);
    SendServerMessageToPC(oSpeaker, "Klasse Barde wird hinzugefügt. Gesinnung wurde angepasst.");
    LevelUpHenchman(oSpeakTarg, nSndClass, FALSE, nPackage); }

  if (nClNbr ==  3 && nSndClass !=  3 && nFstClass !=  3)
  { AdjustAlignment(oSpeakTarg, ALIGNMENT_NEUTRAL, 50, FALSE);
    SendServerMessageToPC(oSpeaker, "Klasse Druide wird hinzugefügt. Gesinnung wurde angepasst.");
    LevelUpHenchman(oSpeakTarg, nSndClass, FALSE, nPackage); }

  if (nClNbr ==  5 && nSndClass !=  5 && nFstClass !=  5)
  { AdjustAlignment(oSpeakTarg, ALIGNMENT_LAWFUL, 50, FALSE);
    SendServerMessageToPC(oSpeaker, "Klasse Mönch wird hinzugefügt. Gesinnung wurde angepasst.");
    LevelUpHenchman(oSpeakTarg, nSndClass, FALSE, nPackage); }

  if (nClNbr ==  6 && nSndClass !=  6 && nFstClass !=  6)
  { AdjustAlignment(oSpeakTarg, ALIGNMENT_LAWFUL, 50, FALSE);
    AdjustAlignment(oSpeakTarg, ALIGNMENT_GOOD, 50, FALSE);
    SendServerMessageToPC(oSpeaker, "Klasse Paladin wird hinzugefügt. Gesinnung wurde angepasst.");
    LevelUpHenchman(oSpeakTarg, nSndClass, FALSE, nPackage); }

  if (nClNbr == 27 && nSndClass != 27 && nFstClass != 27)
  { object oCreate = IPCreateProficiencyFeatItemOnCreature(oSpeakTarg);  ActionEquipItem(oCreate, 8); // Erschaffe Ring, der alle Talente gibt und rüste ihn aus
    if (GetIsObjectValid(GetItemInSlot(8, oSpeakTarg)) == TRUE) // ist der Ring existent?
    { itemproperty ipSkill = ItemPropertySkillBonus(255, 10);   // ja, dann lege die minimal Skills fest
      IPSafeAddItemProperty(oCreate, ipSkill); }                // und setze sie auf den Ring
    SendServerMessageToPC(oSpeaker, "Prestigeklasse Schattentänzer wird hinzugefügt. Benötigte Fähigkeiten wurden ergänzt.");
    LevelUpHenchman(oSpeakTarg, nSndClass, FALSE, nPackage); }

  if (nClNbr == 28 && nSndClass != 28 && nFstClass != 28)
  { AdjustAlignment(oSpeakTarg, ALIGNMENT_NEUTRAL, 50, FALSE);  // Gesinnung anpassen
    object oCreate = IPCreateProficiencyFeatItemOnCreature(oSpeakTarg);  ActionEquipItem(oCreate, 8); // Erschaffe Ring, der alle Talente gibt und rüste ihn aus
    if (GetIsObjectValid(GetItemInSlot(8, oSpeakTarg)) == TRUE) // ist der Ring existent?
    { itemproperty ipSkill = ItemPropertySkillBonus(255, 10);   // ja, dann lege die minimal Skills fest
      IPSafeAddItemProperty(oCreate, ipSkill); }                // und setze sie auf den Ring
    SendServerMessageToPC(oSpeaker, "Prestigeklasse Harfnerkundschafter wird hinzugefügt. Benötigte Gesinnung/Fähigkeiten wurden ergänzt.");
    LevelUpHenchman(oSpeakTarg, nSndClass, FALSE, nPackage); }

  if (nClNbr == 29 && nSndClass != 29 && nFstClass != 29)
  { if ( (GetRacialType(oSpeakTarg) != 1) || (GetRacialType(oSpeakTarg) != 4) || // Rassenbeschränkungen prüfen!
         (GetBaseAttackBonus(oSpeakTarg) <= 5) ||                                // Klassenbeschränkung BAB prüfen!
         (nSndClass !=  9) || (nFstClass !=  9) ||                               // Klassenminimum Hexenmeister prüfen!
         (nSndClass != 10) || (nFstClass != 10) )                                // Klassenminimum Magier prüfen!
    { SendServerMessageToPC(oSpeaker, "Diese Klasse ist nicht mit diesem NSC möglich."); return;}
    object oCreate = IPCreateProficiencyFeatItemOnCreature(oSpeakTarg);  ActionEquipItem(oCreate, 8); // Erschaffe Ring, der alle Talente gibt und rüste ihn aus
    if (GetIsObjectValid(GetItemInSlot(8, oSpeakTarg)) == TRUE) // ist der Ring existent?
    { itemproperty ipSkill = ItemPropertySkillBonus(255, 10);   // ja, dann lege die minimal Skills fest
      IPSafeAddItemProperty(oCreate, ipSkill); }                // und setze sie auf den Ring
    SendServerMessageToPC(oSpeaker, "Prestigeklasse Arkaner Bogenschütze wird hinzugefügt. Benötigte Fähigkeiten wurden ergänzt.");
    LevelUpHenchman(oSpeakTarg, nSndClass, FALSE, nPackage); }

  if (nClNbr == 30 && nSndClass != 30 && nFstClass != 30)
  { AdjustAlignment(oSpeakTarg, ALIGNMENT_EVIL, 50, FALSE);
    object oCreate = IPCreateProficiencyFeatItemOnCreature(oSpeakTarg);  ActionEquipItem(oCreate, 8); // Erschaffe Ring, der alle Talente gibt und rüste ihn aus
    if (GetIsObjectValid(GetItemInSlot(8, oSpeakTarg)) == TRUE) // ist der Ring existent?
    { itemproperty ipSkill = ItemPropertySkillBonus(255, 10);   // ja, dann lege die minimal Skills fest
      IPSafeAddItemProperty(oCreate, ipSkill); }                // und setze sie auf den Ring
    SendServerMessageToPC(oSpeaker, "Prestigeklasse Assassine wird hinzugefügt. Benötigte Gesinnung/Fähigkeiten wurden ergänzt.");
    LevelUpHenchman(oSpeakTarg, nSndClass, FALSE, nPackage); }

  if (nClNbr == 31 && nSndClass != 31 && nFstClass != 31)
  { if ( (GetBaseAttackBonus(oSpeakTarg) <= 5) )                // Klassenbeschränkung BAB prüfen!
    { SendServerMessageToPC(oSpeaker, "Diese Klasse ist nicht mit diesem NSC möglich."); return;}
    AdjustAlignment(oSpeakTarg, ALIGNMENT_EVIL, 50, FALSE);
    object oCreate = IPCreateProficiencyFeatItemOnCreature(oSpeakTarg);  ActionEquipItem(oCreate, 8); // Erschaffe Ring, der alle Talente gibt und rüste ihn aus
    if (GetIsObjectValid(GetItemInSlot(8, oSpeakTarg)) == TRUE) // ist der Ring existent?
    { itemproperty ipSkill = ItemPropertySkillBonus(255, 10);   // ja, dann lege die minimal Skills fest
      IPSafeAddItemProperty(oCreate, ipSkill); }                // und setze sie auf den Ring
    SendServerMessageToPC(oSpeaker, "Prestigeklasse Finsterer Streiter wird hinzugefügt. Benötigte Gesinnung/Fähigkeiten wurden ergänzt.");
    LevelUpHenchman(oSpeakTarg, nSndClass, FALSE, nPackage); }

  if (nClNbr == 32 && nSndClass != 32 && nFstClass != 32)
  { if ( (GetBaseAttackBonus(oSpeakTarg) <= 6) )                // Klassenbeschränkung BAB prüfen!
    { SendServerMessageToPC(oSpeaker, "Diese Klasse ist nicht mit diesem NSC möglich."); return;}
    AdjustAlignment(oSpeakTarg, ALIGNMENT_NEUTRAL, 50, FALSE);  // Gesinnung festlegen
    object oCreate = IPCreateProficiencyFeatItemOnCreature(oSpeakTarg);  ActionEquipItem(oCreate, 8); // Erschaffe Ring, der alle Talente gibt und rüste ihn aus
    if (GetIsObjectValid(GetItemInSlot(8, oSpeakTarg)) == TRUE) // ist der Ring existent?
    { itemproperty ipSkill = ItemPropertySkillBonus(255, 10);   // ja, dann lege die minimal Skills fest
      IPSafeAddItemProperty(oCreate, ipSkill); }                // und setze sie auf den Ring
    SendServerMessageToPC(oSpeaker, "Prestigeklasse Vorkämpfer des Torm wird hinzugefügt. Benötigte Fähigkeiten wurden ergänzt.");
    LevelUpHenchman(oSpeakTarg, nSndClass, FALSE, nPackage); }

  if (nClNbr == 33 && nSndClass != 33 && nFstClass != 33)
  { if ( (GetBaseAttackBonus(oSpeakTarg) <= 4) )                // Klassenbeschränkung BAB prüfen!
    { SendServerMessageToPC(oSpeaker, "Diese Klasse ist nicht mit diesem NSC möglich."); return;}
    AdjustAlignment(oSpeakTarg, ALIGNMENT_NEUTRAL, 50, FALSE);  // Gesinnung festlegen
    object oCreate = IPCreateProficiencyFeatItemOnCreature(oSpeakTarg);  ActionEquipItem(oCreate, 8); // Erschaffe Ring, der alle Talente gibt und rüste ihn aus
    if (GetIsObjectValid(GetItemInSlot(8, oSpeakTarg)) == TRUE) // ist der Ring existent?
    { itemproperty ipSkill = ItemPropertySkillBonus(255, 10);   // ja, dann lege die minimal Skills fest
      IPSafeAddItemProperty(oCreate, ipSkill); }                // und setze sie auf den Ring
    SendServerMessageToPC(oSpeaker, "Prestigeklasse Waffenmeister wird hinzugefügt. Benötigte Fähigkeiten wurden ergänzt.");
    LevelUpHenchman(oSpeakTarg, nSndClass, FALSE, nPackage); }

  if (nClNbr == 34 && nSndClass != 34 && nFstClass != 34)
  { if ( (nSndClass !=  9) || (nFstClass !=  9) ||              // Klassenminimum Hexenmeister prüfen!
         (nSndClass != 10) || (nFstClass != 10) )               // Klassenminimum Magier prüfen!
    { SendServerMessageToPC(oSpeaker, "Diese Klasse ist nicht mit diesem NSC möglich."); return;}
    AdjustAlignment(oSpeakTarg, ALIGNMENT_EVIL, 50, FALSE);
    object oCreate = IPCreateProficiencyFeatItemOnCreature(oSpeakTarg);  ActionEquipItem(oCreate, 8); // Erschaffe Ring, der alle Talente gibt und rüste ihn aus
    if (GetIsObjectValid(GetItemInSlot(8, oSpeakTarg)) == TRUE) // ist der Ring existent?
    { itemproperty ipSkill = ItemPropertySkillBonus(255, 10);   // ja, dann lege die minimal Skills fest
      IPSafeAddItemProperty(oCreate, ipSkill); }                // und setze sie auf den Ring
    SendServerMessageToPC(oSpeaker, "Prestigeklasse Bleicher Meister wird hinzugefügt. Benötigte Gesinnung/Fähigkeiten wurden ergänzt.");
    LevelUpHenchman(oSpeakTarg, nSndClass, FALSE, nPackage); }

  if (nClNbr == 35 && nSndClass != 35 && nFstClass != 35)
  { if ( (nSndClass !=  2) || (nFstClass !=  2) ||              // Klassenminimum Kleriker prüfen!
         (nSndClass !=  3) || (nFstClass !=  3) )               // Klassenminimum Druide prüfen!
    { SendServerMessageToPC(oSpeaker, "Diese Klasse ist nicht mit diesem NSC möglich."); return;}
    object oCreate = IPCreateProficiencyFeatItemOnCreature(oSpeakTarg);  ActionEquipItem(oCreate, 8); // Erschaffe Ring, der alle Talente gibt und rüste ihn aus
    if (GetIsObjectValid(GetItemInSlot(8, oSpeakTarg)) == TRUE) // ist der Ring existent?
    { itemproperty ipSkill = ItemPropertySkillBonus(255, 10);   // ja, dann lege die minimal Skills fest
      IPSafeAddItemProperty(oCreate, ipSkill); }                // und setze sie auf den Ring
    SendServerMessageToPC(oSpeaker, "Prestigeklasse Wahrer Wandler wird hinzugefügt. Benötigte Gesinnung/Fähigkeiten wurden ergänzt.");
    LevelUpHenchman(oSpeakTarg, nSndClass, FALSE, nPackage); }

  if (nClNbr == 36 && nSndClass != 36 && nFstClass != 36)
  { if ( (GetRacialType(oSpeakTarg) != 0) ||                                     // Rassenbeschränkungen prüfen!
         (GetBaseAttackBonus(oSpeakTarg) <= 6) )                                 // Klassenbeschränkung BAB prüfen!
    { SendServerMessageToPC(oSpeaker, "Diese Klasse ist nicht mit diesem NSC möglich."); return;}
    AdjustAlignment(oSpeakTarg, ALIGNMENT_LAWFUL, 50, FALSE);   // Gesinnung festlegen
    object oCreate = IPCreateProficiencyFeatItemOnCreature(oSpeakTarg);  ActionEquipItem(oCreate, 8); // Erschaffe Ring, der alle Talente gibt und rüste ihn aus
    if (GetIsObjectValid(GetItemInSlot(8, oSpeakTarg)) == TRUE) // ist der Ring existent?
    { itemproperty ipSkill = ItemPropertySkillBonus(255, 10);   // ja, dann lege die minimal Skills fest
      IPSafeAddItemProperty(oCreate, ipSkill); }                // und setze sie auf den Ring
    SendServerMessageToPC(oSpeaker, "Prestigeklasse Zwergischer Verteidiger wird hinzugefügt. Benötigte Fähigkeiten wurden ergänzt.");
    LevelUpHenchman(oSpeakTarg, nSndClass, FALSE, nPackage); }

  if (nClNbr == 37 && nSndClass != 37 && nFstClass != 37)
  { if ( (nSndClass !=  1) || (nFstClass !=  1) ||              // Klassenminimum Hexenmeister prüfen!
         (nSndClass !=  9) || (nFstClass !=  9) )               // Klassenminimum Magier prüfen!
    { SendServerMessageToPC(oSpeaker, "Diese Klasse ist nicht mit diesem NSC möglich."); return;}
    object oCreate = IPCreateProficiencyFeatItemOnCreature(oSpeakTarg);  ActionEquipItem(oCreate, 8); // Erschaffe Ring, der alle Talente gibt und rüste ihn aus
    if (GetIsObjectValid(GetItemInSlot(8, oSpeakTarg)) == TRUE) // ist der Ring existent?
    { itemproperty ipSkill = ItemPropertySkillBonus(255, 10);   // ja, dann lege die minimal Skills fest
      IPSafeAddItemProperty(oCreate, ipSkill); }                // und setze sie auf den Ring
    SendServerMessageToPC(oSpeaker, "Prestigeklasse Jünger des Roten Drachen wird hinzugefügt. Benötigte Gesinnung/Fähigkeiten wurden ergänzt.");
    LevelUpHenchman(oSpeakTarg, nSndClass, FALSE, nPackage); }

  if (nClNbr == 41 && nSndClass != 41 && nFstClass != 41)
  { if ( (GetBaseAttackBonus(oSpeakTarg) <= 3) )                                 // Klassenbeschränkung BAB prüfen!
    { SendServerMessageToPC(oSpeaker, "Diese Klasse ist nicht mit diesem NSC möglich."); return;}
    AdjustAlignment(oSpeakTarg, ALIGNMENT_NEUTRAL, 50, FALSE);  // Gesinnung festlegen
    object oCreate = IPCreateProficiencyFeatItemOnCreature(oSpeakTarg);  ActionEquipItem(oCreate, 8); // Erschaffe Ring, der alle Talente gibt und rüste ihn aus
    if (GetIsObjectValid(GetItemInSlot(8, oSpeakTarg)) == TRUE) // ist der Ring existent?
    { itemproperty ipSkill = ItemPropertySkillBonus(255, 10);   // ja, dann lege die minimal Skills fest
      IPSafeAddItemProperty(oCreate, ipSkill); }                // und setze sie auf den Ring
    SendServerMessageToPC(oSpeaker, "Prestigeklasse Ritter des Purpurdrachen wird hinzugefügt. Benötigte Gesinnung/Fähigkeiten wurden ergänzt.");
    LevelUpHenchman(oSpeakTarg, nSndClass, FALSE, nPackage); }

}
