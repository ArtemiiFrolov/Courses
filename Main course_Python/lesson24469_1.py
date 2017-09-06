s = input()
a = input()
b = input()
k = 0
if a == b:
    print("Impossible")
else:
    while True:
        if a in s:
            s = s.replace(a, b)
            k += 1
        else:
            break
    print(k)