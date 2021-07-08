#include "_sltools_inc"

void main()
{
  // Checks if DeadMagic Zone
  object oMap = GetArea(oSpeaker);
  int nCLEAR = GetLocalInt(oMap, "DeadMagic");

       if (nCLEAR == 0)
       {
         SetLocalInt(oMap, "DeadMagic", 1);
         SendMessageToAllDMs("Tote Magiezone in "+GetName(oMap)+" errichtet.");
       }
  else if (nCLEAR == 1)
       {
         SetLocalInt(oMap, "DeadMagic", 0);
         SendMessageToAllDMs("Tote Magiezone in "+GetName(oMap)+" zerstört.");
       }
}
