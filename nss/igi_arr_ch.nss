//void main() {}
#include "dsc_inc_core"

//==========================================/
void arr_ch_main(object client)
//==========================================/
    {
    int iid = get_client_iid(client);

    int cd = create_container_at_cd(client, iid | CI_CH);
    int cc_param = create_link_jal(iid | CI_CH_MENU | SID_CH_SEL);

    //make folders
    //----------------------------------------//
    int n = ITEM_CHARGE_CNT_MIN;
    while(n <= ITEM_CHARGE_CNT_MAX)
        {
        create_content_int(client, cd, IntToString(n) + UI_STR_UNIT_CH, cc_param, n);

        n++;
        }
    }
