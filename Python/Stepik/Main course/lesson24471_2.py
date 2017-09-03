'''Вашей программе на вход подается ссылка на HTML файл.
Вам необходимо скачать этот файл, затем найти в нем все ссылки вида <a ... href="..." ... > и вывести список сайтов, на которые есть ссылка.

Сайтом в данной задаче будем называть имя домена вместе с именами поддоменов. То есть, это последовательность символов, которая следует сразу после символов протокола, если он есть, до символов порта или пути, если они есть, за исключением случаев с относительными ссылками вида
<a href="../some_path/index.html">﻿.

Сайты следует выводить в алфавитном порядке.'''
import requests, re
a = set()
line_from = input().strip()
res = requests.get(line_from)
pattern = r'''<a.*?href.*?=.*?["'](.*?)["']'''
urls = re.findall(pattern, res.text)
pattern_2 = r"(.*?\:\/\/([^\/\:]*))"
pattern_3 = r"([^\/\:]*)"
for url in urls:
    if not(url[0] == "." and url[1] == "."):
        temp_urls = re.findall(pattern_2, url)
        if temp_urls:
            a.add(temp_urls[0][1])
        else:
            temp_urls = re.findall(pattern_3, url)
            a.add(temp_urls[0])
for i in sorted(a):
    print(i)