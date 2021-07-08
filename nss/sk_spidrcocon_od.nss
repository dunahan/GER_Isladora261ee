//:  sk_spidrcocon_od
#include "nw_i0_2q4luskan"


void main()
{ int nRoll = d100();

  if (nRoll >= 5 && nRoll <= 7)
  { int iCount;
    location lTarg = GetLocation( OBJECT_SELF );
    string sResRef = GetLocalString(OBJECT_SELF, "ResRef");
    for ( iCount = 5; iCount > 0; iCount-- )
    { CreateObjectVoid(OBJECT_TYPE_CREATURE, sResRef, lTarg); } }
}

