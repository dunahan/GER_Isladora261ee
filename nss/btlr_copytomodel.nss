//:://////////////////////////////////////////////
//::  BODY TAILOR:  copy to model
//::                          onconv bodytailor
//:://////////////////////////////////////////////
/* gather the pc info
   and copy to the model */
//:://////////////////////////////////////////////
//:: Created By: bloodsong
//:: based on the Mil_Tailor by Milambus Mandragon
//:://////////////////////////////////////////////
#include "btlr__inc"

void main()
{
    object oPC = OBJECT_SELF;   //--reversed from copy to pc
    object oSelf = GetPCSpeaker();
    int iNewApp, i;

//--WINGS:
    SetCreatureWingType(GetCreatureWingType(oSelf), oPC);

//--TAIL:
    SetCreatureTailType(GetCreatureTailType(oSelf), oPC);

//--HEAD: only 20
    SetCreatureBodyPart(CREATURE_PART_HEAD, GetCreatureBodyPart(CREATURE_PART_HEAD, oSelf), oPC);

//--BODYPARTS: from 0 to 17
    for (i=0;i<18;i++)  SetCreatureBodyPart(i, GetCreatureBodyPart(i, oSelf), oPC);

//--EYES
   //--this can't be done from pc to npc. (easily). live with it.

//--PHENOTYPE
   SetPhenoType(GetPhenoType(oSelf), oPC);

//--Color
    for (i = 0; i<4; i++)   SetColor(oPC, i, GetColor(oSelf, i));
}
