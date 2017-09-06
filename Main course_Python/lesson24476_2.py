'''В этой задаче вам необходимо воспользоваться API сайта artsy.net

API проекта Artsy предоставляет информацию о некоторых деятелях искусства, их работах, выставках.

В рамках данной задачи вам понадобятся сведения о деятелях искусства (назовем их, условно, художники).

Вам даны идентификаторы художников в базе Artsy.
Для каждого идентификатора получите информацию о имени художника и годе рождения.
Выведите имена художников в порядке неубывания года рождения. В случае если у художников одинаковый год рождения, выведите их имена в лексикографическом порядке.'''
import requests
import json

client_id = '814b52d56080e2f7bb19'
client_secret = '9236df2a10c356347dbda54c9a9d333f'

# инициируем запрос на получение токена
r = requests.post("https://api.artsy.net/api/tokens/xapp_token",
                  data={
                      "client_id": client_id,
                      "client_secret": client_secret
                  })

# разбираем ответ сервера
j = json.loads(r.text)

# достаем токен
token = j["token"]

# создаем заголовок, содержащий наш токен
headers = {"X-Xapp-Token" : token}
artists = []
with open("input.txt") as f:
    for i in f:
        r = requests.get("https://api.artsy.net/api/artists/{}".format(i.strip()), headers=headers)
        data = r.json()
        artists.append(data["birthday"]+data["sortable_name"])
for i in sorted(artists):
    print (i[4:])