import sys
import string

alphList = {}
prevWord = {}
q = []
answer = []
with open("wordList.txt") as inp:
    for line in inp:
        alphList[''.join(sorted(line.strip()))] = line.strip()
begin, end = ''.join(sorted(sys.argv[1])), ''.join(sorted(sys.argv[2]))

q.append(begin)
flag = True
wrong = False
k = 0
while flag:
    if len(q)>k:
        if (q[k] != end) and (len(q)<len(alphList)):
            for i in range(len(q[k])):
                tmp = q[k][:i]+q[k][i+1:]
                if (tmp in alphList.keys()) and (tmp not in q):
                    q.append(tmp)
                    prevWord[tmp] = q[k]
            for i in string.ascii_lowercase:
                tmp = ''.join(sorted(q[k]+i))
                if tmp in alphList.keys() and (tmp not in q):
                    q.append(tmp)
                    prevWord[tmp] = q[k]
            k += 1
        else:
            flag = False
    else:
        wrong = True
        flag = False
if wrong:
    f = open('output.txt', 'w')
else:
    answer.append(end)
    while answer[0] != begin:
        answer.insert(0, prevWord[answer[0]])
        answer[1] = alphList[answer[1]]
    answer[0] = sys.argv[1]
    answer[-1] = sys.argv[2]
    with open("output.txt", "w") as ouf:
        for i in answer[:len(answer)-1]:
            ouf.write(i+'\n')
        ouf.write(answer[len(answer)-1])