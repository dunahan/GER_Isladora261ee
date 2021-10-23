//void main() {}

//--------------------------------------/
//PROTOTYPES
//--------------------------------------/
void select_working_item(object user, object item);
string flags_summary_to_string(object item);
string ui_item_info_summary(object user);
string ui_lis_setname_renew(object item);

void hide_menu_apply_setlis(object user);
void show_menu_apply_setlis(object user);

void cp_stack_filter(object user, object item);
string cp_cost_summary_to_string(object user, int mod_cost, int cp_cnt);
void hide_menu_apply_cp(object user);
void show_menu_apply_cp(object user);

//--------------------------------------/
//#INC
//--------------------------------------/
#include "msc_inc_vars"
#include "dsh_inc_itemref"
#include "std_inc_color"
#include "std_inc_general"
#include "dsc_inc_core"

//--------------------------------------/
//IMPLEMENTATION
//--------------------------------------/
//==========================================/
void select_working_item(object user, object item)
//==========================================/
    {
    //SetLocalObject(user, WORKING_ITEM, item);
    set_working_item(user, item);

    cp_stack_filter(user, item);
    }

//==========================================/
string flags_summary_to_string(object item)
//==========================================/
    {
    string disp;

    //disp += set_string_color(UI_STR_HDR_SETFLAGS, CHDR) + UI_CHAR_NEWLINE;
    //--------------------------------------/
    if(GetItemCursedFlag(item))
        {
        disp += set_string_color(UI_STR_PARAM_FLAG_CURSED, CERR);

        if(GetPlotFlag(item))
            {
            disp += UI_CHAR_COMMA + UI_CHAR_SPACE + set_string_color(UI_STR_PARAM_FLAG_PLOT, CERR);
            }

        if(GetStolenFlag(item))
            {
            disp += UI_CHAR_COMMA + UI_CHAR_SPACE + set_string_color(UI_STR_PARAM_FLAG_STOLEN, CERR);
            }
        }

    else if(GetPlotFlag(item))
        {
        disp += set_string_color(UI_STR_PARAM_FLAG_PLOT, CERR);

        if(GetStolenFlag(item))
            {
            disp += UI_CHAR_COMMA + UI_CHAR_SPACE + set_string_color(UI_STR_PARAM_FLAG_STOLEN, CERR);
            }
        }

    else if(GetStolenFlag(item))
        {
        disp += set_string_color(UI_STR_PARAM_FLAG_STOLEN, CERR);
        }

    else
        {
        disp += UI_STR_PARAM_FLAG_NULL;
        }

    return disp;
    }

//==========================================/
string ui_item_info_summary(object user)
//==========================================/
    {
    object item = get_working_item(user);

    string disp;

    disp += set_string_color(UI_STR_HDR_MODMENU_ITEMHDR, CHDR) + UI_CHAR_NEWLINE;
    disp += GetName(item);
    /*
    string name_orig = GetName(item, TRUE);
    if(name != name_orig)
        {
        disp += set_string_color(UI_STR_SEPV + name_orig, CHLT);
        }
    */
    disp += UI_CHAR_NEWLINE;

    disp += UI_CHAR_NEWLINE;
    disp += GetDescription(item) + UI_CHAR_NEWLINE;

    int stack_size = GetItemStackSize(item);
    if(stack_size > 1)
        {
        disp += UI_CHAR_SPACE + set_string_color(UI_CHAR_BRK2_START + UI_STR_UNIT_STACK + IntToString(stack_size) + UI_CHAR_BRK2_END, CHLT);
        }
    disp += set_string_color(UI_STR_PREFIX_SETFLAGS + flags_summary_to_string(item), CHLT);

    set_sid_str(user, SID_ITM_SEL_MSC, disp);

    return disp;
    }

//==========================================/
string ui_lis_setname_renew(object item)
//==========================================/
    {
    string disp;

    //disp += set_string_color(UI_STR_HDR_SETLIS_ITEMNAME, CHDR) + UI_CHAR_NEWLINE;
    disp += GetName(item) + UI_CHAR_NEWLINE;
    disp += UI_CHAR_NEWLINE;
    disp += GetDescription(item) + UI_CHAR_NEWLINE;
    disp += UI_CHAR_NEWLINE;
    disp += set_string_color(UI_STR_HDR_SETLIS_RENEW, CHDR);

    return disp;
    }

//==========================================/
void hide_menu_apply_setlis(object user)
//==========================================/
    {
    int iid_shared = get_client_iid(MSC_RES_TRACKER);

    set_ccd_hidden(user, iid_shared | CI_SETLIS | 1);
    set_ccd_hidden(user, iid_shared | CI_SETLIS | 2);
    }

//==========================================/
void show_menu_apply_setlis(object user)
//==========================================/
    {
    int iid_shared = get_client_iid(MSC_RES_TRACKER);

    rem_ccd_hidden(user, iid_shared | CI_SETLIS | 1);
    rem_ccd_hidden(user, iid_shared | CI_SETLIS | 2);
    }

//==========================================/
void cp_stack_filter(object user, object item)
//==========================================/
    {
    int ccd = get_client_iid(MSC_RES_TRACKER) | CI_CP | INCR_CCI;

    int ccd0 = ccd + get_item_max_stack_size(item) + CP_ITEM_CNT_MIN;
    int ccd_max = get_ccd_next(ccd);

    while(ccd < ccd0)
        {
        rem_ccd_hidden(user, ccd);

        ccd += INCR_CCI;
        }

    while(ccd <= ccd_max)
        {
        set_ccd_hidden(user, ccd);

        ccd += INCR_CCI;
        }
    }

//==========================================/
string cp_cost_summary_to_string(object user, int mod_cost, int cp_cnt)
//==========================================/
    {
    int user_gp = GetGold(user);

    object item = get_working_item(user);

    string disp;
    disp += set_string_color(UI_STR_HDR_CP_SEL, CHDR) + UI_CHAR_NEWLINE;
    disp += GetName(item) + UI_CHAR_SPACE + set_string_color(UI_CHAR_BRK2_START + UI_STR_UNIT_STACK + IntToString(cp_cnt) + UI_CHAR_BRK2_END, CHLT) + UI_CHAR_NEWLINE;
    disp += UI_CHAR_NEWLINE;

    string scp_cost = set_string_color(UI_STR_HDR_CP_COST, CHDR) + IntToString(mod_cost) + UI_STR_UNIT_GP;
    if(mod_cost > user_gp)
        {
        scp_cost = set_string_color(scp_cost, CERR);
        hide_menu_apply_cp(OBJECT_SELF);
        }
    else
        {
        show_menu_apply_cp(OBJECT_SELF);
        }

    disp += scp_cost;

    return disp;
    }

//==========================================/
void hide_menu_apply_cp(object user)
//==========================================/
    {
    set_ccd_hidden(user, get_client_iid(MSC_RES_TRACKER) | CI_CP_MENU | 1);
    }

//==========================================/
void show_menu_apply_cp(object user)
//==========================================/
    {
    rem_ccd_hidden(user, get_client_iid(MSC_RES_TRACKER) | CI_CP_MENU | 1);
    }
