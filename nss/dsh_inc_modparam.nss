//--------------------------------------/
//LOCAL VARIABLE STRINGS
//--------------------------------------/
const string PARAM_MOD = "dm0_";
const string PARAM_MODCOST = "dm1_";

//--------------------------------------/
//PROTOTYPES
//--------------------------------------/
void mod_cost_set(object user, int cost);
int mod_cost_get(object user);
void mod_set_int(object user, int mod);
int mod_get_int(object user);
void mod_set_str(object user, string mod);
string mod_get_str(object user);

//--------------------------------------/
//IMPLEMENTATION
//--------------------------------------/
//==========================================/
void mod_set_int(object user, int mod)
//==========================================/
    {
    SetLocalInt(user, PARAM_MOD, mod);
    }

//==========================================/
int mod_get_int(object user)
//==========================================/
    {
    return GetLocalInt(user, PARAM_MOD);
    }

//==========================================/
void mod_set_str(object user, string mod)
//==========================================/
    {
    SetLocalString(user, PARAM_MOD, mod);
    }

//==========================================/
string mod_get_str(object user)
//==========================================/
    {
    return GetLocalString(user, PARAM_MOD);
    }

//==========================================/
void mod_cost_set(object user, int cost)
//==========================================/
    {
    SetLocalInt(user, PARAM_MODCOST, cost);
    }

//==========================================/
int mod_cost_get(object user)
//==========================================/
    {
    return GetLocalInt(user, PARAM_MODCOST);
    }
