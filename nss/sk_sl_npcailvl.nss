//::///////////////////////////////////////////////
//:: SL-Tools
//:: sk_sl_npcailvl
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    ST-Tools für Isladora
    Skript um die Ai des Npc zu beeinflussen


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 07.12.2010
//:://////////////////////////////////////////////
#include "_sltools_inc"

void main()
{
  // Lese die bestimmende Int aus
  int nLvl = GetLocalInt(oSpeaker, "Int1");

  // Deklariere die AI als Integer und eine Message, die gesendet wird
  string sMsg;
  switch (nLvl) {
    case 0: sMsg = "Sehr niedrige KI gesetzt."; break;
    case 1: sMsg = "Niedrige KI gesetzt."; break;
    case 2: sMsg = "Normale KI gesetzt."; break;
    case 3: sMsg = "Hohe KI gesetzt."; break;
    case 4: sMsg = "Sehr hohe KI gesetzt."; break;
    default: sMsg = "Standard-KI gesetzt."; break; }

  // Setzen des AI-Levels und senden einer Nachricht über Erfolg oder Mißerfolg
  SetAILevel(oSpeakTarg, nLvl);
  SendServerMessageToPC(oSpeaker, sMsg);
}

