//--------------------------------------/
//SIMPLE COMMAND PARSER v1.1
//--------------------------------------/

//--------------------------------------/
//CONSTANTS
//--------------------------------------/
object UI_STR_SP_CLIENT = GetObjectByTag("shared_res_tracker");
const string PARSE_NUM_VALID = "0123456789";
const string PARSE_CHAR_VALID = "abcdefghijklmnopqrstuvwxyz_";
const string PARSE_NAME_VALID = "abcdefghijklmnopqrstuvwxyz_0123456789";
const string PARSE_ERR_STR = "#ERROR#";
const string PARSE_FUN_EXECUTE = "prs_modn_func";

//const string FUN_SCRIPT_PREFIX = "fun__";

//--------------------------------------/
//INPUT/DISPLAY STRINGS
//--------------------------------------/
const string PARSE_CHAR_BRK_START = "[";
const string PARSE_CHAR_BRK_END = "]";
const string PARSE_CHAR_SPACE = " ";
const string PARSE_CHAR_COMMA = ",";
const string PARSE_CHAR_CMDSTART = "~";
const string PARSE_CHAR_BLANK = "";
//const string PARSE_STR_QUOTE = "'";
const string PARSE_STR_ERROR_MSG = "#syntax error#";

//--------------------------------------/
//FLAGS
//--------------------------------------/
const int FUN_VALID_BIT = 0x80000000; //10000000000000000000000000000000
const int INCR_EXE_INDEX = 0x400;

//--------------------------------------/
//STATE VARIABLES
//--------------------------------------/
const int INPUT_PARSE_STATE_INIT = 0;
const int INPUT_PARSE_STATE_CMD = 1;

const int VAR_PARSE_STATE_INIT = 0;
const int VAR_PARSE_STATE_STRING = 1;
const int VAR_PARSE_STATE_FUNCTION = 2;
const int VAR_PARSE_STATE_NUM = 3;
const int VAR_PARSE_STATE_ERROR = 4;

const int CMD_PARSE_STATE_INIT = 0;
const int CMD_PARSE_STATE_ARG = 2;
const int CMD_PARSE_STATE_END = 3;
const int CMD_PARSE_STATE_ERROR = 4;

//--------------------------------------/
//LOCAL VARIABLE STRINGS
//--------------------------------------/
const string UI_CHAR_QUOTE = "ui_char_quote";
const string FUN_RES = "sp0_";
const string FUN_RESP_VALID = "sp1_";
const string FUN_EXE_INDEX = "sp2_";
const string FUN_EXE_INDEX_REF = "sp3_";
const string FUN_ARG_INDEX = "sp4_";
const string FUN_ARG = "sp5_";
const string FUN_NAME = "sp6_";

//--------------------------------------/
//PROTOTYPES
//--------------------------------------/
int get_char_valid_num(string s);
int get_char_valid_letter(string s);
int get_char_valid_name(string s);
int get_is_number(string num);
void store_function_name(string name, object user);
string retrieve_function_name(object user);
void store_arg(string function_arg, int exe_index, object user);
string retrieve_arg(int args_index, object user = OBJECT_SELF);
void set_function_result(string result, object user = OBJECT_SELF);
string get_function_result(int exe_index, object user);
void set_function_result_valid(object user = OBJECT_SELF);
int get_function_result_valid(int exe_index, object user);
string parse_init(string input, object user);
string parse_var(string cmd, object user);
string parse_function_arg(string function_name, string cmd, object user);

//--------------------------------------/
//IMPLEMENTATION
//--------------------------------------/
//==========================================/
int get_char_valid_num(string s)
//==========================================/
    {
    string valid = PARSE_NUM_VALID;

    return FindSubString(valid, s) + 1;
    }

//==========================================/
int get_char_valid_letter(string s)
//==========================================/
    {
    string valid = PARSE_CHAR_VALID;

    return FindSubString(valid, s) + 1;
    }

//==========================================/
int get_char_valid_name(string s)
//==========================================/
    {
    string valid = PARSE_NAME_VALID;

    return FindSubString(valid, s) + 1;
    }

//==========================================/
int get_is_number(string num)
//==========================================/
    {
    return (num == IntToString(StringToInt(num)));
    }

//==========================================/
void store_function_name(string name, object user)
//==========================================/
    {
    SetLocalString(user, FUN_NAME, name);
    }

//==========================================/
string retrieve_function_name(object user)
//==========================================/
    {
    return GetLocalString(user, FUN_NAME);
    }

//==========================================/
void store_arg(string function_arg, int exe_index, object user)
//==========================================/
    {
    int args_index = GetLocalInt(user, FUN_ARG_INDEX + IntToHexString(exe_index)) + 1;
    SetLocalInt(user, FUN_ARG_INDEX + IntToHexString(exe_index), args_index);

    SetLocalString(user, FUN_ARG + IntToHexString(exe_index | args_index), function_arg);
    }

//==========================================/
string retrieve_arg(int args_index, object user = OBJECT_SELF)
//==========================================/
    {
    //argument number starts at 1!
    int exe_index = GetLocalInt(user, FUN_EXE_INDEX_REF);

    int args_index_max = GetLocalInt(user, FUN_ARG_INDEX + IntToHexString(exe_index));
    if(args_index_max >= args_index)
        {
        return GetLocalString(user, FUN_ARG + IntToHexString(exe_index | args_index));
        }

    return PARSE_ERR_STR;
    }

//==========================================/
void set_function_result(string result, object user = OBJECT_SELF)
//==========================================/
    {
    int exe_index = GetLocalInt(user, FUN_EXE_INDEX_REF);

    SetLocalString(user, FUN_RES + IntToHexString(exe_index), result);
    }

//==========================================/
string get_function_result(int exe_index, object user)
//==========================================/
    {
    string result = GetLocalString(user, FUN_RES + IntToHexString(exe_index));
    DeleteLocalString(user, FUN_RES + IntToHexString(exe_index));

    return result;
    }

//==========================================/
void set_function_result_valid(object user = OBJECT_SELF)
//==========================================/
    {
    int exe_index = GetLocalInt(user, FUN_EXE_INDEX_REF);

    SetLocalInt(user, FUN_RESP_VALID + IntToHexString(exe_index), FUN_VALID_BIT);
    }

//==========================================/
int get_function_result_valid(int exe_index, object user)
//==========================================/
    {
    int valid = FUN_VALID_BIT & GetLocalInt(user, FUN_RESP_VALID + IntToHexString(exe_index));
    DeleteLocalInt(user, FUN_RESP_VALID + IntToHexString(exe_index));

    return valid;
    }

//==========================================/
string parse_init(string input, object user)
//==========================================/
    {
    int parse_state = INPUT_PARSE_STATE_INIT;

    int cmd_str_len = GetStringLength(input);
    int cmd_str_pos = 0;

    //kill end spaces
    string s = GetSubString(input, cmd_str_len-1, 1);
    while(cmd_str_len >= 0 && s == PARSE_CHAR_SPACE)
        {
        cmd_str_len--;
        s = GetSubString(input, cmd_str_len-1, 1);
        }

    s = GetSubString(input, cmd_str_pos, 1);
    while(cmd_str_pos <= cmd_str_len)
        {
        switch(parse_state)
            {
            //--------------------------------------/
            case INPUT_PARSE_STATE_INIT:
                {
                if(s == PARSE_CHAR_CMDSTART)
                    {
                    parse_state = INPUT_PARSE_STATE_CMD;
                    }

                else if(s != PARSE_CHAR_SPACE)
                    {
                    return input;
                    }

                break;
                }

            //--------------------------------------/
            case INPUT_PARSE_STATE_CMD:
                {
                DeleteLocalInt(user, FUN_EXE_INDEX);
                string parsed_cmd = parse_var(GetStringRight(input, cmd_str_len - cmd_str_pos), user);

                SendMessageToPC(user, parsed_cmd);
                return parsed_cmd;

                break;
                }
            }

        cmd_str_pos++;
        s = GetSubString(input, cmd_str_pos, 1);
        }

    return input;
    }

//==========================================/
string parse_var(string cmd, object user)
//==========================================/
    {
    string PARSE_STR_QUOTE = GetLocalString(UI_STR_SP_CLIENT, UI_CHAR_QUOTE);

    string arg = "";

    int bracket_cnt = 0;

    int parse_state = VAR_PARSE_STATE_INIT;

    int cmd_str_len = GetStringLength(cmd);
    int cmd_str_pos = 0;

    //kill end spaces
    string s = GetSubString(cmd, cmd_str_len-1, 1);
    while(cmd_str_len >= 0 && s == PARSE_CHAR_SPACE)
        {
        cmd_str_len--;
        s = GetSubString(cmd, cmd_str_len-1, 1);
        }

    //begin
    s = GetSubString(cmd, cmd_str_pos, 1);
    while(cmd_str_pos <= cmd_str_len)
        {
        //--------------------------------------/
        if(s == PARSE_CHAR_BRK_START)
            {
            bracket_cnt++;
            }
        else if(s == PARSE_CHAR_BRK_END)
            {
            bracket_cnt--;
            }
        if(bracket_cnt < 0)
            {
            parse_state = VAR_PARSE_STATE_ERROR;
            }

        //--------------------------------------/
        switch(parse_state)
            {
            //--------------------------------------/
            case VAR_PARSE_STATE_INIT:
                {
                if(s == PARSE_STR_QUOTE)
                    {
                    parse_state = VAR_PARSE_STATE_STRING;
                    }

                else if(get_char_valid_letter(s))
                    {
                    arg += s;

                    parse_state = VAR_PARSE_STATE_FUNCTION;
                    }

                else if(get_char_valid_num(s))
                    {
                    arg += s;

                    if(cmd_str_pos == cmd_str_len-1)
                        {
                        return arg;
                        }
                    else
                        {
                        parse_state = VAR_PARSE_STATE_NUM;
                        }
                    }

                else if(s != PARSE_CHAR_SPACE)
                    {
                    parse_state = VAR_PARSE_STATE_ERROR;
                    }

                break;
                }

            //--------------------------------------/
            case VAR_PARSE_STATE_STRING:
                {
                if(s == PARSE_STR_QUOTE)
                    {
                    if(cmd_str_pos == cmd_str_len-1)
                        {
                        return arg;
                        }

                    else
                        {
                        parse_state = VAR_PARSE_STATE_ERROR;
                        }
                    }

                else
                    {
                    arg += s;
                    }

                break;
                }

            //--------------------------------------/
            case VAR_PARSE_STATE_FUNCTION:
                {
                if(s == PARSE_CHAR_BRK_START)
                    {
                    return parse_function_arg(arg, GetStringRight(cmd, cmd_str_len - cmd_str_pos-1), user);
                    }

                else if(get_char_valid_name(s))
                    {
                    arg += s;
                    }

                else
                    {
                    parse_state = VAR_PARSE_STATE_ERROR;
                    }

                break;
                }

            //--------------------------------------/
            case VAR_PARSE_STATE_NUM:
                {
                if(get_char_valid_num(s))
                    {
                    arg += s;

                    if(cmd_str_pos == cmd_str_len-1)
                        {
                        return arg;
                        }
                    }

                else
                    {
                    parse_state = VAR_PARSE_STATE_ERROR;
                    }

                break;
                }

            //--------------------------------------/
            case VAR_PARSE_STATE_ERROR:
                {
                //SendMessageToPC(user, "var: " + PARSE_STR_ERROR_MSG);
                return PARSE_ERR_STR;
                }
            }

        cmd_str_pos++;
        s = GetSubString(cmd, cmd_str_pos, 1);
        }

    ////
    //SendMessageToPC(user, "var: " + PARSE_STR_ERROR_MSG);
    return PARSE_ERR_STR;
    }

//==========================================/
string parse_function_arg(string function_name, string cmd, object user)
//==========================================/
    {
    string PARSE_STR_QUOTE = GetLocalString(UI_STR_SP_CLIENT, UI_CHAR_QUOTE);
    //function_name( a, b, c, d, ...)
    //**************X <- begin here

    int exe_index = GetLocalInt(user, FUN_EXE_INDEX) + INCR_EXE_INDEX;
    SetLocalInt(user, FUN_EXE_INDEX, exe_index);

    string function_arg = "";

    int bracket_cnt = 1;
    int quote_state = 0;

    int parse_state = CMD_PARSE_STATE_INIT;

    int cmd_str_len = GetStringLength(cmd);
    int cmd_str_pos = 0;

    //kill end spaces
    string s = GetSubString(cmd, cmd_str_len-1, 1);
    while(cmd_str_len >= 0 && s == PARSE_CHAR_SPACE)
        {
        cmd_str_len--;
        s = GetSubString(cmd, cmd_str_len-1, 1);
        }

    //begin
    s = GetSubString(cmd, cmd_str_pos, 1);
    while(cmd_str_pos <= cmd_str_len)
        {
        //--------------------------------------/
        if(s == PARSE_CHAR_BRK_START)
            {
            bracket_cnt++;
            }
        else if(s == PARSE_CHAR_BRK_END)
            {
            bracket_cnt--;
            }
        if(bracket_cnt < 0)
            {
            parse_state = CMD_PARSE_STATE_ERROR;
            }

        //--------------------------------------/
        if(s == PARSE_STR_QUOTE)
            {
            quote_state = !quote_state;
            }

        /////
        //SpeakString("state: " + IntToString(parse_state));
        //SpeakString("arg: " + function_arg);

        //--------------------------------------/
        switch(parse_state)
            {
            //--------------------------------------/
            case CMD_PARSE_STATE_INIT:
                {
                if(s == PARSE_CHAR_BRK_END)
                    {
                    if(cmd_str_pos == cmd_str_len-1)
                        {
                        parse_state = CMD_PARSE_STATE_END;
                        }
                    else
                        {
                        parse_state = CMD_PARSE_STATE_ERROR;
                        }
                    }

                else if(s != PARSE_CHAR_SPACE)
                    {
                    function_arg += s;

                    parse_state = CMD_PARSE_STATE_ARG;
                    }

                break;
                }

            //--------------------------------------/
            case CMD_PARSE_STATE_ARG:
                {
                if(s == PARSE_CHAR_COMMA && bracket_cnt == 1 && !quote_state)
                    {
                    if(function_arg != PARSE_CHAR_BLANK)
                        {
                        string arg = parse_var(function_arg, user);

                        if(arg != PARSE_ERR_STR)
                            {
                            store_arg(arg, exe_index, user);
                            function_arg = PARSE_CHAR_BLANK;
                            }

                        else
                            {
                            parse_state = CMD_PARSE_STATE_ERROR;
                            }
                        }
                    else
                        {
                        parse_state = CMD_PARSE_STATE_ERROR;
                        }
                    }

                else if(s == PARSE_CHAR_BRK_END && bracket_cnt == 0 && !quote_state)
                    {
                    if(function_arg != PARSE_CHAR_BLANK)
                        {
                        string arg = parse_var(function_arg, user);

                        if(arg != PARSE_ERR_STR)
                            {
                            store_arg(arg, exe_index, user);

                            if(cmd_str_pos == cmd_str_len-1)
                                {
                                parse_state = CMD_PARSE_STATE_END;
                                }
                            else
                                {
                                parse_state = CMD_PARSE_STATE_ERROR;
                                }
                            }

                        else
                            {
                            parse_state = CMD_PARSE_STATE_ERROR;
                            }
                        }

                    else
                        {
                        parse_state = CMD_PARSE_STATE_ERROR;
                        }
                    }

                else
                    {
                    function_arg += s;
                    }

                break;
                }

            //--------------------------------------/
            case CMD_PARSE_STATE_END:
                {
                SetLocalInt(user, FUN_EXE_INDEX_REF, exe_index);
                //ExecuteScript(FUN_SCRIPT_PREFIX + function_name, user);
                store_function_name(function_name, user);
                ExecuteScript(PARSE_FUN_EXECUTE, user);

                DeleteLocalInt(user, FUN_EXE_INDEX_REF);
                DeleteLocalInt(user, FUN_ARG_INDEX + IntToHexString(exe_index));

                if(get_function_result_valid(exe_index, user))
                    {
                    return get_function_result(exe_index, user);
                    }

                break;
                }

            //--------------------------------------/
            case CMD_PARSE_STATE_ERROR:
                {
                //SendMessageToPC(user, "function: " + PARSE_STR_ERROR_MSG);

                DeleteLocalInt(user, FUN_ARG_INDEX + IntToHexString(exe_index));
                return PARSE_ERR_STR;
                }
            }

        cmd_str_pos++;
        s = GetSubString(cmd, cmd_str_pos, 1);
        }

    ////
    //SendMessageToPC(user, "function: " + PARSE_STR_ERROR_MSG);

    DeleteLocalInt(user, FUN_ARG_INDEX + IntToHexString(exe_index));
    return PARSE_ERR_STR;
    }
