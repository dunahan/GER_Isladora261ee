#include "std_inc_general"
#include "std_inc_color"
#include "std_inc_char"

#include "prs_inc_parser"

#include "xid_inc_reg"

#include "dsh_inc_vars"
#include "dsh_inc_itemref"
#include "dsh_inc_modparam"

#include "dsc_inc_core"
#include "dsc_inc_vars"

#include "msc_inc_general"

//==========================================/
void main()
//==========================================/
    {
    object user = GetPCChatSpeaker();

    string msg = parse_init(GetPCChatMessage(), user);

    switch(get_xid(user))
        {
        case SID_SETLIS_RENEW:
            {
            object item = get_working_item(user);

            mod_set_str(user, msg);
            show_menu_apply_setlis(user);

            string disp = ui_lis_setname_renew(item) + UI_CHAR_NEWLINE;
            disp += set_string_color(UI_STR_HDR_SETLIS_DETECT, CHDR) + UI_CHAR_NEWLINE;
            disp += msg;

            set_sid_str(user, SID_SETLIS_RENEW, disp);

            restart_conversation(user, user, DSC_CV_MAIN);

            break;
            }
        }
    }
