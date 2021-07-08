/*
As included in the nwnee_release_notes_final.pdf as
OnClientLeave event is now called before the
creature is physically removed from the area,
instead of after, to allow scripting to determine the
creature’s position as it leaves.
*/

#include "_isla_inc"
#include "habd_include"
#include "shifter_inc"
#include "tele_inc"

void main()
{
  object oPC = GetExitingObject();
  if (!GetIsObjectValid(oPC))
    oPC = OBJECT_SELF;

  object oItem = GetItemPossessedBy(oPC, ITEMFORPOSITIONS);

  if (IsShifterMorphed(oPC) == TRUE || ShifterIsInForm(oPC) == TRUE )
    ResetAppearance(oPC);

  if (GetLocalInt(GetArea(oPC), "NoSave") == 0 && GetLocalInt(oPC, "SaveOnExit") == 0)
    SetLocalLocationOverride(oPC, TELEARRAY, oItem);

  HABDSetDBOnClientLeave(GetName(oPC));

  DelayCommand(60.0, SleepMode());
  StopPlayerTracking(oPC);
}
