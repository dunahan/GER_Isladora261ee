#include "_isla_inc"

void main()
{
  string sKey = "key_gasthaus";
  object oPC = GetEnteringObject();
  object oDestroy = GetItemPossessedBy(oPC, sKey);

  if ( GetIsObjectValid(oDestroy) == TRUE )
    DestroyObject(oDestroy, 0.1);

}
