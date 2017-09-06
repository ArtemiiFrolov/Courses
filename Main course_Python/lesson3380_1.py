n = int(input())
l = {}
for i in range(n):
    s = input().split(';')
    if s[0] not in l:
        l[s[0]] = [0, 0, 0, 0]
    if s[2] not in l:
        l[s[2]] = [0, 0, 0, 0]
    if s[1] > s[3]:
        l[s[0]][1] += 1
        l[s[2]][3] += 1
    elif s[3] > s[1]:
        l[s[2]][1] += 1
        l[s[0]][3] += 1
    else:
        l[s[0]][2] += 1
        l[s[2]][2] += 1
    l[s[0]][0] += 1
    l[s[2]][0] += 1
for i in l:
    print(i,':', end="")
    for j in l[i]:
        print(j, end=" ")
    print(str(l[i][1]*3+l[i][2]*1))
