// Henchmen Always Bleed to Death
// By Demetrious, OldManWhistler and IntrepidCW
//
// PLEASE READ "habd_include" FOR MORE INFORMATION.
//
// AddOn fuer HABD

#include "habd_include"
#include "_isla_inc"
#include "NW_I0_GENERIC"

void main()
{
  object oPC=GetPCSpeaker();
    if (oPC == OBJECT_INVALID)
        oPC = GetLastUsedBy();

  string       sID = GetPCPlayerName(oPC)+GetName(oPC);
  int       iState = HABDGetHABD_PLAYER_STATE(sID,oPC);
  object oDeadBody = GetObjectByTag( "Clone_" + sID );

  // location locDeadBody = HABDLoadPCLocationFromDB(GetPCPlayerName(oPC), GetName(oPC));
  location locDeadBody = GetLocation(oDeadBody);

  if ( iState == HABD_STATE_PLAYER_ALIVE )
  {
    AssignCommand( oDeadBody, SetIsDestroyable(TRUE,FALSE,FALSE));
    DestroyObject( oDeadBody );
    DelayCommand ( 1.0, AssignCommand( oPC, JumpToLocation (locDeadBody) ) );
  }

}
