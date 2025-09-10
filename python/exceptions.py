# Exceptions
# try:
#     age = int(input("Enter your age:"))
#     test = 99/age
# except Exception as e:
#     print(f"Exception occured: {e}")
# try:
#     age = int(input("Enter your age:"))
#     test = 99/age
# except ValueError:
#     print(f"Please enter number")
# except ZeroDivisionError:
#     print(f"Age cannot be zero for this exercise")
# except Exception as e:
#     print(f"Some error occured: {e}")
# else:
#     print(f"Your age is {age} and 99/age is {test}")
# finally:
#     print("Thanks for using this program!")

#-------------------
# exception_examples.py

# 1. Basic try-except with ValueError
def example_basic_try_except():
    try:
        age = int(input("Enter your age: "))
        test = 99 / age
    except ValueError:
        print("❌ Please enter a number.")
    except ZeroDivisionError:
        print("❌ Age cannot be zero.")
    except Exception as e:
        print(f"❌ Some error occurred: {e}")
    else:
        print(f"✅ Your age is {age} and 99/age is {test}")
    finally:
        print("🧹 Finished basic try-except example.\n")


# 2. Catching multiple exceptions in one block
def example_multiple_exceptions():
    try:
        x = int("abc")  # ValueError
        y = 10 / 0       # ZeroDivisionError
    except (ValueError, ZeroDivisionError) as e:
        print(f"❌ Multiple exception caught: {e}")
    finally:
        print("🧹 Finished multiple exceptions example.\n")


# 3. Catching all exceptions (generic)
def example_catch_all():
    try:
        risky = undefined_var  # NameError
    except Exception as e:
        print(f"❌ Caught a generic exception: {e}")
    finally:
        print("🧹 Finished catch-all example.\n")


# 4. Raising a custom exception
def example_raise_custom():
    try:
        amount = -10
        if amount < 0:
            raise ValueError("Amount must be positive.")
    except ValueError as e:
        print(f"❌ Custom raise example: {e}")
    finally:
        print("🧹 Finished raise example.\n")


# 5. Defining and using a custom exception class
class ValidationError(Exception):
    """Raised when validation fails."""
    def __init__(self, message, code):
        super().__init__(message)
        self.code = code


def example_custom_exception_class():
    try:
        raise ValidationError("Invalid input!", 400)
    except ValidationError as e:
        print(f"❌ Caught custom error: {e} (code {e.code})")
    finally:
        print("🧹 Finished custom exception class example.\n")


# 6. Using assert for debugging
def example_assert():
    try:
        value = -1
        assert value >= 0, "Value must be non-negative"
    except AssertionError as e:
        print(f"❌ Assertion failed: {e}")
    finally:
        print("🧹 Finished assert example.\n")


# 7. Using traceback module for debugging
import traceback

def example_traceback():
    try:
        1 / 0
    except Exception:
        print("🧨 Full traceback:")
        traceback.print_exc()
    finally:
        print("🧹 Finished traceback example.\n")


# 8. File handling with exception blocks
def example_file_handling():
    try:
        with open("nonexistent_file.txt", "r") as f:
            data = f.read()
    except FileNotFoundError:
        print("❌ File not found!")
    except IOError as e:
        print(f"❌ I/O error: {e}")
    finally:
        print("🧹 Finished file handling example.\n")


# ========== MAIN ==========

if __name__ == "__main__":
    print("🔎 Running exception handling examples...\n")
    example_basic_try_except()
    example_multiple_exceptions()
    example_catch_all()
    example_raise_custom()
    example_custom_exception_class()
    example_assert()
    example_traceback()
    example_file_handling()
    print("✅ All examples complete.")
