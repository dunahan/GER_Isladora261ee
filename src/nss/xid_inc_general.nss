//--------------------------------------/
//LOCAL VARIABLE STRINGS
//--------------------------------------/
const string XID = "xg0_";

//--------------------------------------/
//PROTOTYPES
//--------------------------------------/
int get_xid(object client);
void set_xid(object client, int sid);

//--------------------------------------/
//IMPLEMENTATION
//--------------------------------------/
//==========================================/
int get_xid(object client)
//==========================================/
    {
    return GetLocalInt(client, XID);
    }

//==========================================/
void set_xid(object client, int sid)
//==========================================/
    {
    SetLocalInt(client, XID, sid);
    }
