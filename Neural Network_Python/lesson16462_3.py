'''Задача: считайте данные из файла и посчитайте их средние значения.

На вход вашему решению будет подан адрес, по которому расположен csv-файл, из которого нужно считать данные. Первая строчка в файле — названия столбцов, остальные строки — числовые данные (то есть каждая строка, кроме первой, состоит из последовательности вещественных чисел, разделённых запятыми).'''
from urllib.request import urlopen
import numpy as np

filename = input()
f = urlopen(filename)

a = np.loadtxt(f,skiprows=1,delimiter=",")
print(a.mean(axis=0))