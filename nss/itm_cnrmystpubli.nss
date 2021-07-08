#include "nw_i0_2q4luskan"

void main()
{
  if (GetIsPC(GetItemActivator()) != FALSE)
    CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "cnrmystpublic", GetItemActivatedTargetLocation());
}
