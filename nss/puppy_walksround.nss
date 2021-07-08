void main()
{
  object oOwner = GetLocalObject(OBJECT_SELF, "SearchFor");
  object oPC = GetFirstPC();

  if (GetIsObjectValid(oPC) == TRUE
   && oPC == oOwner ) {
    if (GetDistanceToObject(oPC) <= 15.0)
      ActionForceFollowObject(oPC);
    else
      ActionJumpToObject(oPC, FALSE); }

  else
    GetNextPC();
}
