//::///////////////////////////////////////////////
//:: Name
//:: FileName   sk_tilemagic
//:: Copyright (c) 2009 Dunahan@schwerterkueste.de
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 22.11.2009
//:://////////////////////////////////////////////
#include "x2_inc_toollib"
#include "_isla_inc"

// change the type of the ground or (by default) sub ground tiles (i.e. water) to the specified type
// Valid values are
// const int X2_TL_GROUNDTILE_ICE = 426;
// const int X2_TL_GROUNDTILE_WATER = 401;
// const int X2_TL_GROUNDTILE_GRASS = 402;
// const int X2_TL_GROUNDTILE_LAVA_FOUNTAIN = 349; // ugly
// const int X2_TL_GROUNDTILE_LAVA = 350;
// const int X2_TL_GROUNDTILE_CAVEFLOOR = 406;
// const int X2_TL_GROUNDTILE_SEWER_WATER = 461;

void main()
{
    object oPC    = GetEnteringObject();
    object oArea  = GetArea(oPC);

    // Get the Tileset witch should be placed
    int  nGround  = GetLocalInt(oArea, "nGround");

    // Get the number of columns in the area
    int   nXsize   = GetAreaSize(AREA_WIDTH, oArea);

    // Get the number of rows in the area
    int   nYsize   = GetAreaSize(AREA_HEIGHT, oArea);

    // Get the Height of the Groundtiles
    float fHeight  = GetLocalFloat(oArea, "fHeight");
    // General Default for all tiles
    float fDefault = 0.5;

    // If an offset is not specified via float on the area, use the default
    if      (fHeight    ==  0.0)
    {
        fHeight         =  -0.05;
        SetLocalFloat(oArea, "fHeight", fHeight);
    }

// - - Starting the script - - //

if      (GetLocalInt(oArea, "Tilemagic") == 0)
    {
  //TLChangeAreaGroundTiles  (oArea, nGround, nXsize, nYsize, fHeight);
    TLChangeAreaGroundTilesEx(oArea, nGround, fHeight);
    SetLocalInt(oArea, "Tilemagic", 1);
    }
else if (GetLocalInt(oArea, "Tilemagic") == 1)
    {
     DelayCommand(1200.0, SetLocalInt(oArea, "Tilemagic", 0));
    }

}
