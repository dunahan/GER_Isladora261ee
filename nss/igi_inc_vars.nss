//--------------------------------------/
//constants
//--------------------------------------/
object IGI_RES_TRACKER = GetObjectByTag("igi_res_tracker");

//--------------------------------------/
//CONSTANTS - CIs
//--------------------------------------/
const int CI_INV = 0x400;
const int CI_IP = 0x800;
const int CI_IP_MENU = 0xC00;
const int CI_IPR = 0x1000;
const int CI_IPR_MENU = 0x1400;
const int CI_CH = 0x1800;
const int CI_CH_MENU = 0x1C00;
const int CI_MODMENU = 0x2000;

//--------------------------------------/
//display texts - menu screen names
//--------------------------------------/
const string CCD_NAME_IP = "Add properties to item";
const string CCD_NAME_IP_ADD = "Add property";

const string CCD_NAME_IPR = "Remove properties from item";
const string CCD_NAME_IPR_REMOVE = "Remove property";

const string CCD_NAME_CH = "Set item charge count";
const string CCD_NAME_CH_SET = "Set charge count";

const string CCD_NAME_IP_APPLY_MOD = "Apply all";
const string CCD_NAME_IP_CANCEL_MOD = "Cancel all";

//--------------------------------------/
//display texts - info disp prefix/headers
//--------------------------------------/
const string UI_STR_PREFIX_CH_CNT = "Charges: ";
const string UI_STR_PREFIX_CH_SETTO = "set to: ";
const string UI_STR_PREFIX_ITEM_VALUE_CURRENT = "Current value: ";
const string UI_STR_PREFIX_MODCOST_TOTAL = "Cost total: ";
const string UI_STR_PREFIX_ITEM_VALUE_RESULT = "Resulting value: ";

const string UI_STR_HDR_ITEM_MOD_LIST = "Item properties:";
const string UI_STR_HDR_IP_SEL = "Add this property:";
const string UI_STR_HDR_IPR_SEL = "Remove this property:";
const string UI_STR_HDR_CH_SEL = "Set new charge count:";

const string UI_STR_HDR_WELCOME = "Item properties forge:\n\nSelect an item to add or remove properties.";

//--------------------------------------/
//MISC FILTER
//--------------------------------------/
const int IP_PARAM_END = -1;

const int ITEM_CHARGE_CNT_MIN = 1;
const int ITEM_CHARGE_CNT_MAX = 50;

//--------------------------------------/
//LOCAL VARIABLE STRINGS
//--------------------------------------/
const string WORKING_ITEM_BLANK = "iv0_";
const string WORKING_ITEM_VALUE = "iv1_";

const string PARAM_MODCOST_TOTAL = "iv2_";
const string PARAM_SID_CH = "iv3_";

const string USER_CACHE = "iv4_";
