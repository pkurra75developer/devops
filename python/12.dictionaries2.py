# ✅ The Full Code:
text = "apple banana apple orange banana apple"
words = text.split()

word_count = {}
for word in words:
    word_count[word] = word_count.get(word, 0) + 1

print(word_count)

# 🧠 Explanation (Line by Line):
# 👉 Line 1:
# text = "apple banana apple orange banana apple"


# You're creating a string variable called text containing words separated by spaces.

# 🔎 Result:

# text = "apple banana apple orange banana apple"

# 👉 Line 2:
# words = text.split()


# You’re splitting the string into a list of individual words.

# split() (by default) splits the string wherever it finds spaces.

# 🔎 Result:

# words = ['apple', 'banana', 'apple', 'orange', 'banana', 'apple']

# 👉 Line 3:
# word_count = {}


# You’re creating an empty dictionary called word_count.

# This will be used to store the count of each word.

# 🔎 Initially:

# word_count = {}

# 👉 Line 4–6: Looping through the words
# for word in words:
#     word_count[word] = word_count.get(word, 0) + 1


# Let’s break this down in even more detail:

# 🔁 for word in words:

# You loop through each word in the words list:
# ['apple', 'banana', 'apple', 'orange', 'banana', 'apple']

# So the loop runs 6 times — once for each word.

# 💡 Inside the loop:
# word_count[word] = word_count.get(word, 0) + 1


# word_count.get(word, 0) tries to get the current count of that word in the dictionary.

# If the word already exists, it returns its value.

# If the word doesn’t exist yet, it returns 0 (the default).

# Then + 1 adds 1 to that count.

# Finally, it assigns this new value back to word_count[word].

# ✅ Let’s visualize the dictionary as it builds:
# Iteration	    word	    Before	      get() result	        After
# 1	            "apple"	    {}	            0	                {'apple': 1}
# 2	            "banana"	{'apple': 1}	0	                {'apple': 1, 'banana': 1}
# 3	            "apple"	    {'apple': 1}	1	                {'apple': 2, 'banana': 1}
# 4	            "orange"	{'apple': 2}	0	                {'apple': 2, 'banana': 1, 'orange': 1}
# 5	            "banana"	{'banana': 1}	1	                {'apple': 2, 'banana': 2, 'orange': 1}
# 6	            "apple"	    {'apple': 2}	2	                {'apple': 3, 'banana': 2, 'orange': 1}