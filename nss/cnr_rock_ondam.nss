/////////////////////////////////////////////////////////
//  Craftable Natural Resources (CNR) by Festyx
//  Name:  cnr_rock_ondam
//  Desc:  When a rock is beaten, chips are produced.
//  Author: David Bobeck 26Jan03
/////////////////////////////////////////////////////////
#include "cnr_config_inc"
#include "cnr_language_inc"

int CNR_MAXNUGG = 20;
float CNR_RESPAWNRES = 3600.0;

void SpawnNewRock(string sRockTag, location locRock)
{
  CreateObject(OBJECT_TYPE_PLACEABLE, sRockTag, locRock);
//DestroyObject(OBJECT_SELF);
}

void main()
{
  object oDamager = GetLastDamager();
  location locRock = GetLocation(OBJECT_SELF);
  object oNugget1 = OBJECT_INVALID;
  object oNugget2 = OBJECT_INVALID;
  object oGem = OBJECT_INVALID;
  string sRockTag = GetTag(OBJECT_SELF);

  int nCollectedNuggets = GetLocalInt(oDamager, "CNR_COLNUG");
  int nMaxHitpointOfRock = GetMaxHitPoints(OBJECT_SELF);
  int nNuggets = 0;
  float fDelay = 0.01;

  if (!GetIsObjectValid(oDamager) || !GetIsPC(oDamager))
    return;

  if (GetLocalInt(OBJECT_SELF, "CnrDamageBelowThreshold"))
    return;

  // the rock starts with 100 or so hit points
  if (GetCurrentHitPoints() < 80)
  {
    SetLocalInt(OBJECT_SELF, "CnrDamageBelowThreshold", TRUE);

    // Create the nugget and have the PC pick it up.
    string sNuggetTag = GetLocalString(GetModule(), sRockTag + "_NuggetTag");
    if (sNuggetTag != "")
    {
      oNugget1 = CreateObject(OBJECT_TYPE_ITEM, sNuggetTag, GetLocation(oDamager));
      FloatingTextStringOnCreature(CNR_TEXT_YOU_HAVE_CHIPPED_OFF_A + GetName(oNugget1) + "!", oDamager);
      nNuggets++;

      if (cnr_d100(1) <= CNR_FLOAT_ORE_MINING_FIND_SECOND_NUGGET_PERCENTAGE)
      {
        oNugget2 = CreateObject(OBJECT_TYPE_ITEM, sNuggetTag, GetLocation(oDamager));
        FloatingTextStringOnCreature(CNR_TEXT_AND_A_SECOND + GetName(oNugget2) + "!", oDamager);
        nNuggets++;
      }

      if (cnr_d100(1) <= CNR_FLOAT_ORE_MINING_FIND_MYSTERY_MINERAL_PERCENTAGE)
      {
        oGem = CreateObject(OBJECT_TYPE_ITEM, "cnrGemMineral000", GetLocation(oDamager));
        FloatingTextStringOnCreature(CNR_TEXT_AND_A + GetName(oGem) + "!", oDamager);
        nNuggets++;
      }

      AssignCommand(oDamager, ActionPickUpItem(oNugget1));

      if (oNugget2 != OBJECT_INVALID)
        AssignCommand(oDamager, ActionPickUpItem(oNugget2));

      if (oGem != OBJECT_INVALID)
        AssignCommand(oDamager, ActionPickUpItem(oGem));
    }

    // Sometimes the rock will get used up
    if (cnr_d100(1) <= CNR_FLOAT_ORE_MINING_DEPOSIT_BREAKAGE_PERCENTAGE)
    {
      if (CNR_FLOAT_ORE_MINING_DEPOSIT_RESPAWN_TIME_SECS > 0.0)
      {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), OBJECT_SELF);
        object oSpawner = CreateObject(OBJECT_TYPE_PLACEABLE, "cnrobjectspawner", locRock);
        AssignCommand(oSpawner, DelayCommand(CNR_FLOAT_ORE_MINING_DEPOSIT_RESPAWN_TIME_SECS, SpawnNewRock(sRockTag, locRock)));
        DestroyObject(OBJECT_SELF, 2.0); // provide time for death effect
        FloatingTextStringOnCreature(CNR_TEXT_THATS_THE_END_OF_THAT, oDamager);
      }
      return;
    }

    SetLocalInt(oDamager, "CNR_COLNUG", nCollectedNuggets+nNuggets);

    if (GetLocalInt(oDamager, "CNR_COLNUG") >= CNR_MAXNUGG)
    {
      fDelay = CNR_RESPAWNRES;
      DeleteLocalInt(oDamager, "CNR_COLNUG");
    }

    // Create a new rock with full hitpoints
    AssignCommand(GetModule(), DelayCommand(fDelay, SpawnNewRock(sRockTag, locRock)));
    DestroyObject(OBJECT_SELF);
  }
}
