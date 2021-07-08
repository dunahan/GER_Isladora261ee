#include "std_inc_general"
#include "std_inc_char"

#include "xid_inc_reg"

#include "dsc_inc_core"
#include "dsh_inc_vars"
#include "dsh_inc_switches"

#include "igi_inc_vars"
#include "igi_arr_2da"
#include "igi_arr_modmenu"
#include "igi_arr_ip"
#include "igi_arr_ch"

//==========================================/
void main()
//==========================================/
    {
    set_null_creature_effect(IGI_RES_TRACKER);
    //--------------------------------------/

    assign_iid_to_client(IGI_RES_TRACKER);
    //set ILR sw at startup
    //enableg_sw_ilr();
    disableg_sw_ilr();

    //--------------------------------------/
    set_2da_range(IGI_RES_TRACKER);
    arr_ip_main(IGI_RES_TRACKER);
    arr_ch_main(IGI_RES_TRACKER);
    arr_modmenu_main(IGI_RES_TRACKER);
    }
