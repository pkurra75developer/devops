# For loop with sets
# EXAMPLE: for loop with set
majorCities = {"London", "New York", "Tokyo", "Paris", "Beijing"}

print("1. Basic for loop (unordered):")
for city in majorCities:
    print(f"{city}")
print()

print("2. Sorted output (alphabetical order):")
for city in sorted(majorCities):
    print(city)
print()

print("3. Enumerate (index + city):")
for index, city in enumerate(majorCities):
    print(f"{index + 1}. {city}")
print()

print("4. All cities in one line (joined string):")
print(", ".join(majorCities))
print()

print("5. Loop using list conversion (index access):")
cityList = list(majorCities)
for i in range(len(cityList)):
    print(f"{i}: {cityList[i]}")
