function tones=fft_dtmf_Student(number)
tones=number;
Fs=32768;
soundsc(tones,Fs);

figure()
subplot(2,1,1)
%Signal im Zeitbereich
%hier Code einfuegen um das Signal im Zeitbereich zu plotten
plot(number);

title('Dial Signal');
xlabel('Time(sec)');
ylabel('Amplitude');
subplot(2,1,2)
n=length(tones);
f=(0:n-1)*Fs/n;
%Transformation in den Frequenzbereich
%hier Code einfuegen um das Signal im Frequenzbereich zu plotten
plot(f,abs(fft(tones))/(Fs/2));
grid on;
axis([0 1500 0 1 ])