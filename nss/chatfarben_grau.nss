#include "colors_inc"
int r = 120,
    g = 135,
    b = 150;

void main()
{
  object oPC = GetPCSpeaker();
  object oItem = GetItemPossessedBy(oPC, "itm_questbuch");

  SetLocalInt(oItem, "CHAT_ROT",   r);
  SetLocalInt(oItem, "CHAT_GRUEN", g);
  SetLocalInt(oItem, "CHAT_BLAU",  b);
}
