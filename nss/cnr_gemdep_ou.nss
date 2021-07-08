/////////////////////////////////////////////////////////
//  Craftable Natural Resources (CNR) by Festyx
//  Name:  cnr_gemdep_ou
//  Desc:  When a player uses a mineral deposit,
//         they must be equipped with a gem crafter's
//         chisel. They will dig something up 20% of
//         the time.
//  Author: David Bobeck 02Mar03
/////////////////////////////////////////////////////////
#include "cnr_config_inc"
#include "cnr_language_inc"
#include "_debugisla"
#include "eds_include"

int CNR_MAXGEMS = 20;
float CNR_RESPAWNRES = 3600.0;

void SpawnNewGemDeposit(string sDepositTag, location locDeposit)
{
  CreateObject(OBJECT_TYPE_PLACEABLE, sDepositTag, locDeposit);
  DestroyObject(OBJECT_SELF);
}

string CreateUniqueID(object oObject)
{
  vector vecLoc = GetPositionFromLocation(GetLocation(oObject));
  float fx, fy, fz; string sx, sy, sz;
  fx = vecLoc.x; fy = vecLoc.y; fz = vecLoc.z;
  return FloatToString(fx, 3, 1)+"|"+FloatToString(fy, 3, 1)+"|"+FloatToString(fz, 3, 1);
}

void StopItFromWorking(object oUser, object oDeposit)
{
  EDS_SetDelay(oDeposit, CreateUniqueID(oDeposit), CNR_RESPAWNRES, FALSE);
  FloatingTextStringOnCreature(CNR_TEXT_THATS_THE_END_OF_THAT, oUser);

  SetLocalInt(OBJECT_SELF, "CnrStopRapidClicks", FALSE);
  DeleteLocalInt(oUser, CreateUniqueID(oDeposit));
}

void DoPostChiselingSuccessCheck(object oUser, location locUserAtStart, object oDeposit)
{
  DeleteLocalInt(oDeposit, "CnrStopRapidClicks");
  int nChiseledGems = GetLocalInt(oUser, CreateUniqueID(oDeposit));
  int nGems = 0;

  location locUser = GetLocation(oUser);
  if (locUser != locUserAtStart)
    return;

  object oMineral1 = OBJECT_INVALID;
  object oMineral2 = OBJECT_INVALID;
  object oMineral3 = OBJECT_INVALID;

  // chance of success
  if (cnr_d100(1) <= CNR_FLOAT_GEM_MINING_FIND_FIRST_MINERAL_PERCENTAGE)
  {
    string sDepositTag = GetTag(oDeposit);
    string sMineralTag = GetLocalString(GetModule(), sDepositTag + "_MineralTag");

    if (sMineralTag != "")
    {
      oMineral1 = CreateObject(OBJECT_TYPE_ITEM, sMineralTag, locUser);
      FloatingTextStringOnCreature(CNR_TEXT_YOU_CHISELED_OFF_A + GetName(oMineral1) + "!", oUser);
      nGems++;

      if (cnr_d100(1) <= CNR_FLOAT_GEM_MINING_FIND_SECOND_MINERAL_PERCENTAGE)
      {
        oMineral2 = CreateObject(OBJECT_TYPE_ITEM, sMineralTag, locUser);
        FloatingTextStringOnCreature(CNR_TEXT_AND_A_SECOND + GetName(oMineral2) + "!", oUser);
        nGems++;
      }

      if (cnr_d100(1) <= CNR_FLOAT_GEM_MINING_FIND_MYSTERY_MINERAL_PERCENTAGE)
      {
        oMineral3 = CreateObject(OBJECT_TYPE_ITEM, "cnrGemMineral000", locUser);
        FloatingTextStringOnCreature(CNR_TEXT_AND_A + GetName(oMineral3) + "!", oUser);
        nGems++;
      }

      ActionPickUpItem(oMineral1);

      if (oMineral2 != OBJECT_INVALID)
        ActionPickUpItem(oMineral2);

      if (oMineral3 != OBJECT_INVALID)
        ActionPickUpItem(oMineral3);
    }

    SetLocalInt(oUser, CreateUniqueID(oDeposit), nChiseledGems + nGems);
  }

  else
  {
    ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 1.0);
    string sFloat;
    int nFloat = d6(1);
    switch (nFloat)
    {
      case 1: sFloat = CNR_TEXT_GEMDEP_MUMBLE_1; break;
      case 2: sFloat = CNR_TEXT_GEMDEP_MUMBLE_2; break;
      case 3: sFloat = CNR_TEXT_GEMDEP_MUMBLE_3; break;
      case 4: sFloat = CNR_TEXT_GEMDEP_MUMBLE_4; break;
      case 5: sFloat = CNR_TEXT_GEMDEP_MUMBLE_5; break;
      case 6: sFloat = CNR_TEXT_GEMDEP_MUMBLE_6; break;
      default: sFloat = CNR_TEXT_GEMDEP_MUMBLE_1; break;
    }
    DelayCommand(1.0, FloatingTextStringOnCreature(sFloat, oUser));
    DelayCommand(2.0, DoPlaceableObjectAction(oDeposit, PLACEABLE_ACTION_USE));
  }
}

void main()
{
  object oDeposit = OBJECT_SELF;
  object oUser = GetLastUsedBy();

  if (GetLocalInt(oUser, CreateUniqueID(oDeposit)) >= CNR_MAXGEMS)
  {
    StopItFromWorking(oUser, oDeposit);
    return;
  }

  if (EDS_IsDelaySet(oDeposit, CreateUniqueID(oDeposit), FALSE))
  {
    if (!EDS_CheckDelay(oDeposit, CreateUniqueID(oDeposit)))
    {
      SendServerMessageToPC(oUser, "Hier lässt sich momentan nichts finden.");
      return;
    }
  }

  int bStopRapidClicks = GetLocalInt(OBJECT_SELF, "CnrStopRapidClicks");
  if (bStopRapidClicks == TRUE)   return;
  SetLocalInt(OBJECT_SELF, "CnrStopRapidClicks", TRUE);

  // Following code added to make gem collection more like ore collection
  if (GetStealthMode(oUser) == STEALTH_MODE_ACTIVATED)
  {
    SendServerMessageToPC(oUser, "Du kannst keine Edelsteine abbauen wenn du versteckt bist.");

    SetLocalInt(OBJECT_SELF, "CnrStopRapidClicks", FALSE);
    return;
  }

  if (GetHasSpellEffect(SPELL_INVISIBILITY, oUser) == TRUE ||          // Unsichtbarkeit
      GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY, oUser) == TRUE || // Erw. Unsi
      GetHasSpellEffect(SPELL_INVISIBILITY_SPHERE, oUser) == TRUE ||   // Sphaere der Unsi
      GetHasSpellEffect(SPELL_SANCTUARY, oUser) == TRUE ||             // Heiligtum
      GetHasSpellEffect(SPELL_ETHEREALNESS, oUser) == TRUE)            // Erw. Heiligtum
  {
    SendServerMessageToPC(oUser, "Du kannst keine Edelsteine abbauen wenn du mit einem Zauber verborgen bist.");
    SetLocalInt(OBJECT_SELF, "CnrStopRapidClicks", FALSE);
    return;
  }

  int bValidTool = FALSE;
  object oChisel = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oUser);
  if (oChisel != OBJECT_INVALID)
    if (GetTag(oChisel) == "cnrGemChisel")
      bValidTool = TRUE;

  if (bValidTool == FALSE)
  {
    oChisel = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oUser);
    if (oChisel != OBJECT_INVALID)
     if (GetTag(oChisel) == "cnrGemChisel")
        bValidTool = TRUE;
  }

  if (!bValidTool)
  {
    FloatingTextStringOnCreature(CNR_TEXT_YOU_MUST_HOLD_A_CHISEL, oUser);
    SetLocalInt(OBJECT_SELF, "CnrStopRapidClicks", FALSE);
    return;
  }

  // there's a chance the chisel may break
  if (cnr_d100(1) <= CNR_FLOAT_GEM_MINING_CHISEL_BREAKAGE_PERCENTAGE)
  {
    DestroyObject(oChisel);
    FloatingTextStringOnCreature(CNR_TEXT_YOU_HAVE_BROKEN_YOUR_CHISEL, oUser);
    SetLocalInt(OBJECT_SELF, "CnrStopRapidClicks", FALSE);
    return;
  }

  location locDeposit = GetLocation(OBJECT_SELF);
  string sDepositTag = GetTag(OBJECT_SELF);

  // Sometimes the deposit will get used up
  if (cnr_d100(1) <= CNR_FLOAT_GEM_MINING_DEPOSIT_BREAKAGE_PERCENTAGE)
  {
    if (CNR_FLOAT_GEM_MINING_DEPOSIT_RESPAWN_TIME_SECS > 0.0)
        StopItFromWorking(oUser, oDeposit);
    SetLocalInt(OBJECT_SELF, "CnrStopRapidClicks", FALSE);
    return;
  }

  AssignCommand(oUser, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 3.0));
  DelayCommand(1.0, PlaySound("as_cv_chiseling2"));
  AssignCommand(oUser, DelayCommand(3.0, DoPostChiselingSuccessCheck(oUser, GetLocation(oUser), oDeposit)));
}
