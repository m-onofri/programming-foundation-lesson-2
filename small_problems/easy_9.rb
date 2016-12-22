# Create a method that takes 2 arguments, an array and a hash. The array will contain 2 or more elements that,
# when combined with adjoining spaces, will produce a person's name. The hash will contain two keys, :title and 
# :occupation, and the appropriate values. Your method should return a greeting that uses the person's full name, 
# and mentions the person's title.

my_array = ["John", "Doe"]

my_hash = { title: "Master", occupation: "Plumber" }

def greetings(array, hash)
  "Hello, #{array[0]} #{array[1]}!" \
  "Nice to have a #{hash[:title]} #{hash[:occupation]} around."
end

puts greetings(my_array, my_hash)


# A double number is a number with an even number of digits whose left-side digits are exactly the same as
# its right-side digits. For example, 44, 3333, 103103, 7676 are all double numbers. 444, 334433, and 107 are not.

# Write a method that returns 2 times the number provided as an argument, unless the argument is a double number;
# double numbers should be returned as-is.

def twice(num)
  string_number = num.to_s
  number_center = string_number.size / 2

  if string_number.size.even? && string_number[0...number_center] == string_number[number_center..-1]
    num
  else
    num * 2
  end
end

puts twice(37) == 74
puts twice(44) == 44
puts twice(334433) == 668866
puts twice(444) == 888
puts twice(107) == 214
puts twice(103103) == 103103
puts twice(3333) == 3333
puts twice(7676) == 7676
puts twice(123_456_789_123_456_789) == 123_456_789_123_456_789
puts twice(5) == 10
puts "-" * 50

# Write a method that takes a number as an argument. If the argument is a positive number, return the negative 
# of that number. If the number is 0 or negative, return the original number.

def negative(num)
  num > 0 ? -num : num
  # case num <=> 0
  # when 1 then num * -1
  # when 0, -1 then num
  # end
end

puts negative(5) #== -5
puts negative(-3) #== -3
puts negative(0) #== 0      # There's no such thing as -0 in ruby


# Write a method that takes an integer argument, and returns an Array of all integers, in sequence,
# between 1 and the argument.

# You may assume that the argument will always be a valid integer that is greater than 0.

def sequence(num)
  (1..num).to_a
end

p sequence(5) #== [1, 2, 3, 4, 5]
p sequence(3) #== [1, 2, 3]
p sequence(1) #== [1]


# Write a method that takes a string argument, and returns true if all of the alphabetic characters inside 
# the string are uppercase, false otherwise. Characters that are not alphabetic should be ignored.

def uppercase?(string)
  string == string.upcase
end

puts uppercase?('t') == false
puts uppercase?('T') == true
puts uppercase?('Four Score') == false
puts uppercase?('FOUR SCORE') == true
puts uppercase?('4SCORE!') == true
puts uppercase?('') == true


# Write a method that takes a string as an argument, and returns an Array that contains every word from the
# string, to which you have appended a space and the word length.

# You may assume that words in the string are separated by exactly one space, and that any substring of 
# non-space characters is a word.

def word_lengths(string)
  string.split.map { |word| word + " #{word.size}" }
end

p word_lengths("cow sheep chicken") == ["cow 3", "sheep 5", "chicken 7"]


# Write a method that takes a first name, a space, and a last name passed as a single String argument,
# and returns a string that contains the last name, a comma, a space, and the first name.

def swap_name(full_name)
  array_name = full_name.split
  "#{array_name[1]}, #{array_name[0]}"
end

puts swap_name('Joe Roberts') #== 'Roberts, Joe'


# Create a method that takes two integers as arguments. The first argument is a count, and the second is 
# the first number of a sequence that your method will create. The method should return an Array that 
# contains the same number of elements as the count argument, while the values of each element will be multiples 
# of the starting number.

# You may assume that the count argument will always have a value of 0 or greater, while the starting number 
# can be any integer value. If the count is 0, an empty list should be returned.

def sequence(count, num)
  (1..count).to_a.inject([]) do |array, counter|
    array << num * counter
    array
  end
end

sequence(5, 1) #== [1, 2, 3, 4, 5]
sequence(4, -7) #== [-7, -14, -21, -28]
sequence(3, 0) #== [0, 0, 0]
sequence(0, 1000000) #== []


# Write a method that determines the mean (average) of the three scores passed to it, and returns the letter 
# value associated with that grade.

# Numerical Score Letter Grade 90 <= score <= 100 'A' 80 <= score < 90 'B' 
#                              70 <= score < 80 'C' 60 <= score < 70 'D' 0 <= score < 60 'F'

# Tested values are all between 0 and 100. There is no need to check for negative values or 
# values greater than 100.

def get_grade(score1, score2, score3)
  average_score = (score1 + score2 + score3) / 3
  case average_score
  when 90..100 then "A"
  when 80...90 then "B"
  when 70...80 then "C"
  when 60...70 then "D"
  when 0...60 then "F" 
  end
end

puts get_grade(95, 90, 93) #== "A"
puts get_grade(50, 50, 95) #== "D"


# Write a method which takes a grocery list (array) of fruits with quantities and converts it into an array 
# of the correct number of each fruit.

def buy_fruit(list)
  result = []
  list.each do |array|
    array[1].times { result << array[0] }
  end
  result
end

p buy_fruit([["apples", 3], ["orange", 1], ["bananas", 2]]) #==
  ["apples", "apples", "apples", "orange", "bananas","bananas"]








