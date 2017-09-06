'''Вам дана последовательность строк.
В каждой строке замените все вхождения нескольких одинаковых букв на одну букву.
Буквой считается символ из группы \w.'''
import re

pattern = r"(\w)(\1)+"
repl = r"\1"
line = input()
out_line = ""
while line:
    out_line += re.sub(pattern, repl, line) +"\n"
    line = input()
print(out_line)

