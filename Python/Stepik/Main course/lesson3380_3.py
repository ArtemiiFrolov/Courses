d = set()
f = set()
for i in range(int(input())):
    d.add(input().lower())
for i in range(int(input())):
    for j in input().lower().split():
        if j not in d:
            f.add(j)
print(*f, sep='\n')