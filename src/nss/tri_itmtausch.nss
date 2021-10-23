#include "_isla_inc"

void main()
{
  // 1++ Grundlagen erfassen
  // 1.1 Erfasse den Verlassenden (Bleibt immer gleich!)
  object oExit = GetExitingObject();

  // 2++ Hier fuehre das Skript an, was die Items austauschen soll:
  /* 2.1 Dazu erfasse das gesuchte Item, hier die Wuerfel...
  object oFirst = GetItemPossessedBy(oExit, "summonblack");
  object oSecon = GetItemPossessedBy(oExit, "summongrey");
  object oThird = GetItemPossessedBy(oExit, "summonspotted");

  if ( GetIsObjectValid(oFirst) )
  {
    SetPlotFlag(oFirst, FALSE); SetStolenFlag(oFirst, FALSE);
    WriteTimestampedLogEntry(GetName(oExit)+" wurde "+GetName(oFirst)+" genommen");
    DestroyObject(oFirst);  //CreateObjectVoid(oExit, 1200);
  }

  if ( GetIsObjectValid(oSecon) )
  {
    SetPlotFlag(oSecon, FALSE); SetStolenFlag(oSecon, FALSE);
    WriteTimestampedLogEntry(GetName(oExit)+" wurde "+GetName(oSecon)+" genommen");
    DestroyObject(oSecon);  GiveGoldToCreature(oExit, 1200);
    SendServerMessageToPC(oExit, "Dir wurde ein altes Item genommen und der Goldwert gegeben. Besorge Dir ein neues davon.");
  }

  if ( GetIsObjectValid(oThird) )
  {
    SetPlotFlag(oThird, FALSE); SetStolenFlag(oThird, FALSE);
    WriteTimestampedLogEntry(GetName(oExit)+" wurde "+GetName(oThird)+" genommen");
    DestroyObject(oThird);  GiveGoldToCreature(oExit, 1200);
    SendServerMessageToPC(oExit, "Dir wurde ein altes Item genommen und der Goldwert gegeben. Besorge Dir ein neues davon.");
  }*/
}
