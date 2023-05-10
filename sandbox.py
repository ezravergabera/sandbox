# try:
#     age = int(input("Age: "))
#     income = 20000
#     risk = income / age
#     print(age)
# except ValueError:
#     print('Not a valid number')
# except ZeroDivisionError:
#     print('Age cannot be 0')

# input = 0

# x1, y1, x2, y2 = input().split()

# print(x1 + y1 + x2 + y2)

import pyautogui as py
import time as t
import random

t.sleep(1)

strng = ""
number_of_letter = random.randint(5, 10)

for j in range(1, number_of_letter + 1):
    number = random.randint(1, 2)
    if number == 1:
        number = "1"
        strng = strng + number

py.typewrite(strng)
