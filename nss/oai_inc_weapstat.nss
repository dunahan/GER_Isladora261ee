////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI - Weapon Types Include File
//  oai_inc_weapstat
//
//  This works for Bioware and ANY Weapon Hak!!
//  Completely Rewritten for OAI by David Kelly
//
//  Copy this into any Scripts that need Weapon Types or Info
//  #include "oai_inc_weapstat"
/*
    Routines to get weapon stats
    Implements an on demand cache for weapon stats from 2DA to local variables

    Cache Table is "OAI_CWS_" prefix to variable name (can be chanhed below)
    Uses "OAI_CWS_Category" as the index to determine if cache values are loaded
    (so "OAI_CWS_Category0" would hold the Category of a short sword)
    Loads all variables (tracked) for the requested base item type from the
    baseitems.2da per when first required.
    Nb! So far only get Int values (through need, will impliment strings later if required)
*/
//:://////////////////////////////////////////////
//:: Created By: David Kelly
//:: Created On: 26-Dec-2005
//:: Updated By: Olander
//:://////////////////////////////////////////////

#include "x2_inc_itemprop"

const string OAI_CACHEPREFIX = "OAI_CSW_";  // Prefix for cahce variables
const int OAI_CACHENULL = -99;  // Value which means has no value (caution, CAN NOT BE zero)

// Tracked variables
const string OAI_STAT_CATEGORY      = "Category";
const string OAI_STAT_WEAPONSIZE    = "WeaponSize";
const string OAI_STAT_WEAPONTYPE    = "WeaponType";
const string OAI_STAT_BASEAMMO      = "BaseAmmo";
const string OAI_STAT_MAXDAMAGE     = "MaxDamage";
const string OAI_STAT_REQFEAT       = "ReqFeat";

// Fixed flags for Feat Mask
// Bit mask: 1E,2M,4S,8D,16Mo,32R,64MU,128Elf,256C
const int OAI_MASK_EXOTIC   = 0x0001;
const int OAI_MASK_MARTIAL  = 0x0002;
const int OAI_MASK_SIMPLE   = 0x0004;
const int OAI_MASK_DRUID    = 0x0008;
const int OAI_MASK_MONK     = 0x0010;
const int OAI_MASK_ROGUE    = 0x0020;
const int OAI_MASK_MU       = 0x0040;
const int OAI_MASK_ELF      = 0x0080;
const int OAI_MASK_CREATURE = 0x0100;

struct OAIWeapon
{
    int nBaseType;      // Weapons BaseType
    int nCategory;      // 1 melee, 2 bows, 3 shield, 6 ammo, 7 thrown
    int nWeaponSize;    // 1 tiny, 2 small, 3 medium, 4 large
    int nWeaponType;    // 1 pierce, 2 crush, 3 slash, 4 slash/pierce, 5 crush/pierce
    int nBaseAmmo;      // nBaseType of ammo (self for thrown)
    int nMaxDamage;     // Maximum damage not counting criticals
    int nReqFeat;       // 1 Exotic, 2 martial, 4 simple, 8 druid, 16 monk,
                        // 32 rogue, 64 MU, 128 elf, 256 creature (as Bit Mask)
};

// Routine to get weapon stats structure for given weapon
struct OAIWeapon OAI_GetWeaponStats(object oItem);

// Gets required weapon stat, from cache if available
// if not chache will be loaded first and then used
int OAI_GetWeaponStat(object oItem, string sStat);

// Converts 2DA Feat reference to Feat Bit Mask value
int OAI_FeatToMask(string sFeat);

// Generate the FeatMask for the given creature
int OAI_GetFeatMask(object oMon);

int OAI_GetFeatMask(object oMon)
{
    int class, pos, mask = 0;

    if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE))
        mask += OAI_MASK_SIMPLE;
    if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL))
        mask += OAI_MASK_MARTIAL;
    if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC))
        mask += OAI_MASK_EXOTIC;

    for (pos = 1; pos <= 3; pos++)
        switch (GetClassByPosition(pos, oMon))
        {
            case CLASS_TYPE_DRUID: mask += OAI_MASK_DRUID; break;
            case CLASS_TYPE_MONK: mask += OAI_MASK_MONK; break;
            case CLASS_TYPE_ROGUE: mask += OAI_MASK_ROGUE; break;
            case CLASS_TYPE_SORCERER:
            case CLASS_TYPE_WIZARD:
                mask += OAI_MASK_MU; break;
        }

    if (GetRacialType(oMon) == RACIAL_TYPE_ELF)
        mask += OAI_MASK_ELF;

    return mask;
}

/*
 * If using 2DA references
 */
int OAI_FeatToMask(string sFeat)
{
    int nFeat = StringToInt(sFeat);
    int nMask;

    switch (nFeat)
    {
        case  44: nMask = OAI_MASK_EXOTIC; break;   // Exotic
        case  45: nMask = OAI_MASK_MARTIAL; break;  // Martial
        case  46: nMask = OAI_MASK_SIMPLE; break;   // Simple
        case  48: nMask = OAI_MASK_DRUID; break;    // Druid
        case  49: nMask = OAI_MASK_MONK; break;     // Monk
        case  50: nMask = OAI_MASK_ROGUE; break;    // Rogue
        case  51: nMask = OAI_MASK_ELF; break;      // MU
        case 255: nMask = OAI_MASK_CREATURE; break; // Creature
        default: nMask = 0;
    }

    return nMask;
}

int OAI_GetWeaponStat(object oItem, string sStat)
{
    object oMod = GetModule();
    int nBaseType = GetBaseItemType(oItem);
    string sBaseType = IntToString(nBaseType);
    int nValue = GetLocalInt(oMod, OAI_CACHEPREFIX + OAI_STAT_CATEGORY + sBaseType);

    // Values not loaded yet
    if (nValue == 0)
    {
        int nLoop;

        // Load Cache
        nValue = StringToInt(Get2DAString("baseitems", "Category", nBaseType));
        if (nValue == 0)
            nValue = OAI_CACHENULL;     // NOT ALLOWED to be zero
        SetLocalInt(oMod, OAI_CACHEPREFIX + OAI_STAT_CATEGORY + sBaseType, nValue);

        // Weapon Size and Type and AMmotype are straight forward
        nValue = StringToInt(Get2DAString("baseitems", "WeaponSize", nBaseType));
        if (nValue)
            SetLocalInt(oMod, OAI_CACHEPREFIX + OAI_STAT_WEAPONSIZE + sBaseType, nValue);
        nValue = StringToInt(Get2DAString("baseitems", "WeaponType", nBaseType));
        if (nValue)
            SetLocalInt(oMod, OAI_CACHEPREFIX + OAI_STAT_WEAPONTYPE + sBaseType, nValue);
        nValue = StringToInt(Get2DAString("baseitems", "RangedWeapon", nBaseType));
        if (nValue)
            SetLocalInt(oMod, OAI_CACHEPREFIX + OAI_STAT_BASEAMMO + sBaseType, nValue);

        // Max Damge is a calculation
        nValue = StringToInt(Get2DAString("baseitems", "NumDice", nBaseType)) *
                 StringToInt(Get2DAString("baseitems", "DieToRoll", nBaseType));
        if (nValue)
            SetLocalInt(oMod, OAI_CACHEPREFIX + OAI_STAT_MAXDAMAGE + sBaseType, nValue);

        // Feats are mapped onto the bit mask values and stored as a single number
        nValue = 0;
        for (nLoop = 0; nLoop <= 4; nLoop++)
            nValue += OAI_FeatToMask(Get2DAString("baseitems", "ReqFeat" + IntToString(nLoop), nBaseType));
        if (nValue)
            SetLocalInt(oMod, OAI_CACHEPREFIX + OAI_STAT_REQFEAT + sBaseType, nValue);
    }

    // Return required result
    return GetLocalInt(oMod, OAI_CACHEPREFIX + sStat + sBaseType);
}

struct OAIWeapon OAI_GetWeaponStats(object oItem)
{
    object oMod = GetModule();
    struct OAIWeapon ow;
    string sBT;

    ow.nBaseType = GetBaseItemType(oItem);
    ow.nCategory = OAI_GetWeaponStat(oItem, OAI_STAT_CATEGORY); // Force cache to load if necessary
    sBT = IntToString(ow.nBaseType);
    ow.nWeaponSize = GetLocalInt(oMod, OAI_CACHEPREFIX + OAI_STAT_WEAPONSIZE + sBT);
    ow.nWeaponType = GetLocalInt(oMod, OAI_CACHEPREFIX + OAI_STAT_WEAPONTYPE + sBT);
    ow.nBaseAmmo = GetLocalInt(oMod, OAI_CACHEPREFIX + OAI_STAT_BASEAMMO + sBT);
    ow.nMaxDamage = GetLocalInt(oMod, OAI_CACHEPREFIX + OAI_STAT_MAXDAMAGE + sBT);
    ow.nReqFeat = GetLocalInt(oMod, OAI_CACHEPREFIX + OAI_STAT_REQFEAT + sBT);

    return ow;
}

int IsWeapon(object oWeapon)
{
    if (!GetIsObjectValid(oWeapon))
        return FALSE;

    switch (OAI_GetWeaponStat(oWeapon, OAI_STAT_CATEGORY))
    {
        case 1: // Melee
        case 2: // Bows
        case 7: // Thrown
            return TRUE;
    }

    return FALSE;
}
int IsMeleeWeapon(object oWeapon)
{
    if (!GetIsObjectValid(oWeapon))
        return FALSE;

    return OAI_GetWeaponStat(oWeapon, OAI_STAT_CATEGORY) == 1;
}

int IsRangedWeapon(object oWeapon)
{
    if (!GetIsObjectValid(oWeapon))
        return FALSE;

    return OAI_GetWeaponStat(oWeapon, OAI_STAT_BASEAMMO) > 0;
}

int IsCrossbow(object oWeapon)
{
    int nType = GetBaseItemType(oWeapon);
    switch (nType)
    {
      case BASE_ITEM_HEAVYCROSSBOW:
      case BASE_ITEM_LIGHTCROSSBOW:
      return TRUE;
    }
    return FALSE;
}

int IsBow(object oWeapon)
{
    int nType = GetBaseItemType(oWeapon);
    switch (nType)
    {
      case BASE_ITEM_LONGBOW:
      case BASE_ITEM_SHORTBOW:
      return TRUE;
    }
    return FALSE;
}

int IsSling(object oWeapon)
{
    int nType = GetBaseItemType(oWeapon);
    switch (nType)
    {
      case BASE_ITEM_SLING:
      return TRUE;
    }
    return FALSE;
}

int IsLightMeleeWeapon(object oWeapon, int nSize=0)
{
    if (!GetIsObjectValid(oWeapon))
        return FALSE;

    if (nSize == 0)
        nSize = GetCreatureSize(OBJECT_SELF);

    return OAI_GetWeaponStat(oWeapon, OAI_STAT_CATEGORY) == 1 &&
           OAI_GetWeaponStat(oWeapon, OAI_STAT_WEAPONSIZE) < nSize;
}

int IsMediumMeleeWeapon(object oWeapon, int nSize=0)
{
    if (!GetIsObjectValid(oWeapon))
        return FALSE;

    if (nSize == 0)
        nSize = GetCreatureSize(OBJECT_SELF);

    return OAI_GetWeaponStat(oWeapon, OAI_STAT_CATEGORY) == 1 &&
           OAI_GetWeaponStat(oWeapon, OAI_STAT_WEAPONSIZE) == nSize;
}

int IsHeavyMeleeWeapon(object oWeapon, int nSize=0)
{
    if (!GetIsObjectValid(oWeapon))
        return FALSE;

    if (nSize == 0)
        nSize = GetCreatureSize(OBJECT_SELF);

    return OAI_GetWeaponStat(oWeapon, OAI_STAT_CATEGORY) == 1 &&
           OAI_GetWeaponStat(oWeapon, OAI_STAT_WEAPONSIZE) > nSize;
}

// now returns weapon size when can be weilding single handed by calling creature
int IsSingleHandedMeleeWeapon(object oWeapon, int nSize=0)
{
    return IsMediumMeleeWeapon(oWeapon, nSize);
}

void SetRacialMovementRate(object oCreature)
{
  //For HCR Systems
  //ExecuteScript("hc_armor_encum", oCreature);

  if(GetLocalInt(oCreature, "RACIAL_MOVEMENT") == 1) return;

  int nRACIALMOVE = GetLocalInt(GetModule(),"RACIALMOVE");
  if(nRACIALMOVE == 0) return;

  int nType = GetRacialType(oCreature);
  if(nType == RACIAL_TYPE_ANIMAL
    || nType == RACIAL_TYPE_BEAST
    || nType == RACIAL_TYPE_DRAGON
    || nType == RACIAL_TYPE_MAGICAL_BEAST
    || nType == RACIAL_TYPE_VERMIN)
    return;

  if(GetCreatureSize(oCreature) == CREATURE_SIZE_SMALL || nType == RACIAL_TYPE_DWARF)
  {
    int nSCMR = GetLocalInt(GetModule(),"SML_CREATURE_MOVEPEN");

    effect eRate = SupernaturalEffect(EffectMovementSpeedDecrease(nSCMR));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eRate, oCreature);
    SetLocalInt(oCreature, "RACIAL_MOVEMENT", 1);
    return;
  }
}

void OAI_UpgradeMeleeWeapon(object oWeapon)
{
  //No Need to Upgrade If Already Enhanced
  if(GetItemHasItemProperty(oWeapon, ITEM_PROPERTY_ENHANCEMENT_BONUS)) return;
  if(GetItemHasItemProperty(oWeapon, ITEM_PROPERTY_ATTACK_BONUS)) return;

  object oMod = GetModule();

  int nMelee = GetLocalInt(oMod,"OAIUPGRADE_MELEE");
  int nNames = GetLocalInt(oMod,"OAIUPGRADE_NAMES");
  int nBonus = GetLocalInt(oMod,"OAI_ABEB_BONUS");
  int nKeen = GetLocalInt(oMod,"OAI_KEEN_BONUS");
  int nCrit = GetLocalInt(oMod,"OAI_CRIT_BONUS");


  //Add Enhancement Bonus
  if(nMelee == 1)
  {
    int nAB = Random(nBonus)+1;
    IPSafeAddItemProperty(oWeapon, ItemPropertyEnhancementBonus(nAB), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);


    //Add Keen 50% of the Time
    if(nKeen == 1 && d2(1) == 1) IPSafeAddItemProperty(oWeapon, ItemPropertyKeen(), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

    //Add Mass Crits
    int nMass = Random(nCrit)+1;
    int nAdd = IP_CONST_DAMAGEBONUS_1d4;
    if(nMass > 9) nAdd = IP_CONST_DAMAGEBONUS_2d12;
    else
    {
      switch(nMass)
      {
        case 1: nAdd = IP_CONST_DAMAGEBONUS_1d4; break;
        case 2: nAdd = IP_CONST_DAMAGEBONUS_1d6; break;
        case 3: nAdd = IP_CONST_DAMAGEBONUS_1d8; break;
        case 4: nAdd = IP_CONST_DAMAGEBONUS_2d4; break;
        case 5: nAdd = IP_CONST_DAMAGEBONUS_1d10; break;
        case 6: nAdd = IP_CONST_DAMAGEBONUS_1d12; break;
        case 7: nAdd = IP_CONST_DAMAGEBONUS_2d6; break;
        case 8: nAdd = IP_CONST_DAMAGEBONUS_2d8; break;
        case 9: nAdd = IP_CONST_DAMAGEBONUS_2d10; break;
        case 10: nAdd = IP_CONST_DAMAGEBONUS_2d12; break;
      }
    }

    //50% of the Time
    if(nCrit > 0 && d2(1) == 1) IPSafeAddItemProperty(oWeapon, ItemPropertyMassiveCritical(nAdd), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

    if(nNames == 1)
    {
      string sName = GetName(oWeapon);

      string sQuality = "Quality ";
      string sJourneyman = "Journeyman ";
      string sMasterful = "Masterful ";
      string sArtisan = "Artisan ";
      string sLegendary = "Legendary ";

      string sNewName;

      if(nAB == 1) sNewName = sQuality + sName;
      if(nAB == 2) sNewName = sJourneyman + sName;
      if(nAB == 3) sNewName = sMasterful + sName;
      if(nAB == 4) sNewName = sArtisan + sName;
      if(nAB >= 5) sNewName = sLegendary + sName;

      SetLocalInt(oWeapon,"NOENCHANT",1);
      SetName(oWeapon,sNewName);
    }
  }

  //Set as Stolen
  SetStolenFlag(oWeapon,TRUE);
}

void OAI_UpgradeRangedWeapon(object oWeapon)
{
  //No Need to Upgrade If Already Enhanced
  if(GetItemHasItemProperty(oWeapon, ITEM_PROPERTY_ENHANCEMENT_BONUS)) return;
  if(GetItemHasItemProperty(oWeapon, ITEM_PROPERTY_ATTACK_BONUS)) return;

  object oMod = GetModule();

  int nRanged = GetLocalInt(oMod,"nOAIUPGRADE_RANGED");
  int nNames = GetLocalInt(oMod,"OAIUPGRADE_NAMES");
  int nBonus = GetLocalInt(oMod,"OAI_ABEB_BONUS");
  int nMighty = GetLocalInt(oMod,"nOAI_MIGHTY_BONUS");

  //Add Attack Bonus
  if(nRanged == 1)
  {
    int nAB = Random(nBonus)+1;
    IPSafeAddItemProperty(oWeapon, ItemPropertyAttackBonus(nAB), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

    //Add Mighty 50% of the Time
    int nSTR = Random(nMighty)+1;
    if(nMighty > 0 && d2(1) == 1) IPSafeAddItemProperty(oWeapon, ItemPropertyMaxRangeStrengthMod(nSTR), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

    if(nNames == 1)
    {
      string sName = GetName(oWeapon);

      string sQuality = "Quality ";
      string sJourneyman = "Journeyman ";
      string sMasterful = "Masterful ";
      string sArtisan = "Artisan ";
      string sLegendary = "Legendary ";

      string sNewName;

      if(nAB == 1) sNewName = sQuality + sName;
      if(nAB == 2) sNewName = sJourneyman + sName;
      if(nAB == 3) sNewName = sMasterful + sName;
      if(nAB == 4) sNewName = sArtisan + sName;
      if(nAB >= 5) sNewName = sLegendary + sName;

      SetLocalInt(oWeapon,"NOENCHANT",1);
      SetName(oWeapon,sNewName);
    }
  }

  //Set as Stolen
  SetStolenFlag(oWeapon,TRUE);
}

void OAI_UpgradeArmor(object oArmor)
{
  //No Need to Upgrade If Already Enhanced
  if(GetItemHasItemProperty(oArmor, ITEM_PROPERTY_AC_BONUS)) return;

  object oMod = GetModule();

  int nArmor = GetLocalInt(oMod,"nOAIUPGRADE_ARMOR");
  int nNames = GetLocalInt(oMod,"OAIUPGRADE_NAMES");
  int nBonus = GetLocalInt(oMod,"nOAI_ACMAX");

  int nAC = Random(nBonus)+1;
  if(nArmor == 1)IPSafeAddItemProperty(oArmor, ItemPropertyACBonus(nAC), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

  //Set as Stolen
  SetStolenFlag(oArmor,TRUE);
}

//void main(){}

