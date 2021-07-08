void EatFeed(object oItem, int nPoints)
{
  // We must check the item because other cows may have
  // reached and eaten the feed first.
  if (GetIsObjectValid(oItem))
  {
    DestroyObject(oItem);
    int nFoodPoints = GetLocalInt(OBJECT_SELF, "nCnrFoodPoints") + nPoints;
    SetLocalInt(OBJECT_SELF, "nCnrFoodPoints", nFoodPoints);

    if (nFoodPoints >= 6)
    {
      if (GetResRef(OBJECT_SELF) == "cnrchicken")
        ActionDoCommand(PlaySound("as_an_chickens1"));

      else if (GetResRef(OBJECT_SELF) == "cnrcow")
        ActionDoCommand(PlaySound("as_an_cow1"));
    }
  }
}

void main()
{
  string sTag = "cnrCornRaw";
  int nFoodPoints = 2;

  object oPC = GetPCSpeaker();
  object oItem = GetItemPossessedBy(oPC, sTag);

  EatFeed(oItem, nFoodPoints);
}
