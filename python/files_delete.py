# Delete files
import os

file_path = "testfiles/newlycreated"

try:
    os.remove(file_path)
    print(f"{file_path} deleted successfully.")
except FileNotFoundError:
    print(f"{file_path} does not exist.")
except PermissionError:
    print(f"No permission to delete {file_path}.")
except Exception as e:
    print(f"Error deleting file: {e}")