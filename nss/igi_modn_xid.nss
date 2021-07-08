#include "std_inc_general"
#include "std_inc_char"
#include "std_inc_ip"

#include "xid_inc_reg"
#include "xid_inc_general"

#include "dsc_inc_core"

#include "dsh_inc_vars"
#include "dsh_inc_itemref"
#include "dsh_inc_modparam"
#include "dsh_inc_switches"

#include "igi_inc_general"

//==========================================/
void main()
//==========================================/
    {
    int iid = get_client_iid(OBJECT_SELF);

    switch(get_xid(OBJECT_SELF))
        {
        case SID_ITM_SEL_IGI:
            {
            ui_item_mod_summary(OBJECT_SELF);

            break;
            }

        case SID_IP_SEL:
            {
            int ip_param0;
            int ip_param1;
            int ip_param2;
            int ip_param3;

            //reconstruct ip...
            int hccd0 = get_ccd_hist(OBJECT_SELF, 0);
            int h0 = get_cc_content_int(hccd0);

            int hccd1 = get_ccd_hist(OBJECT_SELF, 1);
            int h1 = get_cc_content_int(hccd1);

            if(h1 != IP_PARAM_END)
                {
                int hccd2 = get_ccd_hist(OBJECT_SELF, 2);
                int h2 = get_cc_content_int(hccd2);

                if(h2 != IP_PARAM_END)
                    {
                    int hccd3 = get_ccd_hist(OBJECT_SELF, 3);
                    int h3 = get_cc_content_int(hccd3);

                    if(h3 != IP_PARAM_END)
                        {
                        ip_param0 = h3;
                        ip_param1 = h2;
                        ip_param2 = h1;
                        ip_param3 = h0;
                        }
                    else
                        {
                        ip_param0 = h2;
                        ip_param1 = h1;
                        ip_param2 = h0;
                        }
                    }
                else
                    {
                    ip_param0 = h1;
                    ip_param1 = h0;
                    }
                }
            else
                {
                ip_param0 = h0;
                }

            //ip to add
            itemproperty ip = ip_param_to_ip(ip_param0, ip_param1, ip_param2, ip_param3);

            int cost = get_item_property_add_cost(OBJECT_SELF, ip);

            mod_set_int(OBJECT_SELF, ip_to_int(ip));
            mod_cost_set(OBJECT_SELF, cost);

            string disp;
            disp += set_string_color(UI_STR_HDR_IP_SEL, CHDR) + UI_CHAR_NEWLINE;
            disp += set_string_color(ip_to_string(ip), CLNK);

            ui_mod_confirmation(OBJECT_SELF, SID_IP_SEL, disp);

            break;
            }

        case SID_IP_ADD:
            {
            int ip_int = mod_get_int(OBJECT_SELF);
            int cost_total = mod_cost_total_addto(OBJECT_SELF, mod_cost_get(OBJECT_SELF));

            add_item_property(OBJECT_SELF, ip_int);
            ui_item_mod_summary(OBJECT_SELF);

            break;
            }

        case SID_IPR_SEL:
            {
            int hccd0 = get_ccd_hist(OBJECT_SELF, 0);

            int cost = get_item_property_remove_cost(OBJECT_SELF, hccd0);

            mod_set_int(OBJECT_SELF,  hccd0);
            mod_cost_set(OBJECT_SELF, cost);

            string disp;
            disp += set_string_color(UI_STR_HDR_IPR_SEL, CHDR) + UI_CHAR_NEWLINE;
            disp += set_string_color(get_cc_name(hccd0), CLNK);

            ui_mod_confirmation(OBJECT_SELF, SID_IPR_SEL, disp);

            break;
            }

        case SID_IPR_REMOVE:
            {
            int ccd = mod_get_int(OBJECT_SELF);
            int cost_total = mod_cost_total_addto(OBJECT_SELF, mod_cost_get(OBJECT_SELF));

            remove_item_property(OBJECT_SELF, ccd);
            ui_item_mod_summary(OBJECT_SELF);

            break;
            }

        case SID_CH_SEL:
            {
            int hccd0 = get_ccd_hist(OBJECT_SELF, 0);
            int ch_cnt = get_cc_content_int(hccd0);
            mod_set_int(OBJECT_SELF, ch_cnt);

            int cost = get_ch_set_cost(OBJECT_SELF, ch_cnt);
            mod_cost_set(OBJECT_SELF, cost);

            string disp;
            disp += set_string_color(UI_STR_HDR_CH_SEL, CHDR) + UI_CHAR_NEWLINE;
            disp += set_string_color(IntToString(ch_cnt), CLNK);

            ui_mod_confirmation(OBJECT_SELF, SID_CH_SEL, disp);

            break;
            }

        case SID_CH_SET:
            {
            int ch_cnt = mod_get_int(OBJECT_SELF);
            int cost_total = mod_cost_total_addto(OBJECT_SELF, mod_cost_get(OBJECT_SELF));

            set_ch_cnt(OBJECT_SELF, ch_cnt);

            ui_item_mod_summary(OBJECT_SELF);

            break;
            }

        case SID_MOD_APPLY:
            {
            int mod_cost = mod_cost_total_get(OBJECT_SELF);

            if(give_gold(-mod_cost, OBJECT_SELF))
                {
                refresh_working_item(OBJECT_SELF);
                ui_item_mod_summary(OBJECT_SELF);
                }

            break;
            }

        case SID_MOD_CANCEL:
            {
            object item = get_working_item(OBJECT_SELF);

            mod_cost_total_clear(OBJECT_SELF);
            reset_ch_cnt(OBJECT_SELF, item);
            hide_menu_apply_mod(OBJECT_SELF);

            refresh_ip_list_original(OBJECT_SELF, item);
            ui_item_mod_summary(OBJECT_SELF);

            break;
            }
        }
    }
