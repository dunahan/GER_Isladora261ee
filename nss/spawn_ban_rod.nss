//
// SpawnBanner : Sample OnActivateItem Script
//
#include "spawnb_main"

void main()
{
  SpawnBanner(GetItemActivator(), GetItemActivated(), GetItemActivatedTarget(), GetItemActivatedTargetLocation());
}
