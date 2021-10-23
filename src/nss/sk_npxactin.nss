#include "x2_inc_switches"
#include "x0_i0_position"

void main()
{
    object oTalker = OBJECT_SELF; // Kennzeichnung NSC 1
    object oTarget = GetNearestObjectByTag(GetLocalString(OBJECT_SELF,
                                           "oTarget")); // Kennzeichnung NSC 2

if (IsInConversation(OBJECT_SELF) != TRUE)
  {
    ActionForceMoveToObject(oTarget); // if NPC 1 was used by a DM, walk to NPC 2
    TurnToFaceObject(oTarget);        // face NPC 2

    int nAnim;
    int iZufall = Random(8);
    switch (iZufall)
    {
        case 0: nAnim =   8; break;
        case 1: nAnim =   9; break;
        case 2: nAnim =  11; break;
        case 3: nAnim = 105; break;
        case 4: nAnim = 107; break;
        case 5: nAnim = 103; break;
        case 6: nAnim = 102; break;
        case 7: nAnim =  14; break;
    }
    ActionPlayAnimation(nAnim, 1.0, 6.0);
  }
}
