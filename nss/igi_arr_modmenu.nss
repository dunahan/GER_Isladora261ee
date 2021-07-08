//void main() {}
#include "dsc_inc_core"

//==========================================/
void arr_modmenu_main(object client)
//==========================================/
    {
    int iid = get_client_iid(client);
    int cd = create_container_at_cd(client, iid | CI_MODMENU);

        //create menu add item properties
        {
        create_content_int(client, cd, CCD_NAME_IP, create_link_jal(iid | CI_IP | SID_IP), IP_PARAM_END);

        int cd_menu = create_container_at_cd(client, iid | CI_IP_MENU);
        create_content_int(client, cd_menu, CCD_NAME_IP_ADD, create_link_jalh(iid | CI_MODMENU | SID_IP_ADD));
        create_content_int(client, cd_menu, CCD_NAME_MAINMENU, create_link_jalh(iid | CI_MODMENU));
        }

        //create menu remove item properties
        {
        create_content_int(client, cd, CCD_NAME_IPR, create_link_jal(IID_LINK_SELF | CI_IPR | SID_IPR));

        int cd_menu = create_container_at_cd(client, iid | CI_IPR_MENU);
        create_content_int(client, cd_menu, CCD_NAME_IPR_REMOVE, create_link_jalh(iid | CI_MODMENU | SID_IPR_REMOVE));
        create_content_int(client, cd_menu, CCD_NAME_MAINMENU, create_link_jalh(iid | CI_MODMENU));
        }

        //create menu set charges
        {
        create_content_int(client, cd, CCD_NAME_CH, create_link_jal(iid | CI_CH | SID_CH));

        int cd_menu = create_container_at_cd(client, iid | CI_CH_MENU);
        create_content_int(client, cd_menu, CCD_NAME_CH_SET, create_link_jalh(iid | CI_MODMENU | SID_CH_SET));
        create_content_int(client, cd_menu, CCD_NAME_MAINMENU, create_link_jalh(iid | CI_MODMENU));
        }

        //create option apply changes
        {
        create_content_int(client, cd, CCD_NAME_IP_APPLY_MOD, SID_MOD_APPLY);
        }

        //create option cancel changes
        {
        create_content_int(client, cd, CCD_NAME_IP_CANCEL_MOD + UI_CHAR_NEWLINE + UI_CHAR_NEWLINE, SID_MOD_CANCEL);
        }
    }
