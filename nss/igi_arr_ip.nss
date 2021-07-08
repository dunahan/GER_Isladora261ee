//void main() {}
#include "dsc_inc_core"

//--------------------------------------/
//PROTOTYPES
//--------------------------------------/
void arr_ip_main(object client);
void ip_main(object client, int iid, int block);
int ip_subtype_file(object client, int iid, string subtype_resref, string costtable_resref, string paramtable_resref, int file_type_menu);
int ip_cost_param1_file(object client, int iid, string costtable_resref, string paramtable_resref, int file_type_menu);

//--------------------------------------/
//IMPLEMENTATION
//--------------------------------------/
//==========================================/
void arr_ip_main(object client)
//==========================================/
    {
    int iid = get_client_iid(client);

    DelayCommand(0.0, ip_main(client, iid, 0));
    DelayCommand(0.0, ip_main(client, iid, 1));
    DelayCommand(0.0, ip_main(client, iid, 2));
    DelayCommand(0.0, ip_main(client, iid, 3));
    DelayCommand(0.0, ip_main(client, iid, 4));
    DelayCommand(0.0, ip_main(client, iid, 5));
    DelayCommand(0.0, ip_main(client, iid, 6));
    DelayCommand(0.0, ip_main(client, iid, 7));
    DelayCommand(0.0, ip_main(client, iid, 8));
    DelayCommand(0.0, ip_main(client, iid, 9));
    //DelayCommand(0.0, ip_main(client, iid, 10));
    //DelayCommand(0.0, ip_main(client, iid, 11));
    }

//==========================================/
//item properties
//==========================================/

//==========================================/
void ip_main(object client, int iid, int block)
//==========================================/
    {
    int folder_index = create_container_at_cd(client, iid | CI_IP);

    string type_resref = "itempropdef";
    int file_type_menu = create_link_jal(iid | CI_IP_MENU | SID_IP_SEL);

    //----------------------------------------//
    //int block = 0;
    //int type_range = GetLocalInt(client, type_resref + UI_CHAR_UNDERSCORE + "0");
    int type_range = GetLocalInt(client, type_resref + UI_CHAR_UNDERSCORE + IntToString(block));

    if(type_range > 0)
    //while(type_range > 0)
        {
        int type_endrow = FILTER_2DA_RANGE_HIGH & type_range;
        int type_row = type_range >>> BITLEN_2DA_RANGE;

        while(type_row <= type_endrow)
            {
            string type_strref = Get2DAString(type_resref, "Name", type_row);
            if(type_strref != "")
                {
                //----------------------------------------//

                string subtype_strref = Get2DAString(type_resref, "Name", type_row);
                string subtype_resref = Get2DAString(type_resref, "SubTypeResRef", type_row);

                string costtable_resref = "";
                string costtable_row = Get2DAString(type_resref, "CostTableResRef", type_row);
                if(costtable_row != "" && costtable_row != "0")
                    {
                    costtable_resref = Get2DAString("IPRP_COSTTABLE", "Name", StringToInt(costtable_row));
                    }

                string paramtable_resref = "";
                string paramtable_row = Get2DAString(type_resref, "Param1ResRef", type_row);
                if(paramtable_row != "")
                    {
                    paramtable_resref = Get2DAString("IPRP_PARAMTABLE", "TableResRef", StringToInt(paramtable_row));
                    }

                int folder_target = 0;
                if(subtype_resref != "")
                    {
                    folder_target = ip_subtype_file(client, iid, subtype_resref, costtable_resref, paramtable_resref, file_type_menu);
                    }
                else if(costtable_resref != "" || paramtable_resref != "")
                    {
                    folder_target = ip_cost_param1_file(client, iid, costtable_resref, paramtable_resref, file_type_menu);
                    }

                int file_type = create_link_jal(folder_target, file_type_menu);
                create_content_int(client, folder_index, GetStringByStrRef(StringToInt(subtype_strref)), file_type, type_row);

                //----------------------------------------//
                }
            type_row++;
            }

        //block++;
        //type_range = GetLocalInt(client, type_resref + UI_CHAR_UNDERSCORE + IntToString(block));
        }
    }

//==========================================/
int ip_subtype_file(object client, int iid, string subtype_resref, string costtable_resref, string paramtable_resref, int file_type_menu)
//==========================================/
    {
    int folder_index = GetLocalInt(client, CD_STRREF + subtype_resref + costtable_resref + paramtable_resref);
    if(folder_index < 1)
        {
        folder_index = create_container(client, iid, subtype_resref + costtable_resref + paramtable_resref);

        int folder_target = ip_cost_param1_file(client, iid, costtable_resref, paramtable_resref, file_type_menu);
        //----------------------------------------//
        int block = 0;
        int subtype_range = GetLocalInt(client, subtype_resref + UI_CHAR_UNDERSCORE + "0");

        while(subtype_range > 0)
            {
            int subtype_endrow = FILTER_2DA_RANGE_HIGH & subtype_range;
            int subtype_row = subtype_range >>> BITLEN_2DA_RANGE;

            while(subtype_row <= subtype_endrow)
                {
                string subtype_strref = Get2DAString(subtype_resref, "Name", subtype_row);
                if(subtype_strref != "")
                    {
                    int file_type = 0;
                    //param1 override
                    //----------------------------------------//
                    string paramtable_row = Get2DAString(subtype_resref, "Param1ResRef", subtype_row);
                    if(paramtable_row != "")
                        {
                        string paramtable_resref_override = Get2DAString("IPRP_PARAMTABLE", "TableResRef", StringToInt(paramtable_row));
                        int folder_target_override = ip_cost_param1_file(client, iid, costtable_resref, paramtable_resref_override, file_type_menu);

                        file_type = create_link_jal(folder_target_override, file_type_menu);
                        }
                    //----------------------------------------//
                    else
                        {
                        file_type = create_link_jal(folder_target, file_type_menu);
                        }

                    create_content_int(client, folder_index, GetStringByStrRef(StringToInt(subtype_strref)), file_type, subtype_row);
                    }
                subtype_row++;
                }

            block++;
            subtype_range = GetLocalInt(client, subtype_resref + UI_CHAR_UNDERSCORE + IntToString(block));
            }
        }

    return folder_index;
    }

//==========================================/
int ip_cost_param1_file(object client, int iid, string costtable_resref, string paramtable_resref, int file_type_menu)
//==========================================/
    {
    int folder_index = GetLocalInt(client, CD_STRREF + costtable_resref + paramtable_resref);
    if(folder_index < 1)
        {
        int folder_index_cost = 0;
        int folder_index_param1 = 0;

        //----------------------------------------//
        if(paramtable_resref != "")
            {
            folder_index_param1 = GetLocalInt(client, CD_STRREF + paramtable_resref);

            if(folder_index_param1 < 1)
                {
                folder_index_param1 = create_container(client, iid, paramtable_resref);

                int block = 0;
                int param1_range = GetLocalInt(client, paramtable_resref + UI_CHAR_UNDERSCORE + "0");

                while(param1_range > 0)
                    {
                    int param1_endrow = FILTER_2DA_RANGE_HIGH & param1_range;
                    int param1_row = param1_range >>> BITLEN_2DA_RANGE;

                    while(param1_row <= param1_endrow)
                        {
                        string param1_strref = Get2DAString(paramtable_resref , "Name", param1_row);
                        if(param1_strref != "")
                            {
                            create_content_int(client, folder_index_param1, GetStringByStrRef(StringToInt(param1_strref)), file_type_menu, param1_row);
                            }
                        param1_row++;
                        }

                    block++;
                    param1_range = GetLocalInt(client, paramtable_resref + UI_CHAR_UNDERSCORE + IntToString(block));
                    }
                }

            folder_index = folder_index_param1;
            }

        //----------------------------------------//
        if(costtable_resref != "")
            {
            folder_index_cost = create_container(client, iid, costtable_resref + paramtable_resref);

            int block = 0;
            int cost_range = GetLocalInt(client, costtable_resref + UI_CHAR_UNDERSCORE + "0");

            while(cost_range > 0)
                {
                int cost_endrow = FILTER_2DA_RANGE_HIGH & cost_range;
                int cost_row = cost_range >>> BITLEN_2DA_RANGE;

                while(cost_row <= cost_endrow)
                    {
                    string costtable_strref = Get2DAString(costtable_resref, "Name", cost_row);
                    if(costtable_strref != "")
                        {
                        int file_type = create_link_jal(folder_index_param1, file_type_menu);
                        create_content_int(client, folder_index_cost, GetStringByStrRef(StringToInt(costtable_strref)), file_type, cost_row);
                        }
                    cost_row++;
                    }

                block++;
                cost_range = GetLocalInt(client, costtable_resref + UI_CHAR_UNDERSCORE + IntToString(block));
                }

            folder_index = folder_index_cost;
            }
        }

    return folder_index;
    }
