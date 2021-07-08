void main()
{

object     oNews = GetObjectByTag("plc_aktuelleshinweise");
object       oPC = GetPCSpeaker();

  if (GetLocalInt(oNews, "active") == 0)
  { SetLocalInt(oNews, "active", 1); }
  else
  { DeleteLocalInt(oNews, "active"); }
}
