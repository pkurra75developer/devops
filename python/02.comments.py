# This is an example of single line comment
# this is another line of single line comment
# single line comments are written as below
# why single line comments are written with hash infront of them?

# if you think the below is a multiline comment, you are wrong!
# in Python, you don't have multi line comments like Java or C

# Python does parse the below stuff but as long as it is not assigned to 
# a variable it will discard!
# So, below is just an example of fake multiline comment. NOT 
# a multiline comment


'''Why multiple lines of comments are written this way?
I dont understand at all why multiple line comments are written.
Its is very surprising for me'''

""" It doesn't end up there. Multiple line comments are written with double quotes also
why python gave three double quotes for multiple line comments and also three single quotes for multiple 
lines of codes? a big question"""

# do you think what I wrote above will be ignored by python parser?
# lets try this out!

# VARIABLES
firstName = "Praveen"
middleName = "Kumar"
lastName = "Kurra"

print(firstName, middleName, lastName)


# if you run this program using python3 comments.py, did you notice that print function automatically
# adds a space in between your firstname, middlename and lastname? That's a 
# good thing to know

# how many arguments a print function can take?
# let's try it out!

# MULTIPLE ARGUMENTS FOR PRINT FUNCTION
print(1, 2, 3, 4, 5, 6, 7)
print("Hi"*3)
print("*"*30)
print("MAGIC")
print("*"*30)

# did you notice it takes n number of arguments!
# that is how it was written!

# BIG TEST VARIABLE
empName = "Raja"
empSal = 12000
empGrade = "B"
empPermanent = False
# # Below variable empIntro stores a long string that spans across multiple lines.
empIntro = '''I am a software engineer with 10 years of experience
in IT. Worked with multiple cultures in different countries. My strong points are
writing programs in python'''

print(empName + " " + "told, \"" + empIntro + "\".")

# NO ESCAPE CHARACTERS
# Since the single quote is inside double quote, no need of escape character
print("Hello this is Praveen's computer") 
# Since the double quote is inside single quote, no need of escape character
print('Rakesh told, "I am doing great!"')
# WITH ESCAPE CHARACTERS
print('Hello! this is Praveen\'s computer')
print("Rakesh told, \"I am doing great!\".")
# ESCAPE CHARACTERS ITSELF
print("This will be printed with a \ttab")
print("This will be printed in\ntwo lines")
print("Path is C:\bombayFolder\bombayfile.txt")
print("Do you need a backslash \\like this?")
print("Path is C:\Myfolder\myfile.txt")
print("Hello\vWorld")

# FORMATTING STRINGS

# RAW STRINGS. IGNORE ESCAPE CHARACTERS
print(r"I can put anything I want C:\\India")
name = "Krishna"
age  = 30
# FORMAT STRINGS - Embed expressions or variables as below
print(f"{name} is aged {age}")
# Same written as below
print(name + " is aged " + str(age))


