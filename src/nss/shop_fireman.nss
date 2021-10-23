/* Script Created By Rami_Ahmed */
#include "shop_inc"
void main()
{  object oPC = GetPCSpeaker(),
          oArea = GetArea(OBJECT_SELF);
   if (!GetIsPC(oPC) || !GetIsObjectValid(oPC) || !GetIsObjectValid(oArea)) return;
   int nSalesmen = GetNumberSalesman(oArea);
   if (nSalesmen <= 0)
   {  FloatingTextStringOnCreature("You dont have any salesmen hired.", oPC);
     return;
   }
   object oSalesman = OBJECT_SELF;
   if (!GetLocalInt(oSalesman, "ShopToBeDeleted"))
   {  object oDoor = GetNearestObject(OBJECT_TYPE_DOOR, oSalesman);
      SetLocalInt(oSalesman, "ShopToBeDeleted", TRUE);
      SetNumberSalesman(oArea, nSalesmen - 1);
      nSalesmen--;
      ActionForceMoveToObject(oDoor);
      ActionDoCommand(DestroyObject(oSalesman, 0.5));
   }
  SendServerMessageToPC(oPC, "You now have " + IntToString(nSalesmen) + " salesmen hired.");
}
