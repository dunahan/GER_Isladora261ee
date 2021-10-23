//void main() {}

//--------------------------------------/
//PROTOTYPES
//--------------------------------------/
object get_user_cache(object user);
void destroy_user_cache(object user);
object make_item_dummy_copy(object item, object user);

object get_working_item_blank(object user);
int get_working_item_value(object user);
void select_working_item(object user, object item);
int refresh_working_item(object user);

void copy_ip_list_to_item_mod(object user, object item);
void refresh_ip_list_mod(object user, object item);
void copy_ip_list_to_item_original(object user, object item);
void refresh_ip_list_original(object user, object item);
void copy_ch_cnt_to_item(object user, object item);

int get_item_property_add_cost(object user, itemproperty ip);
int get_item_property_remove_cost(object user, int ccd_ip_remove);
int get_ch_set_cost(object user, int ch_cnt);

void add_item_property(object user, int ip_int);
void remove_item_property(object user, int ccd);

int mod_cost_total_addto(object user, int cost);
void mod_cost_total_clear(object user);
int mod_cost_total_get(object user);

void set_ch_cnt(object user, int ch_cnt);
int get_ch_cnt(object user);
void reset_ch_cnt(object user, object item);

string modcost_to_string(object user);
string modcost_summary_to_string(object user, int mod_cost);
string ch_cnt_to_string(object user);

string ui_item_mod_summary(object user);
string ui_mod_confirmation(object user, int sid, string header);

string get_item_type_2da_column(object item);
void ip_baseitem_filter(object user, object item);

void hide_menu_apply_mod(object user);
void show_menu_apply_mod(object user);

//--------------------------------------/
//#INC
//--------------------------------------/
#include "igi_inc_vars"
#include "igi_arr_ipr"
#include "dsh_inc_switches"

//--------------------------------------/
//IMPLEMENTATION
//--------------------------------------/
//==========================================/
object get_user_cache(object user)
//==========================================/
    {
    int iid = get_client_iid(user);
    object user_cache = GetLocalObject(user, USER_CACHE + IntToString(iid));

    if(!GetIsObjectValid(user_cache))
        {
        user_cache = CreateItemOnObject(USER_CACHE_RESREF, IGI_RES_TRACKER, 1, USER_CACHE + IntToString(iid));
        SetLocalObject(user, USER_CACHE + IntToString(iid), user_cache);
        }

    return user_cache;
    }

//==========================================/
void destroy_user_cache(object user)
//==========================================/
    {
    int iid = get_client_iid(user);
    object user_cache = GetLocalObject(user, USER_CACHE + IntToString(iid));

    if(GetIsObjectValid(user_cache))
        {
        DestroyObject(user_cache);
        }
    }

//==========================================/
object make_item_dummy_copy(object item, object user)
//==========================================/
    {
    object user_cache = get_user_cache(user);

    return copy_item(item, user_cache);
    }

//==========================================/
object get_working_item_blank(object user)
//==========================================/
    {
    return GetLocalObject(user, WORKING_ITEM_BLANK);
    }

//==========================================/
int get_working_item_value(object user)
//==========================================/
    {
    return GetLocalInt(user, WORKING_ITEM_VALUE);
    }

//==========================================/
void select_working_item(object user, object item)
//==========================================/
    {
    //destroy previous copy
    DestroyObject(GetLocalObject(user, WORKING_ITEM_BLANK));

    //create blank copy
    object item_copy = make_item_dummy_copy(item, user);
    ip_remove_all(item_copy);

    //SetLocalObject(user, WORKING_ITEM, item);
    set_working_item(user, item);
    SetLocalObject(user, WORKING_ITEM_BLANK, item_copy);

    arr_ipr_main(user, item);
    reset_ch_cnt(user, item);

    ip_baseitem_filter(user, item);

    mod_cost_total_clear(user);

    SetLocalInt(user, WORKING_ITEM_VALUE, get_item_cost(item));
    }

//==========================================/
int refresh_working_item(object user)
//==========================================/
    {
    object item = get_working_item(user);
    copy_ip_list_to_item_mod(user, item);
    copy_ch_cnt_to_item(user, item);

    //update blank item
    object item_blank = GetLocalObject(user, WORKING_ITEM_BLANK);
    copy_ch_cnt_to_item(user, item_blank);

    int mod_cost = mod_cost_total_get(user);
    mod_cost += get_working_item_value(user);
    SetLocalInt(user, WORKING_ITEM_VALUE, mod_cost);

    mod_cost_total_clear(user);
    reset_ch_cnt(user, item);

    refresh_ip_list_mod(user, item);

    return mod_cost;
    }

//==========================================/
//apply all changes that were made to the item - don't include old
//for modding and getting modcost
void copy_ip_list_to_item_mod(object user, object item)
//==========================================/
    {
    ip_remove_all(item);
    int iid = get_client_iid(user);

    int cd = iid | CI_IPR;
    int ccd_max = get_ccd_next(cd);
    int ccd = cd | CCI_DISP_OFFSET_DEF;

    while(ccd <= ccd_max)
        {
        int cc_param = get_cc_param(user, ccd);

        if(!get_is_ccd_hidden(cc_param))
            {
            int cc_content = get_cc_content_int(ccd);
            itemproperty ip = int_to_ip(cc_content);

            AddItemProperty(DURATION_TYPE_PERMANENT, ip, item);
            }

        ccd += INCR_CCI;
        }
    }

//==========================================/
//apply all changes that were made to the item - don't include old
//for modding and getting modcost
void refresh_ip_list_mod(object user, object item)
//==========================================/
    {
    //ip_remove_all(item);
    int iid = get_client_iid(user);

    int cd = iid | CI_IPR;
    int ccd_max = get_ccd_next(cd);
    int ccd_src = cd | CCI_DISP_OFFSET_DEF;
    int ccd = ccd_src;

    while(ccd_src <= ccd_max)
        {
        int cc_param = get_cc_param(user, ccd_src);

        if(!get_is_ccd_hidden(cc_param))
            {
            string sccd = IntToHexString(ccd);
            string sccd_src = IntToHexString(ccd_src);

            SetLocalInt(user, CC_PARAM + sccd, ~USER_DEF_BIT1 & GetLocalInt(user, CC_PARAM + sccd_src));

            if(ccd_src > ccd)
                {
                SetLocalString(user, CC_NAME + sccd,    GetLocalString(user, CC_NAME + sccd_src));
                SetLocalInt(user, CC_CONTENT + sccd,    GetLocalInt(user, CC_CONTENT + sccd_src));
                }

            ccd += INCR_CCI;
            }

        ccd_src += INCR_CCI;
        }

    set_cci(ccd - INCR_CCI);
    }

//==========================================/
//apply all changes that were made to the item - don't include new
//for getting original cost
void copy_ip_list_to_item_original(object user, object item)
//==========================================/
    {
    ip_remove_all(item);
    int iid = get_client_iid(user);

    int cd = iid | CI_IPR;
    int ccd_max = get_ccd_next(cd);
    int ccd = cd | CCI_DISP_OFFSET_DEF;

    while(ccd <= ccd_max)
        {
        int cc_param = get_cc_param(user, ccd);

        if(!get_is_ccd_user_def1(cc_param))
            {
            int cc_content = get_cc_content_int(ccd);
            itemproperty ip = int_to_ip(cc_content);

            AddItemProperty(DURATION_TYPE_PERMANENT, ip, item);
            }

        ccd += INCR_CCI;
        }
    }

//==========================================/
//apply all changes that were made to the item - don't include old
//for modding and getting modcost
void refresh_ip_list_original(object user, object item)
//==========================================/
    {
    //ip_remove_all(item);
    int iid = get_client_iid(user);

    int cd = iid | CI_IPR;
    int ccd_max = get_ccd_next(cd);
    int ccd_src = cd | CCI_DISP_OFFSET_DEF;
    int ccd = ccd_src;

    while(ccd_src <= ccd_max)
        {
        int cc_param = get_cc_param(user, ccd_src);

        if(!get_is_ccd_user_def1(cc_param))
            {
            string sccd = IntToHexString(ccd);
            string sccd_src = IntToHexString(ccd_src);

            SetLocalInt(user, CC_PARAM + sccd, ~HIDDEN_BIT & GetLocalInt(user, CC_PARAM + sccd_src));

            if(ccd_src > ccd)
                {
                SetLocalString(user, CC_NAME + sccd,    GetLocalString(user, CC_NAME + sccd_src));
                SetLocalInt(user, CC_CONTENT + sccd,    GetLocalInt(user, CC_CONTENT + sccd_src));
                }

            ccd += INCR_CCI;
            }

        ccd_src += INCR_CCI;
        }

    set_cci(ccd - INCR_CCI);
    }

//==========================================/
void copy_ch_cnt_to_item(object user, object item)
//==========================================/
    {
    int ch_cnt = get_ch_cnt(user);

    if(ch_cnt > 0)
        {
        SetItemCharges(item, ch_cnt);
        }
    }

//==========================================/
int get_item_property_add_cost(object user, itemproperty ip)
//==========================================/
    {
    object item_blank = get_working_item_blank(user);
    object item_copy = make_item_dummy_copy(item_blank, user);
    copy_ip_list_to_item_mod(user, item_copy);
    copy_ch_cnt_to_item(user, item_copy);

    int cost_original = get_item_cost(item_copy);

    AddItemProperty(DURATION_TYPE_PERMANENT, ip, item_copy);

    int cost_modified = get_item_cost(item_copy);
    DestroyObject(item_copy);

    return cost_modified - cost_original;
    }

//==========================================/
int get_item_property_remove_cost(object user, int ccd_ip_remove)
//==========================================/
    {
    object item_blank = get_working_item_blank(user);
    object item_copy = make_item_dummy_copy(item_blank, user);
    copy_ch_cnt_to_item(user, item_copy);

    int cd = FILTER_CD & ccd_ip_remove;
    int ccd_max = get_ccd_next(cd);
    int ccd = cd | CCI_DISP_OFFSET_DEF;

    int cc_content;
    itemproperty ip;

    while(ccd <= ccd_max)
        {
        int cc_param = get_cc_param(user, ccd);

        if((ccd != ccd_ip_remove) && !get_is_ccd_hidden(cc_param))
            {
            cc_content = get_cc_content_int(ccd);
            ip = int_to_ip(cc_content);
            AddItemProperty(DURATION_TYPE_PERMANENT, ip, item_copy);
            }

        ccd += INCR_CCI;
        }

    int cost_modified = get_item_cost(item_copy);

    cc_content = get_cc_content_int(ccd_ip_remove);
    ip = int_to_ip(cc_content);
    AddItemProperty(DURATION_TYPE_PERMANENT, ip, item_copy);

    int cost_original = get_item_cost(item_copy);
    DestroyObject(item_copy);

    return cost_modified - cost_original;
    }

//==========================================/
int get_ch_set_cost(object user, int ch_cnt)
//==========================================/
    {
    object item_blank = get_working_item_blank(user);
    object item_copy = make_item_dummy_copy(item_blank, user);
    copy_ip_list_to_item_mod(user, item_copy);
    copy_ch_cnt_to_item(user, item_copy);

    int cost_original = get_item_cost(item_copy);

    SetItemCharges(item_copy, ch_cnt);
    int cost_modified = get_item_cost(item_copy);
    DestroyObject(item_copy);

    return cost_modified - cost_original;
    }

//==========================================/
void add_item_property(object user, int ip_int)
//==========================================/
    {
    itemproperty ip = int_to_ip(ip_int);

    int cc_param = create_link_jal(get_client_iid(IGI_RES_TRACKER) | CI_IPR_MENU | SID_IPR_SEL);
    int ccd_new = create_content_int(user, get_client_iid(user) | CI_IPR, ip_to_string(ip), cc_param, ip_int);
    set_ccd_user_def1(user, ccd_new);
    }

//==========================================/
void remove_item_property(object user, int ccd)
//==========================================/
    {
    int cc_param = get_cc_param(user, ccd);

    if(get_is_ccd_user_def1(cc_param))
        {
        remove_ccd(ccd);
        }
    else
        {
        set_ccd_hidden(user, ccd);
        }
    }

//==========================================/
int mod_cost_total_addto(object user, int cost)
//==========================================/
    {
    int cost_total = GetLocalInt(user, PARAM_MODCOST_TOTAL) + cost;
    SetLocalInt(user, PARAM_MODCOST_TOTAL, cost_total);

    return cost_total;
    }

//==========================================/
void mod_cost_total_clear(object user)
//==========================================/
    {
    DeleteLocalInt(user, PARAM_MODCOST_TOTAL);
    }

//==========================================/
int mod_cost_total_get(object user)
//==========================================/
    {
    return GetLocalInt(user, PARAM_MODCOST_TOTAL);
    }

//==========================================/
void set_ch_cnt(object user, int ch_cnt)
//==========================================/
    {
    SetLocalInt(user, PARAM_SID_CH, ch_cnt);
    }

//==========================================/
int get_ch_cnt(object user)
//==========================================/
    {
    return GetLocalInt(user, PARAM_SID_CH);
    }

//==========================================/
void reset_ch_cnt(object user, object item)
//==========================================/
    {
    SetLocalInt(user, PARAM_SID_CH, GetItemCharges(item));
    }

//==========================================/
string modcost_to_string(object user)
//==========================================/
    {
    int cost = mod_cost_get(user);
    string scost = IntToString(cost) + UI_STR_UNIT_GP;
    if(cost <= 0)
        {
        scost = set_string_color(scost, CGRN);
        }

    int mod_cost = mod_cost_total_get(user) + cost;

    string disp;
    disp += set_string_color(UI_STR_PREFIX_MODCOST, CUD1) + scost + UI_CHAR_NEWLINE;

    return disp;
    }

//==========================================/
string modcost_summary_to_string(object user, int mod_cost)
//==========================================/
    {
    int user_level = get_character_level(user);
    int user_gp = GetGold(user);

    int mod_enabled = 1;

    //--------------------------------------/
    int item_value_original = get_working_item_value(user);
    int item_level_original = get_item_level_by_cost(item_value_original);

    string sitem_value_original = IntToString(item_value_original) + UI_STR_UNIT_GP;
    string sitem_level_original = UI_STR_UNIT_LEVEL + IntToString(item_level_original);

    string sitem_original = IntToString(item_value_original) + UI_STR_UNIT_GP;
    sitem_original += UI_CHAR_SPACE + UI_CHAR_BRK_START + sitem_level_original + UI_CHAR_BRK_END;

    //
    string disp;
    disp += set_string_color(UI_STR_PREFIX_ITEM_VALUE_CURRENT + sitem_original, CHLT) + UI_CHAR_NEWLINE;

    if(mod_cost != 0)
        {
        //--------------------------------------/
        string smod_cost = IntToString(mod_cost) + UI_STR_UNIT_GP;

        if(mod_cost > user_gp)
            {
            mod_enabled = 0;

            smod_cost = set_string_color(smod_cost, CERR);
            }
        else if(mod_cost <= 0)
            {
            smod_cost = set_string_color(smod_cost, CGRN);
            }

        //
        disp += set_string_color(UI_STR_PREFIX_MODCOST_TOTAL, CUD1) + smod_cost + UI_CHAR_NEWLINE;

        //--------------------------------------/
        int item_value_new = item_value_original + mod_cost;
        int item_level_new = get_item_level_by_cost(item_value_new);

        string sitem_value_new = IntToString(item_value_new) + UI_STR_UNIT_GP;
        string sitem_level_new = UI_STR_UNIT_LEVEL + IntToString(item_level_new);

        if((mod_cost > 0) && (item_level_new > user_level))
            {
            if ( get_sw_ilr_enabled(user) )
                {
                mod_enabled = 0;
                }

            sitem_level_new = set_string_color(sitem_level_new, CERR);
            }

        string sitem_new = IntToString(item_value_new) + UI_STR_UNIT_GP;
        sitem_new += UI_CHAR_SPACE + UI_CHAR_BRK_START + sitem_level_new + UI_CHAR_BRK_END;

        //
        disp += set_string_color(UI_STR_PREFIX_ITEM_VALUE_RESULT, CUD1) + sitem_new;
        }

    //--------------------------------------/
    if(mod_enabled)
        {
        show_menu_apply_mod(user);
        }
    else
        {
        hide_menu_apply_mod(user);
        }

    return disp;
    }

//==========================================/
string ch_cnt_to_string(object user)
//==========================================/
    {
    int charge_mod = get_ch_cnt(user);
    int charge_original = GetItemCharges(GetLocalObject(user, WORKING_ITEM_BLANK));

    string scharge = UI_STR_PREFIX_CH_CNT + IntToString(charge_original);
    if(charge_mod != charge_original)
        {
        scharge += set_string_color(UI_CHAR_SPACE + UI_STR_PREFIX_CH_SETTO + IntToString(charge_mod), CUD1);
        }

    return scharge;
    }

//==========================================/
string ui_item_mod_summary(object user)
//==========================================/
    {
    int iid = get_client_iid(user);
    int mod_cost = mod_cost_total_get(user);
    object item = get_working_item(user);

    string disp;
    disp += GetName(item) + UI_CHAR_NEWLINE;
    //disp += set_string_color(UI_STR_HDR_ITEM_MOD_LIST, CHDR) + UI_CHAR_NEWLINE;
    disp += UI_CHAR_BRK_START + ch_cnt_to_string(user) + UI_CHAR_BRK_END + UI_CHAR_NEWLINE;
    disp += cd_list_to_string(user, iid | CI_IPR);
    disp += set_string_color(UI_STR_SEP_130, CHLT) + UI_CHAR_NEWLINE;
    disp += modcost_summary_to_string(user, mod_cost);

    set_sid_str(user, SID_ITM_SEL_IGI, disp);
    set_sid_str(user, SID_IP, disp);
    set_sid_str(user, SID_IPR, disp);
    set_sid_str(user, SID_CH, disp);
    set_sid_str(user, SID_MOD_APPLY, disp);
    set_sid_str(user, SID_MOD_CANCEL, disp);

    return disp;
    }

//==========================================/
string ui_mod_confirmation(object user, int sid, string header)
//==========================================/
    {
    string disp;

    disp += header + UI_CHAR_NEWLINE;
    disp += modcost_to_string(user) + UI_CHAR_NEWLINE;

    set_sid_str(user, sid, disp);

    return disp;
    }

//::::::::::::::::::::::::::::::::::::::::::/
string get_item_type_2da_column(object item)
//::::::::::::::::::::::::::::::::::::::::::/
    {
    if(GetIsObjectValid(item))
        {
        int base_item_type = GetBaseItemType(item);
        string column_strref = Get2DAString("baseitems", "PropColumn", base_item_type);

        if(column_strref != "")
            {
            switch(StringToInt(column_strref))
                {
                case 0:  return "0_Melee";
                case 1:  return "1_Ranged";
                case 2:  return "2_Thrown";
                case 3:  return "3_Staves";
                case 4:  return "4_Rods";
                case 5:  return "5_Ammo";
                case 6:  return "6_Arm_Shld";
                case 7:  return "7_Helm";
                case 8:  return "8_Potions";
                case 9:  return "9_Scrolls";
                case 10: return "10_Wands";
                case 11: return "11_Thieves";
                case 12: return "12_TrapKits";
                case 13: return "13_Hide";
                case 14: return "14_Claw";
                case 15: return "15_Misc_Uneq";
                case 16: return "16_Misc";
                case 17: return "17_No_Props";
                case 18: return "18_Containers";
                case 19: return "19_HealerKit";
                case 20: return "20_Torch";
                case 21: return "21_Glove";
                }
            }
        }
    return "";
    }

//==========================================/
void ip_baseitem_filter(object user, object item)
//==========================================/
    {
    string column = get_item_type_2da_column(item);

    int ccd = get_client_iid(IGI_RES_TRACKER) | CI_IP | INCR_CCI;
    int ccd_max = get_ccd_next(ccd);

    while(ccd <= ccd_max)
        {
        if(Get2DAString("itemprops", column, get_cc_content_int(ccd)) != "")
            {
            rem_ccd_hidden(user, ccd);
            }
        else
            {
            set_ccd_hidden(user, ccd);
            }

        ccd += INCR_CCI;
        }
    }

//==========================================/
void hide_menu_apply_mod(object user)
//==========================================/
    {
    set_ccd_hidden(user, get_client_iid(IGI_RES_TRACKER) | CI_MODMENU | 4);
    }

//==========================================/
void show_menu_apply_mod(object user)
//==========================================/
    {
    rem_ccd_hidden(user, get_client_iid(IGI_RES_TRACKER) | CI_MODMENU | 4);
    }
