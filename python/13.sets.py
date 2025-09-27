# Sets
# Similar to Dictionaries. But no Keys!
# Use curly braces like Dictionaries
# Values are unique. Even if we had the same value, it will not throw error. But no additional item will be added.
# Not displayed in the same order of adding.
# Even if you added them in a certain order, Python internally stores them based on hash values,
# not position.
# empty set defined as myBasket = set()  # Not {}

itemList = {"lamp", "box", "umbrella","coat"}
print(itemList)
itemList.add("mouse")
print(itemList)

# create an empty set and add
myBasket = set()  # Not {}
myBasket.add("Roses")
myBasket.add("Lilies")
myBasket.add("Jasmines")

print(myBasket)

# removing items
# myBasket.remove("lotus")  # Raises error if not found
myBasket.discard("lotus")  # No error if not found

# duplicates removed automatically

s = {"apple", "banana", "apple"}
print(s)  # Output: {'apple', 'banana'}


# Union/intersection/difference/Symmetric diff
# Set Union (|) or union()
a = {"apple", "banana"}
b = {"banana", "cherry"}
print(a | b)  # {'apple', 'banana', 'cherry'}

# 🎯 Set Intersection (&) or intersection()
print(a & b)  # {'banana'}

# 🎯 Set Difference (-) or difference()
print(a - b)  # {'apple'}

# 🎯 Set Difference (-) or difference()
print(b - a)  # {'cherry'}

# 🎯 Symmetric Difference (^)
print(a ^ b)  # {'apple', 'cherry'}

# ✅ Real-World Examples
# 1. Removing duplicates from a list
names = ["Alice", "Bob", "Alice", "Tom"]
unique_names = set(names)
print(unique_names)  # {'Alice', 'Tom', 'Bob'}

# 2. Checking membership
banned_words = {"spam", "scam", "fake"}
word = "spam"
if word in banned_words:
    print("This is a banned word!")

# 3. Finding common tags between two articles
article1_tags = {"python", "data", "machine learning"}
article2_tags = {"python", "deep learning", "AI"}
common = article1_tags & article2_tags
print(common)  # {'python'}

# Frozen sets
# 🧪 Bonus: Frozen Sets
# If you want an immutable set (cannot change after creation):

fs = frozenset(["a", "b", "c"])
print(fs)