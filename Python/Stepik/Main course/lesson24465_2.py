import os
import os.path

s = []
for current_dir, dirs, files in os.walk("main"):
    flag = False
    for file in files:
        if file.endswith(".py"):
            flag = True
    if flag:
        s.append(current_dir)
s.sort()
for i in s:
    print (i)