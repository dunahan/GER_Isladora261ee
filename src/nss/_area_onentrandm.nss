#include "_isla_inc"

void main ()
{
  // 1++ Wichtige Deklerationen
  string sSpawnTag; string sSpawnObj; int nSpawnTyp;
  string sChance; int nChance; int nRandom; int nDice;

  // 1.1 Scanne das Objekt das Eintritt
  //     und erfasse die Map in der er sich befindet
  object oPC = GetEnteringObject();
  object oMap = GetArea(oPC);

  // 1.2 Ist dieses Existent? Wenn Nein, brich ab!
  if (!GetIsObjectValid(oPC)) return;

  // 1.3 Ist das OnEnter Skript bereits einmal ausgelöst worden?
  //     Ein Despawn der Placeables findet nicht statt, der Dungeon
  //     wird nur einmal pro Reset aufgebaut! Brich ab, wenn Ja!
  if (GetLocalInt(oMap, "Stop")==TRUE) return;

  // 2++ Beginne nun das Spawnen der Objekte je nach Chance und gewuerfelten Augen

  // 2.1 Scanne das erste Objekt der Map. Die Spawneinstellungen und ResRefs sind
  //     auf entsprechenden Wegpunkten abgelegt. Wenn dieser existiert, dann
  object oSpawnpoint = GetFirstObjectInArea(oMap);
  while ( GetIsObjectValid(oSpawnpoint) == TRUE )
  {
    //SpeakString("Scanne Objekt", TALKVOLUME_SHOUT);
    // 2.2 Scanne ob es sich um einen Wegpunkt handelt
    if ( GetObjectType (oSpawnpoint) == OBJECT_TYPE_WAYPOINT )
    {
      // 2.2.1 Lese Tag (Einstellungen) und Namen (ResRef) aus
      sSpawnTag = GetTag(oSpawnpoint); sSpawnObj = GetName(oSpawnpoint);

      // 2.2.2 Lese nun die Chance aus und wandle diese in eine Zahl um
      sChance = GetTokenFromString(3, sSpawnObj, "_"); nChance = StringToInt(sChance);

      // 2.2.3 Sicherheitsabfrage, sollte die Zahl nicht vorgegeben sein
      if (nChance <= 0) { nChance = 20; }

      // 2.2.4 Bilde nun aus dieser Chance und einem Wurf auf 1W20 die Moeglichkeit, das ein Spawn erfolgt
      nRandom = Random(nChance)+1; nDice = d20();

      if ( nDice <= nRandom )
      {
        DebugMode("Spawn fuer "+sSpawnTag+" erfolgte in "+GetName(OBJECT_SELF));
        // 2.2.5 Der Spawn erfolgt da der Wurf sich innerhalb der Chance befand
        sSpawnObj = GetTokenFromString(2, sSpawnObj, "_"); nSpawnTyp = StringToInt(sSpawnObj);
        AssignCommand(oMap, CreateObjectVoid(nSpawnTyp, sSpawnTag, GetLocation(oSpawnpoint), FALSE));
      }
      //2 .2.6 Der Spawnpoint wurde genutzt und somit kann dieser entfernt werden
      if (GetStringLeft(GetName(oSpawnpoint), 3) == "DUN")
      { DebugMode("Spawnpoint: "+GetName(oSpawnpoint)+" "+GetTag(oSpawnpoint)+" wird geloescht");
        DestroyObject(oSpawnpoint); }
    }
    // 2.3 Scanne das naechste Objekt der Map
    oSpawnpoint = GetNextObjectInArea(oMap);
  }

  // 3++ Skript zu Ende, also setze Flagge!
  SetLocalInt(oMap, "Stop", TRUE);
}

