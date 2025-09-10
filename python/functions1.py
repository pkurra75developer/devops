# Functions
# def addNumbers(num1, num2, num3, num4):
#     total = num1 + num2 + num3 + num4
#     print(total)

# addNumbers(1,2,3,4)

# another example

# def addNumbers(num1, num2, num3, num4):
#     total_1 = num1 + num2
#     total_2 = num3 + num4
#     print(total_1, total_2)

# addNumbers(1,2,3,4)

# EXAMPLE Returning values
# def addNumbers(num1,num2):
#     total = num1 + num2
#     return total

# # x = addNumbers(1,2)
# # print(x)
# # or
# print(addNumbers(3,100))

# EXAMPLE WITH ARGUMENT NAMES

def greet(name, salute="Mr./Ms."):
    print(f"Hello, {salute} {name}!")

greet(salute="Dr.", name="Clara")  # Hello, Dr. Clara!

# EXAMPLE - with default values

def funGreet(name, salute = 'Sir'):
    retText = f"Good Morning {salute} {name}"
    return retText

# MULTIPLE ARGUMENTS

def add_all(*args):
    return sum(args)

print(add_all(1, 2, 3))  # Output: 6
print(add_all(5, 10))    # Output: 15

# **kwargs — for arbitrary keyword arguments (dictionary)
def print_info(**kwargs):
    for key, value in kwargs.items():
        print(f"{key}: {value}")

print_info(name="Alice", age=30)
# Output:
# name: Alice
# age: 30

# 7. Combination of Parameters
# Order is important: normal args, *args, default args, **kwargs.

def func(a, b=2, *args, **kwargs):
    print(f"a={a}, b={b}")
    print(f"args={args}")
    print(f"kwargs={kwargs}")

func(1, 3, 4, 5, x=10, y=20)
# a=1, b=3
# args=(4, 5)
# kwargs={'x': 10, 'y': 20}

# Anonymous Functions (Lambda)
# Used often in functions like map(), filter(), sorted().
# Short single-expression functions.

square = lambda x: x * x
print(square(5))  # Output: 25


# Docstrings
# Documentation inside function.

def greet(name):
    """
    Prints greeting to the given name.
    """
    print(f"Hello, {name}!")

help(greet)  # Shows the docstring

# Function Annotations
# Optional metadata about argument and return types.
# Note: Python doesn't enforce types; annotations are for readability/tools.
def add(a: int, b: int) -> int:
    return a + b

print(add(3, 4))  # Output: 7


# Nested Functions
# Define a function inside another.

def outer():
    print("Outer function")

    def inner():
        print("Inner function")

    inner()

outer()
# Output:
# Outer function
# Inner function

# 12. Returning Functions
# Functions can return other functions.
def outer():
    def inner():
        print("Hello from inner")
    return inner

f = outer()
f()  # Output: Hello from inner

# Higher-Order Functions
# Functions that take functions as arguments.

def apply_func(f, x):
    return f(x)

print(apply_func(lambda n: n*2, 5))  # Output: 10

# Decorators
# Functions that modify behavior of other functions.

def decorator(func):
    def wrapper():
        print("Before function")
        func()
        print("After function")
    return wrapper

@decorator
def say_hello():
    print("Hello!")

say_hello()
# Output:
# Before function
# Hello!
# After function

# 15. Recursion
# Functions calling themselves.

def factorial(n):
    if n == 0:
        return 1
    else:
        return n * factorial(n-1)

print(factorial(5))  # Output: 120


# ANOTHER INPUT EXAMPLE

user_input = input("Enter your Name and Salution separated by comma(,)\(Note: Salutation is optional): ")
parts = user_input.split(',')

# cleaned_parts = []
# for p in parts:
#     cleaned_parts.append(p.strip()) # p.strip() will remove leading and trailinng spaces!
# parts = cleaned_parts

# The above 4 lines of code can be written using list comprehension as below

parts = [p.strip() for p in parts] # This is called list comprehension (to write smaller and readable code)

if len(parts) == 1:
    print(funGreet(parts[0]))
elif len(parts) == 2:
    print(funGreet(parts[0],parts[1]))
else:
    print("Invalid input")
    




