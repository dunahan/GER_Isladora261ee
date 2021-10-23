#include "lwjb_inc_common"

/*
** INTERFACE: LWJB FOGAMOUN V1.0 **
*/

void lwjb_if_init()
{

// set max[1-]. range then goes from 0 to max-1.
SetLocalInt(OBJECT_SELF,"lwjb_max",100);

// finally: set header.
SetCustomToken(LWJB_CUSTOMTOKENSTART+30,
 "** INTERFACE: LWJB FOGAMOUN V1.0 **\n"+
 "Description: - Menge des Nebels im aktuellen Gebiet beeinflussen.\n"+
 "Data source: - hardcoded.\n");

}


string makebar(float f,string col1="<c þ >",string col2="<cþ  >")
{
if (f<0.0) f=0.0; else
 if (f>1.0) f=1.0;

string barraw="||||||||||||||||||||||||||||||||||||||||";
string barcolored;
int fi;
fi=FloatToInt(f*40.0);
barcolored=col1+GetSubString(barraw,0,fi)+"</c>"+col2+GetSubString(barraw,fi,40)+"</c>";
return barcolored;
}

string lwjb_if_getline(int i)
{

i=i*2;

string s;
s=makebar(IntToFloat(i)/200.0)+" "+IntToString(i/2)+"%";
return s;

}


void lwjb_if_waspressed(int i)
{

i=i*2;

object area;
area=GetArea(OBJECT_SELF);

SetFogAmount(FOG_TYPE_ALL,i,area);

}


void main()
{

lwjb_dispatcher();

}

// void main() {}
