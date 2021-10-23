/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_ta_cowchic
//
//  Desc:  Alters the greeting text to denote whether
//         the animal has consumed enough food to
//         produce its resource.
//
//  Author: David Bobeck 24Dec02
//
/////////////////////////////////////////////////////////
int StartingConditional()
{
  SetCustomToken(500, "\n");

  int nFoodPoints = GetLocalInt(OBJECT_SELF, "nCnrFoodPoints");

  if (GetTag(OBJECT_SELF) == "cnrChicken")
  {
    if (nFoodPoints >= 6)
    {
      SetCustomToken(22020, "Das Huhn sieht gut gefüttert aus. Es sieht so aus als wenn man ein Ei bekommen könnte!");
    }
    else
    {
      SetCustomToken(22020, "Das Huhn sieht hungrig aus und sollte gefüttert werden. Man kann im Moment keine Eier bekommen.");
    }
  }
  if (GetTag(OBJECT_SELF) == "cnrCow")
  {
    if (nFoodPoints >= 6)
    {
      SetCustomToken(22020, "Die Kuh sieht gut gefüttert aus. Es sieht so aus als wenn man Milch bekommen könnte!");
    }
    else
    {
      SetCustomToken(22020, "Die Kuh ist hungrig und sollte gefüttert werden. Man kann im Moment keine Milch bekommen.");
    }
  }

  // Always show something
  return TRUE;
}
