//void main() {}
#include "dsc_inc_core"
#include "std_inc_ip"
#include "std_inc_general"
#include "dsh_inc_itemref"
#include "dsh_inc_modparam"

//==========================================/
void arr_ipr_main(object client, object item)
//==========================================/
    {
    int iid = get_client_iid(client);
    int iid_shared = get_client_iid(IGI_RES_TRACKER);

    int cd = create_container_at_cd(client, iid | CI_IPR);
    set_cci(cd);

    int cc_param = create_link_jal(iid_shared | CI_IPR_MENU | SID_IPR_SEL);

    itemproperty ip = GetFirstItemProperty(item);
    while(GetIsItemPropertyValid(ip))
        {
        create_content_int(client, cd, ip_to_string(ip), cc_param, ip_to_int(ip));

        ip = GetNextItemProperty(item);
        }
    }
