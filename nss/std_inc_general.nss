//--------------------------------------/
//GENERAL FUNCTIONS
//--------------------------------------/

//--------------------------------------/
//CONSTANTS
//--------------------------------------/
const int ITEM_LEVEL_MIN = 1;
const int ITEM_LEVEL_MAX = 60;

const int CHAR_LEVEL_MIN = 1;
const int CHAR_LEVEL_MAX = 40;

const int ALIGN_LC_MIN = 0;
const int ALIGN_LC_MAX = 100;

const int ALIGN_GE_MIN = 0;
const int ALIGN_GE_MAX = 100;

const int ITEM_STACK_SIZE_MIN = 1;
const int ITEM_STACK_SIZE_MAX = 99;

//--------------------------------------/
//PROTOTYPE
//--------------------------------------/
void start_conversation(object user, object target, string cv);
int get_character_level(object user);
int get_item_cost(object item);
int get_item_stack_cost(object item, int stack_size_req, object dummy_inv);
int search_2DA_lb_inclusive(string filename, string search_col, int search_val, int begin, int end, int min_result, int max_result);
int search_2DA_ub_inclusive(string filename, string search_col, int search_val, int begin, int end, int min_result, int max_result);
int get_level_from_exp(int exp);
int get_exp_from_level(int level);
int get_item_level_by_cost(int cost);
object copy_item(object item, object target_inventory, int copy_identify = TRUE);
void copy_item_stack(object item, object target_inventory, int stack_size_req, object dummy_inv);
int get_item_max_stack_size(object item);
int give_gold(int gp_amount, object user);
void set_align_lc(object user, int lc_target);
void set_align_ge(object user, int ge_target);
int get_item_inventory_slot(object item, object user);
void equip_item(object item, int equip_slot, object user);
void set_null_creature_effect(object target);

//--------------------------------------/
//IMPLEMENTATION
//--------------------------------------/
//==========================================/
void start_conversation(object user, object target, string cv)
//==========================================/
    {
    AssignCommand(user, ActionStartConversation(target, cv, TRUE, FALSE));
    }

//==========================================/
int get_character_level(object user)
//==========================================/
    {
    int level = GetLevelByClass(GetClassByPosition(1, user), user);
    level += GetLevelByClass(GetClassByPosition(2, user), user);
    level += GetLevelByClass(GetClassByPosition(3, user), user);

    return level;
    }

//==========================================/
//get item cost wrapper
//ignores flags
int get_item_cost(object item)
//==========================================/
    {
    int item_plot_flag = GetPlotFlag(item);
    SetPlotFlag(item, 0);
    int item_identified = GetIdentified(item);
    SetIdentified(item, 1);

    int cost = GetGoldPieceValue(item);

    SetPlotFlag(item, item_plot_flag);
    SetIdentified(item, item_identified);

    return cost;
    }

//==========================================/
int get_item_stack_cost(object item, int stack_size_req, object dummy_inv)
//==========================================/
    {
    int cost = 0;

    object item_copy = copy_item(item, dummy_inv);

    int stack_size_max = get_item_max_stack_size(item);
    if(stack_size_req >= stack_size_max)
        {
        SetItemStackSize(item_copy, stack_size_max);
        cost = get_item_cost(item_copy);

        cost *= stack_size_req / stack_size_max;
        stack_size_req = stack_size_req % stack_size_max;
        }

    if(stack_size_req)
        {
        SetItemStackSize(item_copy, stack_size_req);
        cost += get_item_cost(item_copy);
        }

    DestroyObject(item_copy);

    return cost;
    }

//::::::::::::::::::::::::::::::::::::::::::/
int search_2DA_lb_inclusive(string filename, string search_col, int search_val, int begin, int end, int min_result, int max_result)
//::::::::::::::::::::::::::::::::::::::::::/
    {
    int n = begin + (end - begin)/2;
    int search_lb = StringToInt(Get2DAString(filename, search_col, n));
    int search_ub = StringToInt(Get2DAString(filename, search_col, n+1));

    if(search_val >= search_lb)
        {
        if(search_val < search_ub)
            {
            return n;
            }
        else if(n >= max_result-1)
            {
            return max_result-1;
            }
        else
            {
            return search_2DA_lb_inclusive(filename, search_col, search_val, n+1, end, min_result, max_result);
            }
        }
    else if(n <= min_result)
        {
        return min_result;
        }
    else
        {
        return search_2DA_lb_inclusive(filename, search_col, search_val, begin, n-1, min_result, max_result);
        }
    }

//::::::::::::::::::::::::::::::::::::::::::/
int search_2DA_ub_inclusive(string filename, string search_col, int search_val, int begin, int end, int min_result, int max_result)
//::::::::::::::::::::::::::::::::::::::::::/
    {
    int n = begin + (end - begin)/2;
    int search_lb = StringToInt(Get2DAString(filename, search_col, n-1));
    int search_ub = StringToInt(Get2DAString(filename, search_col, n));

    if(search_val > search_lb)
        {
        if(search_val <= search_ub)
            {
            return n;
            }
        else if(n >= max_result-1)
            {
            return max_result-1;
            }
        else
            {
            return search_2DA_lb_inclusive(filename, search_col, search_val, n+1, end, min_result, max_result);
            }
        }
    else if(n <= min_result)
        {
        return min_result;
        }
    else
        {
        return search_2DA_lb_inclusive(filename, search_col, search_val, begin, n-1, min_result, max_result);
        }
    }

//==========================================/
//2da based exp to level converter
//works for all sorted exptables
int get_level_from_exp(int exp)
//==========================================/
    {
    int row = search_2DA_lb_inclusive("exptable", "XP", exp, 0, CHAR_LEVEL_MAX-1, 0, CHAR_LEVEL_MAX);
    return StringToInt(Get2DAString("exptable", "Level", row));
    }

//==========================================/
//2da based level to exp converter
//works for all sorted exptables
int get_exp_from_level(int level)
//==========================================/
    {
    int row = search_2DA_lb_inclusive("exptable", "Level", level, 0, CHAR_LEVEL_MAX-1, 0, CHAR_LEVEL_MAX);
    return StringToInt(Get2DAString("exptable", "XP", row));
    }

//==========================================/
//2da based cost to item level converter
int get_item_level_by_cost(int cost)
//==========================================/
    {
    int row = search_2DA_ub_inclusive("itemvalue", "MAXSINGLEITEMVALUE", cost, 0, ITEM_LEVEL_MAX-1, 0, ITEM_LEVEL_MAX);
    return StringToInt(Get2DAString("itemvalue", "LABEL", row));
    }

//==========================================/
//wrapper for copy item - always copy identified
object copy_item(object item, object target_inventory, int copy_identify = TRUE)
//==========================================/
    {
    object item_copy = CopyItem(item, target_inventory, FALSE);

    SetIdentified(item_copy, copy_identify | GetIdentified(item));
    return item_copy;
    }

//==========================================/
void copy_item_stack(object item, object target_inventory, int stack_size_req, object dummy_inv)
//==========================================/
    {
    object item_copy = copy_item(item, dummy_inv);

    int stack_size_max = get_item_max_stack_size(item_copy);
    if(stack_size_req >= stack_size_max)
        {
        SetItemStackSize(item_copy, stack_size_max);

        while(stack_size_req > stack_size_max)
            {
            copy_item(item_copy, target_inventory);
            stack_size_req -= stack_size_max;
            }
        }

    SetItemStackSize(item_copy, stack_size_req);
    copy_item(item_copy, target_inventory);

    DestroyObject(item_copy);
    }

//==========================================/
//retrieve max stack size from 2da
int get_item_max_stack_size(object item)
//==========================================/
    {
    return StringToInt(Get2DAString("baseitems", "Stacking", GetBaseItemType(item)));
    }

//==========================================/
//give gold to creature function that works for negative numbers
//returns true on successful charge (i.e. target has more gold than charge amount)
int give_gold(int gp_amount, object user)
//==========================================/
    {
    if(gp_amount >= 0)
        {
        GiveGoldToCreature(user, gp_amount);
        }
    else
        {
        if((GetGold(user) + gp_amount) >= 0)
            {
            TakeGoldFromCreature(-gp_amount, user, TRUE);
            }
        else
            {
            return FALSE;
            }
        }
    return TRUE;
    }

//==========================================/
//set law-chaos alignment to specific value - jumps through multiple steps in one loop
void set_align_lc(object user, int lc_target)
//==========================================/
    {
    int lc_cur = GetLawChaosValue(user);

    if(lc_target > ALIGN_LC_MAX)
        {
        lc_target = ALIGN_LC_MAX;
        }
    else if(lc_target < ALIGN_LC_MIN)
        {
        lc_target = ALIGN_LC_MIN;
        }

    while(lc_target != lc_cur)
        {
        AdjustAlignment(user, ALIGNMENT_LAWFUL, lc_target - lc_cur);
        lc_cur = GetLawChaosValue(user);
        }
    }

//==========================================/
//set good-evil alignment to specific value - jumps through multiple steps in one loop
void set_align_ge(object user, int ge_target)
//==========================================/
    {
    int ge_cur = GetGoodEvilValue(user);

    if(ge_target > ALIGN_GE_MAX)
        {
        ge_target = ALIGN_GE_MAX;
        }
    else if(ge_target < ALIGN_GE_MIN)
        {
        ge_target = ALIGN_GE_MIN;
        }

    while(ge_target != ge_cur)
        {
        AdjustAlignment(user, ALIGNMENT_GOOD, ge_target - ge_cur);
        ge_cur = GetGoodEvilValue(user);
        }
    }

//==========================================/
//get the equip slot of an item
//-1 on error (i.e. DNE or not equipped)
int get_item_inventory_slot(object item, object user)
//==========================================/
    {
    int n = 0;
    while(n < NUM_INVENTORY_SLOTS)
        {
        if(GetItemInSlot(n, user) == item)
            {
            return n;
            }
        n++;
        }

    return -1;
    }

//==========================================/
//equip item wrapper - temporarily freezes user during process
void equip_item(object item, int equip_slot, object user)
//==========================================/
    {
    effect immobilize = ExtraordinaryEffect(EffectCutsceneImmobilize());
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, immobilize, user);

    //----------------------------------------//
    AssignCommand(user, ActionEquipItem(item, equip_slot));
    RemoveEffect(user, immobilize);
    }

//==========================================/
void set_null_creature_effect(object target)
//==========================================/
    {
    effect paralyze = ExtraordinaryEffect(EffectCutsceneParalyze());
    effect ghost = ExtraordinaryEffect(EffectCutsceneGhost());
    effect evis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, paralyze, target);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ghost, target);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, evis, target);
    }
