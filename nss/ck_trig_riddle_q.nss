#include "_ck_sraetsel_inc"

void main()
{
  object oChest = GetObjectByTag(CK_CHEST);
  SetLocalString(oChest, "Raetsel001", ck_random_raetselwort());   // Erstes Wort, das gesucht wird
  SetLocalString(oChest, "Raetsel002", ck_random_raetselwort());   // Zweites Wort, das gesucht wird
  SetLocalString(oChest, "Raetsel003", ck_random_raetselwort());   // Drittes Wort, das gesucht wird
}
