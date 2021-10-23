/* Script Created By Rami_Ahmed */
#include "shop_inc"
void main()
{ object oPC = GetLastClosedBy(),
         oArea = GetArea(OBJECT_SELF);
  if (!GetIsPC(oPC) || !GetIsObjectValid(oPC)) return;
  if (GetOwner(oArea) == GetName(oPC))
  { SaveItems(oArea, oPC, OBJECT_SELF, TRUE, GetLocalInt(oArea, "ShopCurStoreType"));
    SetLocked(OBJECT_SELF, TRUE);
    int i; for (i; i <= 10; i++)
    {  object oStore = GetNearestObject(OBJECT_TYPE_STORE, OBJECT_SELF, i);
       if (GetIsObjectValid(oStore) && (GetTag(oStore) == "shop_store990" || GetTag(oStore) == "shop_store991"))
       {  DestroyObject(oStore, 1.0);
       }
    }
  }
  else
  { object oLoop = GetFirstItemInInventory();
    while (GetIsObjectValid(oLoop))
    {  CopyItem(oLoop, oPC, TRUE);
       DestroyObject(oLoop, 1.5);
     oLoop = GetNextItemInInventory();
    }
  }
  DestroyObject(OBJECT_SELF, 5.0);
}
