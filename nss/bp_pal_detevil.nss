//::///////////////////////////////////////////////
//:: Detect Evil 1.1
//:: bp_pal_detevil
//:: Copyright (c) 2006 CarfaxAbbey.net
//:://////////////////////////////////////////////
/*
    Return a string describing the strength of the evil.
    Based on the PHB 3.5 rules.
*/
//:://////////////////////////////////////////////
//:: Created By: Diavlen <diavlen@carfaxabbey.net>
//:: Created On: August 11, 2006
//:://////////////////////////////////////////////
#include "x2_inc_switches"
#include "_debugisla"

/////////////////////////////
// D E C L A R A T I O N S //
/////////////////////////////

// Returns the power of the evil.  From table on page 219 in PHB 3.5
string AuraPower(int nHitDice, int nClassType, int nRaceType);

//  Author: Big E
//  Date:   July 20, 2002
//  Given the facing value (0-360), set the compass direction and diplay
//  the loction and distance of the evil.
void GetDirection(float fFacing,object oCaster,object oCreature, float nDistance);

//  Wrapper for GetNearestObject
object GetNearest(object oCaster, int iCount);

//  Return True if creature's alignment is hidden.
int Alignment_Hidden(object oCreature);

//Detect Evil By Round
void Detect_Evil_By_Round(object oCaster, int iRound);

// delays for each round
void Detect_Evil(object oCaster);

/////////////////////////////////
// I M P L E M E N T A T I O N //
/////////////////////////////////

string AuraPower(int nHitDice, int nClassType, int nRaceType)   {
    if((nClassType==CLASS_TYPE_OUTSIDER) || (nRaceType==RACIAL_TYPE_OUTSIDER)) {
        if((nHitDice <= 1) && (nHitDice >=  1))
            return "Leicht";
        if((nHitDice <= 4) && (nHitDice >=  2))
            return "Mittel";
        if((nHitDice <= 10) && (nHitDice >=  5))
            return "Stark";
        if((nHitDice >= 11))
            return "Überwältigend";
        return "Keine";
    } else if(nClassType==CLASS_TYPE_CLERIC) {
        if((nHitDice <= 1) && (nHitDice >= 1))
            return "Leicht";
        if((nHitDice <= 4) && (nHitDice >= 2))
            return "Mittel";
        if((nHitDice <= 10) && (nHitDice >= 5))
            return "Stark";
        if((nHitDice >= 11))
            return "Überwältigend";
        return "Keine";
    } else if((nClassType==CLASS_TYPE_UNDEAD) || (nRaceType==RACIAL_TYPE_UNDEAD)) {
        if((nHitDice <= 2) && (nHitDice >=  1))
            return "Leicht";
        if((nHitDice <= 8) && (nHitDice >=  3))
            return "Mittel";
        if((nHitDice <= 20) && (nHitDice >=  9))
            return "Stark";
        if((nHitDice >= 21))
            return "Überwältigend";
        return "Keine";
    } else {
        if((nHitDice <= 10) && (nHitDice >= 1))
            return "Leicht";
        if((nHitDice <= 25) && (nHitDice >=  11))
            return "Mittel";
        if((nHitDice <= 50) && (nHitDice >=  26))
            return "Stark";
        if((nHitDice >= 51))
            return "Überwältigend";
        return "Keine";
    }
}

/*
  Author: Big E
  Date:   July 20, 2002
  Given the facing value (0-360), set the compass direction and diplay
  the loction and distance of the evil.
*/
void GetDirection(float fFacing,object oCaster,object oCreature, float nDistance)   {
    //Correct the bug in GetFacing (Thanks Iskander)
    if (fFacing >=  360.0)
        fFacing  =  720.0 - fFacing;
    if (fFacing <     0.0)
        fFacing += (360.0);
    int iFacing = FloatToInt(fFacing);
    /*
      359 -  2  = E
        3 - 45  = NEE
       46 - 87  = NNE
       88 - 92  = N
       93 - 135 = NNW
      136 - 177 = NWW
      178 - 182 = W
      183 - 225 = SWW
      226 - 267 = SSW
      268 - 272 = S
      273 - 315 = SSE
      316 - 358 = SEE
    */
    string sDirection = "";
    if((iFacing >= 359) && (iFacing <=   2))
        sDirection = "Osten";
    if((iFacing >=   3) && (iFacing <=  45))
        sDirection = "Nord Ost Ost";
    if((iFacing >=  46) && (iFacing <=  87))
        sDirection = "Nord Nord Ost";
    if((iFacing >=  88) && (iFacing <=  92))
        sDirection = "Norden";
    if((iFacing >=  93) && (iFacing <= 135))
        sDirection = "Nord Nord West";
    if((iFacing >= 136) && (iFacing <= 177))
        sDirection = "Nord West West";
    if((iFacing >= 178) && (iFacing <= 182))
        sDirection = "West";
    if((iFacing >= 183) && (iFacing <= 225))
        sDirection = "Süd West West";
    if((iFacing >= 226) && (iFacing <= 267))
        sDirection = "Süd Süd West";
    if((iFacing >= 268) && (iFacing <= 272))
        sDirection = "Süden";
    if((iFacing >= 273) && (iFacing <= 315))
        sDirection = "Süd Süd Ost";
    if((iFacing >= 316) && (iFacing <= 358))
        sDirection = "Süd Ost Ost";
    string sDistance = IntToString(FloatToInt(nDistance));
    //Evil Power
    string sEvil = AuraPower(GetHitDice(oCreature),GetClassByPosition(1,oCreature),GetRacialType(oCreature));
    SendServerMessageToPC(oCaster, sEvil + " Böses entdeckt " + sDistance + " Meter in Richtung " + sDirection);
}

object GetNearest(object oCaster, int iCount)   {
    return GetNearestObjectToLocation(OBJECT_TYPE_CREATURE,GetLocation(oCaster),iCount);
}

//Author Big E
//Date:   July 20, 2002
//Insert you method of alignment hiding here.
//Return True if creature's alignment is hidden.
int Alignment_Hidden(object oCreature)  {
    if(GetTag(GetItemInSlot(INVENTORY_SLOT_CLOAK,oCreature)) == "bp_pal_cloak")
        return TRUE;
    return FALSE;
}

//Detect Evil By Round
void Detect_Evil_By_Round(object oCaster,int iRound)    {
    //float RANGE              =  18.3;  //Range in metres (DND 3.5)
    float RANGE              =  36.6;  //Range in metres
    int MIN_EVIL             =  49;    //The number at which the evil outweighs the good
    int iEvilCreatureCount   =  0;     //The number of evil auras in range
    int iMostEvil            =  1;     //The lowest GoodEvil value
    int iCount               =  1;     //A counter to cycle through creatures
    float nDistance          =  0.0;   //The distance away from the caster of the creature
    string sDistance         =  "";    //String version of nDistance
    string sEvil             =  "";    //Aura strength
    int bEvilDetected        =  FALSE; //Evil found?
    location lCreature;                //Location of the creature
    vector vCreature;                  //Vector location of the creature
    //Get the location of the caster
    location lCaster = GetLocation(oCaster);
    //Get the first closest creature to the caster
    object oCreature = GetNearest(oCaster,iCount);
    int nEvil;
    while((GetIsObjectValid(oCreature)) && (GetDistanceBetween(oCaster,oCreature) <= RANGE))    {
        nDistance = GetDistanceBetween(oCaster,oCreature);
        if((GetGoodEvilValue(oCreature) >= MIN_EVIL) || (Alignment_Hidden(oCreature)))  { //Not Evil or alignment hidden?
            //Go on to the next creature
            iCount++;
            oCreature = GetNearest(oCaster,iCount);
            continue;
        }
        bEvilDetected = TRUE; //Evil found
        lCreature = GetLocation(oCreature);
        //Round 1 - Evil presence detected
        if (iRound == 1)    {
            if(GetLocation(oCaster) != GetLocalLocation(oCaster,"lPlayer")) {
                SendServerMessageToPC(oCaster, "Konzentration unterbrochen.  Böses entdecken abgebrochen.");
                ClearAllActions();
                oCreature = OBJECT_INVALID;
                return;
            }
            SendServerMessageToPC(oCaster,"Es wurde Böses entdeckt.");
            return;
        };
        //Round 2 - Number of evil aura's
        if(iRound == 2) {
            if(GetLocation(oCaster) != GetLocalLocation(oCaster,"lPlayer")) {
                SendServerMessageToPC(oCaster, "Konzentration unterbrochen.  Böses entdecken abgebrochen.");
                ClearAllActions();
                oCreature = OBJECT_INVALID;
                return;
            };
            iEvilCreatureCount++;
            string sEvil = AuraPower(GetHitDice(oCreature),GetClassByPosition(1,oCreature),GetRacialType(oCreature));
            if(sEvil=="Leicht") nEvil=1;
            if(sEvil=="Mittel") nEvil=2;
            if(sEvil=="Stark") nEvil=3;
            if(sEvil=="Überwältigend") nEvil=4;

            if(nEvil>iMostEvil) {
                iMostEvil   =   nEvil;
                SetLocalObject(oCaster,"STRONGAURA",oCreature);
            }
        }
        //Round 3
        if(iRound == 3){
            if(GetLocation(oCaster) != GetLocalLocation(oCaster,"lPlayer")){
                SendServerMessageToPC(oCaster, "Konzentration unterbrochen.  Böses entdecken abgebrochen.");
                ClearAllActions();
                oCreature = OBJECT_INVALID;
                return;
            };
            //Get the creature's vector
            vCreature = GetPosition(oCreature);
            //Face the creature
            AssignCommand(oCaster,SetFacingPoint(vCreature));
            //Get the compass direction of the creature
            AssignCommand(oCaster,GetDirection(GetFacing(oCaster),oCaster,oCreature,nDistance));
        }
        iCount++;
        oCreature = GetNearest(oCaster,iCount);
    }
    if((iRound == 2) && (bEvilDetected)){
        SendServerMessageToPC(oCaster,"Es sind " + IntToString(iEvilCreatureCount) + " Böse Wesen anwensend.");
        string sAura;
        if(iMostEvil==1) sAura="Leicht";
        if(iMostEvil==2) sAura="Mittel";
        if(iMostEvil==3) sAura="Stark";
        if(iMostEvil==4) sAura="Überwältigend";
        if(iMostEvil == 4){
            //If the caster is good, they are stunned by the overwhelming evil
            int nCasterLevel    =   GetHitDice(oCaster)*2;
            int nMonsterLevel   =   GetHitDice(GetLocalObject(oCaster,"STRONGAURA"));
            if((GetAlignmentGoodEvil(oCaster)==ALIGNMENT_GOOD)&&(nMonsterLevel>=nCasterLevel)) {
                SendServerMessageToPC(oCaster,"Diese Ansammlung an Bösem ist so " + sAura + " das Du betäubt wirst!");
                AssignCommand(oCaster,ActionMoveAwayFromObject(GetLocalObject(oCaster,"STRONGAURA"),TRUE,nDistance + 10.0));
                DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(),oCaster,ROUND));
                oCreature = OBJECT_INVALID;
                AssignCommand(oCaster,ActionWait(ROUND));
            }
        } else
            SendServerMessageToPC(oCaster,"Diese Ansammlung an Bösem ist " + sAura);
        return;
    }
}

void Detect_Evil(object oCaster)    {
    SetLocalLocation(oCaster,"lPlayer",GetLocation(oCaster));
    DelayCommand(ROUND,AssignCommand(oCaster,Detect_Evil_By_Round(oCaster,1)));
    DelayCommand(ROUND+ROUND,AssignCommand(oCaster,Detect_Evil_By_Round(oCaster,2)));
    DelayCommand(ROUND+ROUND+ROUND,AssignCommand(oCaster,Detect_Evil_By_Round(oCaster,3)));
}

//Example using a ring of detect evil for event OnActivateItem
float ROUND = 6.0; //Need this defined.  I use a six second round


#include "x2_inc_spellhook"

void main()
{

    /*
      Spellcast Hook Code
      Added 2003-06-23 by GeorgZ
      If you want to make changes to all spells,
      check x2_inc_spellhook.nss to find out more
    */


        if (!X2PreSpellCastCode())
        {
        // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
            return;
        }

    // End of Spell Cast Hook

    //Declare major variables
    object     oCaster = OBJECT_SELF;
    object     oTarget = GetSpellTargetObject();
    location locTarget = GetSpellTargetLocation();
//  float    fDuration = 18.0;
    int     nMetaMagic = GetMetaMagicFeat();;

/* Duration extended through metamagic?
  if (nMetaMagic == METAMAGIC_EXTEND)
  {
      fDuration = fDuration *2; //Duration is +100%
  }
*/

// The spell

    Detect_Evil(oCaster);

}
