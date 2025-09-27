# Example of datatypes

# Integer datatypes
yesterdayTemp = -30
todayTemp = 15

# Float
piValue  = 3.145
negativeBalance = -0.4578

# Boolean
isUgly = False

# Empty and None
empCaste = ""
empSexualOrientation = None

print(type(yesterdayTemp))
print(type(todayTemp))
print(type(piValue))
print(type(negativeBalance))
print(type(isUgly))
print(type(empCaste))
print(type(empSexualOrientation))

# Truthy Falsy for strings

print("*"*10)
print("strings")
print("*"*10)

x = ""
print(bool(x))
y = "hello"
print(bool(y))


# Truthy Falsy for int

print("*"*10)
print("int")
print("*"*10)


p = 0
q = 1

print(bool(p))
print(bool(q))

# Truthy Falsy for None

print("*"*10)
print("None")
print("*"*10)


validOffer = ""
discountAvailable = None # Note: If you put None in double quotes it will be a string! :)

print(bool(validOffer))
print(bool(discountAvailable))