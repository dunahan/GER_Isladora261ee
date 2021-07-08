//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_listensave
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    SL-Tools für Isladora



*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

void main()
{
  int nMatch = GetListenPatternNumber();

  string sPrefix  = GetMatchedSubstring(0);  // Sollte nur *SL * sein
  string sVariable= GetMatchedSubstring(1);  // Sollte nur *Int1*/*Int2*/*Int3*/*Int4*/*String1*/*Float1*
  string sCommand = GetMatchedSubstring(3);  // Sollte der Befehl SL String1 Topf sagen, so ist sCommand "Topf"

  string nChoice = GetStringLeft(sVariable, 3);

  object oSL = GetFirstPC();
  string sOwner = GetLocalString(OBJECT_SELF, "Owner");
  string sSL = GetName(oSL) + "_" + GetPCPlayerName(oSL);

  while ( (GetIsDM(oSL) == TRUE) && ( sSL == sOwner) )
  { if (sPrefix == "SL ")
    { // Speichere den Wert ab
           if (nChoice == "Int") { SetLocalInt   ( oSL, sVariable, StringToInt(sCommand)   );
           SendServerMessageToPC(oSL, "*"+sPrefix+"*_*"+sVariable+"*_*"+sCommand+"*"); }

      else if (nChoice == "Str") { SetLocalString( oSL, sVariable, sCommand                );
           SendServerMessageToPC(oSL, "*"+sPrefix+"*_*"+sVariable+"*_*"+sCommand+"*"); }

      else if (nChoice == "Flo") { SetLocalFloat ( oSL, sVariable, StringToFloat(sCommand) );
           SendServerMessageToPC(oSL, "*"+sPrefix+"*_*"+sVariable+"*_*"+sCommand+"*"); } }

    else
    { SendServerMessageToPC(oSL, "Unbekannter Befehl. Beende Skript."); }

    // Zerstöre den Zuhörer, da nicht mehr gebraucht
    DestroyObject(OBJECT_SELF, 1.0);
    oSL = GetNextPC();
  }
}
