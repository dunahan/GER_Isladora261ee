#include "xid_inc_reg"
#include "xid_inc_general"

//--------------------------------------/
//SID handler names
//--------------------------------------/
const string IGI_XID_MAIN = "igi_modn_xid";
const string MSC_XID_MAIN = "msc_modn_xid";

//--------------------------------------/
//MAIN
//--------------------------------------/
//==========================================/
void main()
//==========================================/
    {
    switch(get_xid(OBJECT_SELF))
        {
        case SID_ITM_SEL_IGI:
        case SID_IP_SEL:
        case SID_IP_ADD:
        case SID_IPR_SEL:
        case SID_IPR_REMOVE:
        case SID_CH:
        case SID_CH_SEL:
        case SID_CH_SET:
        case SID_MOD_APPLY:
        case SID_MOD_CANCEL:
            {
            ExecuteScript(IGI_XID_MAIN, OBJECT_SELF);

            break;
            }

        case SID_ITM_SEL_MSC:
        case SID_SETLIS_RENEW:
        case SID_SETLIS_ACCEPTNAME:
        case SID_SETLIS_ACCEPTDISC:
        case SID_SETFLAGS:
        case SID_SETFLAGS_CURSED:
        case SID_SETFLAGS_PLOT:
        case SID_SETFLAGS_STOLEN:
        case SID_CP:
        case SID_CP_SEL:
        case SID_CP_SET:
            {
            ExecuteScript(MSC_XID_MAIN, OBJECT_SELF);

            break;
            }
        }
    }
