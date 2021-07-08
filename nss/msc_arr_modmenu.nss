//void main() {}
#include "dsc_inc_core"

//==========================================/
void arr_modmenu_main(object client)
//==========================================/
    {
    int iid = get_client_iid(client);
    int cd = create_container_at_cd(client, iid | CI_MODMENU);

        //create menu set item name
        {
        create_content_int(client, cd, CCD_NAME_SETLIS, create_link_jal(iid | CI_SETLIS | SID_SETLIS_RENEW));

        int cd_menu = create_container_at_cd(client, iid | CI_SETLIS);
        //create_content_int(client, cd_menu, CCD_NAME_SETLIS_RENEW, SID_SETLIS_RENEW);
        create_content_int(client, cd_menu, CCD_NAME_SETLIS_ACCEPTNAME, create_link_jalh(iid | CI_MODMENU | SID_SETLIS_ACCEPTNAME));
        create_content_int(client, cd_menu, CCD_NAME_SETLIS_ACCEPTDISC, create_link_jalh(iid | CI_MODMENU | SID_SETLIS_ACCEPTDISC));
        create_content_int(client, cd_menu, CCD_NAME_MAINMENU, create_link_jalh(iid | CI_MODMENU));
        }

        //create menu set flags
        {
        create_content_int(client, cd, CCD_NAME_SETFLAGS, create_link_jal(iid | CI_SETFLAGS | SID_SETFLAGS));

        int cd_menu = create_container_at_cd(client, iid | CI_SETFLAGS);
        create_content_int(client, cd_menu, CCD_NAME_SETFLAGS_CURSED, SID_SETFLAGS_CURSED);
        create_content_int(client, cd_menu, CCD_NAME_SETFLAGS_PLOT, SID_SETFLAGS_PLOT);
        create_content_int(client, cd_menu, CCD_NAME_SETFLAGS_STOLEN, SID_SETFLAGS_STOLEN);
        }

        //create menu copy item
        {
        create_content_int(client, cd, CCD_NAME_CP, create_link_jal(iid | CI_CP | SID_CP));

        int cd_menu = create_container_at_cd(client, iid | CI_CP_MENU);
        create_content_int(client, cd_menu, CCD_NAME_CP_SET, create_link_jalh(iid | CI_MODMENU | SID_CP_SET));
        create_content_int(client, cd_menu, CCD_NAME_MAINMENU, create_link_jalh(iid | CI_MODMENU));
        }
    }
