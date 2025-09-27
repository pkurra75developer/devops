# Read and Append to existing files

# f = open("testfiles/names.txt","r")
# print(f.read()) # Read the entire file contents
# print(f.read(10)) # Read only first 7 characters

# print(f.readline()) # Read the first line
# print(f.readline()) # If you give again, it will read next line but
                    # there will be a blank line in between.

# print all lines by looping thru
# for line in f:
#     print(line)

# If you notice carefully, print will automatically add a new line.
# so, you will get extra lines in between for every print statment
# to avoid it, you can strip or use end ='' as below

# for line in f:
#     print(line.strip())

# for line in f:
#     print(line, end='')

# f.close # Its important to close becuase if you make some changes
        # to the file, they will NOT be reflected until you close


# EXCEPTION
# note: in the finally, 
# we gave another try - for a reason. see comments

# try:
#     f = open("testfiles/namesk.txt","r")
#     print(f.read())
# except:
#     print("File doesn't exist")
# finally: 
#     try:
#         f.close()
#     except:
#         pass # File wasn't opened, so nothing to close


# understanding WITH
# What is with in Python?
# with is just a clean, safe way to manage resources (like files, locks, network connections, etc.)
# Think of it like this:
# "Do some setup → run your code → do some cleanup automatically."
# ✅ Real-World Analogy
# Imagine you're using a public toilet 🚽:
# You unlock the stall door → __enter__
# You do your business → your code
# You close the door behind you → __exit__
# You don't want to forget closing the door.
# Python's with ensures that the "door" always gets closed — even if your code crashes inside.

# What is with Called in Python?
# with is a context management statement,
# and it's used to work with a context manager.
# So:
# with → the context manager syntax
# The object after with → a context manager

# Same example with with

# try:
#     with open("testfiles/namesk.txt", "r") as f:
#         print(f.read())
# except FileNotFoundError:
#     print("File doesn't exist")
# except Exception as e:
#     print(f"An unexpected error occurred: {e}")

# APPEND - is to add new lines to the end of the file
# NOte: if the file doesn't exist, it will create
# f = open("testfiles/cities.txt", "a")
# f.write("New York")
# f.write("Delhi")
# f.close

# WRITE - is to overwrite the contents of the existing file
# NOte: if the file doesn't exist, it will create
# f = open("testfiles/citiesnew.txt", "w")
# f.write("Amsterdam\n")
# f.close

# CREATE NEW FILE
# nOTE: write is to write 1 string, writeline is for list of strings
# but \n should be there after every string

# try:
#     f = open("testfiles/newlycreated", "x")
#     f.write("Hello")
#     f.write("Zello")
#     f.close()
# except Exception as e:
#     print("{e}")



with open("testfiles/jimari.log", "a") as f:
    f.write("I am a jimari")
f.close()





