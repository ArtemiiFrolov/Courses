def get_def(a,b):
    if b in diction[a]:
        return a
    else:
        if a=="global":
            return "None"
        else:
            return get_def(diction[a][0],b)
diction = {'global': [], }
n = int(input())
for i in range(n):
    com = input().split()
    if com[0] == "create":
        diction[com[1]] = [com[2],]
    elif com[0] == "add":
        diction[com[1]] += [com[2]]
    else:
        print(get_def(com[1], com[2]))