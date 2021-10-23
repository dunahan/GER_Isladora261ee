#include "spawn_functions"

int StartingConditional()
{
  SetCustomToken(1003, FloatToString(SPAWN_HEARTBEAT_INTERVALL, 3, 0));
  SetCustomToken(1004, FloatToString(SPAWN_HEARTBEAT_FIRSTDELAY,3, 0));
  return TRUE;
}

