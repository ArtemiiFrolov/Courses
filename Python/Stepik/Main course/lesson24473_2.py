'''Вам дано описание наследования классов в формате JSON.
Описание представляет из себя массив JSON-объектов, которые соответствуют классам. У каждого JSON-объекта есть поле name, которое содержит имя класса, и поле parents, которое содержит список имен прямых предков.

Пример:
[{"name": "A", "parents": []}, {"name": "B", "parents": ["A", "C"]}, {"name": "C", "parents": ["A"]}]'''
import json
classes = input()
classes = json.loads(classes)
l = {}
l1 = {}
for i in classes:
    l[i["name"]] = i["parents"]
for i in l:
    for j in l[i]:
        if j in l1:
            if i not in l1[j]:
                l1[j].append(i)
        else:
            l1[j] = [i,]
    if i not in l1:
        l1[i] = []
def check_list(a, b):
    for i in l1[b]:
        if i not in l1[a]:
            l1[a].append(i)
        if i in l1:
            check_list(a, i)
    return

for i in l1:
    check_list(i,i)
for i in sorted(l1):
    print (i,":", len(l1[i])+1)

