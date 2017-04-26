function [] = KPV_plot( A,B1,B2 )
%KPV_plot( A,B1,B2 )
%Löst das KPV mit der Form
%A*U = B1*Uin + B2*Uin2
%Uin1=0..3V;
%Uin2=1V;


if (sum(size(A)~=[4,4]))
error('Matrix A is not in the Form 4x4')
end

if (sum(size(B1)~=[4,1]))
error('Vektor B1 is not in the Form 4x1')
end 

if (sum(size(B2)~=[4,1]))
error('Vektor B2 is not in the Form 4x1')
end 


Uin1=(0:0.01:3);
Uin2=1;

Q=A^-1;

disp(' ')
disp('A^(-1) =')
disp(num2str(Q,3))

disp(' ')
disp('A^(-1) * B1 =')
disp(num2str(Q*B1,3))

disp(' ')
disp('A^(-1) * B2 =')
disp(num2str(Q*B2,3))
disp(' ')


Uout=Q*B1*Uin1+Q*B2*ones(size(Uin1))*Uin2;


figure1 = figure;
axes1 = axes('Parent',figure1,...
    'YMinorTick','on',...
    'YMinorGrid','on',...
    'XMinorTick','on',...
    'XMinorGrid','on');
box(axes1,'on');
grid(axes1,'on');
hold(axes1,'all');

plot(Uin1,Uout,'Parent',axes1,'LineWidth',1.5)
grid on
axis([0 3 -0.5 2.5])
legend('U_1','U_2','U_3','U_4')
xlabel ('U_{in,1} [V]')
ylabel ('U_{x} [V]')


end

