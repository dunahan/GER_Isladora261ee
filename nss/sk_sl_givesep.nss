//::///////////////////////////////////////////////
//:: SL Tools
//:: sk_sl_givesep
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*
    SL-Tool: Gold vergeben
*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 05.12.2009
//:://////////////////////////////////////////////
#include "_sltools_inc"
#include "ll_include"

void main()
{
  if ( (oSpeakTarg != OBJECT_INVALID) && (oSpeakTarg != oSpeaker) &&
       (GetIsPC(oSpeakTarg) == TRUE)  && (HasItem(oSpeakTarg, SL_GOLD) == FALSE) )
  {
      if ( (nGivenEPS <= 1000) )
      {
        int     nAmount = d100 (5);
        string sMessage = GetName(oSpeaker) + " hat an " + GetName(oSpeakTarg) + " " + IntToString(nAmount) +
                      " EP vergeben.";
        SendServerMessageToPC(oSpeaker, sMessage);

        if (nGivenEPS == 0) SetLocalInt(OBJECT_SELF, GetName(oSpeakTarg), nAmount);
        else                SetLocalInt(OBJECT_SELF, GetName(oSpeakTarg), nAmount+nGivenEPS);

        WriteTimestampedLogEntry(sMessage);
        //DelayCommand(10.0, GiveXPToCreature(oSpeakTarg, nAmount));
        DelayCommand(10.0, SetXPImproved(oSpeakTarg, GetXP(oSpeakTarg)+nAmount));
      }
  }
  else
  { SendServerMessageToPC(oSpeaker, "Du kannst an dieses Wesen keine EP vergeben!");
    if (nGivenEPS >= 1000 )  {DeleteLocalInt(OBJECT_SELF, GetName(oSpeakTarg));}
  }
}
