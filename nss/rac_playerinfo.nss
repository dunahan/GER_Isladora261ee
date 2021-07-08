//::///////////////////////////////////////////////
//:: Isladoras Sonderrassen
//:: rac_playerinfo
//:: Copyright (c) 2010 Dunahan.
//:://////////////////////////////////////////////
/*
    Sonderrassen
    Info ueber Rasse darstellen


*/
//:://////////////////////////////////////////////
//:: Created By: Dunahan@schwerterkueste.de
//:: Created On: 06.11.2010
//:://////////////////////////////////////////////
#include "_isla_inc"
#include "_isla_races"

int StartingConditional()
{
  if (GetIsPC(oRacePC) == TRUE)
  {
    if (nRace != 28)
    {
      switch (nRace)
      { case 0: { sRace = "Zwerg"; } break;   case 1: { sRace = "Elf"; } break;
        case 2: { sRace = "Gnom"; } break;    case 3: { sRace = "Halbling"; } break;
        case 4: { sRace = "Halbelf"; } break; case 5: { sRace = "Halbork"; } break;
        case 6: { sRace = "Mensch"; } break; }
    }

    SetCustomToken(80001, sRace);

    if (sSubRace == "") { SetCustomToken(80002, "Unbekannt"); }
    else                { SetCustomToken(80002, sSubRace); }

    SetCustomToken(80003, sAge);
    SetCustomToken(80004, sDeity);
    return TRUE;
  }

  SetCustomToken(80001, "Unbekannt");
  SetCustomToken(80002, "Unbekannt");
  SetCustomToken(80003, "Unbekannt");
  SetCustomToken(80004, "Unbekannt");

  return TRUE;
}
