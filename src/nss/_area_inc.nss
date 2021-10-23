//::///////////////////////////////////////////////
//:: Area Include File
//:: area_inc
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    GetArea(), GetFirstArea() functions.
    Used in conjunction with the Area Place Holder
    placeable. If you want your area to show up in
    the list of areas, you must include this placeable
    somewhere in your area.
*/
//:://////////////////////////////////////////////
//:: Created By:  MJ
//:: Created On:  12/21/04
//:://////////////////////////////////////////////
#include "_debugisla"

/* Area Size Constants
const int MaxAreaSizeX = 32;
const int MaxAreaSizeY = 32;

string AREA_DESIGNATOR_TAG = "area_designator";

const string AREA_LIST_PREFIX = "AREA_";
const string AREA_LIST_COUNT  = "AREA_COUNT";
const string AREA_LIST_RESREF = "AREA_RESREF";
const string AREA_LIST_TAG = "AREA_TAG";
const string AREA_LIST_POINTER = "AREA_LIST_POINTER";
*/
string TokenToString(string sToken, string sTargetString, string sDelimiter = "|")
{
  return (sTargetString != "") ? sTargetString + sDelimiter + sToken : sToken;
}
/*
//------------------------------------------------------------------------------
// Initialize the modules list of areas.
//------------------------------------------------------------------------------
void InitializeAreaList();
void InitializeAreaList()
{
    object oModule = GetModule();
    object oArea; string sName; string sTag; string sResRef;
    string sTemp; string sDes;
    object oAreaList = GetObjectByTag("AreaList");

    int nNth = 0;
    object oDesignator = GetObjectByTag(AREA_DESIGNATOR_TAG,nNth);

    while (GetIsObjectValid(oDesignator))
    {
        oArea = GetArea(oDesignator);
        SetLocalObject(oModule, AREA_LIST_PREFIX+IntToString(nNth), oArea);

        sName = GetName(oArea); sTag = GetTag(oArea); sResRef = GetResRef(oArea);
        AreaLogging("Map: "+sName+", Tag: "+sTag+ ", ResRef: "+sResRef+" aufgenommen.");

        sResRef = TokenToString(GetLocalString(oModule, AREA_LIST_RESREF), sResRef);
        sTag = TokenToString(GetLocalString(oModule, AREA_LIST_TAG), sTag);
        sDes = sName+" ("+sTag+")";
        sDes = TokenToString(GetDescription(oAreaList), sDes);

        SetLocalString(oAreaList, AREA_LIST_RESREF, sResRef);
        SetLocalString(oAreaList, AREA_LIST_TAG, sTag);
        SetDescription(oAreaList, sDes, TRUE);

        SetPlotFlag(oDesignator,FALSE);
        DestroyObject(oDesignator);
        nNth++;

        AreaLogging("Anzahl der bisherigen Maps: "+IntToString(nNth));

        oDesignator = GetObjectByTag(AREA_DESIGNATOR_TAG,nNth);
    }
    SetLocalInt(oModule,AREA_LIST_COUNT,(nNth));
}

//------------------------------------------------------------------------------
// Provides direct access to area nIdx in the modules area list
//------------------------------------------------------------------------------
object GetAreaByIndex(int nIdx);
object GetAreaByIndex(int nIdx)
{
    object oRet = GetLocalObject(GetModule(), AREA_LIST_PREFIX+IntToString(nIdx));
    DebugMode(GetName(oRet));
    return oRet;
}
//------------------------------------------------------------------------------
// Return the First Area in the Modules Arealist
//------------------------------------------------------------------------------
object GetFirstArea();
object GetFirstArea()
{
    SetLocalInt (GetModule(), AREA_LIST_POINTER,0);
    object oRet =  GetAreaByIndex(0);
    DebugMode(GetName(oRet));
    return oRet;
}
//------------------------------------------------------------------------------
// Return the Next Area in the Modules Arealist
//------------------------------------------------------------------------------
object GetNextArea();
object GetNextArea()
{
    int nIdx =  GetLocalInt (GetModule(),AREA_LIST_POINTER);
    nIdx++;
    object oRet =  GetAreaByIndex(nIdx);
    SetLocalInt (GetModule(),AREA_LIST_POINTER,nIdx);
    DebugMode(GetName(oRet));
    return oRet;
}
*/

object GetAreaByResRef(string sResRef);
object GetAreaByResRef(string sResRef)
{
    object oArea = GetFirstArea();
    while (GetIsObjectValid(oArea))
    {
        if (GetResRef(oArea) == sResRef)
            return oArea;
        else
            oArea = GetNextArea();
    }

    return OBJECT_INVALID;
}

//------------------------------------------------------------------------------
// Return the number of areas in the module
//------------------------------------------------------------------------------
int GetAreaCount();
int GetAreaCount()
{
    object oArea = GetFirstArea();
    int nResult = 0;
    while (GetIsObjectValid(oArea))
    {
        nResult++;
        oArea = GetNextArea();
    }

    return nResult;
}

//------------------------------------------------------------------------------
// Returns a random location within the specified area.
//------------------------------------------------------------------------------
location AreaRandomLocation(object oArea);
location AreaRandomLocation(object oArea)
{
    location lLoc;
    int nRanX, nRanY, nRanZ;

    nRanX = Random(GetAreaSize(AREA_HEIGHT, oArea));
    nRanY = Random(GetAreaSize(AREA_WIDTH, oArea));
    nRanZ = 0; // Random(MaxAreaSizeZ); ???

    float fX = IntToFloat(nRanX);
    float fY = IntToFloat(nRanY);
    float fZ = IntToFloat(nRanZ);

    vector vVec = Vector(fX, fY, fZ);
    lLoc = Location(oArea, vVec, 0.0);
    return lLoc;
}

int GetIsAreaEmpty(object oArea) {
    object oPC = GetFirstPC();
    while (oPC != OBJECT_INVALID) {
        if (GetArea(oPC) == oArea)
            return FALSE;
        oPC = GetNextPC();
    }
    return TRUE;
}
