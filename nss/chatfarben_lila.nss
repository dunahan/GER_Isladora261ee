#include "colors_inc"
int r = 128,
    g = 0,
    b = 128;

void main()
{
  object oPC = GetPCSpeaker();
  object oItem = GetItemPossessedBy(oPC, "itm_questbuch");

  SetLocalInt(oItem, "CHAT_ROT",   r);
  SetLocalInt(oItem, "CHAT_GRUEN", g);
  SetLocalInt(oItem, "CHAT_BLAU",  b);
}
