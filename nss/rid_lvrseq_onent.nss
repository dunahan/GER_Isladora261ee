void main()
{
  // wo ist die Hilfe versteckt?
  string sHint = GetLocalString(OBJECT_SELF, "Hint");
  object oHint = GetObjectByTag(sHint);

  // welcher Tag hat der Hebel?
  string sLever = GetLocalString(OBJECT_SELF,"Lever");
  object oLever = GetObjectByTag(sLever);

  // Sequenz auf Hilfe abspeichern!
  string sDesHint = GetDescription(oHint);
  string sSequel = GetLocalString(oLever, "Sequel");

  SetDescription(oHint, sDesHint + sSequel);

}
