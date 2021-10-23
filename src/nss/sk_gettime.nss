//::///////////////////////////////////////////////
//:: Get Time
//:: sk_gettime
//:: Copyright (c) 2010 Dunahan
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
#include "eds_include"
#include "_isla_inc"

// Hauptskript
void main()
{
  int cHour  = GetTimeHour(); string sHour;
  int cMonth = GetCalendarMonth(); int cYear = GetCalendarYear();
  int cDay   = GetCalendarDay();   int cWeek = GetCalendarDay();
  string sDay; string sWeek; string sMonth; string sYear;

  switch (cMonth){
    case 01: {sMonth = ". Hammer ";     break;} case 02: {sMonth = ". Alturiak "; break;} case 03: {sMonth = ". Ches ";    break;}
    case 04: {sMonth = ". Tarsak ";     break;} case 05: {sMonth = ". Mirrul ";   break;} case 06: {sMonth = ". Kytorn ";  break;}
    case 07: {sMonth = ". Flammleite "; break;} case 08: {sMonth = ". Eleasias "; break;} case 09: {sMonth = ". Eleint ";  break;}
    case 10: {sMonth = ". Marpenot ";   break;} case 11: {sMonth = ". Uktar ";    break;} case 12: {sMonth = ". Nachtal "; break;}}

  switch (cYear){
    case 1371: {sYear = "dem Jahr der saitenlosen Harfe, "; break;}
    case 1372: {sYear = "dem Jahr der Wilden Magie, ";      break;}
    case 1373: {sYear = "dem Jahr der Drachendiebe, ";      break;}}


  switch (cDay){
    case 01: case 11: case 21: {sDay = "Amaunatag";   break;}
    case 02: case 12: case 22: {sDay = "Selûnestag";  break;}
    case 03: case 13: case 23: {sDay = "Helmstag";    break;}
    case 04: case 14: case 24: {sDay = "Oghmastag";   break;}
    case 05: case 15: case 25: {sDay = "Rittmitte";   break;}
    case 06: case 16: case 26: {sDay = "Talostag";    break;}
    case 07: case 17: case 27: {sDay = "Sunestag";    break;}
    case 08: case 18: case 28: {sDay = "Mystrastag";  break;}
    case 09: case 19: case 29: {sDay = "Silvanustag"; break;}
    case 10: case 20: case 30: {sDay = "Rittende";    break;}}

  switch (cWeek){
    case 01: case 02: case 03: case 04: case 05:
    case 06: case 07: case 08: case 09: case 10: {sWeek = " des 1. Zehntages."; break;}
    case 11: case 12: case 13: case 14: case 15:
    case 16: case 17: case 18: case 19: case 20: {sWeek = " des 2. Zehntages."; break;}
    case 21: case 22: case 23: case 24: case 25:
    case 26: case 27: case 28: case 29: case 30: {sWeek = " des 3. Zehntages."; break;}}

  switch (cHour){
    case  0: {sHour = " Um Mitternacht."; break;}
    case  1: case  2: case  3: case  4: case  5: {sHour = " In den Nachtstunden."; break;}
    case  6: {sHour = " Zur Morgendämmerung."; break;}
    case  7: case  8: case  9: case 10: case 11: {sHour = " In den Morgenstunden."; break;}
    case 12: {sHour = " Zum Sonnenhöchststand."; break;}
    case 13: case 14: case 15: case 16: case 17: {sHour = " In den Mittagsstunden."; break;}
    case 18: {sHour = " Zur Abenddämmerung."; break;}
    case 19: case 20: {sHour = " In den Abendstunden."; break;}
    case 21: case 22: case 23: {sHour = " In den Nachtstunden."; break;}}

  string sTime =  "Heute ist der " +                  // Heute ist der
                  IntToString(GetCalendarDay()) +     // 1
                  sMonth +                            // . Hammer
                  IntToString(GetCalendarYear()) +    // 1371
                  " " + sYear +                       // dem Jahr der saitenlosen Harfe,
                  sDay +                              // Amaunatag
                  sWeek +                             // des 1. Zehntages.
                  sHour;                              // In den Mittagsstunden.

  FloatingTextStringOnCreature(ColorString(sTime, 255, 255, 0), GetLastSpeaker());

  Time_Update();
}
