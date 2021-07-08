#include "lwjb_inc_common"

/*
** INTERFACE: LWJB MUSIC V1.0 **
*/

void lwjb_if_init()
{

// set max[1-]. range then goes from 0 to max-1. Added CMP Files
SetLocalInt(OBJECT_SELF,"lwjb_max",335);

// finally: set header.
SetCustomToken(LWJB_CUSTOMTOKENSTART+30,
 "** INTERFACE: LWJB MUSIC V1.0 **\n"+
 "Description: - Musik im aktuellen Gebiet beeinflussen.\n"+
 "Data source: - ambientmusic.2da.\n");

}


string lwjb_if_getline(int i)
{

string s;
s="Resource= <"+Get2DAString("ambientmusic","Resource",i)+">, ";
s=s+"DisplayName= <"+Get2DAString("ambientmusic","DisplayName",i)+">.";
return s;

}


void lwjb_if_waspressed(int i)
{

object area;
area=GetArea(OBJECT_SELF);

MusicBackgroundChangeDay(area,i);
MusicBackgroundChangeNight(area,i);

}


void main()
{

lwjb_dispatcher();

}

// void main() {}
