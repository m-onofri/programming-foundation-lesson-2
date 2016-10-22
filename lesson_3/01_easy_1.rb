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

# Question n° 2
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

# Question n° 3

# Replace the word "important" with "urgent" in this string:

advice = "Few things in life are as important as house training your pet dinosaur."

substring1 = 'important'
substring2 = 'urgent'
advice.gsub!(substring1, substring2)

puts advice

####################################################################

# Question n° 4

# The Ruby Array class has several methods for removing items from the array.
# Two of them have very similar names. Let's see how they differ:

numbers = [1, 2, 3, 4, 5]

# What do the following method calls do (assume we reset numbers to the
# original array between method calls)?

numbers.delete_at(1) # => returns 2 and changes the array: numbers = [1, 3, 4, 5]
numbers.delete(1)    # => returns 1 and changes the array: numbers = [2, 3, 4, 5]

#####################################################################

# Question n° 5

# Programmatically determine if 42 lies between 10 and 100.

# hint: Use Ruby's range object in your solution.

def between_10_100? number
  (10..100).include?(number)
end

puts between_10_100? 100

#######################################################################

# Question n° 6

# Starting with the string:

famous_words = "seven years ago..."

# show two different ways to put the expected "Four score and " in front of it.

famous_words.prepend("Four score and ")

famous_words.insert(0, "Four score and ")

########################################################################

# Question n° 7

# Fun with gsub:

def add_eight(number)
  number + 8
end

number = 2

how_deep = "number"
5.times { how_deep.gsub!("number", "add_eight(number)") }

p how_deep

# This gives us a string that looks like a "recursive" method call:

"add_eight(add_eight(add_eight(add_eight(add_eight(number)))))"

# If we take advantage of Ruby's Kernel#eval method to have it
# execute this string as if it were a "recursive" method call

eval(how_deep)

# what will be the result?









