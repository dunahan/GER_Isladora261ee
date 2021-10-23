//--------------------------------------/
//constants
//--------------------------------------/
object MSC_RES_TRACKER = GetObjectByTag("msc_res_tracker");

//--------------------------------------/
//CONSTANTS - CIs
//--------------------------------------/
const int CI_MODMENU = 0x400;
const int CI_INV = 0x800;
const int CI_SETLIS = 0xC00;
const int CI_SETFLAGS = 0x1000;
const int CI_CP = 0x1400;
const int CI_CP_MENU = 0x1800;

//--------------------------------------/
//display texts - menu screen names
//--------------------------------------/
const string CCD_NAME_SETLIS = "Modify item name and/or description";
const string CCD_NAME_SETLIS_ACCEPTNAME = "Set as name";
const string CCD_NAME_SETLIS_ACCEPTDISC = "Set as description";
const string CCD_NAME_CP = "Create copies of this item";
const string CCD_NAME_CP_SET = "Create copies to inventory";

const string CCD_NAME_SETFLAGS = "Toggle item flags";
const string CCD_NAME_SETFLAGS_CURSED = "Toggle cursed flag";
const string CCD_NAME_SETFLAGS_PLOT = "Toggle plot flag";
const string CCD_NAME_SETFLAGS_STOLEN = "Toggle stolen flag";

//--------------------------------------/
//display texts - info disp prefix/headers
//--------------------------------------/
const string UI_STR_HDR_MODMENU_ITEMHDR = "Selected item: ";
//const string UI_STR_HDR_SETLIS_ITEMNAME = "Current name and description:";
const string UI_STR_HDR_SETLIS_RENEW = "Listening - Enter a new name or description for this item in chat.";
const string UI_STR_HDR_SETLIS_DETECT = "Detected:";
const string UI_STR_HDR_CP_SEL = "Make copies of this item: ";
const string UI_STR_HDR_CP_COST = "Cost: ";

const string UI_STR_HDR_WELCOME = "Item manager:\n\nSelect an item to change its name, description or flags.";

//--------------------------------------/
//display texts - other
//--------------------------------------/
const string UI_STR_PARAM_FLAG_CURSED = "cursed";
const string UI_STR_PARAM_FLAG_PLOT = "plot";
const string UI_STR_PARAM_FLAG_STOLEN = "stolen";
const string UI_STR_PARAM_FLAG_NULL = "none";

//--------------------------------------/
//MISC FILTER
//--------------------------------------/
const int CP_ITEM_CNT_MIN = 2;
const int CP_COST_MIN = 1;
