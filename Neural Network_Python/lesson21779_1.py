'''
Итак, мы знаем, как посчитать «назад» ошибку из l+1l+1 слоя в ll-й. Чтобы это знание не утекло куда подальше, давайте сразу его запрограммируем. Заодно вспомним различия между .dot и *.

Напишите функцию, которая, используя набор ошибок δl+1δl+1 для nn примеров, матрицу весов Wl+1Wl+1 и набор значений сумматорной функции на ll-м шаге для этих примеров, возвращает значение ошибки δlδl на ll-м слое сети.

Сигнатура: get_error(deltas, sums, weights), где deltas — ndarray формы (nn, nl+1nl+1), содержащий в ii-й строке значения ошибок для ii-го примера из входных данных, sums — ndarray формы (nn, nlnl), содержащий в ii-й строке значения сумматорных функций нейронов ll-го слоя для ii-го примера из входных данных, weights — ndarray формы (nl+1nl+1, nlnl), содержащий веса для перехода между ll-м и l+1l+1-м слоем сети. Требуется вернуть вектор δlδl — ndarray формы (nlnl, 1); мы не проверяем размер (форму) ответа, но это может помочь вам сориентироваться. Все нейроны в сети — сигмоидальные. Функции sigmoid и sigmoid_prime уже определены.
'''
import numpy as np


def get_error(deltas, sums, weights):
    first = weights.T.dot(deltas.T)
    second = first.T * sigmoid_prime(sums)
    return np.mean(second, axis=0)