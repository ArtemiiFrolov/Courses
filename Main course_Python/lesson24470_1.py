import re

pattern = r"cat"
line = input()
out_line = ""
while line:
    if len(re.findall(pattern, line)) > 1:
        out_line += line+"\n"
    line = input()
print(out_line)

