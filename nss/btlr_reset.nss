//:://////////////////////////////////////////////
//::  BODY TAILOR:  reset
//::                          onconv bodytailor
//:://////////////////////////////////////////////
/*  set all to 0/1  */
//:://////////////////////////////////////////////
//:: Created By: bloodsong
//:: based on the Mil_Tailor by Milambus Mandragon
//:://////////////////////////////////////////////
#include "btlr__inc"

void main()
{
    object oPC = OBJECT_SELF; int i;  //--reversed from copy to pc

//--WINGS:
    SetCreatureWingType(0, oPC);

//--TAIL:
    SetCreatureTailType(0, oPC);

//--EYES
    ApplyEyes(0, oPC);

//--PHENO
    SetPhenoType(PHENOTYPE_NORMAL);

//--HEAD:
    SetCreatureBodyPart(CREATURE_PART_HEAD, 1, oPC);

//--BODYPARTS:
    for (i=0; i<18; i++)    SetCreatureBodyPart(i, 1, oPC);

//--Colors
    for (i=0; i<4; i++)     SetColor(OBJECT_SELF, i, 1);

//--Race
    SetCreatureAppearanceType(OBJECT_SELF, APPEARANCE_TYPE_HUMAN);
}
