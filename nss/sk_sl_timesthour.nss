//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_timesthour
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript um die Uhrzeit um eine Stunde voran
    schreiten zu lassen.

*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

void main()
{
  // Lese die aktuelle Zeit aus
  int nHour = GetTimeHour();
  int nMinute = GetTimeMinute();
  int nSecond = GetTimeSecond();
  int nMillisecond = GetTimeMillisecond();

  //int nYear  = GetCalendarYear();
  //int nMonth = GetCalendarMonth();
  //int nDay   = GetCalendarDay();

  // Eine Stunde vor stellen
  nHour += 1;

  // Neue Zeit einstellen
  SetTime(nHour, nMinute, nSecond, nMillisecond);
  SendServerMessageToPC(oSpeaker, "Es ist "+ IntToString(GetTimeHour()) +
                            " am "+ IntToString(GetCalendarDay()) + ". " +
                                    IntToString(GetCalendarMonth()) + ". " +
                                    IntToString(GetCalendarYear()) + ".");

  // am besten gleich noch eine Sicherung durchführen, Schau in das Zeitansehen Skript!
}
