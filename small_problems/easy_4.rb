# Write a method that takes two strings as arguments, determines the longest of the two strings, and then
# returns the result of concatenating the shorter string, the longer string, and the shorter string once again.
# You may assume that the strings are of different lengths.

def short_long_short(str1, str2)
  shorter = str1.size > str2.size ? str2 : str1
  longer = shorter == str1 ? str2 : str1
  shorter + longer + shorter
end

puts short_long_short("ciao", "hello!")


# Write a method that takes a year as input and returns the century. The return value should be a string that
# begins with the century number, and ends with st, nd, rd, or th as appropriate for that number.

# New centuries begin in years that end with 01. So, the years 1901-2000 comprise the 20th century.

def century(year)
  century = year % 100 == 0 ? (year / 100) : ((year / 100) + 1)
  
  if [11, 12, 13].include?(century % 100)
    century.to_s + "th"
  else
    case century.to_s.split(//).last
    when "1" then century.to_s + "st"
    when "2" then century.to_s + "nd"
    when "3" then century.to_s + "rd"
    else century.to_s + "th"
    end
  end
end

puts century(1012)


# In the modern era under the Gregorian Calendar, leap years occur in every year that is evenly divisible by 4,
# unless the year is also divisible by 100. If the year is evenly divisible by 100, then it is not a leap year
# unless the year is evenly divisible by 400.

# Assume this rule is good for any year greater than year 0. Write a method that takes any year greater than 0 as
# input, and returns true if the year is a leap year, or false if it is not a leap year.

def leap_year?(year)
  if year % 4 == 0 && year % 100 != 0
    return true
  elsif year % 400 == 0
    return true
  end
  false
end

puts "-" * 50

# The British Empire adopted the Gregorian Calendar in 1752, which was a leap year. Prior to 1752, the Julian
# Calendar was used. Under the Julian Calendar, leap years occur in any year that is evenly divisible by 4.

# Using this information, update the method from the previous exercise to determine leap years both before and
# after 1752.

def leap_year_1?(year)
  if year > 1752
    return true if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0  
  else
    return true if year % 4 == 0
  end
  false
end

puts leap_year_1?(2016) == true
puts leap_year_1?(2015) == false
puts leap_year_1?(2100) == false
puts leap_year_1?(2400) == true
puts leap_year_1?(240000) == true
puts leap_year_1?(240001) == false
puts leap_year_1?(2000) == true
puts leap_year_1?(1900) == false
puts leap_year_1?(1752) == true
puts leap_year_1?(1700) == true
puts leap_year_1?(1) == false
puts leap_year_1?(100) == true
puts leap_year_1?(400) == true


# Write a method that searches for all multiples of 3 or 5 that lie between 1 and some other number,
# and then computes the sum of those multiples. For instance, if the supplied number is 20, the result
# should be 98 (3 + 5 + 6 + 9 + 10 + 12 + 15 + 18 + 20).

def multisum(num)
  multiples = []
  (1..num).each { |item| multiples << item if item % 5 == 0 || item % 3 == 0 }
  multiples.reduce(&:+)
end

p multisum(20)


# Write a method that takes an Array of numbers, and returns an Array with the same number of elements,
# and each element has the running total from the original Array.

array = [2, 5, 13]

def running_total(array)
  array.inject([]) do |array, num|
    item = array.empty? ? num : num + array.last
    array << item
  end
end

p running_total(array)
puts running_total([2, 5, 13]) == [2, 7, 20]
puts running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
puts running_total([3]) == [3]
puts running_total([]) == []


# Write a method that takes a String of digits, and returns the appropriate number as an integer. 
# You may not use any of the methods mentioned above.

# For now, do not worry about leading + or - signs, nor should you worry about invalid characters;
# assume all characters will be numeric.

DIGITS = { "0" => 0, "1" => 1, "2" => 2, "3" => 3, "4" => 4, "5" => 5,
           "6" => 6, "7" => 7, "8" => 8, "9" => 9 }

def string_to_number(string)
  # convert each string character in a digit "123" => [1, 2, 3]
  digits_array = string.split(//).map { |char| DIGITS[char] }
  # convert the array of digits in an integer [1, 2, 3] => 123
  digits_array.reduce(0) { |tot, digit| tot = tot * 10 + digit }
end

p string_to_number("12356789")


# Write a method that takes a String of digits, and returns the appropriate number as an integer.
# The String may have a leading + or - sign; if the first character is a +, your method should return a positive number; if it is a -, your method should return a negative number. If no sign is given, you should return a positive number.

# You may assume the string will always contain a valid number.

def string_to_signed_integer(string) # +123
  case string[0]
  when "+", "-"
    string[0] == "+" ? string_to_number(string[1..-1]) : -string_to_number(string[1..-1])
  else
    string_to_number(string)
  end
end

p string_to_signed_integer("0")


# In the previous two exercises, you developed methods that convert simple numeric strings to signed Integers.
# In this exercise and the next, you're going to reverse those methods.

# Write a method that takes a positive integer or zero, and converts it to a string representation.

def integer_to_string(integer) 
  modulus = 0
  counter = 1
  chars_array = []
  loop do 
    modulus = integer % (10 ** counter) 
    current_int = modulus / (10 ** (counter - 1))
    chars_array.unshift(current_int)
    break if modulus == integer
    counter += 1
  end
  chars_array.map { |int| DIGITS.key(int) }.join
end

p integer_to_string(123)


# In the previous exercise, you developed a method that converts non-negative numbers to strings.
# In this exercise, you're going to extend that method by adding the ability to represent negative numbers as well.

# Write a method that takes an integer, and converts it to a string representation.

def signed_integer_to_string(integer)
  if integer < 0
    "-" + integer_to_string(integer * (-1))
  elsif integer > 0
    "+" + integer_to_string(integer)
  else
    "0"
  end
end

p signed_integer_to_string(123)
















