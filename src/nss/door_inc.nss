/*
Include Datei fur alle Tuerenskripte
parolen & losungen

[parole01]
parole=Ich binde mir den Hanfkragen um, um mit wem zu tanzen?
losung=scharfrichter

[parole02]
parole=Wer kommt mit Hammer und Pfeife und wo er klopft, gibt man acht?
losung=klabautermann

[parole03]
parole=Mein Herz durchbohrte Amor, so verschmaehte ich was?
losung=glitzergold

[parole04]
parole=Beispiel
losung=leer

*/

#include "_debugisla"

const string CLOSEME = "zu";

 /* void main() { }

Include Datei fuer das Parolen-Skript der Tueren
Darin werden alle Parolen und Losungen abgelegt

*/

const string SCHLIESSE = "zu";

string Losung(string sTag)
{
  string sResult;
  sTag = GetStringLowerCase(sTag);

  if (sTag == "")
    sResult = "zu";

  else if (sTag == "parole01")
    sResult = "scharfrichter";

  else if (sTag == "parole02")
    sResult = "klabautermann";

  else if (sTag == "parole03")
    sResult = "glitzergold";

/* fuer neue Parolen/Losungen. Abschnitt 27 & 28 kopieren und entsprechend ausgefuellt einfuegen
  else if (sTag == "paroleXY")
    sResult = "Losung fur neue Parole";
*/

  else
    sResult = "zu";

  return sResult;
}

string Parole(string sTag)
{
  string sResult;
  sTag = GetStringLowerCase(sTag);

  if (sTag == "")
    sResult = "zu";

  else if (sTag == "parole01")
    sResult = "Ich binde mir den Hanfkragen um, um mit wem zu tanzen?";

  else if (sTag == "parole02")
    sResult = "Wer kommt mit Hammer und Pfeife und wo er klopft, gibt man acht?";

  else if (sTag == "parole03")
    sResult = "Mein Herz durchbohrte Amor, so verschmähte ich was?";

/* fuer neue Parolen/Losungen. Abschnitt 54 & 55 kopieren und entsprechend ausgefuellt einfuegen
  else if (sTag == "paroleXY")
    sResult = "Losung fur neue Parole";
*/

  else
    sResult = "zu";

  return sResult;
}
