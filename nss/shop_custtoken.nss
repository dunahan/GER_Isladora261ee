/* Script Created By Rami_Ahmed */
#include "shop_inc"
int StartingConditional()
{ object oArea = GetArea(OBJECT_SELF);
  int nPrice = GetShopPrice(oArea);
  if (nPrice == 0)
  {  nPrice = GetLocalInt(GetModule(), "ShopStartPrice");
  }
  string sPrice;
  if (GetBuySellState(oArea))
  {  sPrice = "Not for sale";
  }
  else
  {  sPrice = IntToString(nPrice);
  }
  SetCustomToken(5176, sPrice);

  string sOwner = GetOwner(oArea);
  if (sOwner == "")
  {   sOwner = "Goverment";
  }
  SetCustomToken(5175, sOwner);

  int nCost = GetNumberSalesman(oArea) * GetSalesmanSalary(oArea);
  string sCost = IntToString(nCost);
  if (nCost <= 0)
  {   sCost = "No";
  }
  SetCustomToken(5174, sCost);

  string sAppraise;
  if (!GetLocalInt(oArea, "ShopUseAppraise"))
  { sAppraise = "On";
  }
  else
  { sAppraise = "Off";
  }
  SetCustomToken(5173, sAppraise);

  string sShopName = GetShopName(oArea);
  SetCustomToken(5172, sShopName);

  int nSalesman = GetNumberSalesman(oArea);
  string sSalesman;
  if (nSalesman <= 0)
  {  sSalesman = "none salesmen";
  }
  else if (nSalesman == 1)
  {  sSalesman = "one salesman";
  }
  else
  {  sSalesman = IntToString(nSalesman) + " salesmen";
  }
  SetCustomToken(5171, sSalesman);

  int iType = GetLocalInt(oArea, "ShopCurStoreType");
  SetCustomToken(5163, IntToString(iType + 1));

  int nMarkUp = GetShopBonusMarkUp(oArea, iType) ;
  SetCustomToken(5170, IntToString(nMarkUp));

  string sSalarySet;
  int nSalarySet = GetSalesmanSalary(oArea);
  if (nSalarySet <= 0)
  {   sSalarySet = "Nothing";
  }
  else
  {   sSalarySet = IntToString(nSalarySet);
  }
  SetCustomToken(5169, sSalarySet);

  int nShopVaultGold = GetGoldInShopVault(oArea, iType);
  SetCustomToken(5167, IntToString(nShopVaultGold));

  int nMarkDown = GetShopBonusMarkDown(oArea, iType);
  SetCustomToken(5166, IntToString(nMarkDown));

  string sOldOwner = GetOldOwner(oArea);
  if (sOldOwner != "")
  {  SetCustomToken(5165, "There may be gold for " + sOldOwner + ", because of the sale of his shop.");
  }
  else
  {  SetCustomToken(5165, "");
  }

  if (GetBuySellState(oArea))
  {  SetCustomToken(5164, "Not for sale");
  }
  else
  {  SetCustomToken(5164, "For sale");
  }
 return TRUE;
}
