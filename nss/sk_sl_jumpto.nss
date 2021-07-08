//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_jumpto
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript um den ausgewählten Char zu sich zu
    beamen

*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

void main ()
{
/* altes Skript
  // Okay, der Nutzer hat die Rechte!
  // Hole die notwendigen Daten aus dem Council
  string sToBeam = GetLocalString(oSpeaker, "ToBeam");            // Gespeicherte ID des Ziels

  // Suche starten
  int nNumPCs = 0;
  object oCheck = GetFirstPC();                                   // Ersten SC erfassen
  string sPC = GetName(oCheck) + "_" + GetPCPlayerName(oCheck);   // Dessen ID auslesen

  while ( GetIsObjectValid(oCheck) == TRUE )                      // Ist der SC vorhanden
  {
    if (sPC == sToBeam)                                           // Vergleiche die ID
    {
      // Sende dem zu Beamenden eine Nachricht
      SendMessageToPC(oCheck, "Du wirst in 30 Sekunden zu " + GetName(oSpeaker) + " gebeamt.");
      // Beame den Charakter zum Nutzer des Tools
      DelayCommand(30.0, ActionJumpToLocation(locOfSpeaker));
    }
    nNumPCs ++;                                                   // Gescannte SC's +1
    oCheck = GetNextPC();                                         // Nächsten SC erfassen
  } */

  object oBeamTo = GetPCSpeaker();
  object oBeamTarget = GetSpellTargetObject();
  if (GetIsObjectValid(oBeamTarget))
  {
    if (oBeamTarget == oBeamTo)
    {
      SendMessageToPC(oBeamTo,"Du kannst Dich nicht selbst teleportieren!");
      return;
    }
    else if (GetIsInCombat(oBeamTo))
    {
      FloatingTextStringOnCreature("Du kannst niemand teleporieren solange Du im Kampf bist!",oBeamTo,FALSE);
      return;
    }
    else if (GetIsInCombat(oBeamTo))
    {
      FloatingTextStringOnCreature("Du kannst niemand teleporieren solange dieser im Kampf ist!",oBeamTo,FALSE);
      return;
    }
    else
    {
      SendMessageToPC(oBeamTarget,"Du wirst nun zu "+GetName(oBeamTo)+"!");
      AssignCommand(oBeamTarget,ClearAllActions());
      AssignCommand(oBeamTarget,JumpToObject(oBeamTo));
    }
  }
  else SendMessageToPC(oBeamTo,"Ziel nicht gefunden.");

}
