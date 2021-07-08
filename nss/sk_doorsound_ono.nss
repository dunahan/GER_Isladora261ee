// Grundskript generiert mit
// Lilac Soul's NWN Script Generator, v. 2.3
// http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625    */
//
// In OnOpen eintragen.
//
// Den Tag des abzuspielenden Sounds als Variable "sound" auf den oeffnenden
// Gegenstand setzen. Sound gesetzt und Konfiguriert bereits in Area!


void main()
{

object oPC = GetLastOpenedBy();
string sTag = GetLocalString(OBJECT_SELF,"sound");

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag(sTag);

SoundObjectPlay(oTarget);

SoundObjectSetVolume(oTarget, 127);
}

