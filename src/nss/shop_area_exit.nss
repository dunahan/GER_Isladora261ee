/* Script Created By Rami_Ahmed */
void main()
{ object oPC = GetExitingObject(),
         oArea = OBJECT_SELF;
  if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) || GetIsDM(oPC) ||
     !GetLocalInt(oArea, "ShopAreaUse")) return;
  object oLoop = GetFirstObjectInArea(oArea);
  while (GetIsObjectValid(oLoop))
  {  if (GetIsPC(oLoop) && !GetIsDM(oLoop) && oLoop != oPC)
     {  break;
       return;
     }
     if (GetResRef(oLoop) == "shopsalesman" && GetObjectType(oLoop) == OBJECT_TYPE_CREATURE)
     {  DestroyObject(oLoop, 1.2);
     }
   oLoop = GetNextObjectInArea(oArea);
  }
  SetLocalInt(oArea, "ShopAreaUse", FALSE);
}
