# Write a method that rotates an array by moving the first element to the end of the array. 
# The original array should not be modified.

# Do not use the method Array#rotate or Array#rotate! for your implementation.

def rotate_array(array)
  result = []
  result << array[0]
  array[1..-1].reverse_each { |item| result.unshift(item) }
  result
end

array = [7, 3, 5, 2, 9, 1]
p rotate_array(array) #== [3, 5, 2, 9, 1, 7]
p array
p rotate_array(['a', 'b', 'c']) #== ['b', 'c', 'a']
p rotate_array(['a']) #== ['a']


# Write a method that can rotate the last n digits of a number.
# Note that rotating just 1 digit results in the original number being returned.
# You may use the rotate_array method from the previous exercise if you want. (Recommended!)
# You may assume that n is always a positive integer.

def rotate_rightmost_digits(num, position)
  num_array = num.to_s.chars
  array_length = num_array.size
  index_separator = array_length - position
  sub_array_1 = num_array[0...index_separator]
  sub_array_2 = num_array[index_separator..-1]
  array_rotated = sub_array_1 + rotate_array(sub_array_2)
  array_rotated.join.to_i
end

p rotate_rightmost_digits(735291, 1) == 735291
p rotate_rightmost_digits(735291, 2) == 735219
p rotate_rightmost_digits(735291, 3) == 735912
p rotate_rightmost_digits(735291, 4) == 732915
p rotate_rightmost_digits(735291, 5) == 752913
p rotate_rightmost_digits(735291, 6) == 352917


# If you take a number like 735291, and rotate it to the left, you get 352917. If you now keep the first digit 
# fixed in place, and rotate the remaining digits, you get 329175. Keep the first 2 digits fixed in place and 
# rotate again to 321759. Keep the first 3 digits fixed in place and rotate again to get 321597. Finally, keep 
# the first 4 digits fixed in place and rotate the final 2 digits to get 321579. The resulting number is called 
# the maximum rotation of the original number.

# Write a method that takes an integer as argument, and returns the maximum rotation of that argument. You can 
# (and probably should) use the rotate_rightmost_digits method from the previous exercise.

def max_rotation(num)
  num_array = num.to_s.chars
  first_rotation = rotate_array(num_array).join.to_i
  counter = num_array.size - 1
  while counter > 0
    first_rotation = rotate_rightmost_digits(first_rotation, counter)
    counter -= 1
  end
  first_rotation
end

p max_rotation(735291) #== 321579
p max_rotation(3) #== 3
p max_rotation(35) #== 53
p max_rotation(105) #== 15 # the leading zero gets dropped
p max_rotation(8_703_529_146) #== 7_321_609_845


# You have a bank of switches before you numbered from 1 to 1000. Each switch is connected to exactly one light 
# that is initially off. You walk down the row of switches, and turn every one of them on. Then, you go back to
# the beginning and toggle switches 2, 4, 6, and so on. Repeat this for switches 3, 6, 9, and so on, and keep 
# going until you have been through 1000 repetitions of this process.

# Write a program that determines which lights are on at the end.

def switch_lights(number)
  lights_array = (1..number).to_a
  switches_on = [false] * number
  starting_hash = Hash[lights_array.zip(switches_on)]
  lights_array.each do |index|
    starting_hash.each do |key, value|
      if key % index == 0
        value == false ? starting_hash[key] = true : starting_hash[key] = false
      end
    end
  end
  starting_hash.select { |key, value| value == true }.keys
end

p switch_lights(1000)


# Write a method that displays a 4-pointed diamond in an n x n grid, where n is an odd integer that is 
# supplied as an argument to the method. You may assume that the argument will always be an odd integer.

def diamond(number)
  "*".center(number)
  counter = 1
  while counter <= number
    puts ("*" * counter).center(number)
    counter += 2
  end
  loop do 
    counter -= 2
    break if counter < 1
    puts ("*" * counter).center(number)
  end
end

diamond(9)

# Write a method that implements a miniature stack-and-register-based programming language that has the following 
# commands:

  # n Place a value n in the "register". Do not modify the stack.
  # PUSH Push the register value on to the stack. Leave the value in the register.
  # ADD Pops a value from the stack and adds it to the register value, storing the result in the register.
  # SUB Pops a value from the stack and subtracts it from the register value, storing the result in the register.
  # MULT Pops a value from the stack and multiplies it by the register value, storing the result in the register.
  # DIV Pops a value from the stack and divides it into the register value, storing the integer result in the register.
  # MOD Pops a value from the stack and divides it into the register value, storing the integer remainder of the division in the register.
  # POP Remove the topmost item from the stack and place in register
  # PRINT Print the register value

# All operations are integer operations (which is only important with DIV and MOD).

# Programs will be supplied to your language method via a string passed in as an argument. 
# Your program may assume that all programs are correct programs; that is, they won't do anything like try to 
# pop a non-existent value from the stack, and they won't contain unknown tokens.

# You should initialize the register to 0.

def minilang(string)
  register = 0
  stack = []
  commands_list = string.split
  commands_list.each do |command|
    case command
    when "PUSH" then stack << register
    when "ADD" then register = register + stack.pop
    when "SUB" then register = register - stack.pop
    when "MULT" then register = register * stack.pop
    when "DIV" then register = register / stack.pop
    when "MOD" then register = register % stack.pop
    when "POP" then register = stack.pop
    when "PRINT" then puts register
    else register = command.to_i
    end
  end
end

minilang('3 PUSH 5 MOD PUSH 7 PUSH 3 PUSH 4 PUSH 5 MULT ADD SUB DIV PRINT')


# Write a method that takes a sentence string as input, and returns a new string that contains the original 
# string with any sequence of the words 'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 
# 'nine' converted to a string of digits.

NUMBER = { "zero" => "0", "one" => "1", "two" => "2", "three" => "3", "four" => "4",
           "five" => "5", "six" => "6", "seven" => "7", "eight" => "8", "nine" => "9" }

def word_to_digit(string)
  result = string.split.map do |word|
    NUMBER.each do |key, val|
      if word.include?(key)
        word = word.gsub(/\b#{key}\b/, val)
      end
    end
    word
  end
  result.join(" ")
end

p word_to_digit('Please call me at five five five one two three four. Thanks.') #== 'Please call me at 5 5 5 1 2 3 4. Thanks.'


# Write a recursive method that computes the nth Fibonacci number, where nth is an argument to the method.

def fibonacci(num)
  return 1 if num < 3
  fibonacci(num - 1) + fibonacci(num - 2)
end

p fibonacci(1) #== 1
p fibonacci(2) #== 1
p fibonacci(3) #== 2
p fibonacci(4) #== 3
p fibonacci(5) #== 5
p fibonacci(12) #== 144
p fibonacci(20) #== 6765


def fibonacci_last(nth)
  fibonacci_serie = [1, 1]
  while fibonacci_serie.size < nth
    fibonacci_serie << fibonacci_serie[-2] + fibonacci_serie[-1]
  end
  fibonacci_serie[nth-1].to_s[-1].to_i
end

p fibonacci_last(12)





