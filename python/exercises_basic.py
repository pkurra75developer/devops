# Print numbers 1 to 20
# Use a for loop.
# for i in range(1,21):
#     print(i)


# Sum of first N natural numbers
# Take input N from user.
# Calculate sum using a loop.

# N = int(input("Enter value for N:"))
# sum = 0
# for i in range(1, N+1):
#     sum = sum + i
# print(f"The sum of first {N} numbers is: {sum}")


# Print even numbers between 1 and 50
# for i in range(1,50):
#     if i%2 == 0:
#         print(i)

# Count vowels in a string
# Take input string.
# Count and print number of vowels (a, e, i, o, u).
# mystr = input("Enter a string:")
# vowelList = {"a", "e", "i", "o", "u"} # Note: you can use tuple or list in this case. Not just a  set!
# vowelCount = 0

# for character in mystr:
#     if character.lower() in vowelList:
#         vowelCount += 1
# print(f"Number of vowels in the given string: {vowelCount}")

# Find the largest number in a list
# Given a list (hardcode it).
# Print the largest number.

# myList = [2,55,888,9,100]
# myList = sorted(myList)
# print(myList[len(myList)-1])


# -------------------------------
# BETTER PROGRAMMING
#-----------------------------

# basic_python_exercises.py

# -------------------------------
# 1. Print numbers 1 to 20
print("1. Numbers from 1 to 20:")
for i in range(1, 21):
    print(i, end=' ')
print("\n" + "-" * 40)

# -------------------------------
# 2. Sum of first N natural numbers
N = int(input("2. Enter a value for N to find sum of first N numbers: "))
total = 0
for i in range(1, N + 1):
    total += i
print(f"The sum of first {N} numbers is: {total}")
print("-" * 40)

# -------------------------------
# 3. Print even numbers between 1 and 50
print("3. Even numbers between 1 and 50:")
for i in range(2, 51, 2):
    print(i, end=' ')
print("\n" + "-" * 40)

# -------------------------------
# 4. Count vowels in a string
input_str = input("4. Enter a string to count vowels: ")
vowels = {"a", "e", "i", "o", "u"}
vowel_count = 0

for char in input_str:
    if char.lower() in vowels:
        vowel_count += 1

print(f"Number of vowels in the given string: {vowel_count}")
print("-" * 40)

# -------------------------------
# 5. Find the largest number in a list
numbers = [2, 55, 888, 9, 100]
max_num = numbers[0]

for num in numbers:
    if num > max_num:
        max_num = num

print(f"5. The largest number in {numbers} is: {max_num}")
print("-" * 40)



