#!/usr/bin/env python3
# '''Hello to the world from ev3dev.org'''

# import os
# import sys
# import time

from ev3dev2.ev3 import *
from time import sleep
import math


Xob = 8
Yob = 8
v = 0.5
x = 0
y = 0
tetha = 0
l = 4
movimientosX = [x]
movimientosY = [y]

ruedaDerecha = LargeMotor('outC')
ruedaIzquierda = LargeMotor('outB')

gyro = GyroSensor()
gyro.mode = 'GYRO-ANG'
unidades = gyro.units
angulo = gyro.value()
sleep(1)

def Caminar():
    ruedaDerecha.run_timed(time_sp = 1000, speed_sp = 260)
    ruedaIzquierda.run_timed(time_sp = 1000, speed_sp = 260)
    angulo = gyro.value()

def Girar(ang,tetha):
    diferencia =  ang - tetha
    while math.fabs(math.fabs(ang) - math.fabs(tetha)) > 10:
        if diferencia > 0:
            ruedaDerecha.run_timed(time_sp = 40, speed_sp = -260)
            ruedaIzquierda.run_timed(time_sp = 40, speed_sp = 260)
        else:
            ruedaDerecha.run_timed(time_sp = 40, speed_sp = 260)
            ruedaIzquierda.run_timed(time_sp = 40, speed_sp =-260)
        ang = gyro.value()
        sleep(1)
    
def PersecusionPura(tetha,x,y):
    x = -v * math.sin(tetha) + x
    y = v * math.cos(tetha) + y
    deltaX = (Xob - x) * math.cos(tetha) + (Yob - y) * math.sin(tetha)
    curvatura = -(2 * deltaX)/(l**2)
    tetha += v * curvatura
    movimientosX.append(x)
    movimientosY.append(y)
    return ang,x,y

while True:
    tetha,x,y = PersecusionPura(tetha,x,y)
    tetha = math.degrees(tetha)
    ang = gyro.value()
    Girar(ang,tetha)
    Caminar()
    sleep(1)
    if math.fabs(x) >= Xob or math.fabs(y) >= Yob:
        break


