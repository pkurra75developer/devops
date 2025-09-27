# Type casting in Python

# int()	Integer
# float()	Float
# str()	String
# bool()	Boolean
# list()	List
# tuple()	Tuple
# set()	Set

empSal = 12000
empBonus = (empSal * 10)/100
empVariablePay = "1500"

# The below line will give error
# empTotalPerks = empSal + empBonus + empVariablePay

# Below also doesn't work because of type coercion. already empsal + empbonus became float. Left -> Right
# empTotalPerks = empSal + empBonus + int(empVariablePay)

# This one will work
empTotalPerks = empSal + empBonus + float(empVariablePay)

print(type(empSal))
print(type(empBonus))
print(type(empVariablePay))
print(type(empTotalPerks))
 



