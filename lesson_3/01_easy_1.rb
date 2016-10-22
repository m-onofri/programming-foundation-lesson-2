# Question n° 1
# What would you expect the code below to print out?

numbers = [1, 2, 2, 3]
numbers.uniq

n = numbers
v = n.is_a?(String)
puts n
puts v


# uniq is a non-destructive method that removes repetitive
# method in the array and returns a new array without duplicate 
# element, so I'd expect that this code will print out the 
# original numbers array, not modified by the uniq method:

# 1
# 2
# 2
# 3

# The output is formatted this way because puts method always 
# call to_s on its argument
################################################################

#Question n° 2
# Describe the difference between ! and ? in Ruby. 
# And explain what would happen in the following scenarios:

# 1 what is != and where should you use it?
# 2 put ! before something, like !user_name
# 3 put ! after something, like words.uniq!
# 4 put ? before something
# 5 put ? after something
# 6 put !! before something, like !!user_name

# 1 != means "not equal"
# 2 ! before an object change the boolean value of the object
#     (if object is true, !object is false)
# 3 ! at the end of a method name (like uniq!) usually indicate
#     that the method alter the object on which the method is called
# 4-5 ? is commonly used in the ternary operator: before the 
#     question mark is the condition that must be evaluated,
#     while after the question mark is the code that will be 
#     executed if the condition is true.
#     Moreover ? is usually used to name methods that return
#     boolean values.
# 6 Two exclamation points before an object turn the object in
#   its corresponding boolean value

##################################################################


