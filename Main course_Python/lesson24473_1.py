'''Вам дана частичная выборка из датасета зафиксированных преступлений, совершенных в городе Чикаго с 2001 года по настоящее время.

Одним из атрибутов преступления является его тип – Primary Type.

Вам необходимо узнать тип преступления, которое было зафиксировано максимальное число раз в 2015 году.'''
import csv
crimes_dict = {}
with open("crimes.csv") as f:
    crimes = csv.reader(f)
    for crime in crimes:
        if crime[2][6:10] == "2015":
            if crime[5] not in crimes_dict:
                crimes_dict[crime[5]] = 0
            crimes_dict[crime[5]] += 1
a = max(crimes_dict.values())
for crime in crimes_dict:
    if crimes_dict[crime] == a:
        print (crime)