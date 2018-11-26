function [t, pos_plan, vel_plan, ace_plan] = planificador(q1,q2)
%**********************parámetros de los accionamientos**************
%---------------------------------------------------------------------
% Especificaciones de los tiempos de arranque y frenado de cada motor.
%---------------------------------------------------------------------
tmotor = 0.1*ones(6,2);
%---------------------------------------------------------------------
%Velocidades Maxima de cada motor.
%---------------------------------------------------------------------
velmax = [1.0472;1.0472;1.0472;1.0472;1.0472;1.0472];
%**********************planificador coordinado***********************
%---------------------------------------------------------------------
% Inicialización de los vectores posicion - Velocidad - aceleracion.
%---------------------------------------------------------------------
q = zeros(6,1);
q0 = [q1 q q];
qf = [q2 q q];
%---------------------------------------------------------------------
% Sincronización de los motores para que realizen un movimiento
%---------------------------------------------------------------------
[velo2,tmaximo]=sincronizador(q0,qf,velmax);
%---------------------------------------------------------------------
%Inicialización de la escala de tiempo y las matrices.
%---------------------------------------------------------------------
t = 0:0.01:(tmaximo+0.15);
% +0.15 se suma con el fin de aumentar el intervalo de tiempo y muestrear
% todo el intervalo de frenado de la articulación, asumiendo las
% aproximaciones realizadas en la función SINCRONIZADOR.
ini=zeros(length(t),1);
pos_plan(:,1)=ini;
vel_plan(:,1)=ini;
ace_plan(:,1)=ini;
%----------------------

%---------------------------------------------------------------------
for i = 1:6
[caso,A,tt] = calculocoef(i,velo2,q0,qf,tmotor);
posi=evalpos(t,tt,caso,A);
pos_plan(:,i)=posi';
ve=evalpos(t,tt,caso,A);
vel_plan(:,i)=ve';
ace=evalpos(t,tt,caso,A);
ace_plan(:,i)=ace';
end;
return