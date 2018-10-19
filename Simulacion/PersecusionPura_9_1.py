#!/usr/bin/env python3

import numpy as np
import math 
from matplotlib import pyplot as plt


# punto actual Debe ir cambiando
x = float(input('Ingrese el punto inicial en X: '))
y = float(input('Ingrese el punto inicial en Y: '))
teta = float(input('Ingrese el angulo con el que sale en vehiculo: '))
v = float(input('Ingrese la velocidad del vehiculo: '))

#punto objetivo
Xob = float(input('Ingrese el punto objetivo en X: '))
Yob = float(input('Ingrese el punto objetivo en Y: '))


deltaX = (Xob - x)*math.cos(teta) + (Yob - y)*math.sin(teta)

L =  math.sqrt((Xob - x)**2 + (Yob - y)**2)

xC=[]

i = False
while i == False:  
    x = -v * math.sin(teta) + x
    y = v * math.cos(teta) + y
    deltaX = (Xob - x)*math.cos(teta) + (Yob - y)*math.sin(teta)
    L =  math.sqrt((Xob - x)**2 + (Yob - y)**2)
    curvatura = -(2*deltaX)/(L**2)
    teta = v * curvatura
    xC.append([x,y])
    if x >= Xob or y >= Yob:
        i = True
        

#print('Distancia es: ',L )
#print('Delta X es: ',X )
#print('curvatura es: ',curvatura )

X2 = np.linspace(x,Xob, len(xC),endpoint=True)
Y2 = X2 

plt.plot(X2)
plt.plot(xC)

plt.show()
