#include "std_inc_general"

#include "xid_inc_reg"

#include "dsc_inc_core"

#include "dsh_inc_vars"

#include "msc_inc_vars"

#include "msc_arr_cp"
#include "msc_arr_modmenu"

//==========================================/
void main()
//==========================================/
    {
    set_null_creature_effect(MSC_RES_TRACKER);
    //--------------------------------------/

    assign_iid_to_client(MSC_RES_TRACKER);

    //--------------------------------------/
    arr_cp_main(MSC_RES_TRACKER);
    arr_modmenu_main(MSC_RES_TRACKER);
    }
