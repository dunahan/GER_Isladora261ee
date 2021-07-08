/* Script Created By Rami_Ahmed */
#include "shop_inc"
void main()
{ object oArea = GetArea(OBJECT_SELF);
  ExecuteScript("nw_c2_default7", OBJECT_SELF);
  int nSalesmen = GetNumberSalesman(oArea);
  if (nSalesmen <= 0)
  {  SetNumberSalesman(oArea, 0);
  }
  else
  {  SetNumberSalesman(oArea, nSalesmen-1);
  }
  SetIsDestroyable(TRUE, FALSE, TRUE);
}
