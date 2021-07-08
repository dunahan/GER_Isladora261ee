#include "std_inc_general"
#include "std_inc_char"
#include "std_inc_ip"

#include "xid_inc_reg"

#include "dsc_inc_core"

#include "dsh_inc_vars"
#include "dsh_inc_itemref"

#include "msc_inc_general"
#include "x2_inc_switches"

//==========================================/
void main()
//==========================================/
    {
    switch(GetUserDefinedItemEventNumber())
        {
        case X2_ITEM_EVENT_ACTIVATE:
            {
            object item = GetItemActivatedTarget();
            if(GetIsObjectValid(item))
                {
                object user = GetItemActivator();

                if(GetObjectType(item) == OBJECT_TYPE_ITEM)
                    {
                    int iid = get_client_iid(user);
                    if(!iid)
                        {
                        iid = assign_iid_to_client(user);
                        }

                    //generate_inv_item_list(user);
                    //ui_initialize(user, iid | CI_INV, SID_INIT_DEF);

                    select_working_item(user, item);
                    //ui_item_mod_summary(user);
                    ui_initialize(user, get_client_iid(MSC_RES_TRACKER) | CI_MODMENU, SID_ITM_SEL_MSC);

                    start_conversation(user, user, DSC_CV_MAIN);
                    }
                else
                    {
                    SendMessageToPC(user, "Invalid target object - Target must be an item.");
                    }
                }
            break;
            }
        }
    }
