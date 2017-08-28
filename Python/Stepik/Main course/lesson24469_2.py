s = input()
t = input()
s1 = s
k = 0
while True:
    if t in s1:
        l = s1.find(t)
        k += 1
        if l < len(s) - 1:
            s1 = s1[(l + 1):]
        else:
            break
    else:
        break
print(k)
