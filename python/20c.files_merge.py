# Read two files and create a new one!

# with open("testfiles/file3.txt", "w") as outfile:
#     for fname in ["testfiles/file1.txt", "testfiles/file2.txt"]:
#         try:
#             with open(fname, "r") as infile:
#                 contents = infile.read()
#                 outfile.write(contents)
#                 # Optional: add a newline or separator between files
#                 outfile.write("\n")  
#         except FileNotFoundError:
#             print(f"Warning: {fname} not found, skipping.")

# problem with the above code is that if no files are found,
# still the file3 is created.
# below code works good!

input_files = ["testfiles/file1.txt", "testfiles/file2.txt"]
contents_to_write = []

for fname in input_files:
    try:
        with open(fname, "r") as infile:
            contents_to_write.append(infile.read())
    except FileNotFoundError:
        print(f"Warning: {fname} not found, skipping.")

if contents_to_write:
    with open("file3.txt", "w") as outfile:
        for content in contents_to_write:
            outfile.write(content)
            outfile.write("\n")  # optional separator
    print("file3.txt created successfully.")
else:
    print("No input files found. file3.txt was not created.")
