/* Script Modified By Rami_Ahmed */

//::///////////////////////////////////////////////
//:: Name: eds_include
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    ENHANCED DELAY SYSTEM -
    Version: 1.1

    This system was developed, in part, to allow
        for long delays without the lag and CPU
        usage associated with the DelayCommand
        function.  The only difference with this
        system is that it's check-based.  Normal
        delays occur the moment the time has
        finished.  Delays using this system are
        activated once the check (verify if the
        delay has finished) has been made.

    To see the system in action, and/or how to
        implement it yourself check out the test
        module.

    Persistent delays are now supported!  This
        ability was added to help preserve lengthy
        delays used by this system.  In order to
        use this option, your module needs to use
        persistent time (system included in the
        test module).  Delays using this feature
        will resume where they left off (i.e
        server crash or restart).

    SYSTEM UPDATES -

    Version 1.1
        * Added support for persistent delays.

    Version 1.0
        * Initial release.

    //===================== VARIABLE CONFIGURATIONS ======================\\

    Set the following variable to:  Module Properties ->
        Advanced -> Minutes/Hour value.
        //const int MINUTES_PER_HOUR = 2;/*

    //====================================================================\\
*/
//:://////////////////////////////////////////////
//:: Created By: Adam Walenga
//:: Created On: September 9th, 2004
//:://////////////////////////////////////////////

#include "aps_include"
#include "eds_include"

//EDS_SetDelay -
//Sets a new delay for the specified object.
//    oObject: This is the object used to store the delay.
//    sVar: This is the variable name to refer to the delay with.
//    fDelay: This is the delay to apply.
//    iPersist: This enables/disables persistency for the delay.  Should only
//        be enabled for long delays (spanning one or more NWN days).
void EDS_SetPersDelay(object oObject, string sVar, float fDelay, int iPersist = TRUE);
void EDS_SetPersDelay(object oObject, string sVar, float fDelay, int iPersist)
{
    //=========================== CALCULATE TIME =========================\\
    int iTotal = (GetCalendarMonth() * 2592000) + (GetCalendarDay() * 86400) +
        (GetTimeHour() * (MINUTES_PER_HOUR * 60)) + (GetTimeMinute() * 60) +
        GetTimeSecond() + FloatToInt (fDelay);

    //======================= STORE TIME VARIABLES =======================\\
    if (iPersist)
    {
        SetPersistentInt(oObject, sVar + "_Year", GetCalendarYear());
        SetPersistentInt(oObject, sVar + "_Time", iTotal);
    }
    else  //Delay is not to be stored for persistency (only locally).
    {
        SetLocalInt(oObject, sVar + "_Year", GetCalendarYear());
        SetLocalInt(oObject, sVar + "_Time", iTotal);
    }
}
//EDS_CheckDelay -
//Checks the current delay, and returns TRUE or FALSE based on whether or not
//the delay time has passed.
//    oObject: This is the object with the stored delay saved to it.
//    sVar: This is the variable name for the specific delay.
int EDS_CheckPersDelay(object oObject, string sVar);
int EDS_CheckPersDelay(object oObject, string sVar)
{
    int iBeginYear = GetPersistentInt(oObject, sVar + "_Year"),
        iBeginTotal;

    //Determine if delay was flagged as persistent.
    if (iBeginYear != 0)
        iBeginTotal = GetPersistentInt(oObject, sVar + "_Time");

    else  //Delay has not been flagged as persistent.  Retrieve local values.
    {
        iBeginYear = GetLocalInt(oObject, sVar + "_Year");
        iBeginTotal = GetLocalInt(oObject, sVar + "_Time");
    }

    //=========================== CALCULATE TIME =========================\\
    int iEndTotal = ((GetCalendarYear() - iBeginYear) * 31104000) +
        (GetCalendarMonth() * 2592000) + (GetCalendarDay() * 86400) +
        (GetTimeHour() * (MINUTES_PER_HOUR * 60)) + (GetTimeMinute() * 60) +
        GetTimeSecond();

    //Determine if the delay has passed.
    return (iEndTotal >= iBeginTotal);
}

//****************************************************************************\\
//****************************** TIME FUNCTIONS ******************************\\
//****************************************************************************\\

//Time_Load -
//Used for OnModuleLoad events.  This script will update the module time
//    for persistency.
void Pers_Time_Load()
{
    //Determine if there is a time period stored that we can load from.
    if (GetPersistentInt(GetModule(), "Time_Initialized"))
    {
        int iYear   = GetPersistentInt(GetModule(), "Time_Year");
        int iMonth  = GetPersistentInt(GetModule(), "Time_Month");
        int iDay    = GetPersistentInt(GetModule(), "Time_Day");
        int iHour   = GetPersistentInt(GetModule(), "Time_Hour");
        int iMinute = GetPersistentInt(GetModule(), "Time_Minute");
        int iSecond = GetPersistentInt(GetModule(), "Time_Second");
        int iMilli  = GetPersistentInt(GetModule(), "Time_Milli");

        //Update module calendar and time.
        SetCalendar(iYear, iMonth, iDay);
        SetTime(iHour, iMinute, iSecond, iMilli);
    }
    else  //First time initializing time for the module.
    {
        SetPersistentInt(GetModule(), "Time_Initialized", TRUE);

        //Store current module time to be used in the future.
        SetPersistentInt(GetModule(), "Time_Year", GetCalendarYear());
        SetPersistentInt(GetModule(), "Time_Month", GetCalendarMonth());
        SetPersistentInt(GetModule(), "Time_Day", GetCalendarDay());
        SetPersistentInt(GetModule(), "Time_Hour", GetTimeHour());
        SetPersistentInt(GetModule(), "Time_Minute", GetTimeMinute());
        SetPersistentInt(GetModule(), "Time_Second", GetTimeSecond());
        SetPersistentInt(GetModule(), "Time_Milli", GetTimeMillisecond());
    }
}
//Time_Update -
//This function, when called, while update the current module time and re-save
//    any values that have changed.
//Note: Time stored in the DB is updated once every NWN hour.
void Pers_Time_Update()
{
    int iHour   = GetTimeHour();
    int iMinute = GetTimeMinute();
    int iSecond = GetTimeSecond();
    int iMilli  = GetTimeMillisecond();

    //Update current module time.  There are two reasons for doing this:
    //    1. Large modules can be CPU intensive, slowing down time progress.
    //    2. Work-around for the known bug when changing time via scripts.
    SetTime(iHour, iMinute, iSecond, iMilli);

    //Every hour time is re-saved to the DB.
    if (iHour == GetPersistentInt(GetModule(), "Time_Hour"))
        return;

    int iYear  = GetCalendarYear();
    int iMonth = GetCalendarMonth();
    int iDay   = GetCalendarDay();

    //Update the module calendar.
    SetPersistentInt(GetModule(), "Time_Year", iYear);
    SetPersistentInt(GetModule(), "Time_Month", iMonth);
    SetPersistentInt(GetModule(), "Time_Day", iDay);
    SetPersistentInt(GetModule(), "Time_Hour", iHour);
    SetPersistentInt(GetModule(), "Time_Minute", iMinute);
    SetPersistentInt(GetModule(), "Time_Second", iSecond);
    SetPersistentInt(GetModule(), "Time_Milli", iMilli);
}
