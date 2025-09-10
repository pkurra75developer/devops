# String manipulation

# myStr = "Welcome to"
#          0123456789 
#          w e l c o m e   t o
#        -10-9-8-7-6-5-4-3-2-1
#  

myStr = "Welcome to"

print(myStr[1:4])   # 'elc'  (from index 1 up to but not including 4)
print(myStr[-4:-1]) # 'e t'  (from 3rd last to 2nd last character)
print(myStr[:3])    # 'Wel'  (start to index 2)
print(myStr[3:])    # 'come to'  (index 3 to end)
print(myStr[-3:])   # ' to'  (last 3 chars)

# Includes the character at start index.
# Excludes the character at end index.

yourStr = "Python is fun"
print(yourStr[-5:-1]) 
print(yourStr[-1:-5]) # this will print nothing. because slicing is +1 by default
# if you give step -1 as below
print(yourStr[-1:-5:-1]) # nuf and space. see the length. it will be 4. not 3
print(len(yourStr[-1:-5:-1]))


