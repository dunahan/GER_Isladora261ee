//--------------------------------------/
//GENERAL COLOR FUNCTIONS
//--------------------------------------/

//--------------------------------------/
//CONSTANTS
//--------------------------------------/
object COLOR_STRING_CLIENT = GetObjectByTag("shared_res_tracker");
const int COLOR_STRING_LEN = 17;
const int COLOR_VAL_MAX = 0xFF;
const string COLOR_TAG_END = "</c>";

//--------------------------------------/
//FILTERS
//--------------------------------------/
const int FILTER_CVAL = 0xFF;
const int BITLEN_CVAL = 8;

//--------------------------------------/
//LOCAL VARIABLE STRINGS
//--------------------------------------/
const string COLOR_STRING = "ui_str_color";
const string COLOR_STRING_CACHE = "sc0_";

//--------------------------------------/
//PROTOTYPES
//--------------------------------------/
string get_color_string_val(int n);
int get_cval(int rval, int gval, int bval);
string set_string_color(string s, int cval);

//--------------------------------------/
//IMPLEMENTATION
//--------------------------------------/
//==========================================/
//get nth character from color string
string get_color_string_val(int n)
//==========================================/
    {
    string color_header_val = GetLocalString(COLOR_STRING_CLIENT, COLOR_STRING_CACHE + IntToHexString(n));
    if(color_header_val == "")
        {
        color_header_val = GetSubString(GetLocalString(COLOR_STRING_CLIENT, COLOR_STRING), n, 1);
        }

    return color_header_val;
    }

//==========================================/
int get_cval(int rval, int gval, int bval)
//==========================================/
    {
    int cval = rval << BITLEN_CVAL | gval;
    cval = cval << BITLEN_CVAL | bval;

    return cval;
    }

//==========================================/
//set a string to some color RGB
//cval: R<<16|G<<8|B
string set_string_color(string s, int cval)
//==========================================/
    {
    int bval = FILTER_CVAL & cval;
    cval >>= BITLEN_CVAL;
    int gval = FILTER_CVAL & cval;
    cval >>= BITLEN_CVAL;
    int rval = FILTER_CVAL & cval;

    rval = rval*(COLOR_STRING_LEN - 1)/COLOR_VAL_MAX;
    gval = gval*(COLOR_STRING_LEN - 1)/COLOR_VAL_MAX;
    bval = bval*(COLOR_STRING_LEN - 1)/COLOR_VAL_MAX;

    string result = "<c";
    string color_string = GetLocalString(COLOR_STRING_CLIENT, COLOR_STRING);

    //----------------------------------------//
    string color_header_rval = GetLocalString(COLOR_STRING_CLIENT, COLOR_STRING_CACHE + IntToHexString(rval));
    if(color_header_rval == "")
        {
        color_header_rval = GetSubString(color_string, rval, 1);

        SetLocalString(COLOR_STRING_CLIENT, COLOR_STRING_CACHE + IntToHexString(rval), color_header_rval);
        }
    result += color_header_rval;

    //----------------------------------------//
    string color_header_gval = "";
    if(gval == rval)
        {
        result += color_header_rval;
        }
    else
        {
        color_header_gval = GetLocalString(COLOR_STRING_CLIENT, COLOR_STRING_CACHE + IntToHexString(gval));
        if(color_header_gval == "")
            {
            color_header_gval = GetSubString(color_string, gval, 1);

            SetLocalString(COLOR_STRING_CLIENT, COLOR_STRING_CACHE + IntToHexString(gval), color_header_gval);
            }
        result += color_header_gval;
        }

    //----------------------------------------//
    if(bval == rval)
        {
        result += color_header_rval;
        }
    else if(bval == gval)
        {
        result += color_header_gval;
        }
    else
        {
        string color_header_bval = GetLocalString(COLOR_STRING_CLIENT, COLOR_STRING_CACHE + IntToHexString(bval));
        if(color_header_bval == "")
            {
            color_header_bval = GetSubString(color_string, bval, 1);

            SetLocalString(COLOR_STRING_CLIENT, COLOR_STRING_CACHE + IntToHexString(bval), color_header_bval);
            }
        result += color_header_bval;
        }

    return (result + ">" + s + COLOR_TAG_END);
    }
