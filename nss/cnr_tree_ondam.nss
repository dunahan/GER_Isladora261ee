/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_tree_ondam
//
//  Desc:  When a tree is beaten, wood is produced.
//
//  Author: David Bobeck 26Jan03
//
/////////////////////////////////////////////////////////
#include "cnr_language_inc"
#include "cnr_config_inc"
#include "nw_i0_plot"

void SpawnNewTree(string sTreeTag, location locTree)
{
  CreateObject(OBJECT_TYPE_PLACEABLE, sTreeTag, locTree);
  DestroyObject(OBJECT_SELF);
}

void main()
{
  object oDamager = GetLastDamager();
  location locTree = GetLocation(OBJECT_SELF);
  string sTreeTag = GetTag(OBJECT_SELF);

  int bHasAxe = FALSE;
  object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oDamager);
  if (GetIsObjectValid(oItem))
  {
    if (GetTag(oItem) == "cnrWoodCutterAxe")
    {
      bHasAxe = TRUE;
    }
  }

  if (bHasAxe == FALSE)
  {
    oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oDamager);
    if (GetIsObjectValid(oItem))
    {
      if (GetTag(oItem) == "cnrWoodCutterAxe")
      {
        bHasAxe = TRUE;
      }
    }
  }

  else  // sollte es sich um eine Inv Sichel handeln
  {
    if (HasItem(oDamager, "cnrWoodCutterSicle"))
    {
        bHasAxe = TRUE;
    }
  }

if (bHasAxe == TRUE)
{

  if (!GetIsObjectValid(oDamager) || !GetIsPC(oDamager))  return;

  if (GetLocalInt(OBJECT_SELF, "CnrDamageBelowThreshold"))  return;

  // the tree starts with 100 hit points or more
  if (GetCurrentHitPoints() < 80)
  {
    SetLocalInt(OBJECT_SELF, "CnrDamageBelowThreshold", TRUE);

    // Create a branch and have the PC pick it up.
    string sBranchTag = GetLocalString(GetModule(), sTreeTag + "_BranchTag");
    if (sBranchTag != "")
    {
      object oBranch = CreateObject(OBJECT_TYPE_ITEM, sBranchTag, GetLocation(oDamager));
      FloatingTextStringOnCreature(CNR_TEXT_YOU_HAVE_CHOPPED_OFF_A + GetName(oBranch) + "!", oDamager);
      AssignCommand(GetLastDamager(), ActionPickUpItem(oBranch));
    }

    // Sometimes the tree will get used up
    if (cnr_d100(1) <= CNR_FLOAT_WOOD_MINING_TREE_BREAKAGE_PERCENTAGE)
    {
      if (CNR_FLOAT_WOOD_MINING_TREE_RESPAWN_TIME_SECS > 0.0)
      {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), OBJECT_SELF);
        object oSpawner = CreateObject(OBJECT_TYPE_PLACEABLE, "cnrobjectspawner", locTree);
        AssignCommand(oSpawner, DelayCommand(CNR_FLOAT_WOOD_MINING_TREE_RESPAWN_TIME_SECS, SpawnNewTree(sTreeTag, locTree)));
        DestroyObject(OBJECT_SELF, 2.0); // provide time for death effect
        FloatingTextStringOnCreature(CNR_TEXT_THATS_THE_END_OF_THAT, oDamager);
      }
      return;
    }

    // Create a new tree with full hitpoints
    DestroyObject(OBJECT_SELF);
    CreateObject(OBJECT_TYPE_PLACEABLE, sTreeTag, locTree);
  }
}  // Ende if (bHasAxe == TRUE)

else
{
  SetPlotFlag(OBJECT_SELF, TRUE);
  FloatingTextStringOnCreature(CNR_TEXT_REQUIRES_A_WOODCUTTERS_AXE, oDamager, FALSE);

  // Stop all commands and unequip weapon
  AssignCommand(oDamager, ClearAllActions(TRUE));
  AssignCommand(oDamager, ActionUnequipItem(oItem));

  // clear the plot flag so the next attacker won't get "weapon not effective"
  DelayCommand(10.0, SetPlotFlag(OBJECT_SELF, FALSE));
}

} // Ende Skript!
