%Diese Funktion generiert die entsprechenden DTMF Toene, wenn  die <key>
%Taste gewaehlt wird

function tone=generate_tones_Student(key)
%Abtastfrequenz
Fs=32768;
t=0:1/Fs:(1/2-1/Fs);
in = key;

%hier die horizontalen Frequenzen in aufsteigender Reihenfolge einfuengen:
%Frequenz horizontal (Zeilenvektor)
fhorz = [1209, 1336, 1477];
%hier die vertikalen Frequenzen in aufsteigender Reihenfolge einfuengen:
%Frequenz vertikal (Zeilenvektor)
fvert = [697, 770, 852, 941];

% Notwendig weil Scopes und so...
f1 = 0;
f2 = 0;

%Eingabe wird als String behandelt um '*' und '#' beruecksichtigen zu
%koennen
     if strcmp(key,'1')==1
        f1 = (fhorz(1));
            elseif strcmp(key,'4')==1
        f1 = (fhorz(1));
            elseif strcmp(key,'7')==1
        f1 = (fhorz(1));
            elseif strcmp(key,'*')==1
        f1 = (fhorz(1));
            elseif strcmp(key,'2')==1
        f1 = (fhorz(2));
            elseif strcmp(key,'5')==1
        f1 = (fhorz(2));
            elseif strcmp(key,'8')==1
        f1 = (fhorz(2));
            elseif strcmp(key,'0')==1
        f1 = (fhorz(2));
            elseif strcmp(key,'3')==1
        f1 = (fhorz(3));
            elseif strcmp(key,'6')==1
        f1= (fhorz(3));
            elseif strcmp(key,'9')==1
        f1 = (fhorz(3));
            elseif strcmp(key,'#')==1
        f1 = (fhorz(3));
            else
        'error'
     end
     
     
    if strcmp(key,'1')==1
        f2 = (fvert(1));
            elseif strcmp(key,'2')==1
        f2 = (fvert(1));
            elseif strcmp(key,'3')==1
        f2 = (fvert(1));
            
            elseif strcmp(key,'4')==1
        f2 = (fvert(2));
            elseif strcmp(key,'5')==1
        f2 = (fvert(2));
            elseif strcmp(key,'6')==1
        f2 = (fvert(2));
            
            elseif strcmp(key,'7')==1
        f2 = (fvert(3));
            elseif strcmp(key,'8')==1
        f2= (fvert(3));
            elseif strcmp(key,'9')==1
       
        f2 = (fvert(3));
            elseif strcmp(key,'*')==1
        f2 = (fvert(4));
            elseif strcmp(key,'0')==1
        f2 = (fvert(4));
            elseif strcmp(key,'#')==1
        f2 = (fvert(4));
           
        else
        'error'
    end
     
    
    %Hier die Formel aus dem Theorieteil fuer die DTFM Toene einfuegen.
    %Hinweis: die beiden Einzelsignale haben jeweils eine Amplitude 1. Ton1 hat die Frequenz f1 und Ton2 die Frequenz f2.

    % tone=
    Ton1 = cos(2*pi*f1*t);
    Ton2 = cos(2*pi*f2*t);
    
    tone=(Ton1+Ton2)/2;
    
end
