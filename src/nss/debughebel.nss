#include "_isla_inc"
#include "cnr_persist_inc"

void main()
{
  string sTag = GetTag(OBJECT_SELF);

    if (sTag == "MonsterSpawn" || sTag == "AreaCleanup" || sTag == "")          // noch nicht eingebaut
      return;
/*
    if (sTag == "CNR_DB_Update")
    {
        int nIndex = GetLocalInt(OBJECT_SELF, "State");
        int nDeviceCount = GetLocalInt(GetModule(), "CnrCraftingDeviceCount");
        if (nIndex == 0 || nIndex >= nDeviceCount)  nIndex = 1;

        CnrWriteDeviceToDatabase(nIndex);

        SetLocalInt(OBJECT_SELF, "State", GetLocalInt(OBJECT_SELF, "State")+1);
        return;
    }
*/
    if (sTag == "WeatherLeverAllClear")
    {
      // 1++ Definiere das Wetter das eingestellt werden soll, hier klar
      int nWeather = WEATHER_CLEAR;
      int nSky = SKYBOX_GRASS_CLEAR;
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

    if (sTag == "DebugModus")
    {
      if (GetLocalInt(GetModule(), "DEBUG_MODE") == 0)
      {
        SetLocalInt(GetModule(), "DEBUG_MODE", 1);
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        SpeakString(GetName(OBJECT_SELF)+" mit GetFirstPC() wurde aktiviert!");
      }

      else if (GetLocalInt(GetModule(), "DEBUG_MODE") == 1)
      {
        SetLocalInt(GetModule(), "DEBUG_MODE", 2);
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        SpeakString(GetName(OBJECT_SELF)+" mit LogEntry wurde aktiviert!");
      }

      else if (GetLocalInt(GetModule(), "DEBUG_MODE") == 2)
      {
        SetLocalInt(GetModule(), "DEBUG_MODE", 3);
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        SpeakString(GetName(OBJECT_SELF)+" mit GetFirstPC() & LogEntry wurde aktiviert!");
      }

      else if (GetLocalInt(GetModule(), "DEBUG_MODE") == 3)
      {
        SetLocalInt(GetModule(), "DEBUG_MODE", 0);
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        SpeakString(GetName(OBJECT_SELF)+" wurde deaktiviert!");
      }
    }
}

