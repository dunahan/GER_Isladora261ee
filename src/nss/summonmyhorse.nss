///////////////////////////////////////////////////////////////////////////////
// Summon your horse
///////////////////////////////////////////////////////////////////////////////
#include "x3_inc_horse"
#include "_isla_inc"

void main()
{
  object           oPC = GetItemActivator();
  object   oHorseToken = GetItemActivated();
  string  sHorseResRef = GetLocalString(oHorseToken, "HorseResRef");
  string      sHorseID = "Horse_" + GetStringRight(GetName(oPC),15) + "_" + GetStringRight(GetPCPlayerName(oPC),10); // 6 + 15 + 1 + 10 = 32 = Maximale Tag Länge
  location       locPC = GetLocation(oPC);
  string sCurrentHorse = GetSkinString(oPC, "sX3_HorseMountTag");
  object        oHorse = GetObjectByTag(sHorseID);
  int          bActive = GetIsObjectValid(oHorse); // Prüfen ob das Pferd gerade gespawnt ist
  int         bMounted = HorseGetIsMounted(oPC) && sCurrentHorse == sHorseID; // Prüfen ob der Spieler gerade auf dem Pferd reitet

  if (!bActive && !bMounted) // Pferd ist gerade nicht gespawnt und wird nicht geritten
  {
    if (!GetItemCursedFlag(oHorseToken)) // nicht Verflucht
    {
      string sItemName = GetName(oHorseToken);
      string sOrigName = GetName(oHorseToken, TRUE);
      string sHorseName = "";
      if (sItemName != sOrigName)
      {
        sHorseName = sItemName;
      }
      // Spawnt das Pferd und fügt es dem Spieler hinzu
      object oHorse = HorseCreateHorse(sHorseResRef, locPC, oPC, sHorseID,-1,-1,-1,"",sHorseName);

      if (!GetIsObjectValid(oHorse))
      { // Pferd konnte nicht gespawnt werden
        AssignCommand(oPC, ActionSpeakString("Falsches Pferd!"));
      }
    }
    else  // Verflucht
    {
      int nRandom = Random(4);
      string sResRef = GetLocalString(oHorseToken, "sResRef");
      string sObType = GetLocalString(oHorseToken, "sObType");

      switch (nRandom)
      { // Summon eines Gegners
        case 0:
        {
          CreateObjectVoid( StringToInt(GetTokenFromString(1, sObType)), GetTokenFromString(1, sResRef), locPC, TRUE );
          break;
        }
        // Summon eines Gegners
        case 2:
        {
          CreateObjectVoid( StringToInt(GetTokenFromString(2, sObType)), GetTokenFromString(2, sResRef), locPC, TRUE );
          break;
        }
        // Summon eines Gegners
        case 3:
        {
          CreateObjectVoid( StringToInt(GetTokenFromString(3, sObType)), GetTokenFromString(3, sResRef), locPC, TRUE );
          break;
        }

        default: // ansonsten Summon des Pferdes
        {
          string sItemName = GetName(oHorseToken);
          string sOrigName = GetName(oHorseToken, TRUE);
          string sHorseName = "";
          if (sItemName != sOrigName)
          {
            sHorseName = sItemName;
          }
          // Spawnt das Pferd und fügt es dem Spieler hinzu
          object oHorse = HorseCreateHorse(sHorseResRef, locPC, oPC, sHorseID,-1,-1,-1,"",sHorseName);

          if (!GetIsObjectValid(oHorse))
          { // Pferd konnte nicht gespawnt werden
            AssignCommand(oPC, ActionSpeakString("Falsches Pferd!"));
          }
          break;
        }
      }
    }
  }
  else if (bActive)
  {
    AssignCommand(oHorse, JumpToObject(oPC));
  }
}
