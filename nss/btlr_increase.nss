//::///////////////////////////////////////////////
//:: BODY TAILOR: increase
//:: onconv bodytailor
//:://////////////////////////////////////////////
/*
   this just increments the piece number and slaps it on.
   well, checking for restrictions and looping back to 0,
   too.
*/
//:://////////////////////////////////////////////
//:: Created By: bloodsong
//:: based on the mil tailor by Jake E. Fitch (Milambus Mandragon)
//:://////////////////////////////////////////////
#include "btlr__inc"



void main()
{
    object oPC = GetPCSpeaker();

    string sToModify = GetLocalString(OBJECT_SELF, "ToModify");
    //-- WINGS, TAIL, HEAD, EYES...
    int iToModify = GetLocalInt(OBJECT_SELF, "ToModify");
    //-- bodypart #...
    string s2DAFile = GetLocalString(OBJECT_SELF, "2DAFile");
    //-- "" for items with no 2da file...?
    string s2DAend; //-- the endoffile check

    int iNewApp;
    string sNewApp = "";

//--WING SECTION vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    if(sToModify == "WINGS")
    {
      //-- advance wing type.
      iNewApp = GetCreatureWingType()+1;

      //--if it is restricted, skip ahead.
      while(WingIsInvalid(iNewApp))
      {//-- increase
        iNewApp++;

        s2DAend = Get2DACheck(s2DAFile, iNewApp);
        //-- check for blank lines
        if (s2DAend == "SKIP")
        {//-- be careful reading 2da in a fast loop.
          iNewApp++;
          s2DAend = Get2DACheck(s2DAFile, iNewApp);
        }
        //-- check we didnt hit the end
        if (s2DAend == "FAIL" || iNewApp > GetCachedLimit(s2DAFile))
        {//-- if hit the end, loop back to 0
           iNewApp = 0;
        }
      }

      //--do the loop around check
      s2DAend = Get2DACheck(s2DAFile, iNewApp);
      while (s2DAend == "SKIP" || s2DAend == "FAIL")
      {
        if (s2DAend == "FAIL" || iNewApp > GetCachedLimit(s2DAFile))
        {
            iNewApp = 0;
        } else {
            iNewApp++;
        }

        s2DAend = Get2DACheck(s2DAFile, iNewApp);
      }  //-- end loop around check

      SetCreatureWingType(iNewApp); //--now slap the new wing on!
      sNewApp = Get2DAString(s2DAFile, "LABEL", iNewApp);
    }
//--END WINGS ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


//--TAIL SECTION vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    if(sToModify == "TAIL")
    {
      //-- advance tail type.
      iNewApp = GetCreatureTailType()+1;

      //--if it is restricted, skip ahead.
      while(TailIsInvalid(iNewApp))
      {//-- increase
        iNewApp++;

        s2DAend = Get2DACheck(s2DAFile, iNewApp);
        //-- check for blank lines
        if (s2DAend == "SKIP")
        {//-- be careful reading 2da in a fast loop.
          iNewApp++;
          s2DAend = Get2DACheck(s2DAFile, iNewApp);
        }
        //-- check we didnt hit the end
        if (s2DAend == "FAIL" || iNewApp > GetCachedLimit(s2DAFile))
        {//-- if hit the end, loop back to 0
           iNewApp = 0;
        }
      }

      //--do the loop around check
      s2DAend = Get2DACheck(s2DAFile, iNewApp);
      while (s2DAend == "SKIP" || s2DAend == "FAIL")
      {
        if (s2DAend == "FAIL" || iNewApp > GetCachedLimit(s2DAFile))
        {
            iNewApp = 0;
        } else {
            iNewApp++;
        }

        s2DAend = Get2DACheck(s2DAFile, iNewApp);
      }  //-- end loop around check

      SetCreatureTailType(iNewApp); //--now slap the new tail on!
      sNewApp = Get2DAString(s2DAFile, "LABEL", iNewApp);
    }
//--END TAIL ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

//--the rest of the parts dont have 2da files to read from.
//-- be sure you set your max numbers in the include file (btlr__inc)

  int nGender = GetGender(OBJECT_SELF);
  int nRace = GetAppearanceType(OBJECT_SELF);
  int nMax = 256;

//--HEAD BITS-------------------------------------------------------
  if(sToModify == "HEAD")
  {
    iNewApp = GetCreatureBodyPart(CREATURE_PART_HEAD)+1;
       //-- check we didnt hit the end(s)
    if(nGender==GENDER_FEMALE)
    {
       switch(nRace)
       {
         case 0: nMax = DFHEADMAX; break;
         case 1: nMax = EFHEADMAX; break;
         case 2: nMax = GFHEADMAX; break;
         case 3: nMax = AFHEADMAX; break;
         case 4:
         case 5: nMax = OFHEADMAX; break;
         case 6: nMax = HFHEADMAX; break;
       }
     }
     else //--males and everything else
     {
       switch(nRace)
       {
         case 0: nMax = DMHEADMAX; break;
         case 1: nMax = EMHEADMAX; break;
         case 2: nMax = GMHEADMAX; break;
         case 3: nMax = AMHEADMAX; break;
         case 4:
         case 5: nMax = OMHEADMAX; break;
         case 6: nMax = HMHEADMAX; break;
       }
    }

    if(iNewApp > nMax)
    {//-- loop to 0
      iNewApp = 0;
    }

     SetCreatureBodyPart(CREATURE_PART_HEAD, iNewApp);
  }  //-- end HEAD section


//--MISC BITS------------------------------------------------------

    if(sToModify == "PARTS")
    {
     iNewApp = GetCreatureBodyPart(iToModify) +1;
     //--check the ceiling
     if(iNewApp > CUSTOMPARTS)
     { //-- more than our 3 parts
       if(iNewApp >= 255)
       { //-- if it is 256, loop to 0
         iNewApp = 0;
       }
       else
       { //-- or else jump from max custom to 256
        iNewApp = 255;
       }
     }  //-- end loop check

     SetCreatureBodyPart(iToModify, iNewApp);
    }


//--PHENO PART------------------------------------------------------
    if(sToModify == "PHENO")
    {
     iNewApp = GetPhenoType(OBJECT_SELF) +1;
     //--check the ceiling
     if(iNewApp > MAXPHENO)
     { //-- more than our 3 parts
         iNewApp = 0;
     }  //-- end loop check

     SetPhenoType(iNewApp);
    }
//--END PHENO PART------------------------------------------------------


//--Colors PART---------------------------------------------------------
    if(sToModify == "SKIN" || sToModify == "HAIR" || sToModify == "TATTOO1" || sToModify == "TATTOO2")
    {
        int iChannel, iMax = 175; //Max color
        if (sToModify == "SKIN")     iChannel = COLOR_CHANNEL_SKIN;
        if (sToModify == "HAIR")     iChannel = COLOR_CHANNEL_HAIR;
        if (sToModify == "TATTOO1")  iChannel = COLOR_CHANNEL_TATTOO_1;
        if (sToModify == "TATTOO2")  iChannel = COLOR_CHANNEL_TATTOO_2;
        iNewApp = GetColor(OBJECT_SELF, iChannel) +1;
        //--check the ceiling
        if(iNewApp > iMax)
            iNewApp = 0;

        SetColor(OBJECT_SELF, iChannel, iNewApp); //Change color
    }
//--END COLOR PART-------------------------------------------------------


//--EVERYBODY/THING SECTION ---------------------------------------------
    SendServerMessageToPC(oPC, "Neues Aussehen: " + IntToString(iNewApp)+"  "+sNewApp);
}
