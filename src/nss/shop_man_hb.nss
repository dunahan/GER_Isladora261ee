/* Script Created By Rami_Ahmed */
#include "shop_inc"
void main()
{ object oArea = GetArea(OBJECT_SELF),
         oDoor = GetNearestObject(OBJECT_TYPE_DOOR);
  if (GetLocalInt(OBJECT_SELF, "ShopToBeDeleted")) return;
  int nMinSal = GetLocalInt(GetModule(), "ShopMinSalary");
  if (nMinSal > 0)
  {  int nCounter = GetLocalInt(OBJECT_SELF, "ShopWaitTime");
     if (!GetSalaryHasBeenPaid(oArea))
     {  SetLocalInt(OBJECT_SELF, "ShopWaitTime", nCounter + 1);
        if (nCounter > 5)
        { SpeakString("You should've paid me my wage ...");
          ActionForceMoveToObject(oDoor);
          ActionDoCommand(DestroyObject(OBJECT_SELF, 1.0));
          SetNumberSalesman(oArea, GetNumberSalesman(oArea)-1);
         return;
        }
     }
     else
     {  if (nCounter > 0)
        {  SetLocalInt(OBJECT_SELF, "ShopWaitTime", 0);
        }
     }
  }
  if (EDS_CheckDelay(oArea, "ShopPayIntrl", 1))
  {  SetSalaryHasBeenPaid(oArea, FALSE);
  }
  object oStayAround = GetNearestObjectByTag("shop_midshop");
  if (GetIsObjectValid(oStayAround) && GetDistanceToObject(oStayAround) > 5.0)
  {  ActionForceMoveToObject(oStayAround);
    return;
  }
  if (!GetIsInCombat() && !IsInConversation(OBJECT_SELF) &&
    GetCurrentAction() != ACTION_RANDOMWALK)
  { ActionRandomWalk();
  }
}
