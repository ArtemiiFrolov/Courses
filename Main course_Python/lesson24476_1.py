'''В этой задаче вам необходимо воспользоваться API сайта numbersapi.com

Вам дается набор чисел. Для каждого из чисел необходимо узнать, существует ли интересный математический факт об этом числе.

Для каждого числа выведите Interesting, если для числа существует интересный факт, и Boring иначе.
Выводите информацию об интересности чисел в таком же порядке, в каком следуют числа во входном файле.'''
import requests
with open("input.txt") as f:
    for i in f:
        api_url = "http://numbersapi.com/{}/math".format(int(i))
        params = {"json" : True }
        res = requests.get(api_url,params)
        data = res.json()
        if data["found"]:
            print("Interesting")
        else:
            print("Boring")