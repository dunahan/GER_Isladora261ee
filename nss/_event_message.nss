#include "_debugisla"

void main()
{
  object oPC = GetEnteringObject();

  if (GetLocalInt(oPC, GetTag(OBJECT_SELF)) == 0)
  {
    string sTlk = GetLocalString(OBJECT_SELF, "Tlk");
    FloatingTextStringOnCreature(sTlk, oPC, FALSE);
    SetLocalInt(oPC, GetTag(OBJECT_SELF), 1);
  }
}


