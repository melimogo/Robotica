function [velo2,tmaximo]=sincronizador(q0,qf,velo)
  %--Calculo de tiempos aproximados.
  taprox = abs((qf(:,1)-q0(:,1)))./velo;
  tmaximo = max(taprox);
  %--Nueva velocidad maxima de cada motor.
  velo2=(qf(:,1)-q0(:,1))/tmaximo;
return