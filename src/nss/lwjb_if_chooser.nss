#include "lwjb_inc_common"

/*
** INTERFACE: LWJB CHOOSER V1.0 **
*/

void lwjb_if_init()
{

// set max[1-]. range then goes from 0 to max-1. Time was disabled!
SetLocalInt(OBJECT_SELF,"lwjb_max",7);

// finally: set header.
SetCustomToken(LWJB_CUSTOMTOKENSTART+30,
 "** INTERFACE: LWJB CHOOSER V1.0 **\n"+
 "Description: - chooses the LWJB interface.\n"+
 "Data source: - hardcoded.\n");

}


string lwjb_if_getline(int i)
{

string s;

switch(i)
{
case 0:
 { s="<lwjb_if_music>. Beeinflusse die Musik.";
 break; }
case 1:
 { s="<lwjb_if_ambient>. Beeinflusse die Hintergrundgeräusche.";
 break; }
case 2:
 { s="<lwjb_if_ambvol>. Lautstärke der Hintergeräusche.";
 break; }
case 3:
 { s="<lwjb_if_skybox>. Beeinflusse den Himmel.";
 break; }
case 4:
 { s="<lwjb_if_weather>. Beeinflusse das Wetter.";
 break; }
case 5:
 { s="<lwjb_if_fogamoun>. Beeinflusse den Nebel.";
 break; }
case 6:
 { s="<lwjb_if_fogcol>. Farbe des Nebels.";
 break; }
case 7:
 { s="<lwjb_if_time>. Beeinflusse die Zeit.";
 break; }
}

return s;

}


void lwjb_if_waspressed(int i)
{

string s;

switch(i)
{
case 0: { s="lwjb_if_music"; break; }
case 1: { s="lwjb_if_ambient"; break; }
case 2: { s="lwjb_if_ambvol"; break; }
case 3: { s="lwjb_if_skybox"; break; }
case 4: { s="lwjb_if_weather"; break; }
case 5: { s="lwjb_if_fogamoun"; break; }
case 6: { s="lwjb_if_fogcol"; break; }
case 7: { s="lwjb_if_time"; break; }
}

SetLocalString(OBJECT_SELF,"lwjb_interface",s);
SetLocalInt(OBJECT_SELF,"lwjb_initted",FALSE); // force reset

}


void main()
{

lwjb_dispatcher();

}

// void main() {}
