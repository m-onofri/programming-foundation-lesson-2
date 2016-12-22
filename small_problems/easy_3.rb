# Write a program that solicits 6 numbers from the user, then prints a message that describes whether or not the
# 6th number appears amongst the first 5 numbers.

# numbers = []

# puts "Enter the 1st number:"
# numbers << gets.chomp.to_i
# puts "Enter the 2nd number:"
# numbers << gets.chomp.to_i
# puts "Enter the 3rd number:"
# numbers << gets.chomp.to_i
# puts "Enter the 4th number:"
# numbers << gets.chomp.to_i
# puts "Enter the 5th number:"
# numbers << gets.chomp.to_i
# puts "Enter the last number:"
# last_number = gets.chomp.to_i

# if numbers.include?(last_number)
#   puts "The number #{last_number} appears in #{numbers}."
# else
#   puts "The number #{last_number} doesn't appears in #{numbers}."
# end


# Write a program that prompts the user for two positive integers, and then prints the results of the following
# operations on those two numbers: addition, subtraction, product, quotient, remainder, and power. Do not worry
# about validating the input.

# puts "Enter the first number:"
# first_number = gets.chomp.to_i
# puts "Enter the second number:"
# second_number = gets.chomp.to_i
# sum = first_number + second_number
# puts "#{first_number} + #{second_number} = #{sum}"
# operators = [:+, :-, :*, :/, :%, :**]
# operators.each do |opr|
#   total = first_num.send(opr, second_num)
#   prompt "#{first_num} #{opr} #{second_num} = #{total}"
# end


# Write a program that will ask a user for an input of a word or multiple words and give back the number of
# characters. Spaces should not be counted as a character.

# puts "Please write word or multiple words:"
# string = gets.chomp

# chars_count = string.split.join.length

# puts "There are #{chars_count} characters in '#{string}'."


# Create a method that takes two arguments, multiplies them together, and returns the result.

def multiply(num_1, num_2)
  num_1 * num_2
end

puts multiply(5, 3) == 15

# Using the multiply method from the "Multiplying Two Numbers" problem, write a method that computes the square
# of its argument (the square is the result of multiplying a number by itself).

def square(num)
  multiply(num, num)
end

puts square(5) == 25
puts square(-8) == 64

# What if we wanted generalize this method to a "power to the n" type method: cubed, to the 4th power, to the 5th,
# etc. How would we go about doing so while still using the multiply method?

def power_to_n(num, power)
  result = 1
  power.times { result = multiply(result, num) }
  result
end

puts power_to_n(2, 3)

# In this exercise, you will write a method named xor that takes two arguments, and returns true if exactly one
# of its arguments is true, false otherwise.

def xor?(op_1, op_2)
  (op_1 == true && op_2 == false) || (op_1 == false && op_2 == true) 
end

puts xor?(5.even?, 4.even?) == true
puts xor?(5.odd?, 4.odd?) == true
puts xor?(5.odd?, 4.even?) == false
puts xor?(5.even?, 4.odd?) == false


# Write a method that returns an Array that contains every other element of an Array that is passed in as an
# argument. The values in the returned list should be those values that are in the 1st, 3rd, 5th, and so on
# elements of the argument Array.

array = [1, 2, 3, 4, 5]

def oddities(array)
  array.select.with_index { |_, ind| ind % 2 == 0 }
end

p oddities(array)
puts oddities([2, 3, 4, 5, 6]) == [2, 4, 6]
puts oddities(['abc', 'def']) == ['abc']
puts oddities([123]) == [123]
puts oddities([]) == []


# Write a method that returns true if the string passed as an argument is a palindrome, false otherwise.
# (A palindrome reads the same forwards and backwards.) Case matters, and all characters should be considered.

def palindrome?(string)
  string == string.reverse
end
puts "-" * 50
# puts palindrome?('madam') == true
# puts palindrome?('Madam') == false          # (case matters)
# puts palindrome?("madam i'm adam") == false # (all characters matter)
# puts palindrome?('356653') == true


# Write another method that returns true if the string passed as an argument is a palindrome, false otherwise.
# This time, however, your method should be case-insensitive, and it should ignore all non-alphanumeric characters.
# If you wish, you may simplify things by calling the palindrome? method you wrote in the previous exercise.

def real_palindrome?(string)
  new_string = string.downcase.delete('^0-9a-z')
  palindrome?(new_string)
end

puts real_palindrome?('madam') == true
puts real_palindrome?('Madam') == true           # (case does not matter)
puts real_palindrome?("Madam, I'm Adam") == true # (only alphanumerics matter)
puts real_palindrome?('356653') == true
puts real_palindrome?('356a653') == true
puts real_palindrome?('123ab321') == false


# Write a method that returns true if its integer argument is palindromic, false otherwise.
# A palindromic number reads the same forwards and backwards.

def palindromic_number?(num)
  string = num.to_s
  string == string.reverse
end

puts palindromic_number?(0d0123210)




























