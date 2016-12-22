# Write a method that takes two arguments, a string and a positive integer,
# and prints the string as many times as the integer indicates.

def repeat(string, int)
  int.times { puts string }
end

repeat("Hello", 3)

# Write a method that takes one argument in the form of an integer or a float;
# this argument may be either positive or negative. This method should check
# if a number is odd, returning true if its absolute value is odd.
# Floats should only return true if the number is equal to its integer part
# and the integer is odd.

def odd_number?(number)
  number % 2 == 1
end

p odd_number?(-5.6)

# Write a method that takes one argument, a positive integer, and
# returns a list of the digits in the number.

def digit_list(num)
  num.to_s.split(//).map(&:to_i)
end

p digit_list(7) == [7]


# Write a method that counts the number of occurrences of each element in a given array.

vehicles = ['car', 'car', 'truck', 'car', 'SUV', 'truck', 'motorcycle', 'motorcycle', 'car', 'truck']

def count_occurrences(array)
  collection = array.inject(Hash.new(0)) do |hash, item|
    hash[item] += 1
    hash
  end
  collection.each { |index, value| puts "#{index} => #{value}" }
end


count_occurrences(vehicles)

# Once counted, print each element alongside the number of occurrences.

# Expected output:

# car => 4
# truck => 3
# SUV => 1
# motorcycle => 2

# Write a method that takes one argument, a string, and returns the same string with the words in reverse order.

def reverse_sentence(string)
  string.split(" ").reverse.join(" ")
end

# Examples:

puts reverse_sentence('') == ''
puts reverse_sentence('Hello World') == 'World Hello'
puts reverse_sentence('Reverse these words') == 'words these Reverse'

#The tests above should print true.


# Write a method that takes one argument, a string containing one or more words, and returns the given string
# with all five or more letter words reversed. Each string will consist of only letters and spaces. Spaces should
# be included only when more than one word is present.

def reverse_words(string)
  reverted_string = []
  string.split.each do |word|
    word.length > 4 ? reverted_string << word.reverse : reverted_string << word
  end
  reverted_string.join(" ")
end

puts reverse_words("my")


# Write a method that takes one argument, a positive integer, and returns a string of alternating 1s and 0s, 
# always starting with 1. The length of the string should match the given integer.

def stringy(int)
  new_string = ""
  (int / 2).times { new_string << "10" }
  new_string << "1" if int.odd? 
  new_string
end

p stringy(7)

def stringy_alt(int, start_with = 1)
  new_string = ""
  case start_with
  when 1
    (int / 2).times { new_string << "10" }
    new_string << "1" if int.odd?
  when 0
    (int / 2).times { new_string << "01" }
    new_string << "0" if int.odd?
  end
  new_string
end

p stringy_alt(7, 0)


# Write a method that takes one argument, an array containing integers, and returns the average of all numbers
# in the array. The array will never be empty and the numbers will always be positive integers.

def average(array)
  array.reduce(:+) / array.length
end

puts average([1, 5, 87, 45, 8, 8])


# Write a method that takes one argument, a positive integer, and returns the sum of its digits.

def sum(int)
  int.to_s.split(//).reduce(0){|sum, item| sum += item.to_i}
end

puts sum(23) == 5
puts sum(496) == 19
puts sum(123_456_789) == 45


# Write a method that takes two arguments, a positive integer and a boolean, and calculates the bonus for
# a given salary. If the boolean is true, the bonus should be half of the salary. If the boolean is false,
# the bonus should be 0.

def calculate_bonus(int, boolean)
  boolean ? int / 2 : 0
end

puts calculate_bonus(2800, true) == 1400
puts calculate_bonus(1000, false) == 0
puts calculate_bonus(50000, true) == 25000












