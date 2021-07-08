#include "nw_i0_plot"

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
  int nEvent = GetUserDefinedEventNumber(), nFoodPoints = 2;
  object oPC = GetLastPerceived(), oItem;
  string sTag = "cnrCornRaw";

  if (nEvent == 1002) //  OnPerception event
  {
    if (GetIsObjectValid(oPC) == TRUE &&    // Objekt gueltig
        GetIsPC(oPC)          == TRUE    )  // und ist ein Spieler
    {
      if (GetLastPerceptionVanished())      // Es sieht sie nicht
        return;

      else if (GetLastPerceptionSeen())     // Es sieht sie
      {
        if (HasItem(oPC, sTag))             // Schau nach, hat es was zu fressen?
        {
          ClearAllActions();
          ActionForceFollowObject(oPC, 2.0);

          oItem = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_ITEM);
          if (GetIsObjectValid(oItem) == TRUE &&    // Objekt gueltig
              GetTag(oItem)           == sTag    )  // und ist das gesuchte Getreide
          {
            ClearAllActions();
            ActionMoveToLocation(GetLocation(oItem), FALSE);

            ActionDoCommand(EatFeed(oItem, nFoodPoints));
          }
        }
      }
    }
  }
}
