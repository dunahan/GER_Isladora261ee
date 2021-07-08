//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_setnight
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript um zum Sonnenuntergang voran zu schreiten


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://///////////////////////////////////////////
#include "_sltools_inc"

void main()
{
  // Lese die aktuelle Zeit aus
  //int nHour   = GetTimeHour();
  //int nMinute = GetTimeMinute();
  //int nSecond = GetTimeSecond();
  //int nMillisecond = GetTimeMillisecond();

  //int nYear  = GetCalendarYear();
  //int nMonth = GetCalendarMonth();
  //int nDay   = GetCalendarDay();

  // Schreite zu Sonnenuntergang voran
  SetTime(18, 0, 0, 0);
  SendServerMessageToPC(oSpeaker, "Es ist "+ IntToString(GetTimeHour()) +
                            " am "+ IntToString(GetCalendarDay()) + ". " +
                                    IntToString(GetCalendarMonth()) + ". " +
                                    IntToString(GetCalendarYear()) + ".");

 // Sicherung der Zeit durchführen!!!
}
