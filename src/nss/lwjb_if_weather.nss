#include "lwjb_inc_common"

/*
** INTERFACE: LWJB WEATHER V1.0 **
*/

void lwjb_if_init()
{

// set max[1-]. range then goes from 0 to max-1.
SetLocalInt(OBJECT_SELF,"lwjb_max",4);

// finally: set header.
SetCustomToken(LWJB_CUSTOMTOKENSTART+30,
 "** INTERFACE: LWJB WEATHER V1.0 **\n"+
 "Description: - Wetter im aktuellen Gebiet beeinflussen.\n"+
 "Data source: - hardcoded.\n");

}


string lwjb_if_getline(int i)
{

switch(i)
{
case 0: { return("WEATHER_USE_AREA_SETTINGS."); break; }
case 1: { return("WEATHER_CLEAR."); break; }
case 2: { return("WEATHER_RAIN."); break; }
case 3: { return("WEATHER_SNOW."); break; }
}

return("<ERROR>");

}


void lwjb_if_waspressed(int i)
{

object area;
area=GetArea(OBJECT_SELF);

switch(i)
{
case 0: { SetWeather(area,WEATHER_USE_AREA_SETTINGS); break; }
case 1: { SetWeather(area,WEATHER_CLEAR); break; }
case 2: { SetWeather(area,WEATHER_RAIN); break; }
case 3: { SetWeather(area,WEATHER_SNOW); break; }
}

}

void main()
{

lwjb_dispatcher();

}

// void main() {}
