# Complete String Methods Demonstration

s = "Hello123"
t = "  hello world  "
u = "Python-is-fun"
v = "12345"
w = " "
bytes_str = b"hello"

print("=== Check Types or Characteristics ===")
print(f"s.isalnum(): {s.isalnum()}")      # True
print(f"s.isalpha(): {s.isalpha()}")      # False (digits present)
print(f"v.isdigit(): {v.isdigit()}")      # True
print(f"w.isspace(): {w.isspace()}")      # True
print(f"'hello'.islower(): {'hello'.islower()}")  # True
print(f"'HELLO'.isupper(): {'HELLO'.isupper()}")  # True
print(f"'Hello World'.istitle(): {'Hello World'.istitle()}")  # True
print(f"s.isascii(): {s.isascii()}")      # True
print(f"'你好'.isascii(): {'你好'.isascii()}")   # False

print("\n=== Case Conversions ===")
print(f"s.lower(): {s.lower()}")
print(f"s.upper(): {s.upper()}")
print(f"t.capitalize(): '{t.capitalize()}'")  # Note the quotes show whitespace
print(f"t.title(): '{t.title()}'")
print(f"s.swapcase(): {s.swapcase()}")

print("\n=== Searching and Counting ===")
print(f"s.find('lo'): {s.find('lo')}")    # index 3
print(f"s.index('lo'): {s.index('lo')}")
print(f"s.count('l'): {s.count('l')}")

print("\n=== Trimming / Stripping ===")
print(f"t.strip(): '{t.strip()}'")
print(f"t.lstrip(): '{t.lstrip()}'")
print(f"t.rstrip(): '{t.rstrip()}'")

print("\n=== Replacing ===")
print(f"u.replace('-', ' '): {u.replace('-', ' ')}")

print("\n=== Splitting and Joining ===")
print(f"t.split(): {t.split()}")
print(f"u.split('-'): {u.split('-')}")
print(f"' '.join(['Hello', 'World']): {' '.join(['Hello', 'World'])}")

print("\n=== Startswith / Endswith ===")
print(f"s.startswith('Hel'): {s.startswith('Hel')}")
print(f"s.endswith('123'): {s.endswith('123')}")
print(f"s.startswith('e', 1): {s.startswith('e', 1)}")  # True
print(f"s.endswith('lo', 0, 4): {s.endswith('lo', 0, 4)}")  # True

print("\n=== Other Useful Methods ===")
print(f"len(s): {len(s)}")
print(f"s.center(12, '*'): '{s.center(12, '*')}'")
print(f"s.ljust(12, '-'): '{s.ljust(12, '-')}'")
print(f"s.rjust(12, '-'): '{s.rjust(12, '-')}'")
print(f"s.zfill(10): '{s.zfill(10)}'")  # Pads with zeros left

print("\n=== Partition and Rpartition ===")
print(f"'a-b-c'.partition('-'): {'a-b-c'.partition('-')}")
print(f"'a-b-c'.rpartition('-'): {'a-b-c'.rpartition('-')}")

print("\n=== Encoding / Decoding ===")
print(f"bytes_str: {bytes_str}")
print(f"bytes_str.decode('utf-8'): {bytes_str.decode('utf-8')}")
print(f"s.encode('utf-8'): {s.encode('utf-8')}")

print("\n=== Expand Tabs ===")
print(f"{'1\t2\t3'.expandtabs(4)}")


print("\n=== Is Identifier ===")
print(f"'abc123'.isidentifier(): {'abc123'.isidentifier()}")  # True
print(f"'123abc'.isidentifier(): {'123abc'.isidentifier()}")  # False (starts with digit)
print(f"'var_name'.isidentifier(): {'var_name'.isidentifier()}")  # True

print("\n=== Is Decimal / Numeric ===")
print(f"'123'.isdecimal(): {'123'.isdecimal()}")   # True
print(f"'²³'.isnumeric(): {'²³'.isnumeric()}")     # True

print("\n=== Remove Prefix / Suffix (Python 3.9+) ===")
print(f"'TestString'.removeprefix('Test'): {'TestString'.removeprefix('Test')}")
print(f"'filename.txt'.removesuffix('.txt'): {'filename.txt'.removesuffix('.txt')}")

print("\n=== Escape Characters ===")
print("Hello\\nWorld prints as:")
print("Hello\nWorld")
print("Hello\\tWorld prints as:")
print("Hello\tWorld")
print("Path with backslash:")
print("C:\\Users\\Name")
print(r"Raw string: C:\Users\Name")  # raw string disables escapes