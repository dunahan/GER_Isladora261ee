#include "lwjb_inc_common"

/*
** INTERFACE: LWJB FOGCOL V1.0 **
*/

// (c) gaoneng:
const string COLORTOKEN = "                  ##################$%&'()*+,-./0123456789:;;==?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[[]^_`abcdefghijklmnopqrstuvwxyz{|}~~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ¡¡¢£¤¥¦§¨©ª«¬¬®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışş";

// returns a properly color-coded sText string based on specified RGB values
string ColorString(string sText, int nRed=255, int nGreen=255, int nBlue=255)
{
return "<c" + GetSubString(COLORTOKEN, nRed, 1) + GetSubString(COLORTOKEN, nGreen, 1) + GetSubString(COLORTOKEN, nBlue, 1) + ">" + sText + "</c>";
}

void lwjb_if_init()
{

// set max[1-]. range then goes from 0 to max-1.
SetLocalInt(OBJECT_SELF,"lwjb_max",512);

// finally: set header.
SetCustomToken(LWJB_CUSTOMTOKENSTART+30,
 "** INTERFACE: LWJB FOGCOL V1.0 **\n"+
 "Description: - Farbe des Nebels im aktuellen Gebiet beeinflussen.\n"+
 "Data source: - hardcoded.\n");

}


string lwjb_if_getline(int i)
{

int r,g,b;
b=(i&7)*32;
i=i>>3;
g=(i&7)*32;
i=i>>3;
r=i*32;

string s;

s="COL/"+
 "R"+IntToString(r)+"/"+
 "G"+IntToString(g)+"/"+
 "B"+IntToString(b)+": "+
 ColorString("The quick brown fox jumps over the lazy dog.",r,g,b);

return s;

}


void lwjb_if_waspressed(int i)
{

object area;
area=GetArea(OBJECT_SELF);

int r,g,b;
b=(i&7)*32;
i=i>>3;
g=(i&7)*32;
i=i>>3;
r=i*32;

int c;
c=(r<<16)|(g<<8)|b;
SetFogColor(FOG_TYPE_ALL,c,area);

}


void main()
{

lwjb_dispatcher();

}

// void main() {}
