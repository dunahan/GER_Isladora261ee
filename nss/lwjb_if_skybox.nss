#include "lwjb_inc_common"

/*
** INTERFACE: LWJB SKYBOX V1.0 **
*/

void lwjb_if_init()
{

// set max[1-]. range then goes from 0 to max-1. Added Custom Skyboxes
SetLocalInt(OBJECT_SELF,"lwjb_max",114);

// finally: set header.
SetCustomToken(LWJB_CUSTOMTOKENSTART+30,
 "** INTERFACE: LWJB SKYBOX V1.0 **\n"+
 "Description: - Himmel im aktuellen Gebiet beeinflussen.\n"+
 "Data source: - skyboxes.2da.\n");

}


string lwjb_if_getline(int i)
{

string s;
s="LABEL= <"+Get2DAString("skyboxes","LABEL",i)+">.";
return s;

}


void lwjb_if_waspressed(int i)
{

object area;
area=GetArea(OBJECT_SELF);

SetSkyBox(i,area);

}


void main()
{

lwjb_dispatcher();

}

// void main() {}
