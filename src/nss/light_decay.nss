void main()
{
    int myTimer = GetLocalInt(OBJECT_SELF, "TIMER");
        myTimer = myTimer - 1;
    if (myTimer < 1)
    {
          SetPlotFlag(OBJECT_SELF, FALSE);
          DestroyObject(OBJECT_SELF, 1.0);
    }
    SetLocalInt(OBJECT_SELF, "TIMER", myTimer);
}
