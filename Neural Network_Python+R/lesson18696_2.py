'''Найдите оптимальные коэффициенты для построения линейной регрессии.

Ваша задача — подсчитать вектор коэффициентов линейной регрессии для предсказания первой переменной (первого столбца данных) по всем остальным. Напомним, что модель линейной регрессии — это y=β0+β1x1+⋯+βnxny=β0+β1x1+⋯+βnxn.
Напечатайте коэффициенты линейной регрессии, начиная с β0β0, через пробел. Мы будем проверять совпадения с точностью до 4 знаков после запятой.'''
from urllib.request import urlopen
import numpy as np
from numpy.linalg import inv

fname = input()  # read file name from stdin
f = urlopen(fname)  # open file from URL
data = np.loadtxt(f, delimiter=',', skiprows=1)  # load data to work with
Y = data[:, 0:1]
X0 = np.ones_like(Y)
X1 = data[:, 1:]
X = np.hstack((X0, data[:, 1:]))
b = X.transpose().dot(X)
b = inv(b)
b = b.dot(X.transpose()).dot(Y)
print(" ".join(map(str, b.flatten())))
