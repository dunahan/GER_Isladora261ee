/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_bird_ondeath
//
//  Desc:  The OnDeath handler for birds that drop
//         feathers. Bird/feather pairs are configured
//         in cnr_source_init.
//
//  Author: David Bobeck 26Mar03
//
/////////////////////////////////////////////////////////

#include "nw_i0_2q4luskan"

void main()
{
  object       oArea = GetArea        (OBJECT_SELF);
  object   oAttacker = GetLastAttacker(OBJECT_SELF);
  location  locDeath = GetLocation    (OBJECT_SELF);
  float       fDelay = GetLocalFloat  (OBJECT_SELF, "fDelay");
  string    sBirdTag = GetTag         (OBJECT_SELF);
  string    sBirdRes = GetResRef      (OBJECT_SELF);

  if ( fDelay == 0.0 ) { fDelay = 120.0; }

  CreateObject(OBJECT_TYPE_ITEM, "cnrfeathers", locDeath, FALSE);

  //object oBird = CreateObject(OBJECT_TYPE_CREATURE, sBirdRes, locDeath);
  AssignCommand(oArea, DelayCommand(fDelay, CreateObjectVoid(OBJECT_TYPE_CREATURE, sBirdRes, locDeath)));

  object oBird = GetNearestObjectByTag(sBirdTag);
  AdjustReputation(oBird, oAttacker, 50);
//  DelayCommand(fDelay, oBird);
}
