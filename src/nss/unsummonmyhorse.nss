///////////////////////////////////////////////////////////////////////////////
// unSummon your horse
///////////////////////////////////////////////////////////////////////////////
#include "x3_inc_horse"


void main()
{
  object          oPC = GetItemActivator();
  object  oHorseToken = GetItemActivated();
  string sHorseResRef = GetLocalString(oHorseToken, "HorseResRef");
  string     sHorseID = GetName(oPC) + GetPCPublicCDKey(oPC);
  location      locPC = GetLocation(oPC);
  location   locHorse = GetItemActivatedTargetLocation();
//object       oHorse = HorseCreateHorse(sHorseResRef, locPC, oPC, sHorseID);

  RemoveHenchman(oPC);
  DestroyObject(OBJECT_SELF, 1.0);
  SetLocalInt(oHorseToken, "Active", 0);
}
