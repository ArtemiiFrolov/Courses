'''Вам дано описание пирамиды из кубиков в формате XML.
Кубики могут быть трех цветов: красный (red), зеленый (green) и синий (blue﻿).
Для каждого кубика известны его цвет, и известны кубики, расположенные прямо под ним.
Введем понятие ценности для кубиков. Самый верхний кубик, соответствующий корню XML документа имеет ценность 1. Кубики, расположенные прямо под ним, имеют ценность 2. Кубики, расположенные прямо под нижележащими кубиками, имеют ценность 3. И т. д.
Ценность цвета равна сумме ценностей всех кубиков этого цвета.
Выведите через пробел три числа: ценности красного, зеленого и синего цветов.'''
from xml.etree import ElementTree
l = {"blue":0, "red": 0, "green": 0}
def counter(root, a):
    for child in root:
        l[child.attrib["color"]] += a
        counter(child, a+1)

root = ElementTree.fromstring(input())
l[root.attrib["color"]] += 1
counter(root, 2)
print (l["red"], l["green"], l["blue"])