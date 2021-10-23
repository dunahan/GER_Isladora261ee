#include "_isla_inc"

void main()
{
  // 1++ Definiere das Wetter das eingestellt werden soll, hier klar
  int nWeather = WEATHER_CLEAR;
  int     nSky = SKYBOX_GRASS_CLEAR;
  object oMod = GetModule();

  // 2++ Umsetzen des Wetters aufs Modul bzw. des Himmels auf die Area
  int nAll = GetAreaCount();     // Erfasse die Anzahl der Areas
  object oArea = GetFirstArea(); // Erfasse die erste Area

  // 2.1 Wenn diese Area exisitert
  while ( GetIsObjectValid(oArea) )
  {
    SetWeather(oMod, nWeather);  // Setze das Wetter auf das vorher Definierte
    SetSkyBox(nSky, oArea);      // Setze den Himmel auf den vorher Definierten

    oArea = GetNextArea();       // Erfasse die naechste Area
  }
}
