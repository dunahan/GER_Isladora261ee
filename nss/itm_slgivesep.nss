//::///////////////////////////////////////////////
//:: SL Tools
//:: itm_slgivesep
//:: Copyright (c) 2009 Dunahan.
//:://////////////////////////////////////////////
/*
    SL-Tool: Gold vergeben
*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 05.12.2009
//:://////////////////////////////////////////////
#include "l_tink_funcs"         // Access to the reusable scripts
#include "_isla_inc"
#include "ll_include"

void main()
{
  object oUser = GetItemActivator();                            // Get the User of the Item
  object oTarget = GetItemActivatedTarget();                    // Get the Target of the Item


  int nEP; string sEP;                                          // Declare XP Variables

  // Collect Data for Save actual XP's!
  object oSavepoint  = GetObjectByTag("rpep_handler");          // Get the Waypoint which holds all the XP for a Day
  string sSavestring = GetLocalString(oSavepoint, "Counci_EP"); // Savestring for Knats Tokenizer...

  string sTarget = GetStringLeft(GetName(oTarget), 5) +         // Get 5 Digits of Name and PCUserName
                   GetStringLeft(GetPCPlayerName(oTarget), 5);

  //if (FALSE == is_a_Counci(oUser) || FALSE == is_a_DM(oUser) )  // Is the User not a Counci OR a DM?
  //{ DestroyObject(OBJECT_SELF); return; }                       // Destroy it! End Script...

  //else                                                          // The User is a Counci or a DM!
  {
    if ( TRUE == GetIsObjectValid(oTarget))//&& oUser != oTarget )// Is oTarget valid, AND the User is not the Target?
    {
      nEP = 500 + d100(); sEP = IntToString(nEP);               // Calculate XP

           if (GetLocalInt(oSavepoint, sTarget)>=1000)          // Limit reached
      {
        // Send Message to User, that something is wrong
        SendServerMessageToPC(oUser, "Das Tageslimit wurde bereits erreicht.");
      }

      else if (GetLocalInt(oSavepoint, sTarget)<=1000)          // Some XP saved, but Limit not reached.
      {
        //Send Message to User and Write down in Log
        SendServerMessageToPC(oUser, "Du hast " + sEP + " EP an " + GetName(oTarget) + " vergeben.");
        WriteTimestampedLogEntry(GetName(oUser) + " hast " + sEP + " EP an " + GetName(oTarget) + " vergeben.");

        //GiveXPToCreature(oTarget, nEP);                       // Give XP to Target
        SetXPImproved(oTarget, GetXP(oTarget)+nEP);             // Give XP to Target

        nEP = GetLocalInt(oSavepoint, sTarget) + nEP;           // Add it then
        SetLocalInt(oSavepoint, sTarget, nEP);                  // Save it
      }

      else
      {                                                         // No XP given!
        //Send Message to User and Write down in Log
        SendServerMessageToPC(oUser, "Du hast " + sEP + " EP an " + GetName(oTarget) + " vergeben.");
        WriteTimestampedLogEntry(GetName(oUser) + " hast " + sEP + " EP an " + GetName(oTarget) + " vergeben.");

        //GiveXPToCreature(oTarget, nEP);                       // Give XP to Target
        SetXPImproved(oTarget, GetXP(oTarget)+nEP);             // Give XP to Target

        SetLocalInt(oSavepoint, sTarget, nEP);                  // Save it
      }
    } // End if
    else                                                        // Target isnt Valid or is the User itself!
    {
      // Send Message to User, that something is wrong
      SendServerMessageToPC(oUser, "Du kannst an dieses Ziel keine EP vergeben.");
    } // End else
  } // End else
} // End void

