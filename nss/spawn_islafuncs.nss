//
// NESS V8.1.3.1
// Spawn Functions for Isladora
//
//   Only Modify this File, if nessesary!
//
//

#include "spawn_timefuncs"
#include "spawn_flags"
#include "spawn_cfg_cusflg"
#include "spawn_main"
#include "x0_i0_corpses"
#include "nw_i0_2q4luskan"
#include "_debugisla"

// Declare constants
const string SPAWN_CENTER_TAG = "SpawnCenter";
const float SPAWN_CENTER_RADIUS = 20.0;
const int DEBUG = FALSE;

void Spawn_ProcessSpawn(object oSpawn, object oSpawnCenter, int nProcessFrequency, int nPCCount, int nTimeNow, int nWaypoint);
void Spawn_DoSpawn(object oSpawn, object oSpawnCenter, int nTimeNow);
void Spawn_InitFlags(object oSpawn, string sSpawnName, string sSpawnTag);
void Spawn_FromTriggerWithAOE();
void Spawn_ResetSpawnsWithinAOE();

void Spawn_ShowAOE() {
    if (!DEBUG)
      return;

    object oSpawnCenter = GetNearestObjectByTag(GetName(OBJECT_SELF), OBJECT_SELF);
    //float fSizeOfRadius = 10.0;
    location locSpawnCenter = GetLocation(oSpawnCenter);
    DelayCommand(5.0, CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "nw_plc_candle1", locSpawnCenter, TRUE));

    object oSpawnWaypoint = GetFirstObjectInShape(SHAPE_SPHERE, SPAWN_CENTER_RADIUS, locSpawnCenter, FALSE, OBJECT_TYPE_WAYPOINT);
    while (GetIsObjectValid(oSpawnWaypoint) && GetLocalInt(oSpawnWaypoint, "scan") == 0) {
        if (GetStringLeft(GetName(oSpawnWaypoint), 2) == "SP") {
            DebugMode(GetName(oSpawnWaypoint) + "\n" + GetTag(oSpawnWaypoint)+"\n-.-.-.-.-.-.-.-.-.-.-.-.\n");
            DelayCommand(10.0, CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "nw_plc_candle1", GetLocation(oSpawnWaypoint), TRUE));
        }
        SetLocalInt(oSpawnWaypoint, "scan", 1);

        oSpawnWaypoint = GetNextObjectInShape(SHAPE_SPHERE, SPAWN_CENTER_RADIUS, locSpawnCenter, FALSE, OBJECT_TYPE_WAYPOINT);
    }
}

int Spawn_SetSpawnsWithinAOE(float fSizeOfRadius = SPAWN_CENTER_RADIUS) {
    string sSpawnName, sSpawnNum, sSpawnTag;
    object oSpawnCenter = GetNearestObjectByTag(GetTag(OBJECT_SELF), OBJECT_SELF);  DebugMode("Spawn_SetSpawnsWithinAOE; oSpawnCenter: "+GetName(oSpawnCenter));
    location locSpawnCenter = GetLocation(oSpawnCenter);                            DebugMode("Spawn_SetSpawnsWithinAOE; locSpawnCenter: "+LocationToString(locSpawnCenter));
    int nNth = 1;
    int nSpawnNum = 0;

    // Enumerate Waypoints in the AOE
    object oSpawn = GetFirstObjectInShape(SHAPE_SPHERE, fSizeOfRadius, locSpawnCenter, FALSE, OBJECT_TYPE_WAYPOINT);
    while (oSpawn != OBJECT_INVALID)
    {
        // Check for a local string called "NESS" on the waypoint
        // first.  If it exists, use it instead of the name
        sSpawnName = GetLocalString(oSpawn, "NESS");                            DebugMode("Spawn_SetSpawnsWithinAOE; LocalString: "+sSpawnName);

        if (GetStringLeft(sSpawnName, 2) != "SP")
        {
            // Retrieve Name
            sSpawnName = GetName(oSpawn);                                       DebugMode("Spawn_SetSpawnsWithinAOE; Name: "+sSpawnName);
        }

        // Check if Waypoint is a Spawn Controller
        if (GetStringLeft(sSpawnName, 2) == "SP")
        {
            // Set Spawn
            nSpawnNum++;                                                        DebugMode("Spawn_SetSpawnsWithinAOE; nSpawnNum: "+IntToString(nSpawnNum));
            sSpawnNum = "Spawn" + PadIntToString(nSpawnNum, 2);                 DebugMode("Spawn_SetSpawnsWithinAOE; sSpawnNum: "+sSpawnNum);

            sSpawnTag = GetLocalString(oSpawn, "NESS_TAG");                     DebugMode("Spawn_SetSpawnsWithinAOE; LocalString: "+sSpawnTag);
            if (sSpawnTag == "")
            {
              sSpawnTag = GetTag(oSpawn);                                       DebugMode("Spawn_SetSpawnsWithinAOE; sSpawnTag: "+sSpawnTag);
            }

            DelayCommand(0.0, InitFlags(oSpawn, sSpawnName, sSpawnTag));        DebugMode("Spawn_SetSpawnsWithinAOE; Initializing Flags");

            SetLocalObject(oSpawnCenter, sSpawnNum, oSpawn);                    DebugMode("Spawn_SetSpawnsWithinAOE; SavingLocalObject");
        }
        nNth++;                                                                 DebugMode("Spawn_SetSpawnsWithinAOE; nNth: "+IntToString(nNth));
        oSpawn = GetNextObjectInShape(SHAPE_SPHERE, fSizeOfRadius, locSpawnCenter, FALSE, OBJECT_TYPE_WAYPOINT);
    }

    SetLocalInt(oSpawnCenter, "Spawns", nSpawnNum);                             DebugMode("Spawn_SetSpawnsWithinAOE; nSpawnNum: "+IntToString(nSpawnNum)+"\n-.-.-.-.-.-.-.-.-.-.-.-.\n");
    return nSpawnNum;
}

void Spawn_ResetSpawnsWithinAOE()
{
    string sSpawnNum; object oSpawn, oSpawnCenter = GetNearestObjectByTag(GetTag(OBJECT_SELF), OBJECT_SELF);
    int nSpawns = GetLocalInt(oSpawnCenter, "Spawns"), nNth;

    for (nNth = 1; nNth <= nSpawns; nNth++)
    {
        // Retrieve Spawn
        sSpawnNum = "Spawn" + PadIntToString(nNth, 2);
        oSpawn = GetLocalObject(oSpawnCenter, sSpawnNum);

        SetLocalInt(oSpawn, "SpawnDeactivated", FALSE);
    }
}

void Spawn_FromTriggerWithAOE()
{
    // Declare Variables
    object oSpawn, oSpawnCenter = GetNearestObjectByTag(GetTag(OBJECT_SELF), OBJECT_SELF);    DebugMode("Spawn_FromTriggerWithAOE; oSpawnCenter: "+GetName(oSpawnCenter));
    object oSpawnArea = GetArea(oSpawnCenter);
    string sSpawnName, sSpawnNum;
    int nSpawnDeactivated;
    int nProcessSpawn;
    int nCurrentProcessTick;
    int nProcessFrequency;
    int nProcessOffset;
    int nNth;

    SPAWN_DELAY_DEBUG = GetLocalInt(oSpawnArea, "SpawnDelayDebug");             //DebugMode("Spawn_FromTriggerWithAOE; SpawnDelayDebug: "+IntToString(SPAWN_DELAY_DEBUG));
    SPAWN_COUNT_DEBUG = GetLocalInt(oSpawnArea, "SpawnCountDebug");             //DebugMode("Spawn_FromTriggerWithAOE; SpawnCountDebug: "+IntToString(SPAWN_COUNT_DEBUG));

    int bAOEInitialized = GetLocalInt(oSpawnCenter, "NESS_AreaInitialized");    DebugMode("Spawn_FromTriggerWithAOE; AOE initialized: "+IntToString(bAOEInitialized));

    if (!bAOEInitialized)
    {
        // Set Global Defaults
        SetGlobalDefaults();

        // Set Spawns
        //location lBase = Location(oSpawnArea, Vector(), 0.0);                 //DebugMode("Spawn_FromTriggerWithAOE; Location: "+LocationToString(lBase));
        int nSpawnsSetup = Spawn_SetSpawnsWithinAOE(SPAWN_CENTER_RADIUS);       DebugMode("Spawn_FromTriggerWithAOE; nSpawnsSetup: "+IntToString(nSpawnsSetup));
        SetLocalInt(oSpawnCenter, SPAWN_AREA_COUNT, 0);                         DebugMode("Spawn_FromTriggerWithAOE; SpawnAreaCount: "+IntToString(GetLocalInt(oSpawnCenter, SPAWN_AREA_COUNT)));
        SetLocalInt(oSpawnCenter, "NESS_AreaInitialized", TRUE);                DebugMode("Spawn_FromTriggerWithAOE; AOE Initilized: "+IntToString(GetLocalInt(oSpawnCenter, "NESS_AreaInitialized")));

        // Recall ourselves after flags have been initialized
        DelayCommand(0.1, Spawn_FromTriggerWithAOE());                          DebugMode("Spawn_FromTriggerWithAOE; starting initializing process again\n-.-.-.-.-.-.-.-.-.-.-.-.\n");
        return;
    }

    // Check Area State
    if (GetLocalInt(oSpawnArea, "AreaSpawnsDeactivated") == TRUE)
    {                                                                           DebugMode("Spawn_FromTriggerWithAOE; stop spawning, area is deactivated\n-.-.-.-.-.-.-.-.-.-.-.-.\n");
        return;
    }

    int nPCCount = CountPCsInArea(oSpawnArea, TRUE);                            DebugMode("Spawn_FromTriggerWithAOE; nPCCount: "+IntToString(nPCCount));

    int nAreaSpawnCount = GetLocalInt(oSpawnCenter, SPAWN_AREA_COUNT);          DebugMode("Spawn_FromTriggerWithAOE; SpawnAreaCount: "+IntToString(nAreaSpawnCount));
    int bLeftoversForceProcessing = GetLocalInt( GetModule(),
      "LeftoversForceProcessing");                                              DebugMode("Spawn_FromTriggerWithAOE; bLeftoversForceProcessing: "+IntToString(bLeftoversForceProcessing));

    if (nPCCount == 0 && (nAreaSpawnCount == 0 || ! bLeftoversForceProcessing))
    {                                                                           DebugMode("Spawn_FromTriggerWithAOE; stop spawning, nobody's here or everything is done\n-.-.-.-.-.-.-.-.-.-.-.-.\n");
        return;
    }

    int nSpawns = GetLocalInt(oSpawnCenter, "Spawns");                          DebugMode("Spawn_FromTriggerWithAOE; nSpawns: "+IntToString(nSpawns));
    int nNewAreaSpawnCount = 0;                                                 DebugMode("Spawn_FromTriggerWithAOE; nNewAreaSpawnCount: "+IntToString(nNewAreaSpawnCount));

    // What time is it?  Used to compare all times
    int nTimeNow = GetCurrentRealSeconds();                                     DebugMode("Spawn_FromTriggerWithAOE; nTimeNow: "+IntToString(nTimeNow));

    // Enumerate Waypoints in the AOE
    for (nNth = 1; nNth <= nSpawns; nNth++)
    {
        // Retrieve Spawn
        sSpawnNum = "Spawn" + PadIntToString(nNth, 2);                          DebugMode("Spawn_FromTriggerWithAOE; sSpawnNum: "+sSpawnNum);
        oSpawn = GetLocalObject(oSpawnCenter, sSpawnNum);                       DebugMode("Spawn_FromTriggerWithAOE; oSpawn: "+GetName(oSpawn)+" | "+GetTag(oSpawn));

        // Validate spawn
        if (! GetIsObjectValid( oSpawn ) )
        {                                                                       DebugMode("Spawn_FromTriggerWithAOE; continue script\n-.-.-.-.-.-.-.-.-.-.-.-.\n");
           continue;
        }
        sSpawnName = GetLocalString(oSpawn, "f_Flags");                         DebugMode("Spawn_FromTriggerWithAOE; sSpawnName: "+sSpawnName);

        DebugMode("Spawn_FromTriggerWithAOE; Check for spawns that need to be processed because they despawned\n"+
                 "due to a PCxx flag and PCs have returned");
        if (nPCCount > 0)
        {
            int nSpawnNumSaveStates = GetLocalInt(oSpawn, "SpawnNumSavedStates");               DebugMode("Spawn_FromTriggerWithAOE; nSpawnNumSaveStates: "+IntToString(nSpawnNumSaveStates));
            int nSpawnNumSaveCampStates = GetLocalInt(oSpawn, "SpawnNumSavedCampStates");       DebugMode("Spawn_FromTriggerWithAOE; nSpawnNumSaveCampStates: "+IntToString(nSpawnNumSaveCampStates));
            if (nSpawnNumSaveStates > 0 || nSpawnNumSaveCampStates > 0)
            {
                DebugMode("forcing respawns");
                RestorePCDespawns(oSpawn, nTimeNow);                            DebugMode("Spawn_FromTriggerWithAOE; RestorePCDespawns");
                NESS_ForceProcess(oSpawn);                                      DebugMode("Spawn_FromTriggerWithAOE; NESS_ForceProcess\n-.-.-.-.-.-.-.-.-.-.-.-.\n");
            }
        }

        // Only Process every nProcessFrequency Seconds
        nProcessSpawn = FALSE;                                                  DebugMode("Spawn_FromTriggerWithAOE; nProcessSpawn: "+IntToString(nProcessSpawn));
        nProcessFrequency = GetLocalInt(oSpawn, "f_ProcessFrequency");          DebugMode("Spawn_FromTriggerWithAOE; nProcessFrequency: "+IntToString(nProcessFrequency));
        nProcessOffset = GetLocalInt(oSpawn, "f_ProcessOffset");                DebugMode("Spawn_FromTriggerWithAOE; nProcessOffset: "+IntToString(nProcessOffset));
        nCurrentProcessTick = GetLocalInt(oSpawn, "CurrentProcessTick");        DebugMode("Spawn_FromTriggerWithAOE; nCurrentProcessTick: "+IntToString(nCurrentProcessTick));

        if (nProcessFrequency == 1)
        {
            // Don't even need to bother with CurrentProcessTick or offset
            nProcessSpawn = TRUE;                                               DebugMode("Spawn_FromTriggerWithAOE; Current nProcessSpawn: "+IntToString(nProcessSpawn));
        }

        else if (nCurrentProcessTick == 0)
        {
            //  First time in. Always process the first time
            nProcessSpawn = TRUE;                                               DebugMode("Spawn_FromTriggerWithAOE; Current nProcessSpawn: "+IntToString(nProcessSpawn));
            SetLocalInt(oSpawn, "CurrentProcessTick", 2-nProcessOffset);        DebugMode("Spawn_FromTriggerWithAOE; Current CurrentProcessTick: "+IntToString(GetLocalInt(oSpawn, "CurrentProcessTick")));
            DebugMode("Tick 1");
            DebugMode("+");
        }

        else
        {
            int nForceProcess = GetLocalInt(oSpawn, "SpawnForceProcess");       DebugMode("Spawn_FromTriggerWithAOE; nForceProcess: "+IntToString(nForceProcess));
            if (nForceProcess)
            {
                SetLocalInt(oSpawn, "SpawnForceProcess", FALSE);                DebugMode("Spawn_FromTriggerWithAOE; nForceProcess: "+IntToString(GetLocalInt(oSpawn, "SpawnForceProcess")));
            }

            if (nCurrentProcessTick > nProcessFrequency)
            {
                // Roll over Counter Tick
                nCurrentProcessTick = 1;                                        DebugMode("Spawn_FromTriggerWithAOE; nCurrentProcessTick: "+IntToString(nCurrentProcessTick));
                DebugMode("Tick " + IntToString(nCurrentProcessTick));
                DebugMode("+");

                nProcessSpawn = TRUE;                                           DebugMode("Spawn_FromTriggerWithAOE; nProcessSpawn: "+IntToString(nProcessSpawn));
            }

            else
            {
                DebugMode("Tick " + IntToString(nCurrentProcessTick));

                if (nForceProcess)
                {
                    DebugMode("+ (forced)");
                    nProcessSpawn = TRUE;                                       DebugMode("Spawn_FromTriggerWithAOE; nProcessSpawn: "+IntToString(nProcessSpawn));
                }

            }
            // Increment Counter Tick
            nCurrentProcessTick++;                                              DebugMode("Spawn_FromTriggerWithAOE; nCurrentProcessTick: "+IntToString(nCurrentProcessTick));
            SetLocalInt(oSpawn, "CurrentProcessTick", nCurrentProcessTick);     DebugMode("Spawn_FromTriggerWithAOE; CurrentProcessTick: "+IntToString(GetLocalInt(oSpawn, "CurrentProcessTick")));
        }

        // Check if Deactivated
        nSpawnDeactivated = GetLocalInt(oSpawn, "SpawnDeactivated");            DebugMode("Spawn_FromTriggerWithAOE; nSpawnDeactivated: "+IntToString(nSpawnDeactivated));
        if (nSpawnDeactivated == TRUE)
        {
            nProcessSpawn = FALSE;                                              DebugMode("Spawn_FromTriggerWithAOE; nProcessSpawn: "+IntToString(nProcessSpawn));
        }

        // Process the Spawn
        if (nProcessSpawn == TRUE)
        {
            DebugMode(GetName(oSpawn)+"_"+IntToString(nProcessFrequency)+"_"+IntToString(nPCCount)+"_"+
                    IntToString(nTimeNow)+"_"+IntToString(nNth));
            DelayCommand(0.0, Spawn_ProcessSpawn(oSpawn, oSpawnCenter, nProcessFrequency,
               nPCCount, nTimeNow, nNth));                                      DebugMode("Spawn_FromTriggerWithAOE; Process Spawn TRUE, doing it rigth now?\n-.-.-.-.-.-.-.-.-.-.-.-.\n");
        }

        nNewAreaSpawnCount += GetLocalInt(oSpawnCenter, "SpawnCount");          DebugMode("Spawn_FromTriggerWithAOE; nNewAreaSpawnCount: "+IntToString(GetLocalInt(oSpawnCenter, "SpawnCount")));
    }

    // Do spawn tracking
    int nTrackModuleSpawns = GetLocalInt(oSpawnCenter, "TrackModuleSpawns");    DebugMode("Spawn_FromTriggerWithAOE; nTrackModuleSpawns: "+IntToString(nTrackModuleSpawns));

    SetLocalInt(oSpawnCenter, SPAWN_AREA_COUNT, nNewAreaSpawnCount);            DebugMode("Spawn_FromTriggerWithAOE; SPAWN_AREA_COUNT: "+IntToString(GetLocalInt(oSpawnCenter, SPAWN_AREA_COUNT)));
    SpawnDelayDebug(oSpawnCenter, " is: " + IntToString(GetLocalInt(oSpawnCenter, SPAWN_AREA_COUNT)));

    // call with old count
    TrackModuleSpawns(nAreaSpawnCount, nTrackModuleSpawns);                     DebugMode("Spawn_FromTriggerWithAOE; TrackModuleSpawns: "+IntToString(nAreaSpawnCount)+" | "+IntToString(nTrackModuleSpawns));

    // Do Spawn dumping
    int nDumpModuleSpawns = GetLocalInt(GetModule(), "DumpModuleSpawns");       DebugMode("Spawn_FromTriggerWithAOE; nDumpModuleSpawns: "+IntToString(nDumpModuleSpawns));
    if (nDumpModuleSpawns)
    {
        DumpModuleSpawns();                                                     DebugMode("Spawn_FromTriggerWithAOE; Dumping Module Spawns\n-.-.-.-.-.-.-.-.-.-.-.-.\n");
    }
}

// This Function Processes a Spawn
void Spawn_ProcessSpawn(object oSpawn, object oSpawnCenter, int nProcessFrequency, int nPCCount,
   int nTimeNow, int nWaypoint)
{
    // Initialize Miscellaneous
    int iCount;
    int jCount;

    // Initialize Spawn and Spawned
    object oCreature, oChild, oSpawnArea = GetArea(oSpawnCenter);
    int nSpawnChild, nSpawnCount, nCurrentChildren;
    int nChildSlot, nEmptyChildSlots;
    string sChildSlot,  sChild;
    int nSpawnBlock, nSpawnDespawn, nDespawning;
    string sSpawnName = GetLocalString(oSpawn, "f_Flags");
    string sSpawnTag = GetLocalString(oSpawn, "f_Template");
    location lSpawn = GetLocation(oSpawn);
    int nChildrenSpawned = GetLocalInt(oSpawn, "ChildrenSpawned");
    int nProcessesPerMinute = 60 / (nProcessFrequency * 6);

    // Get New Name and Tag
    sSpawnName = GetLocalString(oSpawn, "f_Flags");
    sSpawnTag = GetLocalString(oSpawn, "f_Template");

    // Initialize InitialState
    int nInitialState = GetLocalInt(oSpawn, "f_InitialState");
    int nInitialDelay = GetLocalInt(oSpawn, "f_InitialDelay");
    int nNextSpawnTime = GetLocalInt(oSpawn, "NextSpawnTime");

    // Set Initial Delay
    if (nInitialDelay > 0)
    {
        if (GetLocalInt(oSpawn, "InitialDelaySet") == FALSE)
        {
            nNextSpawnTime = nTimeNow + nInitialDelay;
            DebugMode(GetName(oSpawn) + "setting NextSpawnTime for initial delay " +
               IntToString(nNextSpawnTime) + " [" + RealSecondsToString(nNextSpawnTime)
               + "]");
            SpawnDelayDebug(oSpawn, "setting NextSpawnTime for initial delay " +
               IntToString(nNextSpawnTime) + " [" + RealSecondsToString(nNextSpawnTime)
               + "]");
            SetLocalInt(oSpawn, "NextSpawnTime", nNextSpawnTime);
            SetLocalInt(oSpawn, "InitialDelaySet", TRUE);
        }
    }

    // Initialize SpawnDelay
    int nSpawnDelay = GetLocalInt(oSpawn, "f_SpawnDelay");
    int nDelayRandom = GetLocalInt(oSpawn, "f_DelayRandom");
    int nDelayMinimum = GetLocalInt(oSpawn, "f_DelayMinimum");
    int nSpawnDelayPeriodic = GetLocalInt(oSpawn, "f_SpawnDelayPeriodic");

    // Initialize SpawnNumber
    int nRndSpawnNumber;
    int nSpawnNumber = GetLocalInt(oSpawn, "f_SpawnNumber");
    int nSpawnNumberMax = GetLocalInt(oSpawn, "f_SpawnNumberMax");
    int nSpawnNumberMin = GetLocalInt(oSpawn, "f_SpawnNumberMin");
    int nSpawnAllAtOnce = GetLocalInt(oSpawn, "f_SpawnAllAtOnce");
    int nSpawnNumberAtOnce = GetLocalInt(oSpawn, "f_SpawnNumberAtOnce");
    int nSpawnNumberAtOnceMin = GetLocalInt(oSpawn, "f_SpawnNumberAtOnceMin");

    // Initialize Day/Night Only
    int nDayOnly = GetLocalInt(oSpawn, "f_DayOnly");
    int nDayOnlyDespawn = GetLocalInt(oSpawn, "f_DayOnlyDespawn");
    int nNightOnly = GetLocalInt(oSpawn, "f_NightOnly");
    int nNightOnlyDespawn = GetLocalInt(oSpawn, "f_NightOnlyDespawn");

    // Initialize Day/Hour Spawns
    int nDay, nHour;
    int nSpawnDayStart = GetLocalInt(oSpawn, "f_SpawnDayStart");
    int nSpawnDayEnd = GetLocalInt(oSpawn, "f_SpawnDayEnd");
    int nSpawnHourStart = GetLocalInt(oSpawn, "f_SpawnHourStart");
    int nSpawnHourEnd = GetLocalInt(oSpawn, "f_SpawnHourEnd");

    // Initialize RandomWalk
    int nRandomWalk = GetLocalInt(oSpawn, "f_RandomWalk");
    float fWanderRange = GetLocalFloat(oSpawn, "f_WanderRange");

    // Initialize ReturnHome
    int nReturnHome = GetLocalInt(oSpawn, "f_ReturnHome");
    float fReturnHomeRange = GetLocalFloat(oSpawn, "f_ReturnHomeRange");

    // Initialize PCCheck
    int nPCCheck = GetLocalInt(oSpawn, "f_PCCheck");
    int nPCCheckDelay = GetLocalInt(oSpawn, "f_PCCheckDelay");
    int nPCReset = GetLocalInt(oSpawn, "f_PCReset");

    // Initialize RandomGold
    int nGoldAmount;
    int nRandomGold = GetLocalInt(oSpawn, "f_RandomGold");
    int nRandomGoldMin = GetLocalInt(oSpawn, "f_RandomGoldMin");
    int nGoldChance = GetLocalInt(oSpawn, "f_GoldChance");

    // Initialize Spawn Effects
    effect sSpawn, eDespawn;
    int nSpawnEffect = GetLocalInt(oSpawn, "f_SpawnEffect");
    int nDespawnEffect = GetLocalInt(oSpawn, "f_DespawnEffect");

    // Initialize Patrol Routes
    int nPatrolScriptRunning;
    int nPatrolRoute = GetLocalInt(oSpawn, "f_PatrolRoute");
    int nRouteType = GetLocalInt(oSpawn, "f_RouteType");
    int bCheckForStuckPatrols;
    if (nPatrolRoute)
    {
       bCheckForStuckPatrols = GetLocalInt(GetModule(), "CheckForStuckPatrols");
    }

    // Initialize Placeables
    int nLootTime;
    int nRefreshTime;
    int nPlaceable = GetLocalInt(oSpawn, "f_Placeable");
    int nPlaceableType = GetLocalInt(oSpawn, "f_PlaceableType");
    int nTrapDisabled = GetLocalInt(oSpawn, "f_TrapDisabled");
    int nPlaceableRefreshPeriod =  GetLocalInt(oSpawn, "f_PlaceableRefreshPeriod");

    // Initialize SpawnGroups
    int nSpawnGroup = GetLocalInt(oSpawn, "f_SpawnGroup");

    // Initialize LootTable
    int nLootTable = GetLocalInt(oSpawn, "f_LootTable");

    // Initialize Spawn Deactivation
    int nSpawnDeactivated, nRunDeactivateScript, nSpawnAgeTime;
    int nDeactivateSpawn = GetLocalInt(oSpawn, "f_DeactivateSpawn");
    int nDeactivateScript = GetLocalInt(oSpawn, "f_DeactivateScript");
    int nDeactivationInfo = GetLocalInt(oSpawn, "f_DeactivationInfo");
    int nForceDeactivateSpawn = GetLocalInt(oSpawn, "ForceDeactivateSpawn");

    // Initialize Child Lifespan
    int nChildLifespanExpireTime;
    int nChildLifespanMax = GetLocalInt(oSpawn, "f_ChildLifespanMax");
    int nChildLifespanMin = GetLocalInt(oSpawn, "f_ChildLifespanMin");

    // Initialize SpawnRadius
    float fSpawnRadius = GetLocalFloat(oSpawn, "f_SpawnRadius");
    float fSpawnRadiusMin = GetLocalFloat(oSpawn, "f_SpawnRadiusMin");
    int nSpawnNearPCs = GetLocalInt(oSpawn, "f_SpawnNearPCs");

    // Initialize SpawnUnseen
    float fSpawnUnseen = GetLocalFloat(oSpawn, "f_SpawnUnseen");
    int nUnseenIndividual = GetLocalInt(oSpawn, "f_UnseenIndividual");
    int nUnseenRetryCount = GetLocalInt(oSpawn, "f_UnseenRetryCount");

    // Initialize CorpseDecay
    float fCorpseDecay = GetLocalFloat(oSpawn, "f_CorpseDecay");

    // Initialize SpawnCamp
    int nSpawnCamp = GetLocalInt(oSpawn, "f_SpawnCamp");
    float fCampDecay = GetLocalFloat(oSpawn, "f_CampDecay");

    // Initialize SpawnScripts
    int nSpawnScript = GetLocalInt(oSpawn, "f_SpawnScript");
    int nDespawnScript = GetLocalInt(oSpawn, "f_DespawnScript");

    // Initialize SpawnCheckCustom
    int nSpawnCheckCustom = GetLocalInt(oSpawn, "f_SpawnCheckCustom");

    // Initialize SpawnCheckPCs
    int nSpawnCheckPCs = GetLocalInt(oSpawn, "f_SpawnCheckPCs");

    // Intialize SpawnTrigger
    float fSpawnTrigger = GetLocalFloat(oSpawn, "f_SpawnTrigger");
    float fDespawnTrigger = GetLocalFloat(oSpawn, "f_DespawnTrigger");

    // Initialize AreaEffect
    int nSpawnAreaEffect = GetLocalInt(oSpawn, "f_SpawnAreaEffect");
    float fAreaEffectDuration = GetLocalFloat(oSpawn, "f_AreaEffectDuration");

    // Initialize ObjectEffect
    int nObjectEffect = GetLocalInt(oSpawn, "f_ObjectEffect");
    float fObjectEffectDuration = GetLocalFloat(oSpawn, "f_ObjectEffectDuration");

    // Initialize RandomSpawn
    int nRandomSpawn = GetLocalInt(oSpawn, "f_RandomSpawn");

    // Initialize SpawnFaction
    int nSpawnFaction = GetLocalInt(oSpawn, "f_SpawnFaction");

    // Initialize SpawnAlignment
    int nSpawnAlignment = GetLocalInt(oSpawn, "f_SpawnAlignment");
    int nAlignmentShift = GetLocalInt(oSpawn, "f_AlignmentShift");

    // Initialize Heartbeat Script
    int nHeartbeatScript = GetLocalInt(oSpawn, "f_HeartbeatScript");

    // Initialize SpawnLocation
    int nSpawnLocation = GetLocalInt(oSpawn, "f_SpawnLocation");
    int nSpawnLocationMin = GetLocalInt(oSpawn, "f_SpawnLocationMin");
    int nSpawnLocationInd = GetLocalInt(oSpawn, "f_SpawnLocationInd");

    // Initialize SpawnFacing
    int nFacing = GetLocalInt(oSpawn, "f_Facing");
    float fSpawnFacing = GetLocalFloat(oSpawn, "f_SpawnFacing");

    // Initialize EntranceExit
    float fEntranceExitX, fEntranceExitY;
    vector vEntranceExit;
    string sEntranceExit, sExit;
    location lEntranceExit, lExit;
    int nRndExit;
    object oExit;
    int nEntranceExit = GetLocalInt(oSpawn, "f_EntranceExit");
    int nEntranceExitMin = GetLocalInt(oSpawn, "f_EntranceExitMin");
    int nExit = GetLocalInt(oSpawn, "f_Exit");
    int nExitMin = GetLocalInt(oSpawn, "f_ExitMin");

    // Initialize HealChildren
    int nHealAmount;
    effect eEffect;
    int nHealChildren = GetLocalInt(oSpawn, "f_HealChildren");
    int nHealEffects = GetLocalInt(oSpawn, "f_HealEffects");

    // Initialize SpawnItem
    int nSpawnItem = GetLocalInt(oSpawn, "f_SpawnItem");

    // Initialize SpawnSit
    int nSpawnSit = GetLocalInt(oSpawn, "f_SpawnSit");

    // Initialize SpawnPlot
    int nSpawnPlot = GetLocalInt(oSpawn, "f_SpawnPlot");

    // Initialize SpawnMerchant
    int nSpawnMerchant = GetLocalInt(oSpawn, "f_SpawnMerchant");

    int nPCCheckDespawn = FALSE;

    // decide if we'll despawn this HB due to PC Check
    if (nPCCheck == TRUE)
    {
        DebugMode("Pc check");
        // Check for PCs
        if (nPCCount == 0)
        {
            int nPCCheckDespawnTime = GetLocalInt(oSpawn, "PCCheckDespawnTime");
            DebugMode("despawn time = " + IntToString(nPCCheckDespawnTime));
            DebugMode("time now = " + IntToString(nTimeNow));
            if (nPCCheckDespawnTime == 0)
            {
                nPCCheckDespawnTime = nTimeNow + nPCCheckDelay;
                SetLocalInt(oSpawn, "PCCheckDespawnTime", nPCCheckDespawnTime);
            }
            if (nTimeNow >= nPCCheckDespawnTime)
            {
                nPCCheckDespawn = TRUE;
                SetLocalInt(oSpawn, "PCCheckDespawnTime", 0);
            }
        }
        else
        {
            SetLocalInt(oSpawn, "PCCheckDespawnTime", 0);
        }
    }

    // Enumerate oSpawned Children
    nChildSlot = 1;
    nSpawnCount = 0;
    nEmptyChildSlots = 0;
    int nSpawnDelayTimerExpired = FALSE;

    for (nChildSlot = 1; nChildSlot <= nSpawnNumber; nChildSlot++)
    {
        // Starting Conditional
        nSpawnDespawn = FALSE;
        nDespawning = FALSE;
        nSpawnChild = FALSE;

        // Retrieve Child
        sChildSlot = "ChildSlot" + PadIntToString(nChildSlot, 2);
        oCreature = GetLocalObject(oSpawn, sChildSlot);
        DebugMode("checking " + sChildSlot + " of " + IntToString(nSpawnNumber));


        // Check if this is Child Slot is Valid
        if (GetIsObjectValid(oCreature) == FALSE)
        {
            // Empty Slot
            DebugMode("Delay: "+GetName(oSpawn) + " invalid in slot " + sChildSlot + ": object " +
              ObjectToString(oCreature) + " " + GetName(oCreature));
            SpawnDelayDebug(oSpawn, "invalid in slot " + sChildSlot + ": object " +
              ObjectToString(oCreature));
            DebugMode("Count: " + GetName(oSpawn) + " invalid in slot " + sChildSlot + ": object " +
              ObjectToString(oCreature) + " " + GetName(oCreature));
            SpawnCountDebug(oSpawn, "invalid in slot " + sChildSlot + ": object " +
              ObjectToString(oCreature));
            nEmptyChildSlots++;

        }
        else
        {
            if (nPlaceable == FALSE && nSpawnCamp == FALSE && nSpawnItem == FALSE)
            {
                // Don't process DM possessed creatures

                if (GetIsDMPossessed( oCreature ) )
                {
                   continue;
                }

                // Check for Corpses
                if (GetIsDead(oCreature) == FALSE)
                {
                    DebugMode("alive");
                    nSpawnChild = TRUE;
                }
                else
                {
                    // Empty Slot
                    DebugMode(GetName(oSpawn) + "dead in slot " + sChildSlot + ": object " +
                        ObjectToString(oCreature));
                    SpawnDelayDebug(oSpawn, "dead in slot " + sChildSlot + ": object " +
                        ObjectToString(oCreature));
                    DebugMode(GetName(oSpawn) + "dead in slot " + sChildSlot + ": object " +
                        ObjectToString(oCreature));
                    SpawnCountDebug(oSpawn, "dead in slot " + sChildSlot + ": object " +
                        ObjectToString(oCreature));
                    nEmptyChildSlots++;
                    NESS_ProcessDeadCreature(oCreature, oSpawn);
                }
            }
            else
            {
                nSpawnChild = TRUE;
            }
        }

        if (nSpawnChild == TRUE)
        {
            // Add to Count Total
            nSpawnCount++;
            //SpawnCountDebug("+ spawn count to " + IntToString(nSpawnCount));
            nSpawnBlock = FALSE;

            // Check Despawning
            nDespawning = GetLocalInt(oCreature, "Despawning");

            // Check Force Despawn
            if (GetLocalInt(oCreature, "ForceDespawn") == TRUE)
            {
                DebugMode("force despawn");
                nDespawning = TRUE;
                nSpawnDespawn = TRUE;
            }

            // Get Creature Home
            float fHomeX = GetLocalFloat(oCreature, "HomeX");
            float fHomeY = GetLocalFloat(oCreature, "HomeY");
            vector vHome = Vector(fHomeX, fHomeY, 0.0);
            location lHome = Location(oSpawnArea, vHome, 0.0);

            // Check Facing
            float fChildFacing = GetLocalFloat(oCreature, "SpawnFacing");

            // Check Lifespan
            if (nChildLifespanMax > -1)
            {
                nChildLifespanExpireTime = GetLocalInt(oCreature, "LifespanExpireTime");
                if (nTimeNow >= nChildLifespanExpireTime)
                {
                    DebugMode("despawn: lifespawn exceeded");
                    nSpawnDespawn = TRUE;
                }
            }

            // Day Only
            if (nDayOnlyDespawn == TRUE && (nDayOnly == TRUE && (GetIsDay() == FALSE && GetIsDawn() == FALSE)))
            {
                DebugMode("despawn: night time for DO spawn");
                nSpawnDespawn = TRUE;
            }

            // Night Only
            if (nNightOnlyDespawn == TRUE && (nNightOnly == TRUE && (GetIsNight() == FALSE && GetIsDusk() == FALSE)))
            {
                DebugMode("despawn: day for NO spawn");
                nSpawnDespawn = TRUE;
            }

            // Check Against Day
            if (nSpawnDayStart > -1)
            {
                nDay = GetCalendarDay();
                if (IsBetweenDays(nDay, nSpawnDayStart, nSpawnDayEnd) == FALSE)
                {
                    DebugMode("despawn: not right day");
                    nSpawnDespawn = TRUE;
                }
            }

            // Check Against Hour
            if (nSpawnHourStart > -1)
            {
                nHour = GetTimeHour();
                if (IsBetweenHours(nHour, nSpawnHourStart, nSpawnHourEnd) == FALSE)
                {
                    DebugMode("despawn: not right hour");
                    nSpawnDespawn = TRUE;
                }
            }

            // Random Walk
            if (nRandomWalk == TRUE && nDespawning == FALSE && nSpawnDespawn == FALSE)
            {
                if (GetCurrentAction(oCreature) != ACTION_WAIT &&
                    GetCurrentAction(oCreature) != ACTION_CASTSPELL &&
                   !GetIsInCombat(oCreature) && !IsInConversation(oCreature))
                {
                    if (d2(1) == 2)
                    {
                        if (fWanderRange > 0.0)
                        {
                            //AssignCommand(oCreature, ClearAllActions());
                            //RandomWalk(oSpawn, oCreature, fWanderRange, FALSE);
                            AssignCommand(oCreature, RandomWalk(oSpawn,
                               fWanderRange, FALSE));
                        }
                        else
                        {
                            AssignCommand(oCreature, ClearAllActions());
                            AssignCommand(oCreature, ActionRandomWalk());
                        }
                    }
                }
            }

            // Patrol
            if (nPatrolRoute > -1 && nDespawning == FALSE && nSpawnDespawn == FALSE)
            {
                if (!GetIsInCombat(oCreature) && !IsInConversation(oCreature))
                {

                    nPatrolScriptRunning = GetLocalInt(oCreature, "PatrolScriptRunning");
                    if (GetCurrentAction(oCreature) == ACTION_INVALID && nPatrolScriptRunning == FALSE)
                    {
                        // He's Slacking!  Send him back to work!
                        //AssignCommand(oCreature, ClearAllActions());
                        AssignCommand(oCreature, SetPatrolRoute(nPatrolRoute));
                        AssignCommand(oCreature, DoPatrolRoute(nPatrolRoute, nRouteType));
                    }

                    else if (bCheckForStuckPatrols)
                    {
                        CheckForStuckPatrol(oCreature, nPatrolRoute, nRouteType);
                    }
                }
                else if (IsInConversation(oCreature) == TRUE)
                {
                    // Reset Script State
                    SetLocalInt(oCreature, "PatrolScriptRunning", FALSE);
                }
            }

            // ReturnHome
            if (nReturnHome == TRUE && nDespawning == FALSE && nSpawnDespawn == FALSE)
            {
                if (GetDistanceBetweenLocations(lHome, GetLocation(oCreature)) > fReturnHomeRange)
                {
                    if (GetCurrentAction(oCreature) == ACTION_INVALID && !GetIsInCombat(oCreature) && !IsInConversation(oCreature))
                    {
                        // Send them back to Home
                        //AssignCommand(oCreature,ClearAllActions());
                        //AssignCommand(oCreature,ActionMoveToLocation(lHome));
                        AssignCommand(oCreature, ReturnHome(lHome));

                        if (nFacing == TRUE)
                        {
                            AssignCommand(oCreature, ActionDoCommand(SetFacing(fChildFacing)));
                        }
                    }
                }
            }

            // PC Check
            if (nPCCheckDespawn == TRUE)
            {
                DebugMode("despawn: PC Check");
               nSpawnDespawn = TRUE;
            }

            // Check Camp
            if (nSpawnCamp == TRUE)
            {
                if (ProcessCamp(oCreature) == 0)
                {
                    DebugMode("despawn: camp state is 0");
                    nSpawnDespawn = TRUE;
                }
            }

            // Check Trigger
            if (fDespawnTrigger > 0.0)
            {
                if (CountPCsInRadius(lSpawn, fDespawnTrigger, TRUE) == 0)
                {
                    DebugMode("despawn: PCs in despawn trigger");
                    nSpawnDespawn = TRUE;
                }
            }

            // Check Placeable
            if (nPlaceable == TRUE)
            {
                // Despawn if Empty
                if (nPlaceableType == 1)
                {
                    if (GetFirstItemInInventory(oCreature) == OBJECT_INVALID)
                    {
                        DebugMode("despawn: empty placeable");
                        nSpawnDespawn = TRUE;
                    }
                }
                // Generate Loot if Empty
                else if (nPlaceableType == 2)
                {
                    if (GetFirstItemInInventory(oCreature) == OBJECT_INVALID && GetIsOpen(oCreature) == FALSE)
                    {
                        // Check Delay Timer
                        if (nSpawnDelay > 0)
                        {
                            nLootTime = GetLocalInt(oCreature, "LootTime");
                            if (nLootTime == 0)
                            {
                                // first time
                                if (nDelayRandom == TRUE)
                                {
                                    nLootTime = -1;
                                    while (nLootTime < nDelayMinimum)
                                    {
                                        nLootTime = Random(nSpawnDelay) + 1;
                                    }
                                }
                                else
                                {
                                    // Setup Next Spawn
                                    nLootTime = nSpawnDelay;
                                }
                                nLootTime += nTimeNow;
                                SetLocalInt(oCreature, "LootTime", nLootTime);
                            }
                        }
                        else
                        {
                            nLootTime = nTimeNow;
                        }

                        if (nTimeNow >= nLootTime)
                        {
                            // Give Random Gold
                            if (nRandomGold > 0)
                            {
                                if (d100(1) <= nGoldChance)
                                {
                                    // Calculate Gold to Drop
                                    nGoldAmount = Random(nRandomGold + 1);
                                    while (nGoldAmount < nRandomGoldMin)
                                    {
                                        nGoldAmount = Random(nRandomGold + 1);
                                    }
                                    // Give Gold
                                    CreateItemOnObject("nw_it_gold001", oCreature,
                                       nGoldAmount);
                                }
                            }
                            // Generate New Loot
                            if (nLootTable > -1)
                            {
                                LootTable(oSpawn, oCreature, nLootTable);
                            }

                            if (nSpawnDelay > 0)
                            {
                                // Set up Delay for next time
                                if (nDelayRandom == TRUE)
                                {
                                    nLootTime = -1;
                                    while (nLootTime < nDelayMinimum)
                                    {
                                        nLootTime = Random(nSpawnDelay) + 1;
                                    }
                                }
                                else
                                {
                                    // Setup Next Spawn
                                    nLootTime = nSpawnDelay;
                                }
                                nLootTime += nTimeNow;
                                SetLocalInt(oCreature, "LootTime", nLootTime);
                            }
                        } // end if time to refill
                    } // end if empty
                } // end if placeable-type == 2

                else if (nPlaceableType == 3)
                {
                    nRefreshTime = GetLocalInt(oCreature, "RefreshTime");
                    if (nRefreshTime == 0)
                    {
                        nRefreshTime = nTimeNow + nPlaceableRefreshPeriod;
                        SetLocalInt(oCreature, "RefreshTime", nRefreshTime);
                    }
                    DebugMode("time now: " + IntToString(nTimeNow));
                    DebugMode("refesh at: " + IntToString(nRefreshTime));
                    if (nTimeNow >= nRefreshTime)
                    {
                        if (!GetIsOpen(oCreature))
                        {
                            // Do the refresh

                            // Despawn the current placeable
                            DebugMode("despawn: placeable refresh");
                            nSpawnDespawn = TRUE;

                            // Override SpawnDelay for respawn
                            SetLocalInt(oSpawn, "OverrideSpawnDelay", 1);

                            // let the system know this is gone this frame
                            nEmptyChildSlots++;
                        }
                    }
                }
            }

            // Run Heartbeat Script
            if (nHeartbeatScript > -1 && nDespawning == FALSE && nSpawnDespawn == FALSE)
            {
                SetLocalInt(oCreature, "HeartbeatScript", nHeartbeatScript);
                ExecuteScript("spawn_sc_hbeat", oCreature);
            }

            // Set Facing
            if (nFacing == TRUE && nDespawning == FALSE)
            {
                if (GetFacing(oCreature) != fChildFacing && IsInConversation(oCreature) == FALSE && GetIsInCombat(oCreature) == FALSE && GetDistanceBetweenLocations(lHome, GetLocation(oCreature)) < 1.0)
                {
                    AssignCommand(oCreature, ActionDoCommand(SetFacing(fChildFacing)));
                }
            }

            // Heal Children
            if (nHealChildren > 0)
            {
                if (GetIsInCombat(oCreature) == FALSE && (GetMaxHitPoints(oCreature) != GetCurrentHitPoints(oCreature)))
                {
                    nHealAmount = FloatToInt(IntToFloat(GetMaxHitPoints(oCreature)) * (IntToFloat(nHealChildren) / 100.0));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(nHealAmount), oCreature, 0.0);
                    if (nHealEffects == TRUE)
                    {
                        eEffect = GetFirstEffect(oCreature);
                        while (GetIsEffectValid(eEffect) == TRUE)
                        {
                            RemoveEffect(oCreature, eEffect);
                            eEffect = GetNextEffect(oCreature);
                        }
                    }
                }
            }

            // Spawn Sit
            if (nSpawnSit == TRUE && nDespawning == FALSE)
            {
                if (GetCurrentAction(oCreature) != ACTION_SIT)
                {
                    if (GetIsInCombat(oCreature) == FALSE && IsInConversation(oCreature) == FALSE)
                    {
                        FindSeat(oSpawn, oCreature);
                    }
                }
            }

            // Check if Item is Possessed by Someone
            if (nSpawnItem == TRUE)
            {
                if (GetItemPossessor(oCreature) != OBJECT_INVALID)
                {
                    // Remove Child Status
                    DeleteLocalObject(oSpawn, GetLocalString(oCreature, "ParentChildSlot"));
                }
            }

            // Population Control
            if (nSpawnCount > nSpawnNumber)
            {
                nSpawnDespawn = TRUE;
                nSpawnBlock = TRUE;
            }
        }


        // Despawn Creatures
        //if (GetIsDM(object) == TRUE || GetIsDM(GetMaster(object)) == TRUE)
        if (nSpawnDespawn == TRUE && ! GetIsDM(oCreature) &&
                                     ! GetIsDM(GetMaster(oCreature)))
        {
            int nSaveState = nPCCheckDespawn && ! nPCReset;
            SetLocalInt(oCreature, "Despawning", TRUE);
            if (nSpawnPlot == TRUE)
            {
                SetPlotFlag(oCreature, FALSE);
            }
            if (nPlaceable == TRUE || nSpawnCamp == TRUE || nSpawnItem == TRUE
                || nSpawnMerchant == TRUE)
            {
                if (nDespawnScript > -1)
                {
                    SetLocalInt(oCreature, "DespawnScript", nDespawnScript);
                    ExecuteScript("spawn_sc_spawn", oCreature);
                }
                if (nSpawnCamp == TRUE)
                {
                    // Destroy camp will save info about what in the camp is
                    // still present on the camp object (oCreature in this
                    // case) if nSaveState is true
                    DestroyCamp(oCreature, fCampDecay, nSaveState);
                    //if (! nSaveState)
                    //{
                    //    // This isn't a PC despawn, so set up SD if needed
                    //    if (nSpawnDelay && nNextSpawnTime == 0)
                    //    {
                    //        nNextSpawnTime = SetupSpawnDelay(nSpawnDelay,
                    //           nDelayRandom, nDelayMinimum, nTimeNow);
                    //        SetLocalInt(oSpawn, "NextSpawnTime", nNextSpawnTime);
                    //    }
                    //}
                }

                if (nDespawnEffect > 0)
                {
                    eDespawn = EffectVisualEffect(SpawnEffect(oSpawn, FALSE, TRUE));
                    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eDespawn,
                       GetLocation(oCreature), 5.0);
                }

                // remove the child object from the spawn
                DeleteLocalObject(oSpawn, GetLocalString(oCreature,
                   "ParentChildSlot"));

                if (nSaveState)
                {
                    if (nSpawnCamp)
                    {
                        SaveCampStateOnDespawn(oCreature, oSpawn);
                    }
                    else
                    {
                        SaveStateOnDespawn(oCreature, oSpawn);
                    }

                }

                // saved camp states don't get destroyed; but everything else
                // (including unsaved camp states do
                if (! (nSaveState && nSpawnCamp))
                {
                    NESS_CleanInventory(oCreature);
                    AssignCommand(oCreature, SetIsDestroyable(TRUE, FALSE,
                       FALSE));
                    SpawnCountDebug(oSpawn, "despawning " + ObjectToString(oCreature));
                    DestroyObject(oCreature);
                }
                nSpawnCount--;
                DebugMode("- spawn count to " + IntToString(nSpawnCount));
            }
            else  // is not placeable, camp, item, or merchant
            {
                if ((!GetIsInCombat(oCreature) && !IsInConversation(oCreature))
                   || (nPCCheck == TRUE && nPCCount == 0))
                {
                    AssignCommand(oCreature, ClearAllActions());
                    AssignCommand(oCreature, ActionWait(1.0) );
                    if (nEntranceExit > -1)
                    {
                        if (nExit > -1)
                        {
                            if (nExitMin > -1)
                            {
                                nRndExit = Random(nExit + 1);
                                while (nRndExit < nExitMin)
                                {
                                    nRndExit = Random(nExit + 1);
                                }
                                nExit = nRndExit;
                            }
                            sExit = "EX" + PadIntToString(nExit, 2);
                            oExit = GetNearestObjectByTag(sExit, oSpawn);
                            lExit = GetLocation(oExit);
                            //AssignCommand(oCreature, ClearAllActions());
                            AssignCommand(oCreature, ActionMoveToLocation(lExit));
                        }
                        else
                        {
                            // Get Creature EntranceExit
                            fEntranceExitX = GetLocalFloat(oCreature, "EntranceExitX");
                            fEntranceExitY = GetLocalFloat(oCreature, "EntranceExitY");
                            vEntranceExit = Vector(fEntranceExitX, fEntranceExitY, 0.0);
                            lEntranceExit = Location(oSpawnArea, vEntranceExit, 0.0);
                            //AssignCommand(oCreature, ClearAllActions());
                            AssignCommand(oCreature, ActionMoveToLocation(lEntranceExit));
                        }
                        if (nDespawnScript > -1)
                        {
                            SetLocalInt(oCreature, "DespawnScript", nDespawnScript);
                            ExecuteScript("spawn_sc_spawn", oCreature);
                        }
                        if (nDespawnEffect > 0)
                        {
                            eDespawn = EffectVisualEffect(SpawnEffect(oSpawn, FALSE, TRUE));
                            AssignCommand(oCreature, ActionDoCommand(ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eDespawn, GetLocation(oCreature), 5.0)));
                        }
                        AssignCommand(oCreature, ActionDoCommand(DeleteLocalObject(oSpawn, GetLocalString(oCreature, "ParentChildSlot"))));
                        AssignCommand(oCreature, ActionDoCommand(NESS_CleanInventory(oCreature)));
                        if (nSaveState)
                        {
                            AssignCommand(oCreature, ActionDoCommand(
                               SaveStateOnDespawn(oCreature, oSpawn)));
                        }

                        AssignCommand(oCreature, SetIsDestroyable(TRUE, FALSE, FALSE));
                        SpawnCountDebug(oSpawn, "despawning " + ObjectToString(oCreature));

                        AssignCommand(oCreature, ActionDoCommand(DestroyObject(oCreature)));
                    }
                    else // doesn't have to exit at a specific place
                    {
                        if (nDespawnScript > -1)
                        {
                            SetLocalInt(oCreature, "DespawnScript", nDespawnScript);
                            ExecuteScript("spawn_sc_spawn", oCreature);
                        }
                        if (nDespawnEffect > 0)
                        {
                            eDespawn = EffectVisualEffect(SpawnEffect(oSpawn, FALSE, TRUE));
                            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eDespawn, GetLocation(oCreature), 5.0);
                        }
                        DeleteLocalObject(oSpawn, GetLocalString(oCreature, "ParentChildSlot"));
                        NESS_CleanInventory(oCreature);
                        if (nSaveState)
                        {
                            SaveStateOnDespawn(oCreature, oSpawn);
                        }

                        AssignCommand(oCreature, SetIsDestroyable(TRUE, FALSE, FALSE));
                        SpawnCountDebug(oSpawn, "despawning " + ObjectToString(oCreature));

                        DestroyObject(oCreature);
                    }
                    nSpawnCount--;
                    DebugMode("- spawn count to " + IntToString(nSpawnCount));

                }
            }
        }
    }

    if (nPCCheckDespawn && (nPCReset == TRUE))
    {
        DebugMode("reset");
        ResetSpawn(oSpawn, nTimeNow);
    }

    //++ Done processing living children

    // Record SpawnCount
    SetLocalInt(oSpawn, "SpawnCount", nSpawnCount);
    DebugMode("set spawn count to " + IntToString(nSpawnCount));
    //SpawnCountDebug("set spawn count to " + IntToString(nSpawnCount));

    // Recalculate spawn number if random spawn number range in use...
    if (nSpawnCount == 0 && (!nPCCheckDespawn) && nSpawnNumberMin > -1 && nPCCount > 0)
    {
        nRndSpawnNumber = Random(nSpawnNumberMax + 1);
        while (nRndSpawnNumber < nSpawnNumberMin)
        {
            nRndSpawnNumber = Random(nSpawnNumberMax + 1);
        }
        nSpawnNumber = nRndSpawnNumber;
        nEmptyChildSlots = nSpawnNumber;
        SetLocalInt(oSpawn, "f_SpawnNumber", nSpawnNumber);                                 DebugMode("f_SpawnNumber: "+IntToString(nSpawnNumber));
        SpawnCountDebug(oSpawn, "spawn number set to " + IntToString(nSpawnNumber));
        SpawnCountDebug(oSpawn, "empty slots is " + IntToString(nEmptyChildSlots));
    }

    // Check InitialState
    if (nInitialState == 0)
    {
        if (GetLocalInt(oSpawn, "InitialStateProcessed") == FALSE)
        {
            nForceDeactivateSpawn = TRUE;
            SetLocalInt(oSpawn, "InitialStateProcessed", TRUE);
        }
    }

    // Check to Deactivate Spawn
    if (nDeactivateSpawn > -1 || nForceDeactivateSpawn == TRUE)
    {
        nSpawnDeactivated = FALSE;
        nRunDeactivateScript = FALSE;
        if (nForceDeactivateSpawn == FALSE)
        {
            switch (nDeactivateSpawn)
            {
                // Deactivate if all Children are Dead
                case 0:
                    if (nSpawnCount == 0 && nChildrenSpawned != 0)
                    {
                        nSpawnDeactivated = TRUE;
                        nRunDeactivateScript = TRUE;
                        nSpawnBlock = TRUE;
                    }
                break;
                // Deactivate if Spawned SpawnNumber Children
                case 1:
                    if (nChildrenSpawned >= nSpawnNumber)
                    {
                        nSpawnDeactivated = TRUE;
                        nRunDeactivateScript = TRUE;
                        nSpawnBlock = TRUE;
                    }
                break;
                // Temporary Pause until all Children are Dead
                case 2:
                    if (nSpawnCount != 0)
                    {
                        nRunDeactivateScript = TRUE;
                        nSpawnBlock = TRUE;
                    }
                break;
                // Deactivate after DI00 Children Spawned
                case 3:
                    if (nChildrenSpawned >= nDeactivationInfo)
                    {
                        nSpawnDeactivated = TRUE;
                        nRunDeactivateScript = TRUE;
                        nSpawnBlock = TRUE;
                    }
                break;
                // Deactivate after DI00 Minutes  (converted to seconds)
                case 4:
                // Deactivate after DI00 Cycles (converted to seconds
                case 5:
                    nSpawnAgeTime = GetLocalInt(oSpawn, "SpawnAgeTime");
                    if (nSpawnAgeTime == 0)
                    {
                        // first time
                        nSpawnAgeTime = nTimeNow + nDeactivationInfo;
                    }

                    if (nTimeNow >= nSpawnAgeTime)
                    {
                        nSpawnDeactivated = TRUE;
                        nRunDeactivateScript = TRUE;
                        nSpawnBlock = TRUE;
                    }
                    SetLocalInt(oSpawn, "SpawnAgeTime", nSpawnAgeTime);
                break;
                // Deactivate when spawn count == spawn number
                case 6:
                    if (nSpawnCount >= nSpawnNumber)
                    {
                        nSpawnDeactivated = TRUE;
                        nRunDeactivateScript = TRUE;
                        nSpawnBlock = TRUE;
                    }
                break;
            }
        }
        else
        {
            // Force Deactivate
            nSpawnDeactivated = TRUE;
            nRunDeactivateScript = TRUE;
            nSpawnBlock = TRUE;
            SetLocalInt(oSpawn, "ForceDeactivateSpawn", FALSE);
        }

        // Record Deactivated State
        SetLocalInt(oSpawn, "SpawnDeactivated", nSpawnDeactivated);

        // Run Deactivation Script
        if (nRunDeactivateScript == TRUE && nDeactivateScript > -1)
        {
            SetLocalInt(oSpawn, "DeactivateScript", nDeactivateScript);
            ExecuteScript("spawn_sc_deactiv", oSpawn);
            SetLocalInt(oSpawn, "DeactivateScript", -1);
        }
    }

    //++ Done checking deactivation

    // Check Number of Creatures against nSpawnNumber
    if (nEmptyChildSlots > 0)
    {
        // If there are empty slots and nSpawnDelay is true and nNextSpawnTime is 0
        // (which indicates no timer is currently set) and this isn't the first time
        // we've ever spawned (as indicated by nNumberChildrenSpawned) and we're not
        // despawning because PCs have left we should
        // set up a timer
        if (nSpawnDelay && (! nSpawnDelayPeriodic) &&
            nChildrenSpawned > 0 && nNextSpawnTime == 0 && ! nPCCheckDespawn )
        {
            nNextSpawnTime = SetupSpawnDelay(nSpawnDelay,
               nDelayRandom, nDelayMinimum, nTimeNow);
            SetLocalInt(oSpawn, "NextSpawnTime", nNextSpawnTime);
            DebugMode(GetName(oSpawn) + "setup spawn delay: " + IntToString(nNextSpawnTime)
            + " [" + RealSecondsToString(nNextSpawnTime) + "]");
            SpawnDelayDebug(oSpawn, "setup spawn delay: " + IntToString(nNextSpawnTime)
            + " [" + RealSecondsToString(nNextSpawnTime) + "]");
            DebugMode(GetName(oSpawn) + "current time: " +  IntToString(nTimeNow)
            + " [" + RealSecondsToString(nTimeNow) + "]");
            SpawnDelayDebug(oSpawn, "current time: " +  IntToString(nTimeNow)
            + " [" + RealSecondsToString(nTimeNow) + "]");
        }

        SpawnCountDebug(oSpawn, IntToString(nEmptyChildSlots) + " empty slots");

        // Check Against Spawn Unseen
        if (fSpawnUnseen > 0.0 && ! nUnseenIndividual)
        {
            if (nEntranceExit > -1)
            {
                fEntranceExitX = GetLocalFloat(oCreature, "EntranceExitX");
                fEntranceExitY = GetLocalFloat(oCreature, "EntranceExitY");
                vEntranceExit = Vector(fEntranceExitX, fEntranceExitY, 0.0);
                lEntranceExit = Location(oSpawnArea, vEntranceExit, 0.0);
                oCreature = GetFirstObjectInShape(SHAPE_SPHERE, fSpawnUnseen,
                   lEntranceExit, FALSE, OBJECT_TYPE_CREATURE);
            }
            else
            {
                oCreature = GetFirstObjectInShape(SHAPE_SPHERE, fSpawnUnseen,
                   lSpawn, FALSE, OBJECT_TYPE_CREATURE);
            }
            while (oCreature != OBJECT_INVALID)
            {
                if (GetIsPC(oCreature) == TRUE)
                {
                    nSpawnBlock = TRUE;
                    oCreature = OBJECT_INVALID;
                }
                if (nEntranceExit > -1)
                {
                    oCreature = GetNextObjectInShape(SHAPE_SPHERE, fSpawnUnseen,
                       lEntranceExit, FALSE, OBJECT_TYPE_CREATURE);
                }
                else
                {
                    oCreature = GetNextObjectInShape(SHAPE_SPHERE, fSpawnUnseen,
                       lSpawn, FALSE, OBJECT_TYPE_CREATURE);
                }
            }
        }

        // Check Against Day or Night Only
        if ((nNightOnly == TRUE && (GetIsNight() == FALSE && GetIsDusk() == FALSE)) || (nDayOnly == TRUE && (GetIsDay() == FALSE && GetIsDawn() == FALSE)))
        {
            nSpawnBlock = TRUE;
        }

        // Check Against Day
        if (nSpawnDayStart > -1)
        {
            nDay = GetCalendarDay();
            if (IsBetweenDays(nDay, nSpawnDayStart, nSpawnDayEnd) == FALSE)
            {
                nSpawnBlock = TRUE;
            }
        }

        // Check Against Hour
        if (nSpawnHourStart > -1)
        {
            nHour = GetTimeHour();
            if (IsBetweenHours(nHour, nSpawnHourStart, nSpawnHourEnd) == FALSE)
            {
                nSpawnBlock = TRUE;
            }
        }

        // Check Against PCCheck
        if (nPCCheck == TRUE)
        {
            // Check for PCs
            if (CountPCsInArea(oSpawnArea, TRUE) == 0)
            {
                nSpawnBlock = TRUE;
            }
        }

        // Check Trigger
        if (fSpawnTrigger > 0.0)
        {
            DebugMode("checking trigger");
            if (CountPCsInRadius(lSpawn, fSpawnTrigger, TRUE) == 0)
            {
                DebugMode("no one close");
                nSpawnBlock = TRUE;
            }
            else
            {
                DebugMode("trigger tripped");
            }
        }

        // Check Spawn Check PCs
        if (nSpawnCheckPCs > -1)
        {
            // If Spawn Cannot Proceed, Block
            if (SpawnCheckPCs(oSpawn) == FALSE)
            {
                nSpawnBlock = TRUE;
            }
        }

        // Check Spawn Check Custom
        if (nSpawnCheckCustom > -1)
        {
            // If Spawn Cannot Proceed, Block
            if (SpawnCheckCustom(oSpawn) == FALSE)
            {
                nSpawnBlock = TRUE;
            }
        }

        if (nSpawnBlock == FALSE)
        {

            // Check the spawn delay timer
            int nOverrideSpawnDelay = GetLocalInt(oSpawn, "OverrideSpawnDelay");
            if (nSpawnDelay || nInitialDelay)
            {
                // need to refetch, as the death of a child may have changed it
                //nNextSpawnTime = GetLocalInt(oSpawn, "NextSpawnTime");
                DebugMode("next spawn time: " + IntToString(nNextSpawnTime));
                DebugMode("time now: " + IntToString(nTimeNow));
                if ((nTimeNow >= nNextSpawnTime)  && (! nPCCheck || nPCCount > 0))
                {
                    nSpawnDelayTimerExpired = TRUE;

                    if (nInitialDelay)
                    {
                        nInitialDelay = 0;
                        SetLocalInt(oSpawn, "f_InitialDelay", nInitialDelay );
                    }

                    if (! nSpawnDelayPeriodic)
                    {
                        DebugMode(GetName(oSpawn) + "SD timer expired: " +
                           IntToString(nNextSpawnTime)
                           + " [" + RealSecondsToString(nNextSpawnTime) + "]");
                        SpawnDelayDebug(oSpawn, "SD timer expired: " +
                           IntToString(nNextSpawnTime)
                           + " [" + RealSecondsToString(nNextSpawnTime) + "]");
                        DebugMode(GetName(oSpawn) + "current time: " +  IntToString(nTimeNow)
                            + " [" + RealSecondsToString(nTimeNow) + "]");
                        SpawnDelayDebug(oSpawn, "current time: " +  IntToString(nTimeNow)
                            + " [" + RealSecondsToString(nTimeNow) + "]");

                        nNextSpawnTime = 0;
                        SetLocalInt(oSpawn, "NextSpawnTime", nNextSpawnTime);
                    }
                }
            }


            // Check Against spawn delay (SD flag)
            DebugMode("SpawnDelayTimerExpired: " + IntToString(nSpawnDelayTimerExpired));

            if ( ( (!nSpawnDelay || nOverrideSpawnDelay) && ! nInitialDelay ) ||
                nSpawnDelayTimerExpired )
            {
                DebugMode("respawn after delay");
                SetLocalInt(oSpawn, "OverrideSpawnDelay", 0);

                // Check RandomSpawn
                if (d100() <= nRandomSpawn)
                {
                    DebugMode(GetName(oSpawn) + "spawn!");
                    SpawnDelayDebug(oSpawn, "spawn!");
                    DebugMode("periodic: " + IntToString(nSpawnDelayPeriodic));
                    DebugMode("nChildrenSpawned: " + IntToString(nChildrenSpawned));
                    // Set up periodic spawn delay if first spawn
                    if (nSpawnDelayPeriodic && nChildrenSpawned == 0)
                    {
                        // little kludge here.  Knock a second off so it
                        // won't roll over when we get to the bottom of this
                        // function.  Avoids creating yet another special flag
                        nNextSpawnTime = nTimeNow + nSpawnDelay - 1;
                        SetLocalInt(oSpawn, "NextSpawnTime", nNextSpawnTime);
                        DebugMode("setup first periodic delay: " + IntToString(nNextSpawnTime));
                    }

                    if (nSpawnAllAtOnce == FALSE)
                    {
                        // Spawn another Creature
                        Spawn_DoSpawn(oSpawn, oSpawnCenter, nTimeNow);
                    }
                    else
                    {
                        if (nSpawnNumberAtOnce > 0)
                        {
                            if (nSpawnNumberAtOnceMin == 0 || nEmptyChildSlots >= nSpawnNumberAtOnceMin)
                            {
                                // Spawn Sets of Creatures
                                for (jCount = 1; (jCount <= nEmptyChildSlots) && (jCount <= nSpawnNumberAtOnce); jCount++)
                                {
                                    DelayCommand(0.0, Spawn_DoSpawn(oSpawn, oSpawnCenter, nTimeNow));
                                }
                            }
                        }
                        else
                        {
                            // Spawn All Creatures
                            for (jCount = 1; jCount <= nEmptyChildSlots; jCount++)
                            {
                                DelayCommand(0.0, Spawn_DoSpawn(oSpawn, oSpawnCenter, nTimeNow));
                            }
                        }
                    }
                } // end RS

                else
                {
                    DebugMode(GetName(oSpawn) + "Spawn blocked by RS");
                    SpawnDelayDebug(oSpawn, "Spawn blocked by RS");
                    if (nSpawnDelay && ! nSpawnDelayPeriodic)
                    {
                        // reset spawn delay timer
                        nNextSpawnTime = SetupSpawnDelay(nSpawnDelay,
                           nDelayRandom, nDelayMinimum, nTimeNow);
                        SetLocalInt(oSpawn, "NextSpawnTime", nNextSpawnTime);
                        DebugMode(GetName(oSpawn) + "setup spawn delay: " +
                           IntToString(nNextSpawnTime)
                           + " [" + RealSecondsToString(nNextSpawnTime) + "]");
                        SpawnDelayDebug(oSpawn, "setup spawn delay: " +
                           IntToString(nNextSpawnTime)
                           + " [" + RealSecondsToString(nNextSpawnTime) + "]");
                        DebugMode(GetName(oSpawn) + "current time: " +  IntToString(nTimeNow)
                            + " [" + RealSecondsToString(nTimeNow) + "]");
                        SpawnDelayDebug(oSpawn, "current time: " +  IntToString(nTimeNow)
                            + " [" + RealSecondsToString(nTimeNow) + "]");


                    }
                }

            } // end spawn delay test
        }  // end if not spawn blocked (PC check or spawn unseen, for instance)
    } // end if empty slots

    // If the SD is periodic, check for rollover
    if (nSpawnDelayPeriodic)
    {
        // if next spawn time is zero, there is no timer in play
        if (nNextSpawnTime > 0 && nTimeNow >= nNextSpawnTime)
        {
            // Setup Next Spawn
            DebugMode("rollover - timeNow: " + IntToString(nTimeNow) + " nNextSpawnTime: "
                + IntToString(nNextSpawnTime));
            nNextSpawnTime += nSpawnDelay;
            DebugMode("setup new periodic delay: " + IntToString(nNextSpawnTime));
            SetLocalInt(oSpawn, "NextSpawnTime", nNextSpawnTime);
        }
    }
}
//

// This Function Performs the Spawn
void Spawn_DoSpawn(object oSpawn, object oSpawnCenter, int nTimeNow)
{
    vector vSpawnPos;
    // lHome is the location of the actual spawn waypoint
    location lHome;
    // The location of an entrance waypoint to spawn in at instead of lHome
    location lEntranceExit;
    // lSpawnLocation is where we actually spawn in
    location lSpawnLocation;
    float fRadius, fRadiusX, fRadiusY, fSpawnAngle;
    object oSpawned, oEntranceExit, oSpawnLocation, oPC;
    object oSpawnArea = GetArea(oSpawnCenter);
    effect eSpawn, eArea;
    int nObjectType, nRadiusValid;
    int nRndEntranceExit;
    string sTemplate, sEntranceExit;
    int nUnseenTryCount, nUnseen;
    int nWalkToHome = FALSE;

    // Initialize Variables
    string sSpawnName = GetLocalString(oSpawn, "f_Flags");
    string sSpawnTag = GetLocalString(oSpawn, "f_Template");
    // location lSpawn = GetLocation(oSpawn);
    float fSpawnRadius = GetLocalFloat(oSpawn, "f_SpawnRadius");
    float fSpawnRadiusMin = GetLocalFloat(oSpawn, "f_SpawnRadiusMin");
    int nSpawnNearPCs = GetLocalInt(oSpawn, "f_SpawnNearPCs");
    float fSpawnFacing;
    int nFacing = GetLocalInt(oSpawn, "f_Facing");


    int nSpawnEffect = GetLocalInt(oSpawn, "f_SpawnEffect");
    int nSpawnAreaEffect = GetLocalInt(oSpawn, "f_SpawnAreaEffect");
    float fAreaEffectDuration = GetLocalFloat(oSpawn, "f_AreaEffectDuration");

    int nEntranceExit = GetLocalInt(oSpawn, "f_EntranceExit");
    int nEntranceExitMin = GetLocalInt(oSpawn, "f_EntranceExitMin");
    int nPlaceable = GetLocalInt(oSpawn, "f_Placeable");
    int nSpawnGroup = GetLocalInt(oSpawn, "f_SpawnGroup");
    int nSpawnCamp = GetLocalInt(oSpawn, "f_SpawnCamp");
    int nSpawnLocation = GetLocalInt(oSpawn, "f_SpawnLocation");
    int nSpawnLocationMin = GetLocalInt(oSpawn, "f_SpawnLocationMin");
    int nSpawnLocationInd = GetLocalInt(oSpawn, "f_SpawnLocationInd");
    int nSpawnItem = GetLocalInt(oSpawn, "f_SpawnItem");
    int nSpawnMerchant = GetLocalInt(oSpawn, "f_SpawnMerchant");

    float fSpawnUnseen = GetLocalFloat(oSpawn, "f_SpawnUnseen");
    int nUnseenIndividual = GetLocalInt(oSpawn, "f_UnseenIndividual");
    int nUnseenRetryCount = GetLocalInt(oSpawn, "f_UnseenRetryCount");

    // Start with this position for this spawn at the spawn waypoint
    vSpawnPos = GetPositionFromLocation(GetLocation(oSpawn));

    // Find facing for this spawn
    if (nFacing)
    {
        fSpawnFacing = GetLocalFloat(oSpawn, "f_SpawnFacing");
    }

    else
    {
        fSpawnFacing = IntToFloat(Random(360));
    }

    // Check Spawn Location
    if (nSpawnLocation > -1)
    {
        // Get SpawnLocation
        oSpawnLocation = GetSpawnLocationObject(oSpawn, nSpawnLocationMin,
            nSpawnLocation, nSpawnLocationInd);

        if (oSpawnLocation != OBJECT_INVALID)
        {
            vSpawnPos = GetPositionFromLocation(GetLocation(oSpawnLocation));
        }

        // kick out spawn unseen is true and SL location is in radius
        if (fSpawnUnseen > 0.0 && nUnseenIndividual)
        {
            if (!CheckPositionUnseen(vSpawnPos, fSpawnUnseen))
            {
                nUnseenTryCount = 0;
                nUnseen = FALSE;

                while(nUnseenTryCount++ < nUnseenRetryCount && ! nUnseen)
                {
                    oSpawnLocation = GetSpawnLocationObject(oSpawn,
                        nSpawnLocationMin, nSpawnLocation, nSpawnLocationInd);

                    if (oSpawnLocation != OBJECT_INVALID)
                    {
                        vSpawnPos = GetPositionFromLocation(GetLocation(
                           oSpawnLocation));
                    }

                    if (CheckPositionUnseen(vSpawnPos, fSpawnUnseen))
                    {
                        nUnseen = TRUE;
                    }
                }
                if (! nUnseen)
                {
                    // do not spawn this child
                    return;
                }
            }
        }

        // Adjust for New SpawnFacing
        if (nFacing == TRUE)
        {
            fSpawnFacing = GetFacing(oSpawnLocation);
        }
    }

    else if (fSpawnRadius > 0.0)
    {
        // Check SpawnNearPCs
        if (nSpawnNearPCs == TRUE)
        {
            oPC =  GetRandomPCInArea(oSpawnArea, oSpawn);
            if (oPC != OBJECT_INVALID)
            {
                vSpawnPos = GetPositionFromLocation(GetLocation(oPC));
            }
        }

        vSpawnPos = GetSpawnRadiusPosition(vSpawnPos, fSpawnRadius,
           fSpawnRadiusMin);

        // kick out spawn unseen is true and vSpawnPos is in range of PC
        if (fSpawnUnseen > 0.0 && nUnseenIndividual)
        {
            if (!CheckPositionUnseen(vSpawnPos, fSpawnUnseen))
            {
                nUnseenTryCount = 0;
                nUnseen = FALSE;

                while(nUnseenTryCount++ < nUnseenRetryCount && ! nUnseen)
                {
                    vSpawnPos = GetSpawnRadiusPosition(vSpawnPos, fSpawnRadius,
                       fSpawnRadiusMin);

                    if (CheckPositionUnseen(vSpawnPos, fSpawnUnseen))
                    {
                        nUnseen = TRUE;
                    }
                }

                if (! nUnseen)
                {
                    // do not spawn this child
                    return;
                }
            }
        }
    } // end else if SR

    else // Not SL or SR
    {
        if (fSpawnUnseen > 0.0 && nUnseenIndividual)
        {
            if (!CheckPositionUnseen(vSpawnPos, fSpawnUnseen))
            {
                // do not spawn this child
                return;
            }
        }
    }

    // Home is where we spawn in OR where we WOULD spawn in if there were no
    // Alternate entrance specified.
    lHome = Location(oSpawnArea, vSpawnPos, fSpawnFacing);

    // If there's an entrance/exit, lSpawnLocation may still change to that
    lSpawnLocation = lHome;


    // Check Spawn Type
    nObjectType = OBJECT_TYPE_CREATURE;
    if (nPlaceable == TRUE || nSpawnCamp == TRUE || sSpawnTag == "AE")
    {
       nObjectType = OBJECT_TYPE_PLACEABLE;
    }
    if (nSpawnItem == TRUE)
    {
        nObjectType = OBJECT_TYPE_ITEM;
    }
    if (nSpawnMerchant == TRUE)
    {
        nObjectType = OBJECT_TYPE_STORE;
    }

    // Check Spawn Group
    if (nSpawnGroup == TRUE)
    {
        // Pull a Creature from the Group
        sTemplate = SpawnGroup(oSpawn, sSpawnTag);
    }
    else
    {
        sTemplate = sSpawnTag;
    }

    // Set up alternate Entrance/Exit
    if (!nSpawnCamp)
    {
        // EntranceExit
        if (nEntranceExit > -1)
        {
            // Get ExitEntrance
            if (nEntranceExitMin > -1)
            {
                nRndEntranceExit = Random(nEntranceExit + 1);
                while (nRndEntranceExit < nEntranceExitMin)
                {
                    nRndEntranceExit = Random(nEntranceExit + 1);
                }
                nEntranceExit = nRndEntranceExit;
            }
            sEntranceExit = "EE" + PadIntToString(nEntranceExit, 2);
            oEntranceExit = GetNearestObjectByTag(sEntranceExit, oSpawn);
            lEntranceExit = GetLocation(oEntranceExit);

            lSpawnLocation = lEntranceExit;
            nWalkToHome = TRUE;
        }
    }

    // Create Effect
    if (nSpawnEffect > 0)
    {
        eSpawn = EffectVisualEffect(SpawnEffect(oSpawn, TRUE, FALSE));
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSpawn, lSpawnLocation,
           5.0);
    }

    // Check Area Effect
    if (nSpawnAreaEffect > 0)
    {
        eArea = SpawnAreaEffect(oSpawn);
        if (fAreaEffectDuration > 0.0)
        {
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eArea, lSpawnLocation,
               fAreaEffectDuration);
        }
        else
        {
            ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eArea, lSpawnLocation,
               0.0);
        }

        // Check Template
        if (sSpawnTag == "AE")
        {
            sTemplate = "plc_invisobj";
        }
    }

    // Validate sSpawnTag
    if (sTemplate != "")
    {
        // Spawn
        if (nSpawnCamp == TRUE)
        {
            oSpawned = CampSpawn(oSpawn, sTemplate, lSpawnLocation);
            RecordSpawned(oSpawn, oSpawned, lHome, lEntranceExit, fSpawnFacing);
        }
        else
        {

            oSpawned = CreateObject(nObjectType, sTemplate, lSpawnLocation);
            DebugMode(GetName(oSpawn) + "spawned " + ObjectToString(oSpawned));
            SpawnDelayDebug(oSpawn, "spawned " + ObjectToString(oSpawned));
            RecordSpawned(oSpawn, oSpawned, lHome, lEntranceExit,
               fSpawnFacing);
            SetupSpawned(oSpawn, oSpawned, lHome, nTimeNow, nWalkToHome);
        }
    }
}
//

// This Function Initializes the Flags
void Spawn_InitFlags(object oSpawn, string sSpawnName, string sSpawnTag)
{
    // These are true when certain flags are present, false otherwise

    // Retreive Defaults
    object oModule = GetModule();

    // These have values associated with them, although in some cases value
    // of 0 is treated as a non-existent flag
    int dfProcessFrequency = GetLocalInt(oModule, "df_processFrequency");
    int dfProcessOffset = GetLocalInt(oModule, "df_processOffest");
    int dfInitialState = GetLocalInt(oModule, "df_InitialState");
    int dfInitialDelay = GetLocalInt(oModule, "df_InitialDelay");
    int dfFlagTableNumber = GetLocalInt(oModule, "df_FlagTableNumber");
    int dfSpawnDelay = GetLocalInt(oModule, "df_SpawnDelay");
    int dfDelayMinimum = GetLocalInt(oModule, "df_DelayMinimum");
    int dfSpawnNumber = GetLocalInt(oModule, "df_SpawnNumber");
    int dfSpawnNumberMin = GetLocalInt(oModule, "df_SpawnNumberMin");
    int dfSpawnNumberAtOnce = GetLocalInt(oModule, "df_SpawnNumberAtOnce");
    int dfSpawnNumberAtOnceMin = GetLocalInt(oModule, "df_SpawnNumberAtOnceMin");
    int dfSpawnDayStart = GetLocalInt(oModule, "df_SpawnDayStart");
    int dfSpawnDayEnd = GetLocalInt(oModule, "df_SpawnDayEnd");
    int dfSpawnHourStart = GetLocalInt(oModule, "df_SpawnHourStart");
    int dfSpawnHourEnd = GetLocalInt(oModule, "df_SpawnHourEnd");
    int dfWanderRange = GetLocalInt(oModule, "df_WanderRange");
    int dfReturnHomeRange = GetLocalInt(oModule, "df_ReturnHomeRange");
    int dfPCCheckDelay = GetLocalInt(oModule, "df_PCCheckDelay");
    int dfRandomGold = GetLocalInt(oModule, "df_RandomGold");
    int dfRandomGoldMin = GetLocalInt(oModule, "df_RandomGoldMin");
    int dfGoldChance = GetLocalInt(oModule, "df_GoldChance");
    int dfSpawnEffect = GetLocalInt(oModule, "df_SpawnEffect");
    int dfDespawnEffect = GetLocalInt(oModule, "df_DespawnEffect");
    int dfPatrolRoute = GetLocalInt(oModule, "df_PatrolRoute");
    int dfRouteType = GetLocalInt(oModule, "df_RouteType");
    int dfPlaceableType = GetLocalInt(oModule, "df_PlaceableType");
    int dfTrapDisabled = GetLocalInt(oModule, "df_TrapDisabled");
    int dfPlaceableRefreshPeriod = GetLocalInt(oModule, "df_PlaceableRefreshPeriod");
    int dfLootTable = GetLocalInt(oModule, "df_LootTable");
    int dfLootTable1ItemChance = GetLocalInt(oModule, "df_LootTable1ItemChance");
    int dfLootTable2ItemChance = GetLocalInt(oModule, "df_LootTable2ItemChance");
    int dfLootTable3ItemChance = GetLocalInt(oModule, "df_LootTable3ItemChance");
    int dfDeactivateSpawn = GetLocalInt(oModule, "df_DeactivateSpawn");
    int dfDeactivateScript = GetLocalInt(oModule, "df_DeactivateScript");
    int dfDeactivationInfo = GetLocalInt(oModule, "df_DeactivationInfo");
    int dfChildLifespanMax = GetLocalInt(oModule, "df_ChildLifespanMax");
    int dfChildLifespanMin = GetLocalInt(oModule, "df_ChildLifespanMin");
    int dfSpawnRadius = GetLocalInt(oModule, "df_SpawnRadius");
    int dfSpawnRadiusMin = GetLocalInt(oModule, "df_SpawnRadiusMin");
    int dfSpawnUnseen = GetLocalInt(oModule, "df_SpawnUnseen");
    int dfUnseenRetryCount = GetLocalInt(oModule, "df_dfUnseenRetryCount");
    int dfCorpseDecay = GetLocalInt(oModule, "df_CorpseDecay");
    int dfCorpseDecayType = GetLocalInt(oModule, "df_CorpseDecayType");
    int dfCorpseRemainsType = GetLocalInt(oModule, "df_CorpseRemainsType");
    int dfCampDecay = GetLocalInt(oModule, "df_CampDecay");
    int dfSpawnScript = GetLocalInt(oModule, "df_SpawnScript");
    int dfDespawnScript = GetLocalInt(oModule, "df_DespawnScript");
    int dfDeathScript = GetLocalInt(oModule, "df_DeathScript");
    int dfSpawnCheckCustom = GetLocalInt(oModule, "df_SpawnCheckCustom");
    int dfSpawnCheckPCs = GetLocalInt(oModule, "df_SpawnCheckPCs");
    int dfCheckPCsRadius = GetLocalInt(oModule, "f_CheckPCsRadius");
    int dfSpawnTrigger = GetLocalInt(oModule, "df_SpawnTrigger");
    int dfDespawnTrigger = GetLocalInt(oModule, "df_DespawnTrigger");
    int dfSpawnAreaEffect = GetLocalInt(oModule, "df_SpawnAreaEffect");
    int dfAreaEffectDuration = GetLocalInt(oModule, "df_AreaEffectDuration");
    int dfObjectEffect = GetLocalInt(oModule, "df_ObjectEffect");
    int dfObjectEffectDuration = GetLocalInt(oModule, "df_ObjectEffectDuration");
    int dfRandomSpawn = GetLocalInt(oModule, "df_RandomSpawn");
    int dfSpawnFaction = GetLocalInt(oModule, "df_SpawnFaction");
    int dfSpawnAlignment = GetLocalInt(oModule, "df_SpawnAlignment");
    int dfAlignmentShift = GetLocalInt(oModule, "df_AlignmentShift");
    int dfHeartbeatScript = GetLocalInt(oModule, "df_HeartbeatScript");
    int dfSpawnLocation = GetLocalInt(oModule, "df_SpawnLocation");
    int dfSpawnLocationMin = GetLocalInt(oModule, "df_SpawnLocationMin");
    int dfSpawnFacing = GetLocalInt(oModule, "df_SpawnFacing");
    int dfEntranceExit = GetLocalInt(oModule, "df_EntranceExit");
    int dfEntranceExitMin = GetLocalInt(oModule, "df_EntranceExitMin");
    int dfExit = GetLocalInt(oModule, "df_Exit");
    int dfExitMin = GetLocalInt(oModule, "df_ExitMin");
    int dfHealChildren = GetLocalInt(oModule, "df_HealChildren");
    int dfGlobalSuppressDR = GetLocalInt(oModule, "df_GlobalSuppressDR");
    int dfSuppressDR = GetLocalInt(oModule, "df_SuppressDR");
    int dfEncounterLevel = GetLocalInt(oModule, "df_EncounterLevel");

    DebugMode("Spawn_InitFlags; init flags: " + sSpawnName);
    SetLocalString(oSpawn, "f_Flags", sSpawnName);
    SetLocalString(oSpawn, "f_Template", sSpawnTag);

    DebugMode("Spawn_InitFlags; Initialize FlagTable");
    int nFlagTable = IsFlagPresent(sSpawnName, "_FT");                          DebugMode("Spawn_InitFlags; nFlagTable: "+IntToString(nFlagTable));
    int nFlagTableNumber = GetFlagValue(sSpawnName, "_FT", dfFlagTableNumber);  DebugMode("Spawn_InitFlags; nFlagTableNumber: "+IntToString(nFlagTableNumber));

    if (nFlagTable == TRUE)
    {
        SpawnFlags(oSpawn, nFlagTableNumber);
        if (GetStringLeft(GetLocalString(oSpawn, "f_Flags"), 2) == "SP")
        {
            sSpawnName = GetLocalString(oSpawn, "f_Flags");
        }
        else if (GetStringLeft(GetLocalString(oSpawn, "f_Flags"), 1) == "_")
        {
            sSpawnName = sSpawnName + GetLocalString(oSpawn, "f_Flags");
        }

        SetLocalString(oSpawn, "f_Flags", sSpawnName);
        sSpawnTag = GetLocalString(oSpawn, "f_Template");
    }

    DebugMode("Spawn_InitFlags; Initialize CustomFlag");
    string sCustomFlag;
    int nCustomFlag = IsFlagPresent(sSpawnName, "CF");

    if (nCustomFlag == TRUE)
    {
        sCustomFlag = GetStringRight(sSpawnName, GetStringLength(sSpawnName) -
            (FindSubString(sSpawnName, "CF") + 2));
        sSpawnName = GetStringLeft(sSpawnName, GetStringLength(sSpawnName) -
            (GetStringLength(sCustomFlag) + 3));
        SetLocalString(oSpawn, "f_Flags", sSpawnName);

    }

    DebugMode("Spawn_InitFlags; Record CustomFlag");
    SetLocalString(oSpawn, "f_CustomFlag", sCustomFlag);
    ParseCustomFlags(oSpawn, sCustomFlag);

    DebugMode("Spawn_InitFlags; Initialize Process Frequency");
    int nProcessFrequency = GetFlagValue(sSpawnName, "SP", dfProcessFrequency);
    int nProcessOffset = GetSubFlagValue(sSpawnName, "SP", "O", dfProcessOffset);
    if (nProcessFrequency <= 0)
    {
        nProcessFrequency = 1;
    }

    DebugMode("Spawn_InitFlags; Record Process Frequency");
    SetLocalInt(oSpawn, "f_ProcessFrequency", nProcessFrequency);               DebugMode("Spawn_InitFlags; nProcessFrequency: "+IntToString(GetLocalInt(oSpawn, "f_ProcessFrequency")));
    SetLocalInt(oSpawn, "f_ProcessOffset", nProcessOffset);                     DebugMode("Spawn_InitFlags; f_ProcessOffset: "+IntToString(GetLocalInt(oSpawn, "f_ProcessOffset")));

    DebugMode("Spawn_InitFlags; Initialize InitialState");
    int nInitialState = GetFlagValue(sSpawnName, "IS", dfInitialState);
    int nInitialDelay = GetSubFlagValue(sSpawnName, "IS", "D", dfInitialDelay);
    nInitialDelay *= 60;  // convert to seconds

    DebugMode("Spawn_InitFlags; Record InitialState");
    SetLocalInt(oSpawn, "f_InitialState", nInitialState);
    SetLocalInt(oSpawn, "f_InitialDelay", nInitialDelay);

    DebugMode("Spawn_InitFlags; Initialize SpawnID");
    int nSpawnID = GetFlagValue(sSpawnName, "ID", 0);

    DebugMode("Spawn_InitFlags; Record SpawnID");
    if (nSpawnID > 0)
    {
        SetLocalInt(oSpawn, "SpawnID", nSpawnID);
    }

    DebugMode("Spawn_InitFlags; Initialize SpawnDelay");
    int nSpawnDelay = GetFlagValue(sSpawnName, "SD", dfSpawnDelay);
    nSpawnDelay *= 60;  // convert to seconds
    int nDelayRandom = IsSubFlagPresent(sSpawnName, "SD", "M");
    int nDelayMinimum = GetSubFlagValue(sSpawnName, "SD", "M", dfDelayMinimum);
    nDelayMinimum *= 60; // convert to seconds
    int nSpawnDelayPeriodic = IsSubFlagPresent(sSpawnName, "SD", "P");

    if (nDelayMinimum > nSpawnDelay)
    {
        nDelayRandom = FALSE;
        nDelayMinimum = 0;
    }

    DebugMode("Spawn_InitFlags; Record SpawnDelay");
    SetLocalInt(oSpawn, "f_SpawnDelay", nSpawnDelay);
    SetLocalInt(oSpawn, "f_DelayRandom", nDelayRandom);
    SetLocalInt(oSpawn, "f_DelayMinimum", nDelayMinimum);
    SetLocalInt(oSpawn, "f_SpawnDelayPeriodic", nSpawnDelayPeriodic);

    DebugMode("Spawn_InitFlags; Initialize SpawnNumber");
    int nSpawnNumber = GetFlagValue(sSpawnName, "SN", dfSpawnNumber);                   DebugMode("nSpawnNumber: "+IntToString(nSpawnNumber));
    int nSpawnNumberMax = nSpawnNumber;
    int nSpawnNumberMin = GetSubFlagValue(sSpawnName, "SN", "M", dfSpawnNumberMin);
    int nSpawnAllAtOnce = IsFlagPresent(sSpawnName, "SA");
    int nSpawnNumberAtOnce = GetFlagValue(sSpawnName, "SA", dfSpawnNumberAtOnce);
    int nSpawnNumberAtOnceMin = GetSubFlagValue(sSpawnName, "SA", "M",
       dfSpawnNumberAtOnceMin);

    if (nSpawnNumberMin > nSpawnNumber)
    {
        nSpawnNumberMin = -1;
    }
    if (nSpawnNumberMin > -1)
    {
        int nRndSpawnNumber = Random(nSpawnNumberMax + 1);
        while (nRndSpawnNumber < nSpawnNumberMin)
        {
            nRndSpawnNumber = Random(nSpawnNumberMax + 1);
        }
        nSpawnNumber = nRndSpawnNumber;
    }

    if (nSpawnNumberAtOnce == 1)
    {
        nSpawnAllAtOnce = FALSE;
    }
    if (nSpawnNumberAtOnceMin > nSpawnNumberAtOnce)
    {
        nSpawnNumberAtOnceMin = 0;
    }

    DebugMode("Spawn_InitFlags; Record SpawnNumber");
    SetLocalInt(oSpawn, "f_SpawnNumber", nSpawnNumber);
    SetLocalInt(oSpawn, "f_SpawnNumberMin", nSpawnNumberMin);
    SetLocalInt(oSpawn, "f_SpawnNumberMax", nSpawnNumberMax);
    SetLocalInt(oSpawn, "f_SpawnAllAtOnce", nSpawnAllAtOnce);
    SetLocalInt(oSpawn, "f_SpawnNumberAtOnce", nSpawnNumberAtOnce);
    SetLocalInt(oSpawn, "f_SpawnNumberAtOnceMin", nSpawnNumberAtOnceMin);

    // Initialize Day/Night Only
    int nDayOnly = IsFlagPresent(sSpawnName, "DO");
    int nDayOnlyDespawn = IsSubFlagPresent(sSpawnName, "DO", "D");
    int nNightOnly = IsFlagPresent(sSpawnName, "NO");
    int nNightOnlyDespawn = IsSubFlagPresent(sSpawnName, "NO", "D");

    // Record Day/Night Only
    SetLocalInt(oSpawn, "f_DayOnly", nDayOnly);
    SetLocalInt(oSpawn, "f_DayOnlyDespawn", nDayOnlyDespawn);
    SetLocalInt(oSpawn, "f_NightOnly", nNightOnly);
    SetLocalInt(oSpawn, "f_NightOnlyDespawn", nNightOnlyDespawn);

    // Initialize Day/Hour Spawns
    int nSpawnDayStart = GetFlagValue(sSpawnName, "DY", dfSpawnDayStart);
    int nSpawnDayEnd = GetSubFlagValue(sSpawnName, "DY", "T", dfSpawnDayEnd);
    if (nSpawnDayEnd > nSpawnDayStart)
    {
        nSpawnDayEnd = -1;
    }
    int nSpawnHourStart = GetFlagValue(sSpawnName, "HR", dfSpawnHourStart);
    int nSpawnHourEnd = GetSubFlagValue(sSpawnName, "HR", "T", dfSpawnHourEnd);
    if (nSpawnHourStart > nSpawnHourEnd)
    {
        nSpawnHourEnd = -1;
    }

    // Record Day/Hour Spawns
    SetLocalInt(oSpawn, "f_SpawnDayStart", nSpawnDayStart);
    SetLocalInt(oSpawn, "f_SpawnDayEnd", nSpawnDayEnd);
    SetLocalInt(oSpawn, "f_SpawnHourStart", nSpawnHourStart);
    SetLocalInt(oSpawn, "f_SpawnHourEnd", nSpawnHourEnd);

    // Initialize RandomWalk
    int nRandomWalk = IsFlagPresent(sSpawnName, "RW");
    float fWanderRange = IntToFloat(GetSubFlagValue(sSpawnName, "RW", "R", dfWanderRange));

    // Record RandomWalk
    SetLocalInt(oSpawn, "f_RandomWalk", nRandomWalk);
    SetLocalFloat(oSpawn, "f_WanderRange", fWanderRange);

    // Initialize ReturnHome
    int nReturnHome = IsFlagPresent(sSpawnName, "RH");
    float fReturnHomeRange = IntToFloat(GetFlagValue(sSpawnName, "RH", dfReturnHomeRange));

    // Record ReturnHome
    SetLocalInt(oSpawn, "f_ReturnHome", nReturnHome);
    SetLocalFloat(oSpawn, "f_ReturnHomeRange", fReturnHomeRange);

    // Initialize PCCheck
    int nPCCheck = IsFlagPresent(sSpawnName, "PC");
    int nPCCheckDelay = GetFlagValue(sSpawnName, "PC", dfPCCheckDelay);
    nPCCheckDelay *= 60; // convert to seconds
    int nPCReset = IsSubFlagPresent(sSpawnName, "PC", "R");

    // Record PCCheck
    SetLocalInt(oSpawn, "f_PCCheck", nPCCheck);
    SetLocalInt(oSpawn, "f_PCCheckDelay", nPCCheckDelay);
    SetLocalInt(oSpawn, "f_PCReset", nPCReset);

    // Initialize RandomGold
    int nRandomGold = GetFlagValue(sSpawnName, "RG", dfRandomGold);
    int nRandomGoldMin = GetSubFlagValue(sSpawnName, "RG", "M", dfRandomGoldMin);
    int nGoldChance = GetSubFlagValue(sSpawnName, "RG", "C", dfGoldChance);

    // Record RandomGold
    SetLocalInt(oSpawn, "f_RandomGold", nRandomGold);
    SetLocalInt(oSpawn, "f_RandomGoldMin", nRandomGoldMin);
    SetLocalInt(oSpawn, "f_GoldChance", nGoldChance);

    // Initialize SpawnEffects
    int nSpawnEffect = GetFlagValue(sSpawnName, "FX", dfSpawnEffect);
    int nDespawnEffect = GetSubFlagValue(sSpawnName, "FX", "D", dfDespawnEffect);

    // Record SpawnEffects
    SetLocalInt(oSpawn, "f_SpawnEffect", nSpawnEffect);
    SetLocalInt(oSpawn, "f_DespawnEffect", nDespawnEffect);

    // Initialize PatrolRoutes
    int nPatrolRoute = GetFlagValue(sSpawnName, "PR",  dfPatrolRoute);
    int nRouteType = GetSubFlagValue(sSpawnName, "PR", "T", dfRouteType);
    int nStartAtClosest = IsSubFlagPresent(sSpawnName, "PR", "C");

    // Record PatrolRoutes
    SetLocalInt(oSpawn, "f_PatrolRoute", nPatrolRoute);
    SetLocalInt(oSpawn, "f_RouteType", nRouteType);
    SetLocalInt(oSpawn, "f_PatrolStartAtClosest", nStartAtClosest);

    // Initialize Placeables
    int nPlaceable = IsFlagPresent(sSpawnName, "PL");
    int nPlaceableType = GetFlagValue(sSpawnName, "PL", dfPlaceableType);
    int nTrapDisabled = GetSubFlagValue(sSpawnName, "PL", "T",  dfTrapDisabled);
    int nPlaceableRefreshPeriod = GetSubFlagValue(sSpawnName, "PL",  "P",  dfPlaceableRefreshPeriod);
    nPlaceableRefreshPeriod *= 60; // convert to seconds

    // Record Placeables
    SetLocalInt(oSpawn, "f_Placeable", nPlaceable);
    SetLocalInt(oSpawn, "f_PlaceableType", nPlaceableType);
    SetLocalInt(oSpawn, "f_TrapDisabled", nTrapDisabled);
    SetLocalInt(oSpawn, "f_PlaceableRefreshPeriod", nPlaceableRefreshPeriod);

    // Initialize SpawnGroups
    int nSpawnGroup = IsFlagPresent(sSpawnName, "SG");

    // Record SpawnGroups
    SetLocalInt(oSpawn, "f_SpawnGroup", nSpawnGroup);

    // Initialize LootTable
    int nLootTable = GetFlagValue(sSpawnName, "LT", dfLootTable);
    int nLootTable1ItemChance = GetSubFlagValue(sSpawnName, "LT", "A", dfLootTable1ItemChance);
    int nLootTable2ItemChance = GetSubFlagValue(sSpawnName, "LT", "B", dfLootTable2ItemChance);
    int nLootTable3ItemChance = GetSubFlagValue(sSpawnName, "LT", "C", dfLootTable3ItemChance);

    if (nLootTable1ItemChance > 100) nLootTable1ItemChance = 100;
    if (nLootTable2ItemChance > 100) nLootTable2ItemChance = 100;
    if (nLootTable3ItemChance > 100) nLootTable3ItemChance = 100;

    // Record LootTable
    SetLocalInt(oSpawn, "f_LootTable", nLootTable);
    SetLocalInt(oSpawn, "f_LootTable1ItemChance", nLootTable1ItemChance);
    SetLocalInt(oSpawn, "f_LootTable2ItemChance", nLootTable2ItemChance);
    SetLocalInt(oSpawn, "f_LootTable3ItemChance", nLootTable3ItemChance);

    // Initialize SpawnDeactivation
    int nDeactivateSpawn = GetFlagValue(sSpawnName, "DS", dfDeactivateSpawn);
    int nDeactivateScript = GetSubFlagValue(sSpawnName, "DS", "S", dfDeactivateScript);
    int nDeactivationInfo = GetFlagValue(sSpawnName, "DI", dfDeactivationInfo);

    // Record SpawnDeactivations
    SetLocalInt(oSpawn, "f_DeactivateSpawn", nDeactivateSpawn);
    SetLocalInt(oSpawn, "f_DeactivateScript", nDeactivateScript);

    if (nDeactivateSpawn == 4)
    {
        nDeactivationInfo *= 60; // convert minutes to seconds
    }
    else if (nDeactivateSpawn == 5)
    {
        nDeactivationInfo *= 6; // convert cycles to seconds
    }

    SetLocalInt(oSpawn, "f_DeactivationInfo", nDeactivationInfo);

    // Initialize ChildLifespan
    int nChildLifespanMax = GetFlagValue(sSpawnName, "CL", dfChildLifespanMax);
    nChildLifespanMax *= 60;  // convert to seconds
    int nChildLifespanMin = GetSubFlagValue(sSpawnName, "CL", "M", dfChildLifespanMin);
    nChildLifespanMin *= 60; // convert to seconds
    if (nChildLifespanMin > nChildLifespanMax)
    {
        nChildLifespanMin = -1;
    }

    // Record ChildLifespan
    SetLocalInt(oSpawn, "f_ChildLifespanMax", nChildLifespanMax);
    SetLocalInt(oSpawn, "f_ChildLifespanMin", nChildLifespanMin);

    // Initialize SpawnRadius
    float fSpawnRadius = IntToFloat(GetFlagValue(sSpawnName, "SR", dfSpawnRadius));
    float fSpawnRadiusMin = IntToFloat(GetSubFlagValue(sSpawnName, "SR", "M", dfSpawnRadiusMin));
    int nSpawnNearPCs = IsSubFlagPresent(sSpawnName, "SR", "P");
    if (fSpawnRadiusMin > fSpawnRadius)
    {
        fSpawnRadiusMin = 0.0;
    }

    // Record SpawnRadius
    SetLocalFloat(oSpawn, "f_SpawnRadius", fSpawnRadius);
    SetLocalFloat(oSpawn, "f_SpawnRadiusMin", fSpawnRadiusMin);
    SetLocalInt(oSpawn, "f_SpawnNearPCs", nSpawnNearPCs);

    // Initialize SpawnUnseen
    float fSpawnUnseen = IntToFloat(GetFlagValue(sSpawnName, "SU", dfSpawnUnseen));

    int nUnseenIndividual = IsSubFlagPresent(sSpawnName, "SU", "I");
    int nUnseenRetryCount = GetSubFlagValue(sSpawnName, "SU", "I", dfUnseenRetryCount);

    // Record SpawnUnseen
    SetLocalFloat(oSpawn, "f_SpawnUnseen", fSpawnUnseen);
    SetLocalInt(oSpawn, "f_UnseenIndividual", nUnseenIndividual);
    SetLocalInt(oSpawn, "f_UnseenRetryCount", nUnseenRetryCount);

    // Initialize CorpseDecay
    float fCorpseDecay = IntToFloat(GetFlagValue(sSpawnName, "CD", dfCorpseDecay));
    int nCorpseDecayType = GetSubFlagValue(sSpawnName, "CD", "T", dfCorpseDecayType);
    int nCorpseRemainsType = GetSubFlagValue(sSpawnName, "CD", "R", dfCorpseRemainsType);
    int bDropWielded = IsSubFlagPresent(sSpawnName, "CD", "D");

    string sCorpseRemainsResRef;
    int bDeleteLootOnDecay = FALSE;

    switch (nCorpseRemainsType)
    {
        case 0: sCorpseRemainsResRef = "invis_corpse_obj"; break;
        case 1: sCorpseRemainsResRef = "invis_corpse_bdy"; break;
        case 2: sCorpseRemainsResRef = "invis_corpse_bon"; break;
        case 3: sCorpseRemainsResRef = "invis_corpse_pot"; break;
        case 4: sCorpseRemainsResRef = "invis_corpse_pch"; break;
        case 5: sCorpseRemainsResRef = "invis_corpse_scr"; break;
        case 6: sCorpseRemainsResRef = "invis_corpse_tre"; break;
        case 7:
            sCorpseRemainsResRef = "invis_corpse_obj";
            bDeleteLootOnDecay = TRUE;
            break;
    }

    // Record CorpseDecay
    SetLocalFloat(oSpawn, "f_CorpseDecay", fCorpseDecay);
    SetLocalInt(oSpawn, "f_CorpseDecayType", nCorpseDecayType);
    SetLocalString(oSpawn, "f_CorpseRemainsResRef", sCorpseRemainsResRef);
    SetLocalInt(oSpawn, "f_CorpseDropWielded", bDropWielded);
    SetLocalInt(oSpawn, "f_CorpseDeleteLootOnDecay", bDeleteLootOnDecay);

    // Initialize SpawnCamp
    int nSpawnCamp = IsFlagPresent(sSpawnName, "CM");
    float fCampDecay = IntToFloat(GetSubFlagValue(sSpawnName, "CM", "D", dfCampDecay));

    // Record SpawnCamp
    SetLocalInt(oSpawn, "f_SpawnCamp", nSpawnCamp);
    SetLocalFloat(oSpawn, "f_CampDecay", fCampDecay);

    // Initialize Spawn Scripts
    int nSpawnScript = GetFlagValue(sSpawnName, "SS", dfSpawnScript);
    int nDespawnScript = GetSubFlagValue(sSpawnName, "SS", "D", dfDespawnScript);

    // Record Spawn Scripts
    SetLocalInt(oSpawn, "f_SpawnScript", nSpawnScript);
    SetLocalInt(oSpawn, "f_DespawnScript", nDespawnScript);

    // Initialize Death Scripts
    int nDeathScript = GetFlagValue(sSpawnName, "DT", dfDeathScript);

    // Record Death Scripts
    SetLocalInt(oSpawn, "f_DeathScript", nDeathScript);

    // Initialize SpawnCheckCustom
    int nSpawnCheckCustom = GetFlagValue(sSpawnName, "CC", dfSpawnCheckCustom);

    // Record SpawnCheckCustom
    SetLocalInt(oSpawn, "f_SpawnCheckCustom", nSpawnCheckCustom);

    // Initialize SpawnCheckPCs
    int nSpawnCheckPCs = GetFlagValue(sSpawnName, "CP", dfSpawnCheckPCs);
    float fCheckPCsRadius = IntToFloat(GetSubFlagValue(sSpawnName, "CP", "R", dfCheckPCsRadius));

    // Record SpawnCheckPCs
    SetLocalInt(oSpawn, "f_SpawnCheckPCs", nSpawnCheckPCs);
    SetLocalFloat(oSpawn, "f_CheckPCsRadius", fCheckPCsRadius);

    // Intialize SpawnTrigger
    float fSpawnTrigger = IntToFloat(GetFlagValue(sSpawnName, "TR", dfSpawnTrigger));
    float fDespawnTrigger = IntToFloat(GetSubFlagValue(sSpawnName, "TR", "D", dfDespawnTrigger));

    // Record SpawnTrigger
    SetLocalFloat(oSpawn, "f_SpawnTrigger", fSpawnTrigger);
    SetLocalFloat(oSpawn, "f_DespawnTrigger", fDespawnTrigger);

    // Initialize AreaEffect
    int nSpawnAreaEffect = GetFlagValue(sSpawnName, "AE", dfSpawnAreaEffect);
    float fAreaEffectDuration = IntToFloat(GetSubFlagValue(sSpawnName, "AE", "D", dfAreaEffectDuration));

    // Record AreaEffect
    SetLocalInt(oSpawn, "f_SpawnAreaEffect", nSpawnAreaEffect);
    SetLocalFloat(oSpawn, "f_AreaEffectDuration", fAreaEffectDuration);

    // Initialize ObjectEffect
    int nObjectEffect = GetFlagValue(sSpawnName, "OE", dfObjectEffect);
    float fObjectEffectDuration = IntToFloat(GetSubFlagValue(sSpawnName, "OE", "D", dfObjectEffectDuration));
    if (fObjectEffectDuration == 0.0)
    {
        fObjectEffectDuration = -1.0;
    }

    // Record ObjectEffect
    SetLocalInt(oSpawn, "f_ObjectEffect", nObjectEffect);
    SetLocalFloat(oSpawn, "f_ObjectEffectDuration", fObjectEffectDuration);

    // Initialize RandomSpawn
    int nRandomSpawn = GetFlagValue(sSpawnName, "RS", dfRandomSpawn);

    // Record RandomSpawn
    SetLocalInt(oSpawn, "f_RandomSpawn", nRandomSpawn);

    // Initialize SpawnFaction
    int nSpawnFaction = GetFlagValue(sSpawnName, "FC", dfSpawnFaction);

    // Record SpawnFaction
    SetLocalInt(oSpawn, "f_SpawnFaction", nSpawnFaction);

    // Initialize SpawnAlignment
    int nSpawnAlignment = GetFlagValue(sSpawnName, "AL", dfSpawnAlignment);
    int nAlignmentShift = GetSubFlagValue(sSpawnName, "AL", "S", dfAlignmentShift);

    // Record SpawnAlignment
    SetLocalInt(oSpawn, "f_SpawnAlignment", nSpawnAlignment);
    SetLocalInt(oSpawn, "f_AlignmentShift", nAlignmentShift);

    // Initialize Heartbeat
    int nHeartbeatScript = GetFlagValue(sSpawnName, "HB", dfHeartbeatScript);

    // Record HeartBeat
    SetLocalInt(oSpawn, "f_HeartbeatScript", nHeartbeatScript);

    // Initialize SpawnLocation
    int nSpawnLocation = GetFlagValue(sSpawnName, "SL", dfSpawnLocation);
    int nSpawnLocationMin = GetSubFlagValue(sSpawnName, "SL", "R", dfSpawnLocationMin);
    int nSpawnLocationInd = IsSubFlagPresent(sSpawnName, "SL", "I");
    if (nSpawnLocationMin > nSpawnLocation)
    {
        nSpawnLocationMin = -1;
    }

    // Record SpawnLocation
    SetLocalInt(oSpawn, "f_SpawnLocation", nSpawnLocation);
    SetLocalInt(oSpawn, "f_SpawnLocationMin", nSpawnLocationMin);
    SetLocalInt(oSpawn, "f_SpawnLocationInd", nSpawnLocationInd);

    // Initialize SpawnFacing
    float fSpawnFacing;
    int nSpawnFacing = IsFlagPresent(sSpawnName, "SF");
    if (nSpawnFacing == TRUE)
    {
        fSpawnFacing = GetFacingFromLocation(GetLocation(oSpawn));
    }
    else
    {
        // If f_Facing is false, fSpawnFacing is now calculated for
        // each individual creature
        fSpawnFacing = 0.0;
        // fSpawnFacing = IntToFloat(Random(360));
    }

    // Record SpawnFacing
    SetLocalInt(oSpawn, "f_Facing", nSpawnFacing);
    SetLocalFloat(oSpawn, "f_SpawnFacing", fSpawnFacing);

    // Initialize EntranceExit
    int nEntranceExit = GetFlagValue(sSpawnName, "EE", dfEntranceExit);
    int nEntranceExitMin = GetSubFlagValue(sSpawnName, "EE", "R", dfEntranceExitMin);
    if (nEntranceExitMin > nEntranceExit)
    {
        nEntranceExitMin = -1;
    }
    int nExit = GetFlagValue(sSpawnName, "EX", dfExit);
    int nExitMin = GetSubFlagValue(sSpawnName, "EX", "R", dfExitMin);
    if (nExitMin > nExit)
    {
        nExitMin = -1;
    }

    // Record EntranceExit
    SetLocalInt(oSpawn, "f_EntranceExit", nEntranceExit);
    SetLocalInt(oSpawn, "f_EntranceExitMin", nEntranceExitMin);
    SetLocalInt(oSpawn, "f_Exit", nExit);
    SetLocalInt(oSpawn, "f_ExitMin", nExitMin);

    // Initialize HealChildren
    int nHealChildren = GetFlagValue(sSpawnName, "HL", dfHealChildren);
    int nHealEffects = IsSubFlagPresent(sSpawnName, "HL", "E");
    if (nHealChildren == 1)
    {
        nHealChildren == 100;
    }

    // Record HealChildren
    SetLocalInt(oSpawn, "f_HealChildren", nHealChildren);
    SetLocalInt(oSpawn, "f_HealEffects", nHealEffects);

    // Initialize SpawnItem
    int nSpawnItem = IsFlagPresent(sSpawnName, "IT");

    // Record SpawnItem
    SetLocalInt(oSpawn, "f_SpawnItem", nSpawnItem);

    // Initialize SpawnSit
    int nSpawnSit = IsFlagPresent(sSpawnName, "ST");

    // Record SpawnSit
    SetLocalInt(oSpawn, "f_SpawnSit", nSpawnSit);

    // Initialize SpawnPlot
    int nSpawnPlot = IsFlagPresent(sSpawnName, "PT");

    // Record SpawnPlot
    SetLocalInt(oSpawn, "f_SpawnPlot", nSpawnPlot);

    // Initialize SpawnMerchant
    int nSpawnMerchant = IsFlagPresent(sSpawnName, "SM");

    // Record SpawnMerchant
    SetLocalInt(oSpawn, "f_SpawnMerchant", nSpawnMerchant);

    // Initialize Dim Returns Suppression
    int nSuppressDimReturns = IsFlagPresent(sSpawnName, "SX");

    if (nSuppressDimReturns)
    {
      // If the flag is present, get suppression mode from its value
      nSuppressDimReturns = GetFlagValue(sSpawnName, "SX", dfSuppressDR);
    }

    else
    {
      // Use the global setting
      nSuppressDimReturns = dfGlobalSuppressDR;
    }

    // Record Dim Returns Suppression
    SetLocalInt(oSpawn, "f_SuppressDimReturns", nSuppressDimReturns);

    // Initialize Loot Suppression
    int nSuppressLooting = IsFlagPresent(sSpawnName, "NL");

    // Record Loot Suppression
    SetLocalInt(oSpawn, "f_SuppressLooting", nSuppressLooting);

    // Initialize Subdual Mode
    int nSubdualMode = IsFlagPresent(sSpawnName, "SB");

    // Record Subdual Mode
    SetLocalInt(oSpawn, "f_SubdualMode", nSubdualMode);

    int nEncounterLevel;

    // Initialize Encounter Level
    if (IsFlagPresent(sSpawnName, "EL"))
    {
      nEncounterLevel = GetFlagValue(sSpawnName, "EL", dfEncounterLevel);
      SetLocalInt(oSpawn, "f_EncounterLevel", nEncounterLevel);
    }

    // Record Flags Initialized
    SetLocalInt(oSpawn, "FlagsInitialized", TRUE);
}
//
