n1 = input()
n2 = input()
l1 = {}
l2 = {}
for i in range(len(n1)):
    l1[n1[i]] = n2[i]
    l2[n2[i]] = n1[i]
for i in input():
    print(l1[i], end="")
print()
for i in input():
    print(l2[i], end="")
