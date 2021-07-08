//--------------------------------------/
//ITEM PROPERTIES GENERAL FUNCTIONS
//--------------------------------------/
const string CHAR_SPACE = " ";

//--------------------------------------/
//FILTERS
//--------------------------------------/
const int FILTER_IP_TYPE = 0x7F;
const int BITLEN_IP_TYPE = 7;

const int FILTER_IP_SUB = 0x3FF;
const int BITLEN_IP_SUB = 10;

const int FILTER_IP_COST = 0xFF;
const int BITLEN_IP_COST = 8;

const int FILTER_IP_PARAM1 = 0x7F;
const int BITLEN_IP_PARAM1 = 7;

//--------------------------------------/
//PROTOTYPES
//--------------------------------------/
int ip_to_int(itemproperty ip);
int ip_param_to_int(int param0, int param1, int param2, int param3);
itemproperty int_to_ip(int param);
itemproperty ip_param_to_ip(int param0, int param1, int param2, int param3);
string ip_to_string(itemproperty ip);
void ip_remove_all(object item);

//--------------------------------------/
//IMPLEMENTATION
//--------------------------------------/
//==========================================/
//ip to single integer converter
int ip_to_int(itemproperty ip)
//==========================================/
    {
    int itempropdef_row = FILTER_IP_TYPE & GetItemPropertyType(ip);
    int subtype_row = FILTER_IP_SUB; //all 1s
    int cost_row = FILTER_IP_COST; //all 1s
    int param1_row = FILTER_IP_PARAM1 & GetItemPropertyParam1Value(ip);

    //subtype exists
    string subtype_resref = Get2DAString("itempropdef", "SubTypeResRef", itempropdef_row);
    if(subtype_resref != "")
        {
        subtype_row &= GetItemPropertySubType(ip);
        }

    //cost exists
    int costtable_row = GetItemPropertyCostTable(ip);
    if(costtable_row > 0)
        {
        cost_row &= GetItemPropertyCostTableValue(ip);
        }

    int param = (itempropdef_row << BITLEN_IP_SUB) | subtype_row;
    param = (param << BITLEN_IP_COST) | cost_row;
    param = (param << BITLEN_IP_PARAM1) | param1_row;

    return param;
    }

//==========================================/
//4-parameter ip to integer converter
int ip_param_to_int(int param0, int param1, int param2, int param3)
//==========================================/
    {
    int itempropdef_row = FILTER_IP_TYPE & param0;
    int subtype_row = FILTER_IP_SUB; //all 1s
    int cost_row = FILTER_IP_COST; //all 1s
    int param1_row = FILTER_IP_PARAM1; //all 1s

    //param0 is always prop type:
    string subtype_resref = Get2DAString("itempropdef", "SubTypeResRef", param0);
    string costtable_resref = Get2DAString("itempropdef", "CostTableResRef", param0);
    string param1_resref = Get2DAString("itempropdef", "Param1ResRef", param0);

    //subtype exists
    if(subtype_resref != "")
        {
        subtype_row &= param1;

        //cost exists
        if(costtable_resref != "")
            {
            cost_row &= param2;

            //param1 exists
            if(param1_resref != ""
                || Get2DAString(subtype_resref, "Param1ResRef", param1) != "")
                {
                param1_row &= param3;
                }
            }

        //no cost
        else
            {
            //param1 exists
            if(param1_resref != ""
                || Get2DAString(subtype_resref, "Param1ResRef", param1) != "")
                {
                param1_row &= param2;
                }
            }
        }
    //no subtype
    else
        {
        //cost exists
        if(costtable_resref != "")
            {
            cost_row &= param1;

            //param1 exists
            if(param1_resref != "")
                {
                param1_row &= param2;
                }
            }
        //no cost
        else
            {
            //param1 exists
            if(param1_resref != "")
                {
                param1_row &= param1;
                }
            }
        }

    int param = (itempropdef_row << BITLEN_IP_SUB) | subtype_row;
    param = (param << BITLEN_IP_COST) | cost_row;
    param = (param << BITLEN_IP_PARAM1) | param1_row;

    return param;
    }

//==========================================/
//integer packed ip to ip decompresser
itemproperty int_to_ip(int param)
//==========================================/
    {
    int param0 = 0;
    int param1 = 0;
    int param2 = 0;
    int param3 = 0;

    //----------------------------------------//
    //7 bits
    int param1_row = FILTER_IP_PARAM1 & param;
    param >>>= BITLEN_IP_PARAM1;

    //8 bits
    int cost_row = FILTER_IP_COST & param;
    param >>>= BITLEN_IP_COST;

    //10 bits
    int subtype_row = FILTER_IP_SUB & param;
    param >>>= BITLEN_IP_SUB;

    //7 bits type
    param0 = FILTER_IP_TYPE & param;

    //----------------------------------------//
    //subtype exists
    if(subtype_row != FILTER_IP_SUB)
        {
        param1 = subtype_row;

        if(cost_row != FILTER_IP_COST)
            {
            param2 = cost_row;
            param3 = param1_row;
            }
        else
            {
            param2 = param1_row;
            }
        }
    else
        {
        if(cost_row != FILTER_IP_COST)
            {
            param1 = cost_row;
            param2 = param1_row;
            }
        }

    return ip_param_to_ip(param0, param1, param2, param3);
    }

//==========================================/
//convert ip to 4-parameter ip
itemproperty ip_param_to_ip(int param0, int param1, int param2, int param3)
//==========================================/
    {
    switch(param0)
        {
        case 0:  return ItemPropertyAbilityBonus(param1, param2);
        case 1:  return ItemPropertyACBonus(param1);
        case 2:  return ItemPropertyACBonusVsAlign(param1, param2);
        case 3:  return ItemPropertyACBonusVsDmgType(param1, param2);
        case 4:  return ItemPropertyACBonusVsRace(param1, param2);
        case 5:  return ItemPropertyACBonusVsSAlign(param1, param2);
        case 6:  return ItemPropertyEnhancementBonus(param1);
        case 7:  return ItemPropertyEnhancementBonusVsAlign(param1, param2);
        case 8:  return ItemPropertyEnhancementBonusVsRace(param1, param2);
        case 9:  return ItemPropertyEnhancementBonusVsSAlign(param1, param2);
        case 10: return ItemPropertyEnhancementPenalty(param1);
        case 11: return ItemPropertyWeightReduction(param1);
        case 12: return ItemPropertyBonusFeat(param1);
        case 13: return ItemPropertyBonusLevelSpell(param1, param2);
        //case 14: return
        case 15: return ItemPropertyCastSpell(param1, param2);
        case 16: return ItemPropertyDamageBonus(param1, param2);
        case 17: return ItemPropertyDamageBonusVsAlign(param1, param3, param2); //special index shift
        case 18: return ItemPropertyDamageBonusVsRace(param1, param3, param2);  //special index shift
        case 19: return ItemPropertyDamageBonusVsSAlign(param1, param3, param2); //special index shift
        case 20: return ItemPropertyDamageImmunity(param1, param2);
        case 21: return ItemPropertyDamagePenalty(param1);
        case 22: return ItemPropertyDamageReduction(param1, param2);
        case 23: return ItemPropertyDamageResistance(param1, param2);
        case 24: return ItemPropertyDamageVulnerability(param1, param2);
        //case 25: return
        case 26: return ItemPropertyDarkvision();
        case 27: return ItemPropertyDecreaseAbility(param1, param2);
        case 28: return ItemPropertyDecreaseAC(param1, param2);
        case 29: return ItemPropertyDecreaseSkill(param1, param2);
        //case 30: return
        //case 31: return
        case 32: return ItemPropertyContainerReducedWeight(param1);
        case 33: return ItemPropertyExtraMeleeDamageType(param1);
        case 34: return ItemPropertyExtraRangeDamageType(param1);
        case 35: return ItemPropertyHaste();
        case 36: return ItemPropertyHolyAvenger();
        case 37: return ItemPropertyImmunityMisc(param1);
        case 38: return ItemPropertyImprovedEvasion();
        case 39: return ItemPropertyBonusSpellResistance(param1);
        case 40: return ItemPropertyBonusSavingThrowVsX(param1, param2);
        case 41: return ItemPropertyBonusSavingThrow(param1, param2);
        //case 42: return
        case 43: return ItemPropertyKeen();
        case 44: return ItemPropertyLight(param1, param2); //special index shift*
        case 45: return ItemPropertyMaxRangeStrengthMod(param1);
        //case 46: return
        case 47: return ItemPropertyNoDamage();
        case 48: return ItemPropertyOnHitProps(param1, param2 + (param1 == IP_CONST_ONHIT_LEVELDRAIN), param3); //special index shift
        case 49: return ItemPropertyReducedSavingThrowVsX(param1, param2);
        case 50: return ItemPropertyReducedSavingThrow(param1, param2);
        case 51: return ItemPropertyRegeneration(param1);
        case 52: return ItemPropertySkillBonus(param1, param2);
        case 53: return ItemPropertySpellImmunitySpecific(param1);
        case 54: return ItemPropertySpellImmunitySchool(param1);
        case 55: return ItemPropertyThievesTools(param1);
        case 56: return ItemPropertyAttackBonus(param1);
        case 57: return ItemPropertyAttackBonusVsAlign(param1, param2);
        case 58: return ItemPropertyAttackBonusVsRace(param1, param2);
        case 59: return ItemPropertyAttackBonusVsSAlign(param1, param2);
        case 60: return ItemPropertyAttackPenalty(param1);
        case 61: return ItemPropertyUnlimitedAmmo(param2);
        case 62: return ItemPropertyLimitUseByAlign(param1);
        case 63: return ItemPropertyLimitUseByClass(param1);
        case 64: return ItemPropertyLimitUseByRace(param1);
        case 65: return ItemPropertyLimitUseBySAlign(param1);
        //case 66: return
        case 67: return ItemPropertyVampiricRegeneration(param1);
        //case 68: return
        //case 69: return
        case 70: return ItemPropertyTrap(param1, param2);
        case 71: return ItemPropertyTrueSeeing();
        case 72: return ItemPropertyOnMonsterHitProperties(param1, param2);
        case 73: return ItemPropertyTurnResistance(param1);
        case 74: return ItemPropertyMassiveCritical(param1);
        case 75: return ItemPropertyFreeAction();
        //case 76: return
        case 77: return ItemPropertyMonsterDamage(param1);
        case 78: return ItemPropertyImmunityToSpellLevel(param1); //special index shift*
        case 79: return ItemPropertySpecialWalk(param1);
        case 80: return ItemPropertyHealersKit(param1);
        case 81: return ItemPropertyWeightIncrease(param1);
        case 82: return ItemPropertyOnHitCastSpell(param1, param2+1); //special index shift
        case 83: return ItemPropertyVisualEffect(param1);
        case 84: return ItemPropertyArcaneSpellFailure(param1);

        //----------------------------------------//
        //added v1.69
        case 85: return ItemPropertyMaterial(param1);
        case 86: return ItemPropertyQuality(param1);
        case 87: return ItemPropertyAdditional(param1);
        }
    itemproperty ip;
    return ip;
    }

//==========================================/
//output item property as string
string ip_to_string(itemproperty ip)
//==========================================/
    {
    string ip_string = "";
    string paramtable_row = "";

    //----------------------------------------//
    int itempropdef_row = GetItemPropertyType(ip);

    string game_strref = Get2DAString("itempropdef", "GameStrRef", itempropdef_row);
    if(game_strref != "")
        {
        ip_string += GetStringByStrRef(StringToInt(game_strref));
        }

    //----------------------------------------//
    int subtype_row = GetItemPropertySubType(ip);
    string subtype_resref = Get2DAString("itempropdef", "SubTypeResRef", itempropdef_row);
    if(subtype_resref != "")
        {
        string subtype_strref = Get2DAString(subtype_resref, "Name", subtype_row);

        if(subtype_strref != "")
            {
            ip_string += CHAR_SPACE + GetStringByStrRef(StringToInt(subtype_strref));
            }

        //param1 override
        //----------------------------------------//
        paramtable_row = Get2DAString(subtype_resref, "Param1ResRef", subtype_row);
        //----------------------------------------//
        }

    //----------------------------------------//
    //string costtable_row = Get2DAString("itempropdef", "CostTableResRef", itempropdef_row);
    int costtable_row = GetItemPropertyCostTable(ip);
    if(costtable_row > 0)
        {
        string costtable_resref = Get2DAString("IPRP_COSTTABLE", "Name", costtable_row);
        string costtable_strref = Get2DAString(costtable_resref, "Name", GetItemPropertyCostTableValue(ip));

        if(costtable_strref != "")
            {
            ip_string += CHAR_SPACE + GetStringByStrRef(StringToInt(costtable_strref));
            }
        }

    //----------------------------------------//
    if(paramtable_row == "")
        {
        paramtable_row = Get2DAString("itempropdef", "Param1ResRef", itempropdef_row);
        }

    if(paramtable_row != "")
        {
        string param1_resref = Get2DAString("IPRP_PARAMTABLE", "TableResRef", StringToInt(paramtable_row));
        string param1_strref = Get2DAString(param1_resref, "Name", GetItemPropertyParam1Value(ip));

        if(param1_strref != "")
            {
            ip_string += CHAR_SPACE + GetStringByStrRef(StringToInt(param1_strref));
            }
        }
    return ip_string;
    }

//==========================================/
void ip_remove_all(object item)
//==========================================/
    {
    itemproperty ip = GetFirstItemProperty(item);
    while(GetIsItemPropertyValid(ip))
        {
        RemoveItemProperty(item, ip);

        ip = GetNextItemProperty(item);
        }
    }
