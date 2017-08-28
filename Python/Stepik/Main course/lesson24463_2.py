l = {}
p = []
ans = []

def check_class(a,b):
    s = 0
    if a in l:
        for i in l[a]:
            if i in p[:b]:
                return 1
            else:
                s += check_class(i, b)
    return s

for i in range(int(input())):
    s = input().split()
    if ":" in s:
        l[s[0]] = s[2:]
    else:
        l[s[0]] = ["empty"]
for i in range(int(input())):
    p += [input()]
for i in p:
    if check_class(i, p.index(i)):
        if i not in ans:
            ans += [i]
for i in ans:
    print(i)