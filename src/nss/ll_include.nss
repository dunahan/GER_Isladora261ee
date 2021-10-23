//::///////////////////////////////////////////////
//:: Simple Legendary Levels include file
//:://////////////////////////////////////////////
/*
  This include file controls the actual benefits that
  each class can get, if you make any changes here, make
  sure you recompile all your scripts by using the
  Build module option.
*/
//:://////////////////////////////////////////////
//:: Created By: ShaDoOoW
//:: Created On: 2008-7-17
//:: Modified by: dunahan@schwerterkueste.de
//::              for the PW Isladora@schwerterkueste.de
//:://////////////////////////////////////////////
#include "x2_inc_itemprop"
#include "x3_inc_skin"
#include "_debugisla"

const int LL_XP = 750000;                   // standard 750000
const int maxcrit = 5;                      // standard 10

//main function, use in OnClientEnter, OnRest, OnRespawn and few other occasions
void LegendaryLevelsRecalculate(object oPC);

//main function, use in spellhook script
//NOTE: this function erase any caster level and DC override that might be put on PC from earlier
//to get around that, the override has to be recalculated in the spellhook script every time
void LegendaryLevelBonusSpellhook();

//use instead of SetXP !
void SetXPImproved(object oPC, int nXpAmount);

//count creatures level by her XP
int GetLevelByXP(object oCreature);

//returns XP amount that creature has above XP required to her level
int GetXPAboveLevel(object oCreature);

//returns XP amount that is required to gain this level
int GetXPToLevel(int nLevel);

//looks after the bonus hp of a LL and reapplies them, if they are missing!
void LegendaryLevelsHeal(object oPC);

////////////////////////////////////////////////////////////////////////////////

void LegendaryLevelBonusSpellhook()
{
  SetLocalInt(OBJECT_SELF, "SPELL_CASTER_LEVEL_OVERRIDE", 0);
  SetLocalInt(OBJECT_SELF, "SPELL_DC_OVERRIDE", 0);

  int cl = GetCasterLevel(OBJECT_SELF);
  int dc = GetSpellSaveDC();
  int nRet, numLL = GetXP(OBJECT_SELF)/LL_XP;
  if (numLL > 0)
  {
    int nClass, wiz, sorc, pm, druid, cleric, bard, paladin, ranger;
    for ( ;numLL > 0;numLL--)
    {
      nClass = GetLocalInt(OBJECT_SELF,"LL_"+IntToString(numLL))-1;

      if      (nClass == CLASS_TYPE_PALADIN)    paladin++;
      else if (nClass == CLASS_TYPE_RANGER)     ranger++;
      else if (nClass == CLASS_TYPE_DRUID)      druid++;
      else if (nClass == CLASS_TYPE_CLERIC)     cleric++;
      else if (nClass == CLASS_TYPE_BARD)       bard++;
      else if (nClass == CLASS_TYPE_SORCERER)   sorc++;
      else if (nClass == CLASS_TYPE_WIZARD)     wiz++;
      else if (nClass == CLASS_TYPE_PALEMASTER) pm++;
    }

    switch (GetLastSpellCastClass())
    {
      case CLASS_TYPE_PALADIN:
        if (paladin) { cl+= paladin; nRet = TRUE; }
      break;

      case CLASS_TYPE_RANGER:
        if (ranger) { cl+= ranger; nRet = TRUE; }
      break;

      case CLASS_TYPE_BARD:
        if (bard) { cl+= bard; nRet = TRUE; }
      break;

      case CLASS_TYPE_DRUID:
        if (druid) { cl+= druid; dc+= druid; nRet = TRUE; }
      break;

      case CLASS_TYPE_CLERIC:
        if (cleric) { cl+= cleric; nRet = TRUE; }
      break;

      case CLASS_TYPE_PALEMASTER:
        if (pm) { cl+= pm; nRet = TRUE; }
      break;

      case CLASS_TYPE_SORCERER:
        if (sorc) { cl+= sorc; dc+= sorc; nRet = TRUE; }
      break;

      case CLASS_TYPE_WIZARD:
        if (wiz) { cl+= wiz; dc+= wiz; nRet = TRUE; }
      break;
    }
  }

  if (nRet)
  {
    SetLocalInt(OBJECT_SELF, "SPELL_DC_OVERRIDE", dc);
    SetLocalInt(OBJECT_SELF, "SPELL_CASTER_LEVEL_OVERRIDE", cl);
    SendServerMessageToPC(OBJECT_SELF, "LL: Boni für Zauber wurden erfolgreich aktiviert! DC = "+IntToString(dc)+", CL = "+IntToString(cl));
  }
}

void LegendaryLevelBonusWeapon(object oPC, object oWeapon)
{
  int numLL = GetXP(oPC)/LL_XP;

  if (numLL > 0)
  {
    int nClass, critic;
    for ( ;numLL > 0;numLL--)
    {
      nClass = GetLocalInt(oPC, "LL_" + IntToString(numLL)) - 1;
      if (nClass == CLASS_TYPE_WEAPON_MASTER) { critic++; }
    }

    if (critic > 0)
    {
      switch(GetBaseItemType(oWeapon))
      {
        case BASE_ITEM_BASTARDSWORD:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_BASTARDSWORD,oPC)) return; else break;
        case BASE_ITEM_BATTLEAXE:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_BATTLEAXE,oPC)) return; else break;
        case BASE_ITEM_CLUB:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_CLUB,oPC)) return; else break;
        case BASE_ITEM_DAGGER:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_DAGGER,oPC)) return; else break;
        case BASE_ITEM_DIREMACE:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_DIREMACE,oPC)) return; else break;
        case BASE_ITEM_DOUBLEAXE:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_DOUBLEAXE,oPC)) return; else break;
        case BASE_ITEM_DWARVENWARAXE:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_DWAXE,oPC)) return; else break;
        case BASE_ITEM_GREATAXE:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_GREATAXE,oPC)) return; else break;
        case BASE_ITEM_GREATSWORD:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_GREATSWORD,oPC)) return; else break;
        case BASE_ITEM_HALBERD:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_HALBERD,oPC)) return; else break;
        case BASE_ITEM_HANDAXE:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_HANDAXE,oPC)) return; else break;
        case BASE_ITEM_HEAVYFLAIL:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_HEAVYFLAIL,oPC)) return; else break;
        case BASE_ITEM_KAMA:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_KAMA,oPC)) return; else break;
        case BASE_ITEM_KATANA:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_KATANA,oPC)) return; else break;
        case BASE_ITEM_KUKRI:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_KUKRI,oPC)) return; else break;
        case BASE_ITEM_LIGHTFLAIL:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_LIGHTFLAIL,oPC)) return; else break;
        case BASE_ITEM_LIGHTHAMMER:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_LIGHTHAMMER,oPC)) return; else break;
        case BASE_ITEM_LIGHTMACE:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_LIGHTMACE,oPC)) return; else break;
        case BASE_ITEM_LONGSWORD:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_LONGSWORD,oPC)) return; else break;
        case BASE_ITEM_MORNINGSTAR:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_MORNINGSTAR,oPC)) return; else break;
        case BASE_ITEM_QUARTERSTAFF:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_QUARTERSTAFF,oPC)) return; else break;
        case BASE_ITEM_RAPIER:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_RAPIER,oPC)) return; else break;
        case BASE_ITEM_SCIMITAR:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_SCIMITAR,oPC)) return; else break;
        case BASE_ITEM_SCYTHE:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_SCYTHE,oPC)) return; else break;
        case BASE_ITEM_SHORTSPEAR:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_SHORTSPEAR,oPC)) return; else break;
        case BASE_ITEM_SHORTSWORD:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_SHORTSWORD,oPC)) return; else break;
        case BASE_ITEM_SICKLE:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_SICKLE,oPC)) return; else break;
        case BASE_ITEM_TRIDENT:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_TRIDENT,oPC)) return; else break;
        case BASE_ITEM_TWOBLADEDSWORD:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_TWOBLADEDSWORD,oPC)) return; else break;
        case BASE_ITEM_WARHAMMER:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_WARHAMMER,oPC)) return; else break;
        case BASE_ITEM_WHIP:
          if(!GetHasFeat(FEAT_WEAPON_OF_CHOICE_WHIP,oPC)) return; else break;
        default:
          return;
   }

    if(critic > maxcrit)
    {
      critic = maxcrit;
      SendServerMessageToPC(oPC,"LL: Maximum an Boni fuer massiven kritischen Schaden erreicht! Mehr als "+IntToString(maxcrit)+" sind nicht moeglich!");
    }

    AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyMassiveCritical(critic < 5 ? critic : critic + 10), oWeapon, 999999.0);
    SendServerMessageToPC(oPC,"LL: Massiver Schaden auf gewaehlte Waffe gelegt: +"+IntToString(critic)+"!");
  }
 }
}

int GetClassLegendaryLevel(object oPC, int nClass)
{
  int nLL, numLL = GetXP(oPC)/LL_XP;
  for ( ;numLL > 0;numLL--) {
    if (GetLocalInt(oPC, "LL_" + IntToString(numLL)) - 1 == nClass) {
      nLL++;
    }
  }
  return nLL;
}

void LegendaryLevelBonus(object oPC)
{
  int numLL = GetXP(oPC)/LL_XP;
  int nClass, AB, dmg, skillAll, disc, conc, ride, critic, AC, CL, DC, heal, lore, perform, saveAll, fort, ref, will, animal, spellcraft, nDC, sneak, taunt, dice;
  if (numLL > 0) {
    int nothing, lvl = numLL;
    for ( ;lvl > 0;lvl--) {
      nClass = GetLocalInt(oPC,"LL_"+IntToString(lvl))-1;

      switch(nClass) {
        case CLASS_TYPE_FIGHTER:
          AB+= 1; dmg+= 1; disc+= 1; heal+= 1; fort+= 1; //dice+= 10;
        break;

        case CLASS_TYPE_ASSASSIN:
          sneak+= 1; skillAll+= 1; ref+= 1; //dice+= 6;
        break;

        case CLASS_TYPE_ARCANE_ARCHER:
          AB+= 1; dmg+= 1; heal+= 1; ref+= 1; //dice+= 8;
        break;

        case CLASS_TYPE_BARBARIAN:
          AB+= 1; dmg+= 1; disc+= 1; fort+= 1; //dice+= 12;
        break;

        case CLASS_TYPE_RANGER:
          AB+= 1; dmg+= 1; animal+= 1; fort+= 1; //dice+= 10;
        break;

        case CLASS_TYPE_WIZARD:
          CL+= 1; DC+= 1; conc+= 1; spellcraft+= 1; will+= 1; //dice+= 4;
        break;

        case CLASS_TYPE_SORCERER:
          CL+= 1; DC+= 1; conc+= 1; spellcraft+= 1; will+= 1; //dice+= 4;
        break;

        case CLASS_TYPE_BARD:
          CL+= 1; dmg+= 1; perform+= 1; lore+= 1; ref+= 1; //dice+= 6;
        break;

        case CLASS_TYPE_DRUID:
          CL+= 1; DC+= 1; conc+= 1; animal+= 1; fort+= 1; //dice+= 8;
        break;

        case CLASS_TYPE_CLERIC:
          CL+= 1; dmg+= 1; will+= 1; conc+= 1; heal+= 1; //dice+= 8;
        break;

        case CLASS_TYPE_WEAPON_MASTER:
          AB+= 1; dmg+= 1; critic+= 1; disc+= 1; ref+= 1; //dice+= 10;
        break;

        case CLASS_TYPE_SHIFTER:
          AC+= 1; dmg+= 1; skillAll+= 1; saveAll+= 1; //dice+= 8;
        break;

        case CLASS_TYPE_BLACKGUARD:
          AB+= 1; saveAll+= 1; taunt+= 1; sneak+= 1; //dice+= 10;
        break;

        case CLASS_TYPE_PALADIN:
          AB+= 1; dmg+= 1; conc+= 1; CL+= 1; saveAll+= 1; //dice+= 10;
        break;

        case CLASS_TYPE_MONK:
          dmg+= 1; disc+= 1; conc+= 1; saveAll+= 1; //dice+= 8;
        break;

        case CLASS_TYPE_ROGUE:
          sneak+= 1; skillAll+= 1; ref+= 1; //dice+= 6;
        break;

        case CLASS_TYPE_DRAGONDISCIPLE:
          dmg+= 1; disc+= 1; lore+= 1; fort+= 1; will+= 1; //dice+= 6;
        break;

        case CLASS_TYPE_PALEMASTER:
          conc+= 1; spellcraft+= 1; CL+= 1; will+= 1; //dice+= 6;
        break;

        case CLASS_TYPE_DWARVENDEFENDER:
          AB+= 1; dmg+= 1; disc+= 1; fort+= 1; will+= 1; //dice+= 12;
        break;

        case CLASS_TYPE_HARPER:
          AC+= 1; skillAll+= 1; will+= 1; //dice+= 6;
        break;

        case CLASS_TYPE_DIVINE_CHAMPION:
          AB+= 1; dmg+= 1; saveAll+= 1; heal+= 1; //dice+= 10;
        break;

        case CLASS_TYPE_PURPLE_DRAGON_KNIGHT:
          AB+= 1; dmg+= 1; ride+= 1; fort+= 1; //dice+= 10;
        break;

        default:
          nothing++;
        break;
      }
    }

    if (nothing == numLL) {
      return;
    }

    //aplikace bonusu
    effect e;
    string sBoosty;
    if (AB) {
      e = EffectLinkEffects(e,EffectAttackIncrease(AB));
      sBoosty+= "+"+IntToString(AB)+"AB, ";
    }

    if (AC) {
      e = EffectLinkEffects(e,EffectACIncrease(AC));
      sBoosty+= "+"+IntToString(AC)+"AC, ";
    }

    if (dmg) {
      e = EffectLinkEffects(e,EffectDamageIncrease(dmg,DAMAGE_TYPE_SLASHING));
      sBoosty+= "+"+IntToString(dmg)+"DMG, ";
    }

    if (disc) {
      e = EffectLinkEffects(e,EffectSkillIncrease(SKILL_DISCIPLINE,disc));
      sBoosty+= "+"+IntToString(disc)+"disc, ";
    }

    if (conc) {
      e = EffectLinkEffects(e,EffectSkillIncrease(SKILL_CONCENTRATION,conc));
      sBoosty+= "+"+IntToString(conc)+"conc, ";
    }

    if (taunt) {
      e = EffectLinkEffects(e,EffectSkillIncrease(SKILL_TAUNT,taunt));
      sBoosty+= "+"+IntToString(taunt)+"taunt, ";
    }

    if(heal) {
      e = EffectLinkEffects(e,EffectSkillIncrease(SKILL_HEAL,heal));
      sBoosty+= "+"+IntToString(heal)+"heal, ";
    }

    if (spellcraft) {
      e = EffectLinkEffects(e,EffectSkillIncrease(SKILL_SPELLCRAFT,spellcraft));
      sBoosty+= "+"+IntToString(spellcraft)+"spellcraft, ";
    }

    if (lore) {
      e = EffectLinkEffects(e,EffectSkillIncrease(SKILL_LORE,lore));
      sBoosty+= "+"+IntToString(lore)+"lore, ";
    }

    if (ride) {
      e = EffectLinkEffects(e,EffectSkillIncrease(SKILL_RIDE,ride));
      sBoosty+= "+"+IntToString(ride)+"ride, ";
    }

    if (perform) {
      e = EffectLinkEffects(e,EffectSkillIncrease(SKILL_PERFORM,perform));
      sBoosty+= "+"+IntToString(perform)+"perform, ";
    }

    if(skillAll) {
      e = EffectLinkEffects(e,EffectSkillIncrease(SKILL_ALL_SKILLS,skillAll));
      sBoosty+= "+"+IntToString(skillAll)+"skills, ";
    }

    if (fort) {
      e = EffectLinkEffects(e,EffectSavingThrowIncrease(SAVING_THROW_FORT,fort));
      sBoosty+= "+"+IntToString(fort)+"fort, ";
    }

    if (ref) {
      e = EffectLinkEffects(e,EffectSavingThrowIncrease(SAVING_THROW_REFLEX,ref));
      sBoosty+= "+"+IntToString(ref)+"ref, ";
    }

    if (will) {
      e = EffectLinkEffects(e,EffectSavingThrowIncrease(SAVING_THROW_WILL,will));
      sBoosty+= "+"+IntToString(will)+"will, ";
    }

    if (saveAll) {
      e = EffectLinkEffects(e,EffectSavingThrowIncrease(SAVING_THROW_ALL,saveAll));
      sBoosty+= "+"+IntToString(saveAll)+"saves, ";
    }

    if (sneak) {
      sBoosty+= "+"+IntToString(sneak)+"d6 sneak, ";
      object oSkin = SKIN_SupportGetSkin(oPC);
      int nFeat;
      int improvedSneak = GetHasFeat(FEAT_EPIC_IMPROVED_SNEAK_ATTACK_1,oPC);
      int nRogue = GetLevelByClass(CLASS_TYPE_ROGUE,oPC);
          nRogue = (nRogue+1)/2;
      int nBG = GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC);
          nBG = (nBG-1)/3;
      int zbyva;

      if      (!nBG) {
        nFeat = 79+sneak-1;
      }
      else if (!nRogue) {
        nFeat = 50+sneak-1;
      }
      else if (!improvedSneak) {
        nFeat = 933+sneak-1;
      }
      else {
        SendServerMessageToPC(oPC,"LL: Fehler, kann Hinterhaeltiger Angriff nicht addieren. Bitte SL informieren!");
      }

      if (nFeat) {
        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusFeat(nFeat),oSkin);
      }
    }

    if (critic) {
      object rWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
      if (GetIsObjectValid(rWeapon)) {
        LegendaryLevelBonusWeapon(oPC,rWeapon);
      }
      object lWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
      if (GetIsObjectValid(lWeapon)) {
        LegendaryLevelBonusWeapon(oPC,lWeapon);
      }
    }

    if (CL) { }

    if (DC) { }

    // add hp for isla
    /*if (dice) {
      e = EffectTemporaryHitpoints(dice);
      sBoosty+= "+"+IntToString(dice)+"temp HP, ";

      SetCampaignInt("LL", GetName(oPC)+"_"+"HP", dice);

      SendServerMessageToPC(oPC,"LL: Achtung, Du kannst keine temporaeren TP durch Rasten oder Heilen wieder zurueck erhalten!");
    }*/

    sBoosty = GetStringLeft(sBoosty, GetStringLength(sBoosty)-2);
    e = SupernaturalEffect(e);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,e,oPC);
    SendServerMessageToPC(oPC,"LL: Basis-Boni erfolgreich gesetzt: "+sBoosty);
  }
}
/*
void LegendaryLevelsTempHP(object oPC)
{
  int dice = 10, numLL = GetXP(oPC)/LL_XP;
  effect e;

  if (LL_XP > 1) {
    e = EffectTemporaryHitpoints(dice * LL_XP);

    SetCampaignInt("LL", GetName(oPC)+"_"+IntToString(numLL), dice);
    //SendServerMessageToPC(oPC,"LL: Achtung, Du kannst keine temporaeren TP durch Rasten oder Heilen wieder zurueck erhalten!");
  }

  if (GetCurrentHitPoints(oPC) <= GetMaxHitPoints(oPC)) {
    e = SupernaturalEffect(e);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, e, oPC);
  }
}

void LegendaryLevelsHeal(object oPC)
{
  int numLL = GetXP(oPC)/LL_XP;

  int dice = getCampaignInt("LL", GetName(oPC)+"_"+"HP");
  effect e;

  if (GetCurrentHitPoints(oPC) == GetMaxHitPoints(oPC))
  {
    e = EffectTemporaryHitpoints(dice);
    e = SupernaturalEffect(e);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, e, oPC);
  }
}
*/
void LegendaryLevelsRecalculate(object oPC)
{
  if (!GetLocalInt(oPC, "LL_INITIALIZED")) //first login this game session
  {
    SetLocalInt(oPC, "LL_INITIALIZED", TRUE);
    int nActXP = GetXP(oPC), numLL;

    if (nActXP != 40)   numLL = nActXP/LL_XP;   // to get around the "FEHLER: DIVISION DURCH NULL" error?
    else                return;                 // so theres no xp on the char, no legendary level achieved

    if (numLL > 0) {
      int nClass;

      for ( ; numLL > 0; numLL--) {
        nClass = GetCampaignInt("LL",GetName(oPC)+"_"+IntToString(numLL));
        GetCampaignInt("LL",GetName(oPC)+"_"+IntToString(numLL));

        SetLocalInt(oPC, "LL_"+IntToString(numLL), nClass); //store data from database as local for easier access
      }
    }
  }

  object oCreator = GetObjectByTag("LL_SETUP");
  if (GetIsObjectValid(oCreator)) {
    effect eSearch = GetFirstEffect(oPC);
    while (GetIsEffectValid(eSearch)) {
      if (GetEffectCreator(eSearch) == oCreator) {
        RemoveEffect(oPC,eSearch);
      }
      eSearch = GetNextEffect(oPC);
    }
  }

  object oSkin = SKIN_SupportGetSkin(oPC);
  //clean all itemproperties on a PC skin
  itemproperty ip = GetFirstItemProperty(oSkin);
  while (GetIsItemPropertyValid(ip)) {
    RemoveItemProperty(oSkin,ip);
    ip = GetNextItemProperty(oSkin);
  }

    //clean temporary massive criticals from the weapons
  object rWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
  if (GetIsObjectValid(rWeapon)) {
    itemproperty ip = GetFirstItemProperty(rWeapon);
    while (GetIsItemPropertyValid(ip)) {
      if (GetItemPropertyDurationType(ip) == DURATION_TYPE_TEMPORARY && GetItemPropertyType(ip) == ITEM_PROPERTY_MASSIVE_CRITICALS) {
        RemoveItemProperty(rWeapon,ip);
      }

      ip = GetNextItemProperty(rWeapon);
    }
  }

  object lWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
  if (GetIsObjectValid(lWeapon) && IPGetIsMeleeWeapon(lWeapon)) {
    itemproperty ip = GetFirstItemProperty(lWeapon);
      while (GetIsItemPropertyValid(ip)) {
      if (GetItemPropertyDurationType(ip) == DURATION_TYPE_TEMPORARY && GetItemPropertyType(ip) == ITEM_PROPERTY_MASSIVE_CRITICALS) {
        RemoveItemProperty(lWeapon,ip);
      }

      ip = GetNextItemProperty(lWeapon);
    }
  }

  AssignCommand(oCreator, LegendaryLevelBonus(oPC));
}

void SetXPImproved(object oPC, int nXpAmount)
{
  int preLvL = GetHitDice(oPC);
  int preXP = GetXP(oPC);
  if (nXpAmount < 1) {
    nXpAmount = 1;
  }

  SetXP(oPC, nXpAmount);
  preXP/= LL_XP;
  nXpAmount/= LL_XP;

  if (nXpAmount < preXP) {
    //OnLegendaryLevelDown event
    for ( ;preXP > nXpAmount;preXP--) {
      SetLocalInt(oPC,"LL_"+IntToString(preXP),0);//delete lost legendary levels
      SetCampaignInt("LL",GetName(oPC)+"_"+IntToString(preXP),0);
    }

    LegendaryLevelsRecalculate(oPC);
  }

  else if (nXpAmount > preXP) {
    //OnLegendaryLevelUp event
    while (nXpAmount-- > preXP) {
      AssignCommand(oPC, PlaySound("gui_level_up"));
      SendMessageToPCByStrRef(oPC, 8302); //Your character has gained enough experience to advance a level.
    }
  }

  //OnLevelDown event
  if(preLvL > GetHitDice(oPC)) {
    //do stuff
  }
}

int GetLevelByXP(object oCreature)
{
  int nLevel = FloatToInt(0.5+sqrt(0.25+(IntToFloat(GetXP(oCreature))/500)));
  if(nLevel>40) {
    nLevel = 40;
  }
  return nLevel;
}

int GetHasAssociate(int nAssociateType, object oMaster=OBJECT_SELF)
{
  return GetIsObjectValid(GetAssociate(nAssociateType,oMaster));
}

int GetXPAboveLevel(object oCreature)
{
  return GetXP(oCreature)-GetXPToLevel(GetLevelByXP(oCreature));
}

int GetXPToLevel(int nLevel)
{
  return --nLevel<1 ? 0 : (nLevel+1)*nLevel*500;
}
