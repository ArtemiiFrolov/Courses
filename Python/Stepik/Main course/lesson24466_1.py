from simplecrypt import decrypt
s = []
ouf = open("output.txt", 'w')
with open("encrypted.bin", "rb") as inp:
    with open("input.txt") as pas:
        for line in pas:
            s.append(line.strip())
    enc = inp.read()
    for i in s:
        try:
            line2 = decrypt(i, enc).decode('utf8')
        except BaseException:
            line2 = "Пароль "+i+" не подходит\n"
        ouf.write(line2)
ouf.close()