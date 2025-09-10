# playground file
flowerList = ["Rose", "Lily", "Jasmine"]

# for flower in flowerList:
#     print(flower)

# for i in range(0, len(flowerList)):
#     print(flowerList[i])

# for i in range(len(flowerList)):
#     print(flowerList[i])

for index, flower in enumerate(flowerList):
    #print(flowerList[index])
    #print(flower) 
    # Above two lines are same!
    print(f"{index} is {flowerList[index]}")

