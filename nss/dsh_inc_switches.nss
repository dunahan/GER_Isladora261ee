//--------------------------------------/
//CONSTANTS
//--------------------------------------/
object SW_GLOBAL_CLIENT = GetObjectByTag("shared_res_tracker");

//--------------------------------------/
//switch constants
//--------------------------------------/
const int SW_ILR = 0x1;
const int SW_ILR_VALID = 0x2;

//--------------------------------------/
//LOCAL VARIABLE STRINGS
//--------------------------------------/
const string PARAM_SW = "fs0_";

//--------------------------------------/
//PROTOTYPES
//--------------------------------------/
int get_sw_ilr_enabled(object client);
void enable_sw_ilr(object client);
void enableg_sw_ilr();
void disable_sw_ilr(object client);
void disableg_sw_ilr();

//--------------------------------------/
//IMPLEMENTATION
//--------------------------------------/
//==========================================/
int get_sw_ilr_enabled(object client)
//==========================================/
    {
    if(GetLocalInt(client, PARAM_SW) & SW_ILR_VALID)
        {
        return GetLocalInt(client, PARAM_SW) & SW_ILR;
        }
    else
        {
        return GetLocalInt(SW_GLOBAL_CLIENT, PARAM_SW) & SW_ILR;
        }
    }

//==========================================/
void enable_sw_ilr(object client)
//==========================================/
    {
    int sw_ilr = GetLocalInt(client, PARAM_SW);
    SetLocalInt(client, PARAM_SW, sw_ilr | SW_ILR_VALID | SW_ILR);
    }

//==========================================/
void enableg_sw_ilr()
//==========================================/
    {
    int sw_ilr = GetLocalInt(SW_GLOBAL_CLIENT, PARAM_SW);
    SetLocalInt(SW_GLOBAL_CLIENT, PARAM_SW, sw_ilr | SW_ILR_VALID | SW_ILR);
    }

//==========================================/
void disable_sw_ilr(object client)
//==========================================/
    {
    int sw_ilr = GetLocalInt(client, PARAM_SW);
    SetLocalInt(client, PARAM_SW, (sw_ilr | SW_ILR_VALID) & ~SW_ILR);
    }

//==========================================/
void disableg_sw_ilr()
//==========================================/
    {
    int sw_ilr = GetLocalInt(SW_GLOBAL_CLIENT, PARAM_SW);
    SetLocalInt(SW_GLOBAL_CLIENT, PARAM_SW, (sw_ilr | SW_ILR_VALID) & ~SW_ILR);
    }
