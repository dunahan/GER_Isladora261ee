//:://////////////////////////////////////////////
//::  BODY TAILOR:  copy to me
//::                          onconv bodytailor
//:://////////////////////////////////////////////
/* gather the model info
   and copy to the pc */
//:://////////////////////////////////////////////
//:: Created By: bloodsong
//:: based on the Mil_Tailor by Milambus Mandragon
//:://////////////////////////////////////////////
#include "btlr__inc"

void main()
{
    object oPC = GetPCSpeaker();
    object oSelf = OBJECT_SELF;
    int iNewApp, i;

//--WINGS:
    if(GetCreatureWingType(oSelf) == CREATURE_WING_TYPE_DRAGON)
      if(ALLOWRDDWING || GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE, oPC) > 0)
        SetCreatureWingType(iNewApp, oPC);

    else //-- not red dragon wing
      if(ALLOWRDDREMOVAL || GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE, oPC) <= 0)
        SetCreatureWingType(iNewApp, oPC);

//--TAIL:
    SetCreatureTailType(GetCreatureTailType(oSelf), oPC);

//--HEAD:
    SetCreatureBodyPart(CREATURE_PART_HEAD, GetCreatureBodyPart(CREATURE_PART_HEAD, oSelf), oPC);

//--BODYPARTS:
  //--bone arm parts with checks
    if (GetCreatureBodyPart(CREATURE_PART_LEFT_BICEP, oSelf) == CREATURE_MODEL_TYPE_UNDEAD)
      if (ALLOWBONEARM || GetLevelByClass(CLASS_TYPE_PALE_MASTER, oPC) > 0)
        SetCreatureBodyPart(CREATURE_PART_LEFT_BICEP, iNewApp, oPC);

    else    //-- not a bone arm.
      if (ALLOWBONEREMOVAL || GetLevelByClass(CLASS_TYPE_PALE_MASTER, oPC) <= 0)
        SetCreatureBodyPart(CREATURE_PART_LEFT_BICEP, iNewApp, oPC);

    if (GetCreatureBodyPart(CREATURE_PART_LEFT_FOREARM) == CREATURE_MODEL_TYPE_UNDEAD)
      if (ALLOWBONEARM || GetLevelByClass(CLASS_TYPE_PALE_MASTER, oPC) > 0)
        SetCreatureBodyPart(CREATURE_PART_LEFT_FOREARM, iNewApp, oPC);

    else    //-- not a bone arm.
      if (ALLOWBONEREMOVAL || GetLevelByClass(CLASS_TYPE_PALE_MASTER, oPC) <= 0)
        SetCreatureBodyPart(CREATURE_PART_LEFT_FOREARM, iNewApp, oPC);

    if (GetCreatureBodyPart(CREATURE_PART_LEFT_HAND) == CREATURE_MODEL_TYPE_UNDEAD)
      if (ALLOWBONEARM || GetLevelByClass(CLASS_TYPE_PALE_MASTER, oPC) > 0)
        SetCreatureBodyPart(CREATURE_PART_LEFT_HAND, iNewApp, oPC);

    else    //-- not a bone arm.
      if (ALLOWBONEREMOVAL || GetLevelByClass(CLASS_TYPE_PALE_MASTER, oPC) <= 0)
        SetCreatureBodyPart(CREATURE_PART_LEFT_HAND, iNewApp, oPC);

//-- right arm
    SetCreatureBodyPart(CREATURE_PART_RIGHT_BICEP, GetCreatureBodyPart(CREATURE_PART_RIGHT_BICEP, oSelf), oPC);
    SetCreatureBodyPart(CREATURE_PART_RIGHT_FOREARM, GetCreatureBodyPart(CREATURE_PART_RIGHT_FOREARM, oSelf), oPC);
    SetCreatureBodyPart(CREATURE_PART_RIGHT_HAND, GetCreatureBodyPart(CREATURE_PART_RIGHT_HAND, oSelf), oPC);

//-- regular bodyparts
    for (i = 0; i < 10; i++)    SetCreatureBodyPart(i, GetCreatureBodyPart(i, oSelf), oPC);

//--EYES
   ExecuteScript("btlr_applyeyes", OBJECT_SELF);

//--PHENOTYPE
   SetPhenoType(GetPhenoType(oSelf), oPC);

//--Color
    for (i = 0; i < 4; i++)     SetColor(oPC, i, GetColor(oSelf, i));
}
