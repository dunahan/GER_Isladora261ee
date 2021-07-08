//--------------------------------------/
//CONSTANTS
//--------------------------------------/
object IID_TRACKER = GetObjectByTag("shared_res_tracker");

const int CCI_DISP_OFFSET_DEF = 1;
const int CCI_SEL_DEF = 0;

const int HSID_DEF = 1;
const int HI_DEF = 0x400;
const int HSEL_DEF = 0x400;

const int CI_ALLOCATION_START = 0x10000;

const int UI_CCI_DISP_CNT_MAX = 30;
const int UI_CCI_SCROLL_INCR = 30;

const string DSC_CHAR_NEWLINE = "\n";
const string DSC_CHAR_INDSEL = "*";

const string DSC_STR_SCRDN = "...scroll down...";
const string DSC_STR_SCRUP = "...scroll up...";
const string DSC_STR_BACK = "...back...";

const int IID_LINK_SELF = 0;

const int TOKEN_SID_PRINT = 433;
const int TOKEN_CCI_INDEX_START = 400;
const int TOKEN_CCI_OPT_UP = 430;
const int TOKEN_CCI_OPT_DN = 431;
const int TOKEN_CCI_OPT_BK = 432;

const string XID_ROOT = "xid_modn_root";
const string DSC_CV_MAIN = "dsc_cv_main";

//--------------------------------------/
//FLAGS
//--------------------------------------/
const int HIDDEN_BIT = 0x40000000; //[31]
const int PARAM_VALID_BIT = 0x80000000; //[30]

//linking parameters
const int LP_JAL = 0x40; //29:10 specifies link target
const int LP_JALH = 0x80; //29:10 specifies link target

//misc parameters
const int USER_DEF_BIT1 = 0x100; //[6]
const int USER_DEF_BIT2 = 0x200;

//--------------------------------------/
//FILTERS
//--------------------------------------/
const int FILTER_IID = 0x3FF00000; //[29:20]
const int INCR_IID = 0x100000; //[20]
const int BITLEN_IID = 10;

const int FILTER_CI = 0xFFC00; //[19:10]
const int INCR_CI = 0x400;
const int BITLEN_CI = 10;

const int FILTER_CD = 0x3FFFFC00; //[29:10]
const int BITLEN_CD = 20;

const int FILTER_CCI = 0x3FF; //[9:0]
const int INCR_CCI = 1;
const int BITLEN_CCI = 10;

const int FILTER_CCD = 0x3FFFFFFF; //[29:0]
const int BITLEN_CCD = 30;

const int FILTER_SID = 0x3F; //[5:0]
const int BITLEN_SID = 6;

const int FILTER_HSEL = 0xFFC00; //[19:10]
const int INCR_HSEL = 0x400;
const int BITLEN_HSEL = 10;

const int FILTER_HI = 0x3FF00000; //[29:20]
const int INCR_HI = 0x100000; //[20]
const int BITLEN_HI = 10;

const int FILTER_LP = 0xC0; //[7:6]
const int BITLEN_LP = 2;

//--------------------------------------/
//LOCAL VARIABLE STRINGS
//--------------------------------------/
const string IID_NEXT = "dc0_";
const string CD_NEXT = "dc1_";
const string IID_CLIENT = "dc2_";
const string CLIENT_IID = "dc3_";
const string CCD_NEXT = "dc4_";
const string CD_STRREF = "dc5_";
const string CC_NAME = "dc6_";
const string CC_PARAM = "dc7_";
const string CC_CONTENT = "dc8_";
const string HIST = "dc9_";
const string HCCD_DISP_OFFSET = "dc10_";
const string HCCD_SEL = "dc11_";

const string UI_SID_PRINT = "dc12_";
const string HSID = "dc13_";

//--------------------------------------/
//PROTOTYPES
//--------------------------------------/
int assign_iid_to_client(object client);
int create_container(object client, int iid, string cd_strref = "");
int create_container_at_cd(object client, int cd);
int create_link_jal(int cd_target, int cc_param_alternate = 0);
int create_link_jalh(int cd_target, int cc_param_alternate = 0);
int create_content_int(object client, int cd, string cc_name, int cc_param, int cc_content = 0);
int create_content_obj(object client, int cd, string cc_name, int cc_param, object cc_content = OBJECT_INVALID);

string set_ccd_name_color(int cc_param, string cc_name);
void ui_refresh(object client, int hsel, int ccd_disp_offset, int sid);
string cd_list_to_string(object client, int cd);
void set_sid_str(object client, int sid, string s);
void ui_select_cci_index(object client, int n);
void ui_initialize(object client, int cd, int sid);
void ui_select_cci_opt_dn(object client);
void ui_select_cci_opt_up(object client);
void ui_select_cci_opt_bk(object client);
void set_ccd_hidden(object client, int ccd);
void rem_ccd_hidden(object client, int ccd);
void set_ccd_user_def1(object client, int ccd);
void rem_ccd_user_def1(object client, int ccd);
void set_ccd_user_def2(object client, int ccd);
void rem_ccd_user_def2(object client, int ccd);

object get_iid_client(int iid);
int get_client_iid(object client);
int get_ccd_next(int ccd);
int get_is_ci_valid(int ccd);
int get_ccd_sid(int cc_param);
int get_ccd_link(int cc_param);
int get_is_ccd_hidden(int cc_param);
int get_is_ccd_user_def1(int cc_param);
int get_is_ccd_user_def2(int cc_param);
int get_is_cc_param_valid(int cc_param);
int get_cc_param(object client, int ccd);
void set_cc_param(object client, int ccd, int cc_param);
string get_cc_name(int ccd);
void set_cc_name(int ccd, string name);
int get_cc_content_int(int ccd);
object get_cc_content_obj(int ccd);
void set_cci(int ccd);
int get_ccd_hist(object client, int n);
void remove_ccd(int ccd);
void restart_conversation(object client, object user, string cv);

//--------------------------------------/
//#INC
//--------------------------------------/
#include "std_inc_color"
#include "dsc_inc_vars"
//#include "dsc_inc_user"
#include "xid_inc_general"

//--------------------------------------/
//IMPLEMENTATION
//--------------------------------------/
//==========================================/
//allows an object to share scripted conversation with others
//client should be a creature
//each client has an "instance ID" (IID)
int assign_iid_to_client(object client)
//==========================================/
    {
    //on spawn set listening for parser
    SetListening(client, TRUE);
    SetListenPattern(client, "**", LISTEN_ALL);

    //increment iid index
    //IID_NEXT -> [iid][...][...]
    int iid = GetLocalInt(IID_TRACKER, IID_NEXT) + INCR_IID;
    SetLocalInt(IID_TRACKER, IID_NEXT, iid);
    //start cd
    SetLocalInt(client, CD_NEXT + IntToHexString(iid), iid | CI_ALLOCATION_START);

    //register new client to shared res
    SetLocalObject(IID_TRACKER, IID_CLIENT + IntToHexString(iid), client);
    //assign iid to client
    SetLocalInt(client, CLIENT_IID, iid);

    return iid;
    }

//==========================================/
//create new container in client
//client: should match IID
//strref: retrieve the 20 bit path of this container with this string value
int create_container(object client, int iid, string cd_strref = "")
//==========================================/
    {
    //increment cd of client
    //CD_NEXT -> [iid][ci][...]
    int cd = GetLocalInt(client, CD_NEXT + IntToHexString(iid)) + INCR_CI;
    SetLocalInt(client, CD_NEXT + IntToHexString(iid), cd);
    //set start of ccd
    SetLocalInt(client, CCD_NEXT + IntToHexString(cd), cd);

    //store cd to strref (optional)
    if(cd_strref != "")
        {
        SetLocalInt(client, CD_STRREF + cd_strref, cd);
        }

    return cd;
    }

//==========================================/
//create new container in client
//client: should match IID
int create_container_at_cd(object client, int cd)
//==========================================/
    {
    if(!GetLocalInt(client, CCD_NEXT + IntToHexString(cd)))
        {
        //set start of ccd
        SetLocalInt(client, CCD_NEXT + IntToHexString(cd), cd);
        }

    return cd;
    }

//==========================================/
//template for creating a link
//cd_target: 20 bit path to target
//alternate: if path is invalid this param value will be used
int create_link_jal(int cd_target, int cc_param_alternate = 0)
//==========================================/
    {
    if(FILTER_CI & cd_target)
        {
        return cd_target | LP_JAL;
        }
    else
        {
        return cc_param_alternate;
        }
    }

//==========================================/
//template for creating a link
//cd_target: 20 bit path to target
//alternate: if path is invalid this param value will be used
int create_link_jalh(int cd_target, int cc_param_alternate = 0)
//==========================================/
    {
    if(FILTER_CI & cd_target)
        {
        return cd_target | LP_JALH;
        }
    else
        {
        return cc_param_alternate;
        }
    }

//==========================================/
//create content to stick in a container - store an integer value that will be returned
//client: should match IID in cd
//name: screen name
//param: defines script to run, hidden t/f, etc
//content: data to return when this option is selected
int create_content_int(object client, int cd, string cc_name, int cc_param, int cc_content = 0)
//==========================================/
    {
    //increment ccd
    //CCD_NEXT + (cd) -> [iid][ci][cci]
    int ccd = GetLocalInt(client, CCD_NEXT + IntToHexString(cd)) + INCR_CCI;
    SetLocalInt(client, CCD_NEXT + IntToHexString(cd), ccd);

    string sccd = IntToHexString(ccd);
    SetLocalString(client, CC_NAME + sccd, cc_name);
    //param bit distribution:
    //[param valid 31][hidden 30][iid 29:20][cci 19:10][link 9][..][sid 5:0]
    SetLocalInt(client, CC_PARAM + sccd, PARAM_VALID_BIT | cc_param);
    SetLocalInt(client, CC_CONTENT + sccd, cc_content);

    return ccd;
    }

//==========================================/
//create content to stick in a container - store an integer value that will be returned
//client: should match IID in cd
//name: screen name
//param: defines script to run, hidden t/f, etc
//content: data to return when this option is selected
int create_content_obj(object client, int cd, string cc_name, int cc_param, object cc_content = OBJECT_INVALID)
//==========================================/
    {
    //increment ccd
    //CCD_NEXT + (cd) -> [iid][ci][cci]
    int ccd = GetLocalInt(client, CCD_NEXT + IntToHexString(cd)) + INCR_CCI;
    SetLocalInt(client, CCD_NEXT + IntToHexString(cd), ccd);

    string sccd = IntToHexString(ccd);
    SetLocalString(client, CC_NAME + sccd, cc_name);
    //param bit distribution:
    //[param valid 31][hidden 30][iid 29:20][cci 19:10][link 9][..][sid 5:0]
    SetLocalInt(client, CC_PARAM + sccd, PARAM_VALID_BIT | cc_param);
    SetLocalObject(client, CC_CONTENT + sccd, cc_content);

    return ccd;
    }

//==========================================/
//==========================================/

//==========================================/
string set_ccd_name_color(int cc_param, string cc_name)
//==========================================/
    {
    if(get_is_ccd_hidden(cc_param))
        {
        cc_name = set_string_color(cc_name, CHID);
        }
    else
        {
        if(get_is_ccd_user_def1(cc_param))
            {
            cc_name = set_string_color(cc_name, CUD1);
            }
        else if(get_ccd_link(cc_param))
            {
            cc_name = set_string_color(cc_name, CLNK);
            }
        }

    return cc_name;
    }

//==========================================/
//refresh an entire page of list options
//client: any with IID
//ccd_disp_offset: UI disp offset (30 bit path)
//ccd_sel: which option is selected? (30 bit path)
void ui_refresh(object client, int hsel, int ccd_disp_offset, int sid)
//==========================================/
    {
    //print sid text
    SetCustomToken(TOKEN_SID_PRINT, GetLocalString(client, UI_SID_PRINT + IntToHexString(FILTER_SID & sid)));

    //--------------------------------------/
    object client_source = get_iid_client(ccd_disp_offset);
    //get maximum index of cd (30 bit path)
    int ccd_max = get_ccd_next(ccd_disp_offset);

    int ccd = ccd_disp_offset;
    int n = 0;

    while(ccd <= ccd_max && n < UI_CCI_DISP_CNT_MAX)
        {
        string sccd = IntToHexString(ccd);

        //search specified client...
        int cc_param = GetLocalInt(client, CC_PARAM + sccd);

        //not there..see if the source has it
        if(!get_is_cc_param_valid(cc_param))
            {
            cc_param = GetLocalInt(client_source, CC_PARAM + sccd);
            }

        string cc_name = GetLocalString(client_source, CC_NAME + sccd);
        cc_name = set_ccd_name_color(cc_param, cc_name);

        //display it to conversation
        SetCustomToken(TOKEN_CCI_INDEX_START + n, cc_name);

        n++;
        ccd += INCR_CCI;
        }

    //--------------------------------------/
    //refresh page navigation scroll up/down
    //scroll down
    if((ccd_disp_offset + UI_CCI_DISP_CNT_MAX) < ccd_max)
        {
        SetCustomToken(TOKEN_CCI_OPT_DN, DSC_STR_SCRDN);
        }
    else
        {
        SetCustomToken(TOKEN_CCI_OPT_DN, set_string_color(DSC_STR_SCRDN, CHID));
        }

    //scroll up
    if((ccd_disp_offset & FILTER_CCI) > CCI_DISP_OFFSET_DEF)
        {
        SetCustomToken(TOKEN_CCI_OPT_UP, DSC_STR_SCRUP);
        }
    else
        {
        SetCustomToken(TOKEN_CCI_OPT_UP, set_string_color(DSC_STR_SCRUP, CHID));
        }

    //--------------------------------------/
    //refresh option: back
    if(hsel > HSEL_DEF)
        {
        SetCustomToken(TOKEN_CCI_OPT_BK, DSC_STR_BACK);
        }
    else
        {
        SetCustomToken(TOKEN_CCI_OPT_BK, set_string_color(DSC_STR_BACK, CHID));
        }

    //--------------------------------------/
    SetLocalInt(client, UI_CCI_DISP_CNT, n);
    }

//==========================================/
string cd_list_to_string(object client, int cd)
//==========================================/
    {
    string output = "";

    object client_source = get_iid_client(cd);
    //get maximum index of cd (30 bit path)
    int ccd_max = get_ccd_next(cd);

    int ccd = cd | CCI_DISP_OFFSET_DEF;
    while(ccd <= ccd_max)
        {
        string sccd = IntToHexString(ccd);

        //search specified client...
        int cc_param = GetLocalInt(client, CC_PARAM + sccd);

        //not there..see if the source has it
        if(!get_is_cc_param_valid(cc_param))
            {
            cc_param = GetLocalInt(client_source, CC_PARAM + sccd);
            }

        string cc_name = GetLocalString(client_source, CC_NAME + sccd);
        cc_name = set_ccd_name_color(cc_param, cc_name);

        output += cc_name + DSC_CHAR_NEWLINE;

        ccd += INCR_CCI;
        }

    return output;
    }

//==========================================/
void set_sid_str(object client, int sid, string s)
//==========================================/
    {
    SetLocalString(client, UI_SID_PRINT + IntToHexString(FILTER_SID & sid), s);
    }

//==========================================/
//action taken when the user selected conversation option n
//client: should be OBJECT_SELF but variable of flexibility
//n: nth option of displayed list
//note about multiplayer - all text must be refreshed every time to work with multiple instances of same tokens
void ui_select_cci_index(object client, int n)
//==========================================/
    {
    //navigation hist tracker - this keeps track of hist index
    //[hi][hsel][...]
    int hist = GetLocalInt(client, HIST);
    //get the selected hist param
    int hsel = FILTER_HSEL & hist;
    string shsel = IntToHexString(hsel);

    //--------------------------------------/
    //last parameter values
    //get sid in hist
    int hsid = GetLocalInt(client, HSID + shsel);
    //selected ccd in nav hist (30 bit path)
    //[iid][cp][ci_sel]
    int hccd_sel = GetLocalInt(client, HCCD_SEL + shsel);
    //ccd UI display offset in nav hist (30 bit path)
    //[iid][cp][ci_offset]
    int hccd_disp_offset = GetLocalInt(client, HCCD_DISP_OFFSET + shsel);

    //--------------------------------------/
    //ccd that was just selected (i.e. nth option of currently displayed list)
    int ccd_sel = hccd_disp_offset + n;

    //get parameter from ccd
    int ccd_sel_param = get_cc_param(client, ccd_sel);

    //--------------------------------------/
    //is the option selected hidden? if not proceed
    if(!get_is_ccd_hidden(ccd_sel_param))
        {
        //index selected is not same as previous
        if(ccd_sel != hccd_sel)
            {
            //update selected option in hist
            SetLocalInt(client, HCCD_SEL + shsel, ccd_sel);
            }

        //get sid of current selected ccd
        int sid = FILTER_SID & ccd_sel_param;
        //if valid
        if(sid)
            {
            hsid = sid;

            //SetLocalInt(client, EXT_SID, hsid);
            set_xid(client, hsid);
            ExecuteScript(XID_ROOT, client);
            }

        //--------------------------------------/
        int iid = FILTER_IID & ccd_sel_param;
        if(iid == IID_LINK_SELF)
            {
            iid = get_client_iid(client);
            }
        int cd_new = iid | (FILTER_CI & ccd_sel_param);

        //--------------------------------------/
        switch(get_ccd_link(ccd_sel_param))
            {
            case LP_JAL:
                {
                //add new page to navigation hist entry
                //increment hist index
                hsel += INCR_HSEL;
                shsel = IntToHexString(hsel);

                //set new directory in nav hist (30 bit path: new_cd | def_cci)
                SetLocalInt(client, HCCD_DISP_OFFSET + shsel, cd_new | CCI_DISP_OFFSET_DEF);
                SetLocalInt(client, HCCD_SEL + shsel, cd_new | CCI_SEL_DEF);
                SetLocalInt(client, HSID + shsel, hsid);

                //keep display offset, update display and max hist index to new page
                SetLocalInt(client, HIST, (hsel << BITLEN_HSEL) | hsel);

                //refresh new path with default display offset and selection
                ui_refresh(client, hsel, cd_new | CCI_DISP_OFFSET_DEF, hsid);

                return;
                }

            case LP_JALH:
                {
                //search through history to find link point
                //start with index hist - 1
                while(hsel >= HSEL_DEF)
                    {
                    hist -= INCR_HSEL;
                    hsel -= INCR_HSEL;
                    shsel = IntToHexString(hsel);

                    hccd_sel = GetLocalInt(client, HCCD_SEL + shsel);

                    //found
                    if((FILTER_CD & hccd_sel) == cd_new)
                        {
                        hsid = GetLocalInt(client, HSID + shsel);
                        hccd_disp_offset = GetLocalInt(client, HCCD_DISP_OFFSET + shsel);

                        SetLocalInt(client, HIST, hist);

                        break;
                        }
                    }

                //ui_refresh(client, hsel, hccd_disp_offset, hsid);

                break;
                }
            }
        }

    ui_refresh(client, hsel, hccd_disp_offset, hsid);
    }

//==========================================/
void ui_initialize(object client, int cd, int sid)
//==========================================/
    {
    //--------------------------------------/
    SetLocalInt(client, HCCD_DISP_OFFSET + IntToHexString(HSEL_DEF), cd | CCI_DISP_OFFSET_DEF);
    SetLocalInt(client, HCCD_SEL + IntToHexString(HSEL_DEF), cd | CCI_SEL_DEF);
    SetLocalInt(client, HIST, (HI_DEF << BITLEN_HSEL) | HSEL_DEF | sid);

    //--------------------------------------/
    //SetLocalInt(client, EXT_SID, sid);
    set_xid(client, sid);
    SetLocalInt(client, HSID + IntToHexString(HSEL_DEF), sid);

    ExecuteScript(XID_ROOT, client);
    ui_refresh(client, HSEL_DEF, cd | CCI_DISP_OFFSET_DEF, sid);
    }

//==========================================/
void ui_select_cci_opt_dn(object client)
//==========================================/
    {
    //navigation hist tracker - this keeps track of hist index
    //[hist_disp_offset][hist_index][hsel]
    int hsel = FILTER_HSEL & GetLocalInt(client, HIST);
    string shsel = IntToHexString(hsel);

    //get the selected hist param
    int hsid = GetLocalInt(client, HSID + shsel);
    //ccd UI display offset in nav hist (30 bit path)
    //[iid][cp][ci_offset]
    int hccd_disp_offset = GetLocalInt(client, HCCD_DISP_OFFSET + shsel);
    //selected ccd in nav hist (30 bit path)
    //[iid][cp][ci_sel]
    int hccd_sel = GetLocalInt(client, HCCD_SEL + shsel);

    if((hccd_disp_offset + UI_CCI_DISP_CNT_MAX) < get_ccd_next(hccd_sel))
        {
        hccd_disp_offset += UI_CCI_SCROLL_INCR;
        SetLocalInt(client, HCCD_DISP_OFFSET + shsel, hccd_disp_offset);
        }

    ui_refresh(client, hsel, hccd_disp_offset, hsid);
    }

//==========================================/
void ui_select_cci_opt_up(object client)
//==========================================/
    {
    //navigation hist tracker - this keeps track of hist index
    //[hist_disp_offset][hist_index][hsel]
    int hsel = FILTER_HSEL & GetLocalInt(client, HIST);
    string shsel = IntToHexString(hsel);

    //get the selected hist param
    int hsid = GetLocalInt(client, HSID + shsel);
    //ccd UI display offset in nav hist (30 bit path)
    //[iid][cp][ci_offset]
    int hccd_disp_offset = GetLocalInt(client, HCCD_DISP_OFFSET + shsel);

    if((hccd_disp_offset & FILTER_CCI) > CCI_DISP_OFFSET_DEF)
        {
        hccd_disp_offset -= UI_CCI_SCROLL_INCR;
        SetLocalInt(client, HCCD_DISP_OFFSET + shsel, hccd_disp_offset);
        }

    ui_refresh(client, hsel, hccd_disp_offset, hsid);
    }

//==========================================/
void ui_select_cci_opt_bk(object client)
//==========================================/
    {
    //navigation hist tracker - this keeps track of hist index
    //[hist_disp_offset][hist_index][hsel]
    int hist = GetLocalInt(client, HIST);

    if((FILTER_HSEL & hist) > HSEL_DEF)
        {
        hist -= INCR_HSEL;
        SetLocalInt(client, HIST, hist);
        }

    int hsel = FILTER_HSEL & hist;
    string shsel = IntToHexString(hsel);

    //get the selected hist param
    int hsid = GetLocalInt(client, HSID + shsel);
    //ccd UI display offset in nav hist (30 bit path)
    //[iid][cp][ci_offset]
    int hccd_disp_offset = GetLocalInt(client, HCCD_DISP_OFFSET + shsel);

    ui_refresh(client, hsel, hccd_disp_offset, hsid);
    }

//==========================================/
void set_ccd_hidden(object client, int ccd)
//==========================================/
    {
    int cc_param = get_cc_param(client, ccd);
    SetLocalInt(client, CC_PARAM + IntToHexString(ccd), PARAM_VALID_BIT | HIDDEN_BIT | cc_param);
    }

//==========================================/
void rem_ccd_hidden(object client, int ccd)
//==========================================/
    {
    int cc_param = get_cc_param(client, ccd);
    SetLocalInt(client, CC_PARAM + IntToHexString(ccd), ~HIDDEN_BIT & (PARAM_VALID_BIT | cc_param));
    }

//==========================================/
void set_ccd_user_def1(object client, int ccd)
//==========================================/
    {
    int cc_param = get_cc_param(client, ccd);
    SetLocalInt(client, CC_PARAM + IntToHexString(ccd), PARAM_VALID_BIT | USER_DEF_BIT1 | cc_param);
    }

//==========================================/
void rem_ccd_user_def1(object client, int ccd)
//==========================================/
    {
    int cc_param = get_cc_param(client, ccd);
    SetLocalInt(client, CC_PARAM + IntToHexString(ccd), ~USER_DEF_BIT1 & (PARAM_VALID_BIT | cc_param));
    }

//==========================================/
void set_ccd_user_def2(object client, int ccd)
//==========================================/
    {
    int cc_param = get_cc_param(client, ccd);
    SetLocalInt(client, CC_PARAM + IntToHexString(ccd), PARAM_VALID_BIT | USER_DEF_BIT2 | cc_param);
    }

//==========================================/
void rem_ccd_user_def2(object client, int ccd)
//==========================================/
    {
    int cc_param = get_cc_param(client, ccd);
    SetLocalInt(client, CC_PARAM + IntToHexString(ccd), ~USER_DEF_BIT2 & (PARAM_VALID_BIT | cc_param));
    }

//==========================================/
//==========================================/

//==========================================/
//get client of specified IID
object get_iid_client(int iid)
//==========================================/
    {
    return GetLocalObject(IID_TRACKER, IID_CLIENT + IntToHexString(FILTER_IID & iid));
    }

//==========================================/
//get the IID of specified client
int get_client_iid(object client)
//==========================================/
    {
    return GetLocalInt(client, CLIENT_IID);
    }

//==========================================/
//get the maximum ccd of this 20 bit cd path
//cd: any path containing cd [29:10]
int get_ccd_next(int ccd)
//==========================================/
    {
    return GetLocalInt(get_iid_client(ccd), CCD_NEXT + IntToHexString(FILTER_CD & ccd));
    }

//==========================================/
//returns the ci number
//boolean test because 0 index should not exist
//ccd: any path containing ci (bits 19:10)
int get_is_ci_valid(int ccd)
//==========================================/
    {
    return FILTER_CI & ccd;
    }

//==========================================/
//get the script index to execute when this ccd is selected
//ccd: param of ccd
int get_ccd_sid(int cc_param)
//==========================================/
    {
    return FILTER_SID & cc_param;
    }

//==========================================/
//is this ccd a link?
//cc_param: parameter of ccd
int get_ccd_link(int cc_param)
//==========================================/
    {
    return FILTER_LP & cc_param;
    }

//==========================================/
//is this content hidden?
//cc_param: parameter of ccd
int get_is_ccd_hidden(int cc_param)
//==========================================/
    {
    return HIDDEN_BIT & cc_param;
    }

//==========================================/
//is this content hidden?
//cc_param: parameter of ccd
int get_is_ccd_user_def1(int cc_param)
//==========================================/
    {
    return USER_DEF_BIT1 & cc_param;
    }

//==========================================/
//is this content hidden?
//cc_param: parameter of ccd
int get_is_ccd_user_def2(int cc_param)
//==========================================/
    {
    return USER_DEF_BIT2 & cc_param;
    }

//==========================================/
//is this content hidden?
//cc_param: parameter of ccd
int get_is_cc_param_valid(int cc_param)
//==========================================/
    {
    return PARAM_VALID_BIT & cc_param;
    }

//==========================================/
//get the parameter of content
//look for personalized copy on local client first
//..if not there try the source
//client: any that has an IID
//ccd: 30 bit content path
int get_cc_param(object client, int ccd)
//==========================================/
    {
    //search specified client...
    int cc_param = GetLocalInt(client, CC_PARAM + IntToHexString(ccd));

    //not there..see if the source has it
    if(!get_is_cc_param_valid(cc_param))
        {
        cc_param = GetLocalInt(get_iid_client(ccd), CC_PARAM + IntToHexString(ccd));
        }

    return cc_param;
    }

//==========================================/
void set_cc_param(object client, int ccd, int cc_param)
//==========================================/
    {
    SetLocalInt(client, CC_PARAM + IntToHexString(ccd), cc_param);
    }

//==========================================/
//get the string name of content
//client: any that has an IID
//ccd: 30 bit content path
string get_cc_name(int ccd)
//==========================================/
    {
    return GetLocalString(get_iid_client(ccd), CC_NAME + IntToHexString(ccd));
    }

//==========================================/
//get the string name of content
//client: any that has an IID
//ccd: 30 bit content path
void set_cc_name(int ccd, string name)
//==========================================/
    {
    SetLocalString(get_iid_client(ccd), CC_NAME + IntToHexString(ccd), name);
    }

//==========================================/
//client: any that has an IID
//ccd: 30 bit content path
int get_cc_content_int(int ccd)
//==========================================/
    {
    return GetLocalInt(get_iid_client(ccd), CC_CONTENT + IntToHexString(ccd));
    }

//==========================================/
//client: any that has an IID
//ccd: 30 bit content path
object get_cc_content_obj(int ccd)
//==========================================/
    {
    return GetLocalObject(get_iid_client(ccd), CC_CONTENT + IntToHexString(ccd));
    }

//==========================================/
//set the content index of this 30 bit content path
//can be used to delete container contents
void set_cci(int ccd)
//==========================================/
    {
    SetLocalInt(get_iid_client(ccd), CCD_NEXT + IntToHexString(FILTER_CD & ccd), ccd);
    }

//==========================================/
//get ccd at hist index
int get_ccd_hist(object client, int n)
//==========================================/
    {
    int hsel = FILTER_HSEL & GetLocalInt(client, HIST);
    return GetLocalInt(client, HCCD_SEL + IntToHexString(hsel - n*INCR_HSEL));
    }

//==========================================/
void remove_ccd(int ccd)
//==========================================/
    {
    object client = get_iid_client(ccd);

    int ccd_src = ccd + INCR_CCI;
    int ccd_next = get_ccd_next(FILTER_CD & ccd);
    while(ccd_src <= ccd_next)
        {
        string sccd = IntToHexString(ccd);
        string sccd_src = IntToHexString(ccd_src);

        SetLocalString(client, CC_NAME + sccd,    GetLocalString(client, CC_NAME + sccd_src));
        SetLocalInt(client, CC_PARAM + sccd,      GetLocalInt(client, CC_PARAM + sccd_src));
        SetLocalInt(client, CC_CONTENT + sccd,    GetLocalInt(client, CC_CONTENT + sccd_src));

        ccd += INCR_CCI;
        ccd_src += INCR_CCI;
        }

    set_cci(ccd_next - INCR_CCI);
    }

//==========================================/
void restart_conversation(object client, object user, string cv)
//==========================================/
    {
    int hsel = FILTER_HSEL & GetLocalInt(client, HIST);
    string shsel = IntToHexString(hsel);
    //get the selected hist param
    int hsid = GetLocalInt(client, HSID + shsel);
    //ccd UI display offset in nav hist (30 bit path)
    //[iid][cp][ci_offset]
    int hccd_disp_offset = GetLocalInt(client, HCCD_DISP_OFFSET + shsel);

    ui_refresh(client, hsel, hccd_disp_offset, hsid);

    AssignCommand(client, ActionStartConversation(user, cv, TRUE, FALSE));
    }
