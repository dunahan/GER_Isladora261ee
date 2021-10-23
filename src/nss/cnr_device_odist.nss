// Neues CNR Device On Disturbed Skript
// Wandelt entweder alle entsprechend hinein gelegten Items wieder in ihre
// Grundzutaten zurueck, oder am Beispiel der Getreidekoerner, in Mehl um.

void main()
{
  object oUser = GetLastUsedBy();            // der Nutzer
  object oItem = GetInventoryDisturbItem();  // das Item, das hinein gelegt wurde

  int nDisturbType, nNuberItems; string sTag, sToGive;

  if (GetIsPC(oUser) == TRUE)
  {
    nDisturbType = GetInventoryDisturbType();

    if (nDisturbType == INVENTORY_DISTURB_TYPE_ADDED)
    {
      sTag = GetTag(oItem);

      if (sTag == "cnrCornRaw") sToGive = "cnrcornflour";

      if (sToGive != "")
      {
        CreateItemOnObject(sToGive, OBJECT_SELF, GetItemStackSize(oItem));
        DestroyObject(oItem);
      }
    }
  }

  else
  {
    // evtl noch etwas weiter programmieren?
  }
}
