%Diese Funktion 
%1) Spielt die vom Benutzer gewaehlte Nummer ab
%2) Plottet die DTMF Toene im Zeitbereich
%3) Plottet die DTMF Toene im Frequenzbereich

%Die Eingabe der gewaehlten Nummer muss ueber '12345' erfolgen.
%(Es wird ein String als Eingabewert erwartet)

%Dabei wird der Input String zu einem Signal der Dauer 0.5 sec konvertiert,
%gefolgt von einer Pause von 0.025 sec.
%Die Laenge der Pause kann ueber die Variable pauselen variiert werden.

function tones=dial_tones()
Fs=32768;
pauselen=round(Fs/20);
telnr=input('Bitte waehle Deine Nummer :');
num=length(telnr);
tones=[];

 
    
%rufe die Funktion generate_tones auf, um die Toene fuer jede gewaehlte
%Ziffer zu erhalten
for i = 1:num
tones=[tones zeros(1,pauselen) generate_tones_Student(telnr(i))];
end

%soll der Ton nicht abgespielt werden, kann die folgende Zeile
%auskommentiert werden
soundsc(tones,Fs);

figure()
subplot(2,1,1)
%Signal im Zeitbereich
time = [0:length(tones)-1]/Fs;
plot(time,tones);
title('Dial Signal');
xlabel('Time(sec)');
ylabel('Amplitude');
subplot(2,1,2)
n=length(tones);
f=(0:n-1)*Fs/n;
%Transformation in den Frequenzbereich
plot(f,abs(fft(tones))/(Fs/2));
grid on;
axis([0 1500 0 1 ])
end