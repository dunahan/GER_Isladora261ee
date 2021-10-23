#include "NW_I0_GENERIC"
#include "shifter_pow"
#include "_debugisla"

/*

Masters of the Wild PNP Shifter Rules
level   sizes       creature types
1       S,M         humanoid
2                   animal, monsterous
3       L,T         beast, plant
4                   giant, vermin
5       D           magical
6                   aberrant, ooze
7       H           dragon
8                   undead, construct
9       F           elemental, outsider
10      G

*/

// for easier translating added those constants
const string SHIFTER_NEWFORMS = "Nutze das Wandlerwerkzeug um neue Formen zu erlernen.";
const string SHIFTER_TRUEFORM = "Wahre Form wieder hergestellt.";
const string SHIFTER_FORGFORM = "Wandlerform vergessen.";
const string SHIFTER_ITMTITLE = "Wandlerform: ";
const string SHIFTER_SUCLEARN = " wurde erfolgreich studiert.";
const string SHIFTER_TYPETARG = "Typ des Ziels: ";
const string SHIFTER_NOTALLOW = "Du kannst diesen Gegenstand nicht nutzen.";

int IsDruidOrShifter(object oMimic)
{
    int iDruidShifterLevels = GetLevelByClass(CLASS_TYPE_DRUID,oMimic)+GetLevelByClass(CLASS_TYPE_SHIFTER, oMimic);

    if (iDruidShifterLevels <= 0)
    {
        DebugMode("No druid/shifter.");
        return FALSE;
    }
    else
    {
        DebugMode("Druid/shifter levels found.");
        return TRUE;
    }
}

int AllowMimic(object oMimic, object oMimicTarget)
{
    //string sMimicTargetName = GetName(oMimicTarget);
    string sMimicTargetName = GetResRef(oMimicTarget);
    int iDruidShifterLevels = GetLevelByClass(CLASS_TYPE_DRUID,oMimic)+GetLevelByClass(CLASS_TYPE_SHIFTER, oMimic);
    int iNotToMimic = GetLocalInt(oMimicTarget, "NotMimic");
    if (GetObjectType(oMimicTarget) != OBJECT_TYPE_CREATURE)
        {SendServerMessageToPC(oMimic,"Das Ziel muss eine Kreatur sein."); return FALSE;}
    //if (MimicDynamicRestricted) //Base PC races too complex for quick shifting
    if (IsDynamic(GetAppearanceType(oMimicTarget)))
        {SendServerMessageToPC(oMimic,"Das Ziel beistzt keine klare Form um studiert zu werden."); return FALSE;}
    if (MimicGenderRestricted) if ((GetGender(oMimic)!=GetGender(oMimicTarget)))
        {SendServerMessageToPC(oMimic,"Wandlerform besitzt das falsche Geschlecht."); return FALSE;}
    if ((MimicBlockBoss) && ((FindSubString(sMimicTargetName,"boss")!=-1)
    ||(FindSubString(sMimicTargetName,"Boss")!=-1)||(FindSubString(sMimicTargetName,"BOSS")!=-1)))
        {SendServerMessageToPC(oMimic,"Wandlerform kann nicht studiert werden."); return FALSE;}
    if (MimicPlotRestricted) if (GetPlotFlag(oMimicTarget))
        {SendServerMessageToPC(oMimic,"Wandlerform kann nicht studiert werden."); return FALSE;}
    if (MimicPCRestricted) if (GetIsPC(oMimicTarget))
        {SendServerMessageToPC(oMimic,"Wandlerform kann nicht studiert werden."); return FALSE;}
    if (MimicDMRestricted) if (GetIsDM(oMimicTarget))
        {SendServerMessageToPC(oMimic,"Wandlerform kann nicht studiert werden."); return FALSE;}
    if (MimicDMPosessedRestricted) if (GetIsDMPossessed(oMimicTarget))
        {SendServerMessageToPC(oMimic,"Wandlerform kann nicht studiert werden."); return FALSE;}
    if (iNotToMimic == 1)
        {SendServerMessageToPC(oMimic,"Wandlerform kann nicht studiert werden."); return FALSE;}
    if (GetHasEffect(EFFECT_TYPE_AC_INCREASE, oMimicTarget)) // to prevent exploits
        {SendServerMessageToPC(oMimic,"Ziel ist magisch geschützt."); return FALSE;}
    if (MimicRequireNWNFeats) if (!(MimicNWNFeatCheck(oMimic, oMimicTarget)))
        {SendServerMessageToPC(oMimic,"Ein Talent wird für diese Wandlerform benötigt."); return FALSE;}
    if (MimicHitDiceRestricted) if ((GetHitDice(oMimic)<GetHitDice(oMimicTarget)))
        {SendServerMessageToPC(oMimic,"Zu niedrigere Stufe für diese Wandlerform."); return FALSE;}
    if (MimicDruidShifterLevelOnly) if ((iDruidShifterLevels)<GetHitDice(oMimicTarget))
        {SendServerMessageToPC(oMimic,"Zu niedrigere Stufe für diese Wandlerform."); return FALSE;}
    if (MimicUsePNPRaceRules) if (!(MimicRaceCheckPNP(oMimic, oMimicTarget)))
        {SendServerMessageToPC(oMimic,"Zu niedrigere Stufe für diese Wandlerform."); return FALSE;}
    if (MimicUsePNPSizeRules) if ((!(MimicSizeCheckPNP(oMimic, oMimicTarget))))
        {SendServerMessageToPC(oMimic,"Zu niedrigere Stufe für diese Wandlerform."); return FALSE;}
    return TRUE;
}

void ResetAppearance(object ItemOwner)
{
    if (MimicVFX!=FALSE) ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(MimicVFX), ItemOwner);
    SetLocalString(ItemOwner,"CREATURE_RESREF","");
    if (GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,ItemOwner)>8)
        SetCreatureWingType(CREATURE_WING_TYPE_DRAGON,ItemOwner);
    else
        SetCreatureWingType(0,ItemOwner);

    SetCreatureTailType(0,ItemOwner);

    DestroyObject(GetItemInSlot(INVENTORY_SLOT_CARMOUR,ItemOwner));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,ItemOwner));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,ItemOwner));
    DestroyObject(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B,ItemOwner));

    DestroyObject(GetItemPossessedBy(ItemOwner,MimicHideTag));
    DestroyObject(GetItemPossessedBy(ItemOwner,MimicHideTemplate));
    DestroyObject(GetItemPossessedBy(ItemOwner,MimicLeftTag));
    DestroyObject(GetItemPossessedBy(ItemOwner,MimicRightTag));
    DestroyObject(GetItemPossessedBy(ItemOwner,MimicBiteTag));

    object RemovePowerItem = (GetFirstItemInInventory(ItemOwner));
    while (RemovePowerItem != OBJECT_INVALID)
    {
        if (GetTag(RemovePowerItem)==MimicPowerTag) DestroyObject(RemovePowerItem);
        RemovePowerItem = GetNextItemInInventory(ItemOwner);
    }

    switch(GetRacialType(ItemOwner))
    {
        case RACIAL_TYPE_DWARF : SetCreatureAppearanceType(ItemOwner,APPEARANCE_TYPE_DWARF); break;
        case RACIAL_TYPE_ELF : SetCreatureAppearanceType(ItemOwner,APPEARANCE_TYPE_ELF); break;
        case RACIAL_TYPE_GNOME : SetCreatureAppearanceType(ItemOwner,APPEARANCE_TYPE_GNOME); break;
        case RACIAL_TYPE_HALFELF : SetCreatureAppearanceType(ItemOwner,APPEARANCE_TYPE_HALF_ELF); break;
        case RACIAL_TYPE_HALFLING : SetCreatureAppearanceType(ItemOwner,APPEARANCE_TYPE_HALFLING); break;
        case RACIAL_TYPE_HALFORC : SetCreatureAppearanceType(ItemOwner,APPEARANCE_TYPE_HALF_ORC); break;
        case RACIAL_TYPE_HUMAN : SetCreatureAppearanceType(ItemOwner,APPEARANCE_TYPE_HUMAN); break;
    }
    //Add subrace engine reset hooks here
}

// Saves Target's Data on Item
void SaveParts(object oSaveTarget, object oSaveDataItem)
{
    int iSaveAppearance = GetAppearanceType(oSaveTarget);
    SetLocalInt(oSaveDataItem,"CREATURE_APPEARANCE",iSaveAppearance);
    SetLocalString(oSaveDataItem,"CREATURE_RESREF",GetResRef(oSaveTarget));
    SetLocalString(oSaveDataItem,"CREATURE_NAME",GetName(oSaveTarget));
    SetLocalInt(oSaveDataItem,"CREATURE_RACE",GetRacialType(oSaveTarget));

    SetLocalInt(oSaveDataItem,"CREATURE_PART_WING",GetCreatureWingType(oSaveTarget));
    SetLocalInt(oSaveDataItem,"CREATURE_PART_TAIL",GetCreatureTailType(oSaveTarget));

    SetLocalString(oSaveDataItem,"CREATURE_PART_HIDE",GetResRef(GetItemInSlot(INVENTORY_SLOT_CARMOUR,oSaveTarget)));
    SetLocalString(oSaveDataItem,"CREATURE_PART_LEFT_CLAW",GetResRef(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,oSaveTarget)));
    SetLocalString(oSaveDataItem,"CREATURE_PART_RIGHT_CLAW",GetResRef(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,oSaveTarget)));
    SetLocalString(oSaveDataItem,"CREATURE_PART_BITE",GetResRef(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B,oSaveTarget)));

    SetLocalInt(oSaveDataItem,"CREATURE_AC",GetNaturalAC(oSaveTarget));
    SetLocalInt(oSaveDataItem,"CREATURE_STRENGTH",GetAbilityScore(oSaveTarget,ABILITY_STRENGTH,TRUE));
    SetLocalInt(oSaveDataItem,"CREATURE_DEXTERITY",GetAbilityScore(oSaveTarget,ABILITY_DEXTERITY,TRUE));
    SetLocalInt(oSaveDataItem,"CREATURE_CONSTITUTION",GetAbilityScore(oSaveTarget,ABILITY_CONSTITUTION,TRUE));
}

// Loads Target's Data from Item
void LoadParts(object oLoadTarget, object oLoadDataItem)
{
    ResetAppearance(oLoadTarget);
    int iLoadAppearance = GetLocalInt(oLoadDataItem, "CREATURE_APPEARANCE");
    SetCreatureAppearanceType(oLoadTarget,iLoadAppearance);
    SetCreatureWingType(GetLocalInt(oLoadDataItem, "CREATURE_PART_WING"),oLoadTarget);
    SetCreatureTailType(GetLocalInt(oLoadDataItem, "CREATURE_PART_TAIL"),oLoadTarget);

    SetLocalString(oLoadTarget,"CREATURE_RESREF",GetLocalString(oLoadDataItem,"CREATURE_RESREF"));

    LoadFormPowers(oLoadTarget, oLoadDataItem);

    CreateCreatureParts(oLoadTarget, oLoadDataItem);
}

int ShifterIsInForm(object oMimic)
{
    if (GetLocalString(oMimic,"CREATURE_RESREF") == "")
        return FALSE;
    else
        return TRUE;
}
