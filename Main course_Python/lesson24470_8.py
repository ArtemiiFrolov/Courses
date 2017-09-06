'''Вам дана последовательность строк.
В каждой строке поменяйте местами две первых буквы в каждом слове, состоящем хотя бы из двух букв.
Буквой считается символ из группы \w﻿.'''
import re

pattern = r"(\b\w)(\w)"
repl = r"\2\1"
line = input()
out_line = ""
while line:
    out_line += re.sub(pattern, repl, line) +"\n"
    line = input()
print(out_line)

