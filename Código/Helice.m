 %Intervalo de integracao da helice:
 % De 0.085 > r < 0.155
 % Constantes
dr = 0.00001 ; % Variacao do raio em metros
ro = 1.225 ; % kg/m^3
vr = zeros(15500,1); % Criando os vetores
vdq = zeros(15500,1); % Criando os vetores
vQ = zeros(8,1); % Criando os vetores
vrpm = zeros(8,1); % Criando os vetores
Cl2 = 0.65 ;
Cd2 = 0.022 ;
% Calculos do programa
i=1 ;
j=1 ;
for rpm = 1000:1000:20000 ;
 % Zerando parametros calculados
 Q=0 ;
 for r = 0.015:dr:0.155 ;
 % Equacoes necessarias
 w = (2*pi*rpm)/60 ; % Rad/s
 v = w*r ; % m/s
 alf = (1.755e7*r^5)-(8.0429e6*r^4)+(1.3913e6*r^3)-(1.1092e5*r^2)+3790.5*r-22.636 ;
 c = (-176.85*r^4)+(29.63*r^3)-(1.7436*r^2)+0.10045*r+0.022753 ;
 Cl = 0.091071*alf+0.28071 ;
 Cd = 0.06408*Cl^3-0.12055*Cl^2+0.062974*Cl+0.014138 ;

 % Calculo do torque 
 if 0.015>=r<0.085 ;
 dq = ro*v^2*c*(Cl2*sind(alf)+Cd2*cosd(alf))*r;  % torque
 
 else
 dq = ro*v^2*c*(Cl*sind(alf)+Cd*cosd(alf))*r  % torque
 end

 vr(i)= r ; % armazenando os valores
 vdq(i)= dq/2 ; % armazenando os valores
 i = i+1 ;
 Q = Q+dq*dr ;
 end
 vQ(j)= Q ; % armazenando os valores
 vrpm(j)= rpm ; % armazenando os valores
 j = j+1 ;
end
%plot (vrpm,vT,'b-') %tração
%hold on
plot (vrpm,vQ,'b-') %torque
title('Torque da hélice por rpm do motor');
xlabel('rpm do motor');
ylabel('Torque hélice (Nm)');
grid on
%hold off