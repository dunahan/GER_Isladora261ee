#include "x2_inc_itemprop"

int MimicDisableNWNShape = TRUE;                              //Default = TRUE

int MimicUsePNPRaceRules = TRUE;                              //Default = TRUE
int MimicUsePNPSizeRules = TRUE;                              //Default = TRUE

/* Masters of the Wild PNP Shifter Rules

level   sizes       creature types
1       S,M         humanoid
2                   animal, monsterous
3       L,T         beast, plant
4                   giant, vermin
5       D           magical, fey*, shapechangers*
6                   aberrant, ooze
7       H           dragon
8                   undead, construct
9       F           elemental, outsider
10      G

*Shapchangers and Fey are not mentioned, so are listed as magical creatures

*/
int CREATURE_SIZE_DIMINUTIVE = 20;  // Creature sizes introduced with CEP 2.3
int CREATURE_SIZE_FINE = 21;
int CREATURE_SIZE_GARGANTUAN = 22;
int CREATURE_SIZE_COLOSSAL = 23;

int MimicRequireNWNFeats = FALSE;                             //Default = FALSE
//Alterative to PnP rules, requires construct, outsider feats etc

int MimicHitDiceRestricted = FALSE;                           //Default = FALSE
// The MoTW book says Pc Level >= HD...

int MimicDruidShifterLevelOnly = TRUE;                        //Default = TRUE
// "Hardcore", Druid+Shifter Levels >= HD

int MimicPCRestricted = TRUE;                                 //Default = TRUE
int MimicDMRestricted = TRUE;                                 //Default = TRUE
int MimicDMPosessedRestricted = FALSE;                        //Default = FALSE

int MimicPlotRestricted = TRUE;                               //Default = TRUE
int MimicBlockBoss = TRUE;                                    //Default = TRUE
//Blocks forms with tags containing "BOSS", "Boss", "boss";

int MimicAllowDruid = TRUE;                                   //Default = TRUE
// Druids can study animals, elementals and dragons

int MimicGenderRestricted = FALSE;                            //Default = FALSE

string MimicHideTag = "SHIFTER_HIDE";
string MimicLeftTag = "SHIFTER_LEFT_CLAW";
string MimicRightTag = "SHIFTER_RIGHT_CLAW";
string MimicBiteTag = "SHIFTER_BITE";
string MimicPowerTag = "SHIFTER_POWER";
string MimicHideTemplate = "MIMIC_HIDE_TEMPLATE";
string MimicHideResRefDefault = "it_shifter_hide";
string MimicFormResRef = "it_shifter_form";

int MimicVFX = VFX_IMP_POLYMORPH;                //Default = VFX_IMP_POLYMORPH
                                                 //No VFX  = FALSE
float MimicPreDelay = 0.0;
float MimicPartsDelay = 0.1;

//An alternative to the PNP shifter rules, uses NWN shifter feats for limits
int MimicNWNFeatCheck(object oMimicToCheck, object oTargetCreature)
{
    int FeatCheckRace = GetRacialType(oTargetCreature);

    if (GetHasFeat(FEAT_HUMANOID_SHAPE,oMimicToCheck)
    ||(FeatCheckRace==RACIAL_TYPE_ABERRATION)
    ||(FeatCheckRace==RACIAL_TYPE_HUMANOID_MONSTROUS)
    ||(FeatCheckRace==RACIAL_TYPE_HUMANOID_GOBLINOID)
    ||(FeatCheckRace==RACIAL_TYPE_HUMANOID_REPTILIAN)
    ||(FeatCheckRace==RACIAL_TYPE_HUMANOID_ORC)
    ||(FeatCheckRace==RACIAL_TYPE_DWARF)
    ||(FeatCheckRace==RACIAL_TYPE_ELF)
    ||(FeatCheckRace==RACIAL_TYPE_FEY)
    ||(FeatCheckRace==RACIAL_TYPE_GIANT)
    ||(FeatCheckRace==RACIAL_TYPE_GNOME)
    ||(FeatCheckRace==RACIAL_TYPE_HALFELF)
    ||(FeatCheckRace==RACIAL_TYPE_HALFLING)
    ||(FeatCheckRace==RACIAL_TYPE_HALFORC)
    ||(FeatCheckRace==RACIAL_TYPE_HUMAN)) return TRUE;

    if (GetHasFeat(FEAT_WILD_SHAPE,oMimicToCheck)
    &&((FeatCheckRace==RACIAL_TYPE_ANIMAL)
    ||(FeatCheckRace==RACIAL_TYPE_BEAST)
    ||(FeatCheckRace==RACIAL_TYPE_MAGICAL_BEAST)
    ||(FeatCheckRace==RACIAL_TYPE_OOZE)
    ||(FeatCheckRace==RACIAL_TYPE_VERMIN))) return TRUE;

    if (GetHasFeat(FEAT_ELEMENTAL_SHAPE,oMimicToCheck)&&(FeatCheckRace==RACIAL_TYPE_ELEMENTAL)) return TRUE;
    if (GetHasFeat(FEAT_EPIC_CONSTRUCT_SHAPE,oMimicToCheck)&&(FeatCheckRace==RACIAL_TYPE_CONSTRUCT)) return TRUE;
    if (GetHasFeat(FEAT_EPIC_OUTSIDER_SHAPE,oMimicToCheck)&&(FeatCheckRace==RACIAL_TYPE_OUTSIDER)) return TRUE;
    if (GetHasFeat(FEAT_EPIC_WILD_SHAPE_DRAGON,oMimicToCheck)&&(FeatCheckRace==RACIAL_TYPE_DRAGON)) return TRUE;
    if (GetHasFeat(FEAT_EPIC_WILD_SHAPE_UNDEAD,oMimicToCheck)&&(FeatCheckRace==RACIAL_TYPE_UNDEAD)) return TRUE;

    return FALSE;
}

int HiInt(int Integer1, int Integer2)
{
    return (Integer1>Integer2) ?  Integer1 : Integer2;
}

int GetNaturalAC(object oCreature)
{

    object oLeft = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oCreature);
    int iLeft = GetBaseItemType(oLeft);

    //int iNAC = 0;
    int iExpert = 0;
    int iDeflect = 0;
    int iShield = 0;

    int iArms  = GetItemACValue(GetItemInSlot(INVENTORY_SLOT_ARMS, oCreature));
    int iBelt  = GetItemACValue(GetItemInSlot(INVENTORY_SLOT_BELT, oCreature));
    int iHead  = GetItemACValue(GetItemInSlot(INVENTORY_SLOT_HEAD, oCreature));
    int iCloak = GetItemACValue(GetItemInSlot(INVENTORY_SLOT_CLOAK, oCreature));
    int iRingL = GetItemACValue(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oCreature));
    int iRingR = GetItemACValue(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oCreature));
    int iArmor = GetItemACValue(GetItemInSlot(INVENTORY_SLOT_CHEST, oCreature));
    int iDodge = GetItemACValue(GetItemInSlot(INVENTORY_SLOT_BOOTS, oCreature));
    int iNatural = GetItemACValue(GetItemInSlot(INVENTORY_SLOT_NECK, oCreature));

    switch(iLeft)
    {
        case BASE_ITEM_SMALLSHIELD: iShield = GetItemACValue(oLeft); break;;
        case BASE_ITEM_LARGESHIELD: iShield = GetItemACValue(oLeft); break;;
        case BASE_ITEM_TOWERSHIELD: iShield = GetItemACValue(oLeft); break;;
        default: iDeflect = GetItemACValue(oLeft); break;
    }

    iDeflect = HiInt(HiInt(HiInt(iArms,iHead),HiInt(iCloak,iRingL)),
               HiInt(HiInt(iRingR,iBelt),HiInt(iShield,iDeflect)));


    if (GetHasFeatEffect(FEAT_EXPERTISE)) iExpert = 5;
    else if (GetHasFeatEffect(FEAT_IMPROVED_EXPERTISE)) iExpert = 10;

//    if (GetIsObjectValid(oArmor))
    //iNAC =
    return (GetAC(oCreature)-(10+iArmor+iDeflect+iDodge+iNatural+iShield+iExpert
                             +GetAbilityModifier(ABILITY_DEXTERITY,oCreature)));
//    else
//        iNAC =(GetAC(oCreature)-(10+iAcc+GetAbilityModifier(ABILITY_DEXTERITY,oCreature)));

    //return iNAC;
}

void ApplyAbilities(object ObjectOwner, object InfoItem,object ObjectToModify)
{
    int NACMod = GetLocalInt(InfoItem, "CREATURE_AC")-GetNaturalAC(ObjectOwner);
    int StrMod = GetLocalInt(InfoItem, "CREATURE_STRENGTH")-GetAbilityScore(ObjectOwner,ABILITY_STRENGTH,TRUE);
    int DexMod = GetLocalInt(InfoItem, "CREATURE_DEXTERITY")-GetAbilityScore(ObjectOwner,ABILITY_DEXTERITY,TRUE);
    int ConMod = GetLocalInt(InfoItem, "CREATURE_CONSTITUTION")-GetAbilityScore(ObjectOwner,ABILITY_CONSTITUTION,TRUE);

    if (NACMod > 20) NACMod = 20;    if (NACMod < -5) NACMod = -5;
    if (StrMod > 12) StrMod = 12;    if (StrMod < -10) StrMod = -10;
    if (DexMod > 12) DexMod = 12;    if (DexMod < -10) DexMod = -10;
    if (ConMod > 12) ConMod = 12;    if (ConMod < -10) ConMod = -10;

    if (NACMod > 0) IPSafeAddItemProperty(ObjectToModify,ItemPropertyACBonus(NACMod));
    if (StrMod > 0) IPSafeAddItemProperty(ObjectToModify,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,StrMod));
    if (DexMod > 0) IPSafeAddItemProperty(ObjectToModify,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,DexMod));
    if (ConMod > 0) IPSafeAddItemProperty(ObjectToModify,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,ConMod));

    if (NACMod < 0) IPSafeAddItemProperty(ObjectToModify,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_NATURAL,-1*NACMod));
    if (StrMod < 0) IPSafeAddItemProperty(ObjectToModify,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_STR,-1*StrMod));
    if (DexMod < 0) IPSafeAddItemProperty(ObjectToModify,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,-1*DexMod));
    if (ConMod < 0) IPSafeAddItemProperty(ObjectToModify,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_CON,-1*ConMod));

}

void AddCreaturePart(object oCrOwner, string sCrPartResRef, string sCrPartTag, int InvSlot)
{
    object oCrPartItem = CreateItemOnObject(sCrPartResRef,oCrOwner,1,sCrPartTag);
    SetPlotFlag(oCrPartItem, FALSE);
    SetIdentified(oCrPartItem, TRUE);
    AssignCommand(oCrOwner,ActionEquipItem(oCrPartItem, InvSlot));
}

void CreateCreatureParts(object oCrOwner, object oCrDataItem)
{
    string MimicHideResRef = GetLocalString(oCrDataItem, "CREATURE_PART_HIDE");
    string MimicLeftResRef = GetLocalString(oCrDataItem, "CREATURE_PART_LEFT_CLAW");
    string MimicRightResRef = GetLocalString(oCrDataItem, "CREATURE_PART_RIGHT_CLAW");
    string MimicBiteResRef = GetLocalString(oCrDataItem, "CREATURE_PART_BITE");

    int MimicParts = 2;
    if (MimicLeftResRef !="") MimicParts++;
    if (MimicRightResRef !="") MimicParts++;
    if (MimicBiteResRef !="") MimicParts++;

    float MimicDelay = (IntToFloat(MimicParts)*MimicPartsDelay);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oCrOwner, MimicDelay);
    AssignCommand(oCrOwner,ClearAllActions(TRUE));
    DelayCommand(MimicDelay, SetCommandable(TRUE,oCrOwner));

    object oCrPartHide = CreateItemOnObject(MimicHideResRefDefault,oCrOwner,1,MimicHideTag);
    SetPlotFlag(oCrPartHide, FALSE);
    SetIdentified(oCrPartHide, TRUE);
    AssignCommand(oCrOwner,ActionEquipItem(oCrPartHide, INVENTORY_SLOT_CARMOUR));

    if (MimicHideResRef !="")
    {
        object MimicHideTemp = CreateItemOnObject(MimicHideResRef,oCrOwner,1,MimicHideTemplate);

        SetPlotFlag(MimicHideTemp, FALSE);
        IPWildShapeCopyItemProperties(MimicHideTemp,oCrPartHide);
        DestroyObject(MimicHideTemp,0.1);
    }

    ApplyAbilities(oCrOwner,oCrDataItem,oCrPartHide);

    MimicParts = 1;
    if (MimicLeftResRef !="")
    {
        MimicDelay = (IntToFloat(MimicParts)*MimicPartsDelay);
        DelayCommand(MimicDelay, AddCreaturePart(oCrOwner, MimicLeftResRef, MimicLeftTag,INVENTORY_SLOT_CWEAPON_L));
        MimicParts++;
    }

    if (MimicRightResRef !="")
    {
        MimicDelay = (IntToFloat(MimicParts)*MimicPartsDelay);
        DelayCommand(MimicDelay, AddCreaturePart(oCrOwner, MimicRightResRef, MimicRightTag,INVENTORY_SLOT_CWEAPON_R));
        MimicParts++;
    }

    if (MimicBiteResRef !="")
    {
        MimicDelay = (IntToFloat(MimicParts)*MimicPartsDelay);
        DelayCommand(MimicDelay, AddCreaturePart(oCrOwner, MimicBiteResRef, MimicBiteTag,INVENTORY_SLOT_CWEAPON_B));
    }
}

int IsDynamic(int iTestAppearance)
{
    int iDynTest = FALSE;
    switch (iTestAppearance)
    {
        case 0 : iDynTest = TRUE; break;
        case 1 : iDynTest = TRUE; break;
        case 2 : iDynTest = TRUE; break;
        case 3 : iDynTest = TRUE; break;
        case 4 : iDynTest = TRUE; break;
        case 5 : iDynTest = TRUE; break;
        case 6 : iDynTest = TRUE; break;

        //CEP Dynamic Races & Armor Stand
        case 1000 : iDynTest = TRUE; break;
        case 1002 : iDynTest = TRUE; break;
        case 1030 : iDynTest = TRUE; break;
        case 1769 : iDynTest = TRUE; break;
    }
    return iDynTest;
}

// Uses Masters of The Wild Shifter Class Rules
int MimicRaceCheckPNP(object MimicPNP, object TargetPNP)
{
    int PNPShifterLevel = GetLevelByClass(CLASS_TYPE_SHIFTER, MimicPNP);
    int PNPDruidLevel = GetLevelByClass(CLASS_TYPE_DRUID, MimicPNP);
    int PNPRace = GetRacialType(TargetPNP);
    int RacePassedPNP = FALSE;

    if (MimicAllowDruid&&(PNPDruidLevel>4)&&(PNPRace == RACIAL_TYPE_ANIMAL)) RacePassedPNP = TRUE;
    if (MimicAllowDruid&&(PNPDruidLevel>15)&&(PNPRace == RACIAL_TYPE_ELEMENTAL)) RacePassedPNP = TRUE;
    if (MimicAllowDruid&&(GetHasFeat(FEAT_EPIC_WILD_SHAPE_DRAGON,MimicPNP))&&(PNPRace == RACIAL_TYPE_DRAGON)) RacePassedPNP = TRUE;

    if ((PNPShifterLevel>0)&&((PNPRace == RACIAL_TYPE_DWARF)
    ||(PNPRace == RACIAL_TYPE_ELF)
    ||(PNPRace == RACIAL_TYPE_GNOME)
    ||(PNPRace == RACIAL_TYPE_HALFELF)
    ||(PNPRace == RACIAL_TYPE_HALFLING)
    ||(PNPRace == RACIAL_TYPE_HALFORC)
    ||(PNPRace == RACIAL_TYPE_HUMAN))) RacePassedPNP = TRUE;
    if ((PNPShifterLevel>1)&&((PNPRace == RACIAL_TYPE_HUMANOID_MONSTROUS)
                             ||(PNPRace == RACIAL_TYPE_HUMANOID_GOBLINOID)
                             ||(PNPRace == RACIAL_TYPE_HUMANOID_ORC)
                             ||(PNPRace == RACIAL_TYPE_HUMANOID_REPTILIAN)
                             )) RacePassedPNP = TRUE;
    if ((PNPShifterLevel>1)&&(PNPRace == RACIAL_TYPE_ANIMAL)) RacePassedPNP = TRUE;
    if ((PNPShifterLevel>2)&&(PNPRace == RACIAL_TYPE_BEAST)) RacePassedPNP = TRUE;
    if ((PNPShifterLevel>3)&&((PNPRace == RACIAL_TYPE_GIANT)
                             ||(PNPRace == RACIAL_TYPE_VERMIN))) RacePassedPNP = TRUE;
    if ((PNPShifterLevel>4)&&((PNPRace == RACIAL_TYPE_MAGICAL_BEAST)
    //fey and shapechangers were left out, but are included for thoroughness
                             ||(PNPRace == RACIAL_TYPE_FEY)
                             ||(PNPRace == RACIAL_TYPE_SHAPECHANGER))) RacePassedPNP = TRUE;
    if ((PNPShifterLevel>5)&&((PNPRace == RACIAL_TYPE_ABERRATION)
                             ||(PNPRace == RACIAL_TYPE_OOZE))) RacePassedPNP = TRUE;
    if ((PNPShifterLevel>6)&&((PNPRace == RACIAL_TYPE_DRAGON))) RacePassedPNP = TRUE;
    if ((PNPShifterLevel>7)&&((PNPRace == RACIAL_TYPE_CONSTRUCT)
                             ||(PNPRace == RACIAL_TYPE_UNDEAD))) RacePassedPNP = TRUE;
    if ((PNPShifterLevel>8)&&((PNPRace == RACIAL_TYPE_ELEMENTAL)
                             ||(PNPRace == RACIAL_TYPE_OUTSIDER))) RacePassedPNP = TRUE;
    return RacePassedPNP;
}

// Uses Masters of The Wild Shifter Class Rules
int MimicSizeCheckPNP(object MimicPNP, object TargetPNP)
{
    int PNPShifterLevel = GetLevelByClass(CLASS_TYPE_SHIFTER,MimicPNP);
    int PNPSize = GetCreatureSize(TargetPNP);
    int SizePassedPNP = FALSE;
    if ((PNPSize==2)||(PNPSize==3)) SizePassedPNP = TRUE; // small and medeium

    if ((PNPShifterLevel>2) && (PNPSize==1)) SizePassedPNP = TRUE;//tiny
    if ((PNPShifterLevel>2) && (PNPSize==4)) SizePassedPNP = TRUE;//large
    if ((PNPShifterLevel>6) && (PNPSize==5)) SizePassedPNP = TRUE;//huge

    if (MimicAllowDruid)
    {
        int PNPDruidLevel = GetLevelByClass(CLASS_TYPE_DRUID, MimicPNP);
        int PNPRace = GetRacialType(TargetPNP);
        if (((PNPDruidLevel>4)&&(PNPRace==RACIAL_TYPE_ANIMAL))
        || ((PNPDruidLevel>15)&&(PNPRace==RACIAL_TYPE_ELEMENTAL))
        || ((GetHasFeat(FEAT_EPIC_WILD_SHAPE_DRAGON,MimicPNP))&&(PNPRace==RACIAL_TYPE_DRAGON)))
        {
            if ((PNPDruidLevel>6) && (PNPSize==1)) SizePassedPNP = TRUE;//tiny
            if ((PNPDruidLevel>6) && (PNPSize==4)) SizePassedPNP = TRUE;//large
            if ((PNPDruidLevel>11) && (PNPSize==5)) SizePassedPNP = TRUE;//huge
        }
    }
    // For CEP
    if (PNPShifterLevel>8) {if (PNPSize==CREATURE_SIZE_FINE) SizePassedPNP = TRUE;}
    if (PNPShifterLevel>9) {if (PNPSize==CREATURE_SIZE_GARGANTUAN) SizePassedPNP = TRUE;}

    return SizePassedPNP;
}
