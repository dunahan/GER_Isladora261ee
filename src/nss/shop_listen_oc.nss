/* Script Created By Rami_Ahmed */
#include "shop_inc"
void main()
{ object oPC = GetLastSpeaker(),
         oArea = GetArea(oPC);
  if (!GetIsObjectValid(oPC) || !GetIsPC(oPC) ||
  GetLocalObject(OBJECT_SELF, "ShopListenFor") != oPC || !GetIsObjectValid(oArea)) return;
  int iPattern = GetListenPatternNumber();
  if (iPattern == 6434)
  {  if (GetOwner(oArea) != GetName(oPC))
     {  FloatingTextStringOnCreature("You are not the owner!", oPC);
       return;
     }
     string sHeard = GetMatchedSubstring(0);
     if (sHeard == "") return;
     int nHeard = StringToInt(sHeard);
     if (nHeard < 0)
     {  FloatingTextStringOnCreature("Unvalid number. Please retry.", oPC);
       return;
     }
     SetShopPrice(oArea, nHeard);
     SendServerMessageToPC(oPC, "You have set the shop price to " + sHeard + ".");
    DestroyObject(OBJECT_SELF, 6.0);
  }
  else if (iPattern == 6436)
  {  if (GetOwner(oArea) != GetName(oPC))
     {  FloatingTextStringOnCreature("You are not the owner!", oPC);
       return;
     }
     string sHeard = GetMatchedSubstring(0);
     if (sHeard == "") return;
     int nMaxLength = GetLocalInt(GetModule(), "ShopRuleMaxNam");
     if (GetStringLength(sHeard) > nMaxLength)
     {  FloatingTextStringOnCreature("Too long name detected. Maximum length: " + IntToString(nMaxLength) + ". Please retry.", oPC);
       return;
     }
     if (nMaxLength > 0)
     { ChangeShopName(oArea, sHeard);
       SendServerMessageToPC(oPC, "You have changed your shops name to " + sHeard + ".");
     }
     else
     {  FloatingTextStringOnCreature("This feature is disabled.", oPC);
     }
    DestroyObject(OBJECT_SELF, 6.0);
 }
}
