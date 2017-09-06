'''Рассмотрим два HTML-документа A и B.
Из A можно перейти в B за один переход, если в A есть ссылка на B, т. е. внутри A есть тег <a href="B">, возможно с дополнительными параметрами внутри тега.
Из A можно перейти в B за два перехода если существует такой документ C, что из A в C можно перейти за один переход и из C в B можно перейти за один переход.

Вашей программе на вход подаются две строки, содержащие url двух документов A и B.
Выведите Yes, если из A в B можно перейти за два перехода, иначе выведите No.

Обратите внимание на то, что не все ссылки внутри HTML документа могут вести на существующие HTML документы.'''
import requests, re
line_from, line_out = input(), input()
res = requests.get(line_from)
pattern = r'<a href="(.*)">'
links = re.findall(pattern, res.text)
flag = "No"
for link in links:
    res = requests.get(link)
    links_2 = re.findall(pattern, res.text)
    if line_out in links_2:
        flag = "Yes"
print(flag)
