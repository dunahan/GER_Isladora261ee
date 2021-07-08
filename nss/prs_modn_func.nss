#include "prs_inc_parser"
#include "std_inc_general"
#include "ll_include"

#include "std_inc_color"

//==========================================/
void main()
//==========================================/
    {
    string function_name = retrieve_function_name(OBJECT_SELF);

    if(function_name == "setxp")
        {
        string arg = retrieve_arg(1);
        if(get_is_number(arg))
            {
            int xp_amount = StringToInt(arg);

            if(xp_amount < 0)
                {
                xp_amount = 0;
                }

            SetXPImproved(OBJECT_SELF, xp_amount);
            //SetXP(OBJECT_SELF, xp_amount);

            set_function_result_valid();
            }
        }

    else if(function_name == "setgp")
        {
        string arg = retrieve_arg(1);
        if(get_is_number(arg))
            {
            int gp_amount = StringToInt(arg);

            if(gp_amount < 0)
                {
                gp_amount = 0;
                }

            int gp_current = GetGold(OBJECT_SELF);

            give_gold(gp_amount - gp_current, OBJECT_SELF);

            set_function_result_valid();
            }
        }

    else if(function_name == "setge")
        {
        string arg = retrieve_arg(1);
        if(get_is_number(arg))
            {
            int ge_amount = StringToInt(arg);

            if(ge_amount < ALIGN_GE_MIN)
                {
                ge_amount = ALIGN_GE_MIN;
                }
            else if(ge_amount > ALIGN_GE_MAX)
                {
                ge_amount = ALIGN_GE_MAX;
                }

            set_align_ge(OBJECT_SELF, ge_amount);

            set_function_result_valid();
            }
        }

    else if(function_name == "setlc")
        {
        string arg = retrieve_arg(1);
        if(get_is_number(arg))
            {
            int lc_amount = StringToInt(arg);

            if(lc_amount < ALIGN_LC_MIN)
                {
                lc_amount = ALIGN_LC_MIN;
                }
            else if(lc_amount > ALIGN_LC_MAX)
                {
                lc_amount = ALIGN_LC_MAX;
                }

            set_align_lc(OBJECT_SELF, lc_amount);

            set_function_result_valid();
            }
        }

    else if(function_name == "lvltoxp")
        {
        string arg = retrieve_arg(1);
        if(get_is_number(arg))
            {
            int xp_amount = get_exp_from_level(StringToInt(arg));

            set_function_result(IntToString(xp_amount));
            set_function_result_valid();
            }
        }

    else if(function_name == "add")
        {
        string arg1 = retrieve_arg(1);
        string arg2 = retrieve_arg(2);

        set_function_result(IntToString(StringToInt(arg1) + StringToInt(arg2)));
        set_function_result_valid();
        }

    else if(function_name == "c")
        {
        string arg1 = retrieve_arg(1);
        string arg2 = retrieve_arg(2);
        string arg3 = retrieve_arg(3);
        string arg4 = retrieve_arg(4);

        int rval = StringToInt(arg2);
        int gval = StringToInt(arg3);
        int bval = StringToInt(arg4);

        int cval = get_cval(rval, gval, bval);

        string s = set_string_color(arg1, cval);

        set_function_result(s);
        set_function_result_valid();
        }

    else if(function_name == "cg")
        {
        string arg1 = retrieve_arg(1);
        string arg2 = retrieve_arg(2);
        string arg3 = retrieve_arg(3);
        string arg4 = retrieve_arg(4);
        string arg5 = retrieve_arg(5);
        string arg6 = retrieve_arg(6);
        string arg7 = retrieve_arg(7);

        int rval1 = StringToInt(arg2);
        int gval1 = StringToInt(arg3);
        int bval1 = StringToInt(arg4);

        int rval2 = StringToInt(arg5);
        int gval2 = StringToInt(arg6);
        int bval2 = StringToInt(arg7);

        int len = GetStringLength(arg1);

        int rstep = (rval2 - rval1)/len;
        int gstep = (gval2 - gval1)/len;
        int bstep = (bval2 - bval1)/len;

        string result;
        string s;

        int pos = 0;

        while(pos <= len)
            {
            s = GetSubString(arg1, pos, 1);

            result += set_string_color(s, get_cval(rval1, gval1, bval1));

            pos++;

            rval1 += rstep;
            gval1 += gstep;
            bval1 += bstep;
            }

        set_function_result(result);
        set_function_result_valid();
        }

    else if(function_name == "cat")
        {
        string s = "";

        string arg = retrieve_arg(1);

        int i = 1;
        while(arg != PARSE_ERR_STR)
            {
            i++;
            s += arg;

            arg = retrieve_arg(i);
            }

        if(s != "")
            {
            set_function_result(s);
            set_function_result_valid();
            }
        }
    }
