#include "_isla_inc"

void main()
{
    location lSelf = GetLocation(OBJECT_SELF);
    int nCount = GetLocalInt(GetModule(), "AreaTransCount");
    int nFlag;

    DebugMode("spawnareatrans");

    // If transitionout has not been set, create it, else create transitionin and reset flag
    if (!GetLocalInt(GetModule(), "AreaTransFlag"))
    {
        object oOut = CreateObject(OBJECT_TYPE_PLACEABLE, "areatrans2", lSelf, FALSE, "areaout" + IntToString(nCount));

        // Set the local reference counter and the boolean transition flag
        SetLocalInt(oOut, "nCount", nCount);
        nFlag = TRUE;
        SetLocalInt(GetModule(), "AreaTransFlag", nFlag);
    }
    else
    {
        object oIn = CreateObject(OBJECT_TYPE_PLACEABLE, "areatransition", lSelf, FALSE, "areain" + IntToString(nCount));
        SetLocalInt(oIn,"nCount", nCount);

        // Increment the counter, set it both locally and on the module, and reset the boolean transition flag
        nCount = nCount + 1;
        SetLocalInt(GetModule(), "AreaTransCount", nCount);
        nFlag = FALSE;
        SetLocalInt(GetModule(), "AreaTransFlag", nFlag);
    }
}
