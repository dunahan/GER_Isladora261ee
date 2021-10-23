void main()
{
  int nBossChance = GetLocalInt(GetArea(OBJECT_SELF), "BossChance");
  int nBossBonus  = GetLocalInt(GetArea(OBJECT_SELF), "BossBonus");

  SpeakString("Boss Chance: "+IntToString(nBossChance), TALKVOLUME_WHISPER);
  SpeakString("Boss Bonus: "+IntToString(nBossBonus), TALKVOLUME_WHISPER);

  int nFiftChance = (- 5) + (nBossChance);
  int nFiftBonus  = (  0) + (nBossBonus) ;

  SpeakString("Modifizierte Boss Chance bis Lvl 15: "+IntToString(nFiftChance), TALKVOLUME_WHISPER);
  SpeakString("Modifizierter Boss Bonus bis Lvl 15: "+IntToString(nFiftBonus), TALKVOLUME_WHISPER);

  int nThrtChance = (-10) + (nBossChance);
  int nThrtBonus  = (  0) + (nBossBonus) ;

  SpeakString("Modifizierte Boss Chance bis Lvl 30: "+IntToString(nThrtChance), TALKVOLUME_WHISPER);
  SpeakString("Modifizierter Boss Bonus bis Lvl 30: "+IntToString(nThrtBonus), TALKVOLUME_WHISPER);

  int nFortChance = (-15) + (nBossChance);
  int nFortBonus  = (  0) + (nBossBonus) ;

  SpeakString("Modifizierte Boss Chance bis Lvl 45: "+IntToString(nFortChance), TALKVOLUME_WHISPER);
  SpeakString("Modifizierter Boss Bonus bis Lvl 45: "+IntToString(nFortBonus), TALKVOLUME_WHISPER);

  int nFrtyChance = (-20) + (nBossChance);
  int nFrtyBonus  = (  0) + (nBossBonus) ;

  SpeakString("Modifizierte Boss Chance ab Lvl 46+: "+IntToString(nFrtyChance), TALKVOLUME_WHISPER);
  SpeakString("Modifizierter Boss Bonus ab Lvl 46+: "+IntToString(nFrtyBonus), TALKVOLUME_WHISPER);




  int nNormChance = GetLocalInt(GetArea(OBJECT_SELF), "NormChance");
  int nNormBonus  = GetLocalInt(GetArea(OBJECT_SELF), "NormBonus");

  SpeakString("Normale Chance: "+IntToString(nNormChance), TALKVOLUME_WHISPER);
  SpeakString("Normaler Bonus: "+IntToString(nNormBonus), TALKVOLUME_WHISPER);

  int nTwenChance = (-10) + (nNormChance);
  int nTwenBonus  = (  0) + (nNormBonus) ;

  SpeakString("Modifizierte Normale Chance bis Lvl 20: "+IntToString(nTwenChance), TALKVOLUME_WHISPER);
  SpeakString("Modifizierter Normaler Bonus bis Lvl 20: "+IntToString(nTwenBonus), TALKVOLUME_WHISPER);

  int nThirChance = (-15) + (nNormChance);
  int nThirBonus  = (  0) + (nNormBonus) ;

  SpeakString("Modifizierte Normale Chance bis Lvl 34: "+IntToString(nThirChance), TALKVOLUME_WHISPER);
  SpeakString("Modifizierter Normaler Bonus bis Lvl 34: "+IntToString(nThirBonus), TALKVOLUME_WHISPER);

  int nFourChance = (-20) + (nNormChance);
  int nFourBonus  = (  0) + (nNormBonus) ;

  SpeakString("Modifizierte Normale Chance ab Lvl 35+: "+IntToString(nFourChance), TALKVOLUME_WHISPER);
  SpeakString("Modifizierter Normaler Bonus ab Lvl 35+: "+IntToString(nFourBonus), TALKVOLUME_WHISPER);
}
