//void main() {}
#include "dsc_inc_core"

//==========================================/
void arr_cp_main(object client)
//==========================================/
    {
    int iid = get_client_iid(client);

    int cd = create_container_at_cd(client, iid | CI_CP);
    int cc_param = create_link_jal(iid | CI_CP_MENU | SID_CP_SEL);

    //make folders
    //----------------------------------------//
    int n = ITEM_STACK_SIZE_MIN;
    while(n <= ITEM_STACK_SIZE_MAX)
        {
        create_content_int(client, cd, UI_STR_UNIT_STACK + IntToString(n), cc_param, n);

        n++;
        }
    }
