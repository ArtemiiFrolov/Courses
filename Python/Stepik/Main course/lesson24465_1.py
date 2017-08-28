s = []
with open("input.txt") as inp, open("output.txt", "w") as ouf:
    for line in inp:
        s.append(line.rstrip())
    for line in reversed(s):
        ouf.write(line+'\n')