function [caso,A,tt] = calculocoef(elem,vel,q0,qf,tmotor)
  %---------------------------------------------------------------------
  %Tiempos de respuesta del motor (aceleración y frenado)
  %---------------------------------------------------------------------
  ti = tmotor(elem,1);
  tf = tmotor(elem,2);
  %-------------------------------
  if vel(elem) ~= 0
    %-Determinacion del caso
    desp = (qf(elem,1) - q0(elem,1));
    ttot = abs(desp/vel(elem));
    if ttot > (ti + tf)
     caso = 1;
    else
     caso = 2;
  end;
  %****************************** CASO 1********************************
  if caso == 1
  %vector de tiempo: Arranque - Velocidad Max - Desaceleracion
  tt = [ ti ttot-(ti+tf) tf ];
  %Determinacion de los coeficientes polinomiales
  A = zeros(3,5);
  %Coeficientes del polinomio de posicion
  A(1,1) = q0(elem,1);
  A(1,2) = q0(elem,2)*tt(1);
  A(1,3) = q0(elem,3)*tt(1)^2/2;
  A(1,4) = tt(1)*vel(elem) - A(1,2) - 4*A(1,3)/3;
  A(1,5) = -tt(1)*vel(elem)/2 + A(1,2)/2 + A(1,3)/2;
  %Coeficientes del polinomio de aceleracion
  A(3,1) = qf(elem,1);
  A(3,2) = qf(elem,2)*tt(3);
  A(3,3) = qf(elem,3)*tt(3)^2/2;
  A(3,4) = tt(3)*vel(elem) - A(3,2) + 4*A(3,3)/3;
  A(3,5) = (tt(3)*vel(elem) - A(3,2) + A(3,3))/2;

  %Espacio recorrido en los anteriores intervalos
  x1 = A(1,2) + A(1,3) + A(1,4) + A(1,5);
  x3 = A(3,2) - A(3,3) + A(3,4) - A(3,5);
  x2 = qf(elem,1) - q0(elem,1) - ( x1 + x3);
  %Tiempo real a velocidad maxima.
  tt(2) = x2/vel(elem);
  %Coeficientes del polinomio de velocidad.
  A(2,1) = A(1,1) + A(1,2) + A(1,3) + A(1,4) + A(1,5);
  A(2,2) = vel(elem)*tt(2);
  %******************************** CASO 2******************************
  elseif caso == 2
  t = (ti + tf)/2;
  tt = [ t t ];
  A = zeros(2,5);
  % Arranque del motor.
  A(1,1) = q0(elem,1);
  A(1,2) = q0(elem,2)*tt(1);
  A(1,3) = q0(elem,3)*tt(1)^2/2;
  % Desaceleracion del motor.
  A(2,1) = qf(elem,1);
  A(2,2) = qf(elem,2)*tt(2);
  A(2,3) = qf(elem,3)*tt(2)^2/2;

  % Los polinomios para este caso son de quinto orden.
  B = [ 1 1 1 -1;
   6/tt(1)^2 12/tt(1)^2 0 0;
   3/tt(1) 4/tt(1) -3/tt(2) 4/tt(2);
   0 0 -6/tt(2)^2 12/tt(2)^2 ];
  b = [ -A(1,1) + A(1,2) + A(1,3) + A(2,1) - A(2,2) + A(2,3);
   -2*A(1,3)/tt(1)^2;
   -(A(1,2) + 2*A(1,3))/tt(1) + (A(2,2) - 2*A(2,3))/tt(2);
   -2*A(2,3)/tt(2)^2 ];
  x = inv(B)*b;
  % Coeficientes 4 y 5 de cada segmento.
  A(1,4) = x(1);
  A(1,5) = x(2);
  A(2,4) = x(3);
  A(2,5) = x(4);
  end;
  % Para cuando el motor no se mueve.
  else
  caso = 2;
  tt = [0 0 0];
  A = zeros(2,5);
  end;
return