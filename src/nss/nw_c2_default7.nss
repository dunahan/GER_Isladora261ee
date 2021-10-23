//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT7
/*
  Default OnDeath event handler for NPCs.

  Adjusts killer's alignment if appropriate and
  alerts allies to our death.
 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/22/2002
//:://////////////////////////////////////////////////
//:://////////////////////////////////////////////////
//:: Modified By: Deva Winblood
//:: Modified On: April 1st, 2008
//:: Added Support for Dying Wile Mounted
//:://///////////////////////////////////////////////

#include "x2_inc_compon"
#include "x0_i0_spawncond"
#include "x3_inc_horse"
#include "nw_i0_2q4luskan"

void main()
{
    location locDeath = GetLocation(OBJECT_SELF);

    //Scareface XP Table
    ExecuteScript("sf_xp", OBJECT_SELF);

    int nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    object oKiller = GetLastKiller();

    if (GetLocalInt(GetModule(),"X3_ENABLE_MOUNT_DB")&&GetIsObjectValid(GetMaster(OBJECT_SELF))) SetLocalInt(GetMaster(OBJECT_SELF),"bX3_STORE_MOUNT_INFO",TRUE);

    /*if (GetRacialType(OBJECT_SELF) == RACIAL_TYPE_ANIMAL) // pruefe ob Tier und wenn ja, ob es ein Vogel ist
    { if ( (GetResRef(OBJECT_SELF) == "nw_chicken")    || (GetResRef(OBJECT_SELF) == "nw_raptor001") ||
           (GetResRef(OBJECT_SELF) == "nw_parrot")     || (GetResRef(OBJECT_SELF) == "nw_raven")     ||
           (GetResRef(OBJECT_SELF) == "nw_seagullfly") || (GetResRef(OBJECT_SELF) == "nw_seagullwalk") )
      { CreateObject(OBJECT_TYPE_ITEM, "cnrfeathers", locDeath); }      // spawne Federn
      else                                                              // kein Vogel, also
      { CreateObject(OBJECT_TYPE_ITEM, "hw_resleath", locDeath); }      // spawne Leder
    }*/

    // If we're a good/neutral commoner,
    // adjust the killer's alignment evil
    if(nClass > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL))
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);

    // Call to allies to let them know we're dead
    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);

    //Shout Attack my target, only works with the On Spawn In setup
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);

    // NOTE: the OnDeath user-defined event does not
    // trigger reliably and should probably be removed
    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
         SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }
    // craft_drop_items(oKiller);
}
