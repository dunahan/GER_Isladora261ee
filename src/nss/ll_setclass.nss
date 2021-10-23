void main()
{
  object oPC = GetPCSpeaker();
  int n;
  for(;n < 11;n++)
    SetLocalInt(OBJECT_SELF, "CanClass"+IntToString(n), FALSE);

  for(n=27;n < 42;n++)
    SetLocalInt(OBJECT_SELF, "CanClass"+IntToString(n), FALSE);

  int c1 = GetClassByPosition(1,oPC);
  int c2 = GetClassByPosition(2,oPC);
  int c3 = GetClassByPosition(3,oPC);
  int l1 = GetLevelByClass(c1,oPC);
  int l2 = GetLevelByClass(c2,oPC);
  int l3 = GetLevelByClass(c3,oPC);
//int b1 = c1 > 26; class 1 nikdy prestizni byt nemuze
  int b2 = c2 > 26;
  int b3 = c3 > 26;
  
  if(b2 && b3)//has two prestiges
  {
    SetLocalInt(OBJECT_SELF,"CanClass"+IntToString(c1),TRUE);
    
    if(l2 >= l3)
      SetLocalInt(OBJECT_SELF,"CanClass"+IntToString(c2),TRUE);
      
    if(l3 >= l2)
      SetLocalInt(OBJECT_SELF,"CanClass"+IntToString(c3),TRUE);
  }
  
  else if(b2 || b3)//ma jednu prestizni
  {
    if(b2)
    {
      SetLocalInt(OBJECT_SELF,"CanClass"+IntToString(c2),TRUE);
      
      if(l1 >= l3)
        SetLocalInt(OBJECT_SELF,"CanClass"+IntToString(c1),TRUE);
        
      if(l3 >= l1)
        SetLocalInt(OBJECT_SELF,"CanClass"+IntToString(c3),TRUE);
    }
  
    else
    {
      SetLocalInt(OBJECT_SELF,"CanClass"+IntToString(c3),TRUE);
      
      if(l1 >= l2)
        SetLocalInt(OBJECT_SELF,"CanClass"+IntToString(c1),TRUE);
        
      if(l2 >= l1)
        SetLocalInt(OBJECT_SELF,"CanClass"+IntToString(c2),TRUE);
    }
  }

  else//nema zadnou prestizni
  {
    int highest;
    if(l1 <= l2 && l1 <= l3)//c1 nejmensi
    {
      if(l2 >= l3)
        SetLocalInt(OBJECT_SELF,"CanClass"+IntToString(c2),TRUE);
        
      if(l3 >= l2)
        SetLocalInt(OBJECT_SELF,"CanClass"+IntToString(c3),TRUE);
    }
    
    else if(l2 <= l1 && l2 <= l3)
    {
      if(l1 >= l3)
        SetLocalInt(OBJECT_SELF,"CanClass"+IntToString(c1),TRUE);
        
      if(l3 >= l1)
        SetLocalInt(OBJECT_SELF,"CanClass"+IntToString(c3),TRUE);
    }
    else
    {
      if(l1 >= l2)
        SetLocalInt(OBJECT_SELF,"CanClass"+IntToString(c1),TRUE);
        
      if(l2 >= l1)
        SetLocalInt(OBJECT_SELF,"CanClass"+IntToString(c2),TRUE);
    }
  }
}
