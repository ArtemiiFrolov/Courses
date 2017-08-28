class ExtendedStack(list):
    def sum(self):
        self.append(int(self.pop([-1]))+ int(self.pop([-1])))

    def sub(self):
        self.append(int(self.pop([-1])) - int(self.pop([-1])))# операция вычитания

    def mul(self):
        self.append(int(self.pop([-1])) * int(self.pop([-1])))# операция умножения

    def div(self):
        self.append(int(self.pop([-1])) // int(self.pop([-1])))# операция целочисленного деления