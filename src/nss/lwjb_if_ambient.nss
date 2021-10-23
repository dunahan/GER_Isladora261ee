#include "lwjb_inc_common"

/*
** INTERFACE: LWJB AMBIENT V1.0 **
*/

void lwjb_if_init()
{

// set max[1-]. range then goes from 0 to max-1.
SetLocalInt(OBJECT_SELF,"lwjb_max",114);

// finally: set header.
SetCustomToken(LWJB_CUSTOMTOKENSTART+30,
 "** INTERFACE: LWJB AMBIENT V1.0 **\n"+
 "Description: - Hintergrundgeräusche im aktuellen Gebiet beeinflussen.\n"+
 "Data source: - AmbientSound.2da.\n");

}


string lwjb_if_getline(int i)
{

string s;
s="Resource= <"+Get2DAString("ambientsound","Resource",i)+">.";
return s;

}


void lwjb_if_waspressed(int i)
{

object area;
area=GetArea(OBJECT_SELF);

AmbientSoundChangeDay(area,i);
AmbientSoundChangeNight(area,i);

}


void main()
{

lwjb_dispatcher();

}

// void main() {}
