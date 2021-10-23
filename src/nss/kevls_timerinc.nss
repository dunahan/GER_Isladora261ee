#include "_debugisla"

// Sets the start time for sVar-event.
void kL_SetIntervalStart(string sVar, object oObject = OBJECT_SELF);

// Gets how many seconds have passed since sVar-event.
// returns -1 if start event hasn't been set
int kL_GetIntervalElapsed(string sVar, object oObject = OBJECT_SELF);

// Resets the counter.
void kL_ClearInterval(string sVar, object oObject = OBJECT_SELF);

// Returns current game-time in seconds.
int kL_CalcCurrent();

// --- bodys following --- \\\

void kL_SetIntervalStart(string sVar, object oObject = OBJECT_SELF) {
    SetLocalInt(oObject, sVar, kL_CalcCurrent());                               d(GetName(oObject) +"\n"+sVar+"\n"+IntToString(kL_CalcCurrent()));
}

int kL_GetIntervalElapsed(string sVar, object oObject = OBJECT_SELF) {
    int i = GetLocalInt(oObject, sVar);                                         d(GetName(oObject) +"\n"+sVar+"\n"+IntToString(i));

    if (i != 0) {                                                               d(GetName(oObject) +"\n"+sVar+"\n"+IntToString(kL_CalcCurrent() - i));
        return kL_CalcCurrent() - i;
    }
    return -1;
}

void kL_ClearInterval(string sVar, object oObject = OBJECT_SELF) {
    SetLocalInt(oObject, sVar, 0);
}

int kL_CalcCurrent()
{
    int iYear = GetCalendarYear();
    int iMonth = GetCalendarMonth();
    int iDay = GetCalendarDay();
    int iHour = GetTimeHour();
    int iMinute = GetTimeMinute();
    int iSecond = GetTimeSecond();
    int iSecondsPerHour = FloatToInt(HoursToSeconds(1));
    return iYear       * 12 * 28 * 24 * iSecondsPerHour
        + (iMonth - 1) * 28 * 24 * iSecondsPerHour
        + (iDay - 1)   * 24 * iSecondsPerHour
        +  iHour       * iSecondsPerHour
        +  iMinute     * 60
        +  iSecond;
}
