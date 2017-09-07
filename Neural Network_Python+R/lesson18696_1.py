'''Теперь давайте попробуем применить наши новые матричные формулы — сначала на игрушечном примере, который мы рассматривали пару видео назад.

У нас есть набор данных: знания о длине тормозного пути и скорости для трёх автомобилей
Напишите через запятую оценки коэффициентов линейной регрессии DD на VV, т.е. β^0β^0, β^1β^1 для модели D=β0+β1V+εD=β0+β1V+ε с точностью до трёх знаков после точки.'''
from urllib.request import urlopen
import numpy as np
from numpy.linalg import inv

x_shape = tuple(map(int, input().split()))
X = np.fromiter(map(int, input().split()), np.int).reshape(x_shape)
print(X)
y_shape = tuple(map(int, input().split()))
Y = np.fromiter(map(int, input().split()), np.int).reshape(y_shape)
b = X.transpose().dot(X)
b = inv(b)
b = b.dot(X.transpose()).dot(Y)
print(b)