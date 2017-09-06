'''Вам дана последовательность строк.
В каждой строке замените все вхождения подстроки "human" на подстроку "computer"﻿ и выведите полученные строки'''
import re

pattern = r"human"
repl = r"computer"
line = input()
out_line = ""
while line:
    out_line += re.sub(pattern, repl, line) +"\n"
    line = input()
print(out_line)

