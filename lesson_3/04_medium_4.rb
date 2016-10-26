# Question n° 1

# Let's do some "ASCII Art" (a stone-age form of nerd artwork from back
# in the days before computers had video screens).

# For this exercise, write a one-line program that creates the following 
# output 10 times, with the subsequent line indented 1 space to the right:

string = "The Flintstones Rock!"

10.times {|i| puts ((' ' * i) + string)}

##########################################################################

# Question n° 2

# Create a hash that expresses the frequency with which each letter 
# occurs in this string:

statement = "The Flintstones Rock"

# create an empty hash
# loop through the string
# check if the character is already a key of the hash
# if it's true, add 1 to the value with the corresponding key
# else, enter a new key/value pair, with the k the current letter, and a value of 1

letters_frequency = {}
statement.gsub!(/\s+/, "")
statement.each_char do |char|
  letters_frequency.keys. include?(char) ? letters_frequency[char] += 1 : 
  letters_frequency[char] = 1
end

p letters_frequency

##############################################################################

# Question n° 3

# The result of the following statement will be an error:

# puts "the value of 40 + 2 is " + (40 + 2)

# Why is this and what are two possible ways to fix this?

# This statement returns an error because it tries to add an integer to a string

puts "the value of 40 + 2 is " + (40 + 2).to_s

puts "the value of 40 + 2 is #{40+2}"

##############################################################################

# Question n° 4

# What happens when we modify an array while we are iterating over it? What would be output by this code?

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end

# => The Array#shift method add elements at the top of an array
# => 1
# => 3

# What would be output by this code?

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end

# => The array#pop method remove elements from the bottom of an array
# => 1
# => 2

################################################################################

# Question n° 5

# Alan wrote the following method, which was intended to show all of the 
# factors of the input number:

def factors(number)
  dividend = number
  divisors = []
  while dividend > 0
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors
end

# Alyssa noticed that this will fail if the input is 0, or a negative number,
# and asked Alan to change the loop. How can you change the loop construct
# (instead of using begin/end/until) to make this work? Note that we're not
# looking to find the factors for 0 or negative numbers, but we just want to
# handle it gracefully instead of raising an exception or going into an
# infinite loop.

p factors(0)

# Bonus 1
# What is the purpose of the number % dividend == 0 ?
# It's useful to check if number can be divided by dividend (with no remainder)

# Bonus 2
# What is the purpose of the second-to-last line in the method
# (the divisors before the method's end)?
# It's purpose is that in this way the method will return the value of 
# divisors variable, because in the method there isn't an explicit return.

################################################################################ 

# Question n° 6

# Alyssa was asked to write an implementation of a rolling buffer.
# Elements are added to the rolling buffer and if the buffer becomes full,
# then new elements that are added will displace the oldest elements in the buffer.

# She wrote two implementations saying, "Take your pick. Do you like << or + for
#  modifying the buffer?". Is there a difference between the two, other than
# what operator she chose to use to add an element to the buffer?

def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end

# There is one important difference: the first method mutate the caller's
# input array (in this case buffer), while in the second method the caller's
# input array (input_array) is not modified. So even though both methods return
# the same result, in the first case the method practically change the variable
# passed as 'buffer', while in the second case the method returns a different value
# compared to the caller's input.

################################################################################

# Question n° 7

# Alyssa asked Ben to write up a basic implementation of a Fibonacci calculator,
# A user passes in two numbers, and the calculator will keep computing the
# sequence until some limit is reached.

# Ben coded up this implementation but complained that as soon as he ran it,
# he got an error. Something about the limit variable. What's wrong with the code?

limit = 15

#def fib(first_num, second_num)
#  while second_num < limit
#    sum = first_num + second_num
#    first_num = second_num
#    second_num = sum
#  end
#  sum
#end

def fib(first_num, second_num, limit)
  while second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, limit)
puts "result is #{result}"

# How would you fix this so that it works?

# The method doesn't work because method's block are entirely self contained, so
# you must pass in all the parameters the method requires.
# In this case, you have to pass the limit variable as an additional
# parameter to the method.

################################################################################

# Question n° 8

# In another example we used some built-in string methods to change the case of
# a string. A notably missing method is something provided in Rails, but not in
# Ruby itself...titleize! This method in Ruby on Rails creates a string that has
# each word capitalized as it would be in a title.

# Write your own version of the rails titleize implementation.

def titleize(string)
  temp_array = string.split
  temp_array.each { |item| item.capitalize! }
  titleize_string = temp_array.join(' ')
  titleize_string
end

puts titleize "Speriamo che funzioni"

################################################################################

# Question n° 9

# Given the munsters hash below

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# Modify the hash such that each member of the Munster family has an additional
# "age_group" key that has one of three values describing the age group the
# family member is in (kid, adult, or senior).

# Note: a kid is in the age range 0 - 17, an adult is in the range 18 - 64 and
# a senior is aged 65+.

munsters.each do |name, inner_hash|
  case inner_hash["age"]
  when 0..18
    inner_hash["age_group"] = "kid"
  when 18..65
    inner_hash["age_group"] = "adult"
  else
    inner_hash["age_group"] = "senior"
  end
end

p munsters

# when ranges are involved, case statement uses Range#=== as the comparison 
# operator.













