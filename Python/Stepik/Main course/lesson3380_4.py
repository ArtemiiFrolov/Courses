l = {'север': [0, 1], 'запад': [-1, 0], 'юг': [0, -1], 'восток': [1, 0]}
coord = [0, 0]
for i in range(int(input())):
    j = input().split()
    coord[0] += l[j[0]][0]*int(j[1])
    coord[1] += l[j[0]][1]*int(j[1])
print(coord[0], " ", coord[1])