#include "std_inc_general"
#include "std_inc_char"

#include "xid_inc_reg"
#include "xid_inc_general"

#include "dsc_inc_core"

#include "dsh_inc_vars"
#include "dsh_inc_itemref"
#include "dsh_inc_modparam"

#include "msc_inc_general"

//==========================================/
void main()
//==========================================/
    {
    int iid = get_client_iid(OBJECT_SELF);

    switch(get_xid(OBJECT_SELF))
        {
        case SID_ITM_SEL_MSC:
            {
            ui_item_info_summary(OBJECT_SELF);

            break;
            }

        case SID_SETLIS_RENEW:
            {
            object item = get_working_item(OBJECT_SELF);

            hide_menu_apply_setlis(OBJECT_SELF);

            string disp = ui_lis_setname_renew(item);
            set_sid_str(OBJECT_SELF, SID_SETLIS_RENEW, disp);

            break;
            }

        case SID_SETLIS_ACCEPTNAME:
            {
            string s = mod_get_str(OBJECT_SELF);
            object item = get_working_item(OBJECT_SELF);

            SetName(item, s);
            ui_item_info_summary(OBJECT_SELF);

            break;
            }

        case SID_SETLIS_ACCEPTDISC:
            {
            string s = mod_get_str(OBJECT_SELF);
            object item = get_working_item(OBJECT_SELF);

            SetDescription(item, s);
            ui_item_info_summary(OBJECT_SELF);

            break;
            }

        case SID_SETFLAGS:
            {
            object item = get_working_item(OBJECT_SELF);

            string disp;

            disp += set_string_color(UI_STR_PREFIX_SETFLAGS, CHDR) + UI_CHAR_NEWLINE;
            disp += flags_summary_to_string(item);

            set_sid_str(OBJECT_SELF, SID_SETFLAGS, disp);

            break;
            }

        case SID_SETFLAGS_CURSED:
            {
            object item = get_working_item(OBJECT_SELF);
            SetItemCursedFlag(item, !GetItemCursedFlag(item));

            string disp;

            disp += set_string_color(UI_STR_PREFIX_SETFLAGS, CHDR) + UI_CHAR_NEWLINE;
            disp += flags_summary_to_string(item);

            set_sid_str(OBJECT_SELF, SID_SETFLAGS_CURSED, disp);
            set_sid_str(OBJECT_SELF, SID_SETFLAGS, disp);

            //int ccd_working_item = get_working_item_ccd(OBJECT_SELF);
            //set_inv_item_name(ccd_working_item, GetName(item));

            ui_item_info_summary(OBJECT_SELF);

            break;
            }

        case SID_SETFLAGS_PLOT:
            {
            object item = get_working_item(OBJECT_SELF);
            SetPlotFlag(item, !GetPlotFlag(item));

            string disp;

            disp += set_string_color(UI_STR_PREFIX_SETFLAGS, CHDR) + UI_CHAR_NEWLINE;
            disp += flags_summary_to_string(item);

            set_sid_str(OBJECT_SELF, SID_SETFLAGS_PLOT, disp);
            set_sid_str(OBJECT_SELF, SID_SETFLAGS, disp);

            //int ccd_working_item = get_working_item_ccd(OBJECT_SELF);
            //set_inv_item_name(ccd_working_item, GetName(item));

            ui_item_info_summary(OBJECT_SELF);

            break;
            }

        case SID_SETFLAGS_STOLEN:
            {
            object item = get_working_item(OBJECT_SELF);
            SetStolenFlag(item, !GetStolenFlag(item));

            string disp;

            disp += set_string_color(UI_STR_PREFIX_SETFLAGS, CHDR) + UI_CHAR_NEWLINE;
            disp += flags_summary_to_string(item);

            set_sid_str(OBJECT_SELF, SID_SETFLAGS_STOLEN, disp);
            set_sid_str(OBJECT_SELF, SID_SETFLAGS, disp);

            //int ccd_working_item = get_working_item_ccd(OBJECT_SELF);
            //set_inv_item_name(ccd_working_item, GetName(item));

            ui_item_info_summary(OBJECT_SELF);

            break;
            }

        case SID_CP_SEL:
            {
            int hccd0 = get_ccd_hist(OBJECT_SELF, 0);
            int cp_cnt = get_cc_content_int(hccd0);
            mod_set_int(OBJECT_SELF, cp_cnt);

            int user_gp = GetGold(OBJECT_SELF);

            object item = get_working_item(OBJECT_SELF);

            int mod_cost = get_item_stack_cost(item, cp_cnt, OBJECT_SELF);
            if(mod_cost < CP_COST_MIN)
                {
                mod_cost = CP_COST_MIN;
                }

            mod_cost_set(OBJECT_SELF, mod_cost);

            set_sid_str(OBJECT_SELF, SID_CP_SEL, cp_cost_summary_to_string(OBJECT_SELF, mod_cost, cp_cnt));

            break;
            }

        case SID_CP_SET:
            {
            int cp_cnt = mod_get_int(OBJECT_SELF);
            int mod_cost = mod_cost_get(OBJECT_SELF);

            object item = get_working_item(OBJECT_SELF);

            if(give_gold(-mod_cost, OBJECT_SELF))
                {
                copy_item_stack(item, OBJECT_SELF, cp_cnt, OBJECT_SELF);
                //generate_inv_item_list(OBJECT_SELF);
                }

            break;
            }
        }
    }
