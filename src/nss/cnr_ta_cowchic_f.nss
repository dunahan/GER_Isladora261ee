/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_ta_cowchic_f
//
//  Desc:  Checks if the the animal has eaten enough
//         to produce food.
//
//  Author: David Bobeck 24Dec02
//
/////////////////////////////////////////////////////////
int StartingConditional()
{
  if (GetTag(OBJECT_SELF) == "cnrChicken")
  {
    SetCustomToken(22021, "ein Ei");
  }
  if (GetTag(OBJECT_SELF) == "cnrCow")
  {
    SetCustomToken(22021, "etwas Milch");
  }

  int nFoodPoints = GetLocalInt(OBJECT_SELF, "nCnrFoodPoints");
  return (nFoodPoints >= 6);
}
