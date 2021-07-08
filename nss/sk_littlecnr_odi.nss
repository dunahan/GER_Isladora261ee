void main()
{
  object oPC = GetLastClosedBy();
  object oItem = GetFirstItemInInventory(OBJECT_SELF);   // Das Item, das hineingelegt wurde erfassen
  string sTag = GetTag(oItem);                           // Lese den Tag aus

  string sItem1 = GetLocalString(OBJECT_SELF, "Item1");  // Zutat 1
  string sItem2 = GetLocalString(OBJECT_SELF, "Item2");  // Zutat 2
  string sItem3 = GetLocalString(OBJECT_SELF, "Item3");  // Zutat 3
  string sItem4 = GetLocalString(OBJECT_SELF, "Item4");  // ResRef des hergestellten Items

  string sDefMsg = GetLocalString(OBJECT_SELF, "DefMSG");  // Standardnachricht
  string sFalMsg = GetLocalString(OBJECT_SELF, "FalMSG");  // Fehlermeldung

  int nStatus = GetLocalInt(OBJECT_SELF, "Status");      // Status auslesen

  if ( GetIsObjectValid(oItem) )                         // Ist das Item vorhanden?
  { if ( sTag == sItem1 && nStatus == 0 )                // Pruefe ob Tag des Items gleich der Zutat 1 ist
    {
      SetLocalInt(OBJECT_SELF, "Status", 1);             // Richtiges Item eingelegt, deswegen Status 1 setzen!
      FloatingTextStringOnCreature( GetName(oItem)+" "+sDefMsg, oPC ); // MSG schicken
      DestroyObject(oItem);                              // Daraufhin dieses vernichten...
    }

    else if ( sTag == sItem2 && nStatus == 1 )           // Pruefe ob Tag des Items gleich der Zutat 2 ist UND der Status 1 ist
    {
      SetLocalInt(OBJECT_SELF, "Status", 2);             // Richtiges Item eingelegt, deswegen Status 2 setzen!
      FloatingTextStringOnCreature( GetName(oItem)+" "+sDefMsg, oPC ); // MSG schicken
      DestroyObject(oItem);                              // Daraufhin dieses vernichten...
    }

    else if ( sTag == sItem3 && nStatus == 2)              // Pruefe ob Tag des Items gleich der Zutat 3 ist UND der Status 2 ist
    {
      SetLocalInt(OBJECT_SELF, "Status", 0);               // Richtiges Item eingelegt, deswegen Status 0 setzen!
      FloatingTextStringOnCreature( GetName(oItem)+" "+sDefMsg, oPC ); // MSG schicken
      DestroyObject(oItem);                                // Daraufhin dieses vernichten...
      CreateItemOnObject(sItem4);                          // Hergestellter Gegenstand erstellen
    }
  }
  else
  { FloatingTextStringOnCreature( sFalMsg, oPC ); }
}
