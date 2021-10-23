//
// Spawn Groups
//
//
// nChildrenSpawned
// : Number of Total Children ever Spawned
//
// nSpawnCount
// : Number of Children currently Alive
//
// nSpawnNumber
// : Number of Children to Maintain at Spawn
//
// nRandomWalk
// : Walking Randomly? TRUE/FALSE
//
// nPlaceable
// : Spawning Placeables? TRUE/FALSE
//
//
int ParseFlagValue(string sName, string sFlag, int nDigits, int nDefault);
int ParseSubFlagValue(string sName, string sFlag, int nDigits, string sSubFlag, int nSubDigits, int nDefault);
object GetChildByTag(object oSpawn, string sChildTag);
object GetChildByNumber(object oSpawn, int nChildNum);
object GetSpawnByID(int nSpawnID);
void DeactivateSpawn(object oSpawn);
void DeactivateSpawnsByTag(string sSpawnTag);
void DeactivateAllSpawns();
void DespawnChildren(object oSpawn);
void DespawnChildrenByTag(object oSpawn, string sSpawnTag);
//
//

string GetTemplateByCR(int nCR, string sGroupType)
{
  string sRetTemplate;

  if (sGroupType == "outdoor")
  {
    switch (nCR)
    {
    case 1:
      switch(d6(1))
      {
        case 1: sRetTemplate = "NW_SKELETON"; break;
        case 2: sRetTemplate = "NW_ZOMBIE01"; break;
        case 3: sRetTemplate = "NW_NIXIE"; break;
        case 4: sRetTemplate = "NW_ORCA"; break;
        case 5: sRetTemplate = "NW_ORCB"; break;
        case 6: sRetTemplate = "NW_BTLFIRE"; break;
      }
      break;
    case 2:
      switch(d4(1))
      {
        case 1: sRetTemplate = "NW_KOBOLD004"; break;
        case 2: sRetTemplate = "NW_KOBOLD005"; break;
        case 3: sRetTemplate = "NW_KOBOLD003"; break;
        case 4: sRetTemplate = "NW_PIXIE"; break;
    }
      break;
    case 3:
      switch(d4(1))
      {
        case 1: sRetTemplate = "NW_BTLBOMB"; break;
        case 2: sRetTemplate = "NW_BTLFIRE002"; break;
        case 3: sRetTemplate = "NW_BTLSTINK"; break;
        case 4: sRetTemplate = "NW_NYMPH"; break;
      }
      break;
    default:
       sRetTemplate = "";
       break;
    }
  }

  else if (sGroupType == "crypt")
  {
    switch (nCR)
    {
    case 1:
      switch(d4(1))
      {
        case 1:
        case 2: sRetTemplate = "NW_SKELETON"; break;
        case 3: sRetTemplate = "NW_ZOMBIE01"; break;
        case 4: sRetTemplate = "NW_ZOMBIE02"; break;
      }
      break;
    case 2:
      sRetTemplate = "NW_GHOUL";
      break;
    case 3:
      sRetTemplate = "NW_SHADOW";
      break;
    default:
       sRetTemplate = "";
       break;
    }  }

  else
  {
    // unknown group type
    sRetTemplate = "";
  }

  return sRetTemplate;
}


// Convert a given EL equivalent and its encounter level,
// return the corresponding CR
float ConvertELEquivToCR(float fEquiv, float fEncounterLevel)
{
  float fCR, fEquivSq, fTemp;

  if (fEquiv == 0.0)
  {
    return 0.0;
  }

  fEquivSq = fEquiv * fEquiv;
  fTemp = log(fEquivSq);
  fTemp /= log(2.0);
  fCR = fEncounterLevel + fTemp;

  return fCR;
}

// Convert a given CR to its encounter level equivalent per DMG page 101.
float ConvertCRToELEquiv(float fCR, float fEncounterLevel)
{
  if (fCR > fEncounterLevel || fCR < 1.0)
  {
    return 1.;
  }

  float fEquiv, fExponent, fDenom;

  fExponent = fEncounterLevel - fCR;
  fExponent *= 0.5;
  fDenom = pow(2.0, fExponent);
  fEquiv =  1.0 / fDenom;

  return fEquiv;
}

string SpawnGroup(object oSpawn, string sTemplate)
{
    // Initialize
    string sRetTemplate;

    // Initialize Values
    int nSpawnNumber = GetLocalInt(oSpawn, "f_SpawnNumber");
    int nRandomWalk = GetLocalInt(oSpawn, "f_RandomWalk");
    int nPlaceable = GetLocalInt(oSpawn, "f_Placeable");
    int nChildrenSpawned = GetLocalInt(oSpawn, "ChildrenSpawned");
    int nSpawnCount = GetLocalInt(oSpawn, "SpawnCount");

//
// Only Make Modifications Between These Lines
// -------------------------------------------

// wild animals near city
  if (sTemplate == "ooze_cleaners")
  {
    switch(d4())
    {
      case  1: sRetTemplate = "mob_largeochreye"; break;
      case  2: sRetTemplate = "mob_medgreenyell"; break;
      case  3: sRetTemplate = "mob_medochreye"; break;
      case  4: sRetTemplate = "mob_largegreenye"; break;
    }
  }
//

// wild animals near city
  if (sTemplate == "wild_near_city")
  {
    switch(d8())
    {
      case  1: sRetTemplate = "cre_dachs_n";      break;
      case  2: sRetTemplate = "cre_eber_n";       break;
      case  3: sRetTemplate = "cre_fledermaus_n"; break;
      case  4: sRetTemplate = "cre_rabe_n";       break;
      case  5: sRetTemplate = "cre_kitz_n";       break;
      case  6: sRetTemplate = "cre_reh_n";        break;
      case  7: sRetTemplate = "cre_hirsch_n";     break;
      case  8: sRetTemplate = "cre_falke_n";      break;
      case  9: sRetTemplate = "cre_waschbaer";    break;
      case 10: sRetTemplate = "cre_stinktier";    break;
    }
  }
//

// Connys Hoppelhaeschen!
  if (sTemplate == "connys_hoppels")
  {
    switch(d3())
    { case 1: sRetTemplate = "cre_hase_braun";  break;
      case 2: sRetTemplate = "cre_hase_grau";   break;
      case 3: sRetTemplate = "cre_hase_geflec"; break; }
  }

// wild animals in wood
  if (sTemplate == "wild_in_wood")
  {
    switch(d4())
    { case 1: sRetTemplate = "NW_WORG";         break;
      case 2: sRetTemplate = "NW_WOLF";         break;
      case 3: sRetTemplate = "NW_DIREWOLF";     break;
      case 4: sRetTemplate = "NW_WOLFDIREBOSS"; break; }
  }
//

// city animals
  if (sTemplate == "city_animal")
  {
    switch(d4())
    { case 1: sRetTemplate = "cre_schwarkatz_e"; break;
      case 2: sRetTemplate = "cre_hund_e";       break;
      case 3: sRetTemplate = "cre_maus_n";       break;
      case 4: sRetTemplate = "cre_tigerkatz_e";  break; }
  }
//

// animals at beach
  if (sTemplate == "beach_animal")
  {
    switch(d4())
    { case 1: sRetTemplate = "cre_otter_n";  break;
      case 2: sRetTemplate = "cre_moewe_f";  break;
      case 3: sRetTemplate = "cre_krabbe_n"; break;
      case 4: sRetTemplate = "cre_moewe_l";  break; }
  }
//

// neutral thiefsguild
  if (sTemplate == "thiefsguild_neutral")
  {
    switch(d4())
    { case 1: sRetTemplate = "nsc_dieb_k"; break;
      case 2: sRetTemplate = "nsc_dieb_s"; break;
      case 3: sRetTemplate = "nsc_dieb_n"; break;
      case 4: sRetTemplate = "nsc_dieb_m"; break; }
  }
//

// skeletons and zombies
  if (sTemplate == "lower_undead")
  {
    switch(d4())
    { case 1: sRetTemplate = "mob_skelett_n"; break;
      case 2: sRetTemplate = "mob_zombie_a";  break;
      case 3: sRetTemplate = "mob_skelett_m"; break;
      case 4: sRetTemplate = "mob_zombie_b";  break; }
  }
//

// Hain der Vier Jahreszeiten
  if (sTemplate == "satyr_hain")
  {
    switch(d4())
    { case 1: sRetTemplate = "mob_satyr_b"; break;
      case 2: sRetTemplate = "mob_satyr_h"; break;
      case 3: sRetTemplate = "mob_satyr_k"; break;
      case 4: sRetTemplate = "mob_satyr_n"; break; }
  }
//

// Kobolde
  if (sTemplate == "kobolds_outside")
  {
    switch(d6())
    { case 1: sRetTemplate = "NW_KOBOLD001"; break;
      case 2: sRetTemplate = "NW_KOBOLD002"; break;
      case 3: sRetTemplate = "NW_KOBOLD003"; break;
      case 4: sRetTemplate = "NW_KOBOLD004"; break;
      case 5: sRetTemplate = "NW_KOBOLD005"; break;
      case 6: sRetTemplate = "NW_KOBOLD006"; break; }
  }
//

// Gobbos draussen
  if (sTemplate == "gobbos_outside")
  {
    switch(d3())
    { case 1: sRetTemplate = "mob_goblin_a"; break;
      case 2: sRetTemplate = "mob_goblin_b"; break;
      case 3: sRetTemplate = "mob_goblin_c"; break; }
  }
//

// Gobbos drinnen
  if (sTemplate == "gobbos_inside")
  {
    switch(d6())
    { case 1: sRetTemplate = "mob_goblin_a"; break;
      case 2: sRetTemplate = "mob_goblin_b"; break;
      case 3: sRetTemplate = "mob_goblin_c"; break;
      case 4: sRetTemplate = "mob_goblin_d"; break;
      case 5: sRetTemplate = "mob_goblin_e"; break;
      case 6: sRetTemplate = "mob_goblin_f"; break; }
  }
//

// Höhlengobbos drinnen
  if (sTemplate == "cavegobbos")
  {
    switch(d6())
    { case 1: sRetTemplate = "mob_cavegoblin_a"; break;
      case 2: sRetTemplate = "mob_cavegoblin_b"; break;
      case 3: sRetTemplate = "mob_cavegoblin_c"; break;
      case 4: sRetTemplate = "mob_cavegoblin_d"; break;
      case 5: sRetTemplate = "mob_cavegoblin_e"; break;
      case 6: sRetTemplate = "mob_cavegoblin_f"; break; }
  }
//

// Alte Ruinen
  if (sTemplate == "old_ghostly_ruins")
  {
    switch(d4())
    { case 1: sRetTemplate = "NW_SHFIEND"; break;
      case 2: sRetTemplate = "NW_SHADOW";  break;
      case 3: sRetTemplate = "NW_WRAITH";  break;
      case 4: sRetTemplate = "NW_SPECTRE"; break; }
  }
//

// Unterreich
  if (sTemplate == "underdark")
  {
    switch(d8())
    { case 1: sRetTemplate = "nw_umberhulk";    break;
      case 2: sRetTemplate = "nw_horror";       break;
      case 3: sRetTemplate = "nw_spidwra";      break;
      case 4: sRetTemplate = "nw_spidswrd";     break;
      case 5: sRetTemplate = "nw_drowfight005"; break;
      case 6: sRetTemplate = "nw_drowmage005";  break;
      case 7: sRetTemplate = "nw_drowcler005";  break;
      case 8: sRetTemplate = "x2_beholder002";  break; }
  }
//

// Großer Riss
  if (sTemplate == "GreatRift")
  {
    switch(d6())
    { case 1: sRetTemplate = "nw_fire";      break;
      case 2: sRetTemplate = "nw_horror";    break;
      case 3: sRetTemplate = "nw_firegreat"; break;
      case 4: sRetTemplate = "nw_umberhulk"; break; }
  }
//

// Troglodyten Unterreich
  if (sTemplate == "Troglodyt")
  {
    switch(d3())
    { case 1: sRetTemplate = "nw_trog001"; break;
      case 2: sRetTemplate = "nw_trog002"; break;
      case 3: sRetTemplate = "nw_trog003"; break; }
  }
//

// Sahuagin
  if (sTemplate == "Sahuagin")
  {
    switch(d3())
    { case 1: sRetTemplate = "nw_sahuagin";    break;
      case 2: sRetTemplate = "nw_sahuaginclr"; break;
      case 3: sRetTemplate = "nw_sahuaginldr"; break; }
  }
//

// Bajou Sumpfgebiet
  if (sTemplate == "bajou_swamp")
  {
    switch(d4())
    { case 1: sRetTemplate = "mob_bombk_n"; break;
      case 2: sRetTemplate = "mob_stinkk_n"; break;
      case 3: sRetTemplate = "nw_spidwra"; break;
      case 4: sRetTemplate = "nw_spidwra"; break; }
  }
//

// Echsen im Sumpf
  if (sTemplate == "bajou_caves")
  {
    switch(d6())
    { case 1: sRetTemplate = "NW_OLDCHIEFA"; break;
      case 2: sRetTemplate = "NW_OLDWARB";   break;
      case 3: sRetTemplate = "NW_OLDMAGEB";  break;
      case 4: sRetTemplate = "NW_OLDWARRA";  break;
      case 5: sRetTemplate = "NW_OLDMAGEA";  break;
      case 6: sRetTemplate = "NW_OLDCHIEFB"; break; }
  }
//

// Orks in dungeons
  if (sTemplate == "orc_dungeons")
  {
    switch(d6())
    { case 1: sRetTemplate = "NW_ORCB";      break;
      case 2: sRetTemplate = "NW_OrcChiefA"; break;
      case 3: sRetTemplate = "NW_ORCA";      break;
      case 4: sRetTemplate = "NW_ORCWIZB";   break;
      case 5: sRetTemplate = "NW_ORCCHIEFB"; break;
      case 6: sRetTemplate = "NW_ORCWIZA";   break; }
  }
//

// Cordells Insel Felsturm
  if (sTemplate == "felsturm_normal")
  {
    switch(d4())
    { case 1: sRetTemplate = "mob_felstpi_boge"; break;
      case 2: sRetTemplate = "mob_felstpi_fuch"; break;
      case 3: sRetTemplate = "mob_felstpi_haud"; break;
      case 4: sRetTemplate = "mob_felstpi_schl"; break; }
  }
//

// Verlassene Binge
  if (sTemplate == "binge_dungeon")
  {
    switch(d4())
    { case 1: sRetTemplate = "nw_minwiz";      break;
      case 2: sRetTemplate = "nw_miotaur";     break;
      case 3: sRetTemplate = "nw_minchief";    break;
      case 4: sRetTemplate = "x2_beholder002"; break;
      case 5: sRetTemplate = "nw_duefight001"; break;
      case 6: sRetTemplate = "nw_duerogue001"; break; }
  }
//

// -------------------------------------------
// Only Make Modifications Between These Lines
//
    return sRetTemplate;
}
