# all loops
# All numbers
# n = 1
# while n <= 10:
#     print(n)
#     n += 1

# # Only even numbers
# n = 1
# while n <= 100:
#     if n%5 == 0:
#         print(n)
#     n += 1


# Break and continue
# You can write else: for While condition!

badTry = 0
while badTry < 5:
    x = int(input("Guess a number between 10 and 50: "))

    if x < 10 or x > 50:
        print("Invalid input. Please enter a number between 10 and 50.\n")
        continue

    if x == 31:
        print("You guessed it right. 31 is the number!")
        break
    else:
        if x >= 10 and x <= 25:
            print("Bad input Try again! Hint: You are below!")
        elif x > 36 and x <= 50:
            print("Bad input Try again! Hint: You are Above!")
        else:
            print("Bad input Try again! Hint: Almost close!")

        badTry += 1
        print(f"You have {5-badTry} tries left!\n")

else:
    print("You reached bad try limit! Exiting the program!")
