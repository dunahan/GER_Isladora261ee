#include "bbs_include"

void main()
{
  object oPC = GetPCSpeaker();                                                  bbs_debug_speak("bbs_start_scribe: "+GetName(oPC));

  object oAvatar = CreateObject(OBJECT_TYPE_CREATURE, "bbs_scribe_bp",
                   GetLocation(OBJECT_SELF), FALSE);                            bbs_debug_speak("bbs_start_scribe: "+GetName(oAvatar));
  AssignCommand(oPC,ClearAllActions());                                         bbs_debug_speak("bbs_start_scribe: ClearAllActions!");

  effect eVis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
  effect eImmobilize = EffectCutsceneImmobilize();
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oAvatar);                    bbs_debug_speak("bbs_start_scribe: Invisible!");
  ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmobilize, oAvatar);           bbs_debug_speak("bbs_start_scribe: Immobile!");

  AssignCommand(oAvatar,ActionStartConversation(oPC,"bbs_scribe",TRUE,FALSE));  bbs_debug_speak("bbs_start_scribe: Conversation!");
}

