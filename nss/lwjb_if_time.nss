#include "lwjb_inc_common"

/*
** INTERFACE: LWJB TIME V1.0 **
*/

void lwjb_if_init()
{

// set max[1-]. range then goes from 0 to max-1.
SetLocalInt(OBJECT_SELF,"lwjb_max",24);

// finally: set header.
SetCustomToken(LWJB_CUSTOMTOKENSTART+30,
 "** INTERFACE: LWJB TIME V1.0 **\n"+
 "Description: - Die Zeit beeinflussen.\n"+
 "Data source: - hardcoded.\n");

}


string lwjb_if_getline(int i)
{

string s;
s="Set to hour: "+IntToString(i)+", minute: 0, second: 0.";
return s;

}


void lwjb_if_waspressed(int i)
{

SetTime(i,0,0,0);

}


void main()
{

lwjb_dispatcher();

}

// void main() {}
