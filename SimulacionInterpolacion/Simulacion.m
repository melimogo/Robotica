
clear
%---------------------------------------------------------------------
% q1 y q2 son las coordenadas articulares inicial y final
%---------------------------------------------------------------------
disp([' ']);
disp([' Vectores q1 y q2 de las coordenadas articulares ']);
disp([' inicial y final. ']);
q1 = rand(6,1)
q2 = rand(6,1)
%---------------------------------------------------------------------
% Llamada a la función PLANIFICADOR
%---------------------------------------------------------------------
[t,pos, vel, ace] = planificador(q1,q2);

%---------------------------------------------------------------------
% gráficas de los resultados
%---------------------------------------------------------------------
figure
plot(t,pos)
grid
title('Perfil de posición dada por el planificador')
xlabel('Tiempo (seg)'), ylabel('Posición (rad)')
figure
plot(t,vel)
grid
title('Perfil de Velocidad dada por el planificador')
xlabel('Tiempo (seg)'), ylabel('Velocidad (rad/seg)')
figure
plot(t,ace)
grid
title('Perfil de Aceleracion Dada por el planificador')
xlabel('Tiempo (seg)'), ylabel('Aceleracion (rad/seg2)')