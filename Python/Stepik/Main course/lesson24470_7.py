'''Вам дана последовательность строк.
В каждой строке замените первое вхождение слова, состоящего только из латинских букв "a" (регистр не важен), на слово "argh".'''
import re

pattern = r"\ba+\b"
repl = "argh"
line = input()
out_line = ""
while line:
    out_line += re.sub(pattern, repl, line, count=1, flags=re.IGNORECASE) +"\n"
    line = input()
print(out_line)

