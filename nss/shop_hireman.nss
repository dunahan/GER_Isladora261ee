/* Script Created By Rami_Ahmed */
#include "shop_inc"

void main()
{ object oPC = GetPCSpeaker(),
         oArea = GetArea(OBJECT_SELF),
         oDoor = GetNearestObject(OBJECT_TYPE_DOOR, oPC);
  if (!GetIsObjectValid(oPC) || !GetIsObjectValid(oArea)) return;
  if (!GetIsObjectValid(oDoor))
  { oDoor = oPC;
  }
  int nSalesman = GetNumberSalesman(oArea);
  if (nSalesman >= 1)
  {  FloatingTextStringOnCreature("You cant have more than one salesman hired at a time.", oPC);
    return;
  }
  object oSalesman = CreateObject(OBJECT_TYPE_CREATURE, "shopsalesman", GetLocation(oDoor));
  AssignCommand(oSalesman, ActionForceMoveToObject(oPC));
  AssignCommand(oSalesman, ActionPlayAnimation(ANIMATION_FIREFORGET_BOW));
  SetNumberSalesman(oArea, nSalesman+1);
  nSalesman++;
  if (nSalesman == 1)
  { SendServerMessageToPC(oPC, "You now have 1 salesman hired.");
  }
  else
  { SendServerMessageToPC(oPC, "You now have " + IntToString(nSalesman) + " salesmen hired.");
  }
}
