l = {}


def check_class(a, b):
    if b not in l:
        return 0
    if a in l[b] or a == b:
        return 1
    elif l[b] == "empty":
        return 0
    else:
        s = 0
        for i in l[b]:
            s += check_class(a, i)
        return s


for i in range(int(input())):
    s = input().split()
    if ":" in s:
        l[s[0]] = s[2:]
    else:
        l[s[0]] = "empty"
for i in range(int(input())):
    s = input().split()
    if check_class(s[0], s[1]) > 0:
        print("Yes")
    else:
        print("No")
