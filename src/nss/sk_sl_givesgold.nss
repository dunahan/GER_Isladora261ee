//::///////////////////////////////////////////////
//:: SL Tools
//:: sk_sl_givesgold
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

void main()
{
  if ( (oSpeakTarg != OBJECT_INVALID) && (oSpeakTarg != oSpeaker) &&
       (GetIsPC(oSpeakTarg) == TRUE)  && (HasItem(oSpeakTarg, SL_EPS) == FALSE) &&
       (nGivenGold <= 1000) )
  { int     nAmount = d12 (5);
    string sMessage = GetName(oSpeaker) + " hat an " + GetName(oSpeakTarg) + " " + IntToString(nAmount) +
                      " Gold vergeben.";
    SendServerMessageToPC(oSpeaker, sMessage);

    if (nGivenGold == 0) SetLocalInt(OBJECT_SELF, GetName(oSpeakTarg), nAmount);
    else                 SetLocalInt(OBJECT_SELF, GetName(oSpeakTarg), nAmount+nGivenGold);

    WriteTimestampedLogEntry(sMessage);
    DelayCommand(10.0, GiveGoldToCreature(oSpeakTarg, nAmount));
  }
  else
  { SendServerMessageToPC(oSpeaker, "Du kannst an dieses Wesen kein Gold vergeben!");
    if (nGivenGold >= 1000 ) {DeleteLocalInt(OBJECT_SELF, GetName(oSpeakTarg));}
  }
}
