'''Задача: перемножьте две матрицы'''
import numpy as np
x_shape = tuple(map(int, input().split()))
X = np.fromiter(map(int, input().split()), np.int).reshape(x_shape)
y_shape = tuple(map(int, input().split()))
Y = np.fromiter(map(int, input().split()), np.int).reshape(y_shape)
try:
    print(X.dot(Y.T))
except BaseException:
    print ("matrix shapes do not match")