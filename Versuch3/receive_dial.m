%Funktion gibt die gewählte Telefonnummer zurück indem das Eingangssignal
%analysiert wird
%Zusätzlich wird jede einzelne Nummer im Zeitbereich geplottet.

function dial=receive_dial(tones)
Fs=32769;
pauselen=Fs/20; %Laenge der Pause zwischen 2 Ziffern
numpad=['1' '2' '3'; '4' '5' '6'; '7' '8' '9'; '*' '0' '#' ];

[start stop ]=dtmfcut(tones,Fs);
num=size(start,2);

for ii=1:num
    decode=tones(start(ii):stop(ii));
    f=(0:length(decode)-1)*Fs/length(decode);
    decode_fft=fft(decode)/(Fs/2);
    
    %Plotten des aktuellen Singals im Frequenzbereich
    figure(ii)
    plot(f,2*abs(decode_fft));
    axis([500 1700 0 0.5])
    xlabel('f(Hz)')
    title('Power')
    
    %While schleife, welche die empfangene Nummer decodiert
    ind=find(2*abs(decode_fft)>0.35)*Fs/length(decode);
    ind1=find(ind<Fs/2);
    index=ind(ind1)-2;
   for jj=1:length(index)
       if abs(index(jj)-697)/697<=0.02
            row=1;
       elseif abs(index(jj)-770)/770<=0.02
              row=2; 
       elseif abs(index(jj)-852)/852<=0.02
                row=3;
      elseif abs(index(jj)-941)/941<=0.02       
            row=4;  
      elseif abs(index(jj)-1209)/1209<=0.02  
            column=1;  
      elseif abs(index(jj)-1336)/1336<=0.02  
            column=2;
      elseif abs(index(jj)-1477)/1477<=0.02 
                    column=3;
           
        end
       
   end

 %Zuordnung der Nummer zu Keypad Koordinaten
 dial(ii)=numpad(row,column);
end
end