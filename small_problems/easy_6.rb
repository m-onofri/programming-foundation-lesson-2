# Write a method that takes a floating point number that represents an angle between 0 and 360 degrees and
# returns a String that represents that angle in degrees, minutes, and seconds. You should use a degree
# symbol (˚) to represent degrees, a single quote (') to represent minutes, and a double quote (")
# to represent seconds. There are 60 minutes in a degree, and 60 seconds in a minute.

def dms(float)
  degrees, decimal = float.divmod(1)
  minutes, remainder = (60 * decimal).divmod(1)
  seconds = (remainder * 60).to_i
  format(%(#{degrees}°%02d'%02d"), minutes, seconds)
end

puts dms(30) == %(30°00'00")
puts dms(76.73) == %(76°43'48")
puts dms(254.6) #== %(254°36'00")
puts dms(93.034773) == %(93°02'05")
puts dms(0) == %(0°00'00")
puts dms(360) == %(360°00'00") || dms(360) == %(0°00'00")


# Write a method that takes an array of strings, and returns an array of the same string values, except with
# the vowels (a, e, i, o, u) removed.

def remove_vowels(array)
  array.map { |string| string.delete('aeiouAEIOU') }
end

puts remove_vowels(%w(abcdefghijklmnopqrstuvwxyz)) == %w(bcdfghjklmnpqrstvwxyz)
puts remove_vowels(%w(green YELLOW black white)) == %w(grn YLLW blck wht)
puts remove_vowels(%w(ABC AEIOU XYZ)) == ['BC', '', 'XYZ']


# Write a method that calculates and returns the index of the first Fibonacci number that has the number of
# digits specified as an argument. (The first Fibonacci number has index 1.)

def find_fibonacci_index_by_length(number)
  fibonacci = [1, 1]
  index = 2
  while fibonacci.last.to_s.size < number
    index += 1
    fibonacci[0], fibonacci[1] = fibonacci[1], fibonacci[0] + fibonacci[1]
  end
  index
end

# puts find_fibonacci_index_by_length(2) == 7
# puts find_fibonacci_index_by_length(10) == 45
# puts find_fibonacci_index_by_length(100) == 476
# puts find_fibonacci_index_by_length(1000) == 4782
# puts find_fibonacci_index_by_length(10000) == 47847


# Write a method that takes an Array as an argument, and reverses its elements in place; that is, mutate the
# Array passed in to this method. The return value should be the same Array object

def reverse!(array)
  iteration = array.length / 2
  iteration.times do |index|
    array[index], array[-index - 1] = array[-index - 1], array[index]
  end
  array
end
my_array = [1, 2, 3, 4]
# p my_array
# p reverse!(my_array)
# p my_array


# Write a method that takes an Array, and returns a new Array with the elements of the original list in
# reverse order. Do not modify the original list. 

def reverse(array)
  reversed_array = []
  array.each { |item| reversed_array.unshift(item) }
  reversed_array
end

p my_array
p reverse(my_array)
p my_array


# Write a method that takes two Arrays as arguments, and returns an Array that contains all of the values
# from the argument Arrays. There should be no duplication of values in the returned Array, even if there
# are duplicates in the original Arrays.

def merge(array_1, array_2)
  (array_1 + array_2).uniq
end

p merge([1, 2, 3], [3, 4, 5, 6])


# Write a method that takes an Array as an argument, and returns two Arrays that contain the first half and
# second half of the original Array, respectively. If the original array contains an odd number of elements,
# the middle element should be placed in the first half Array.

def halvsies(array)
  halvs = []
  first_half_size = array.size % 2 == 0 ? array.size / 2 : array.size / 2 + 1
  halvs[0] = array[0...first_half_size]
  halvs[1] = array[first_half_size..-1]
  halvs
end

p halvsies([1, 2, 3, 4, 5])


# Given an unordered array and the information that exactly one value in the array occurs twice (every other
# value occurs exactly once), how would you determine which value occurs twice? Write a method that will find
# and return the duplicate value that is known to be in the array.

def find_dup(array)
  array.inject(Hash.new(0)) { |hash, item| hash[item] += 1; hash }.key(2)
end

puts find_dup([1, 5, 3, 1]) == 1


# Write a method named include? that takes an Array and a search value as arguments. This method should return
# true if the search value is in the array, false if it is not. You may not use the Array#include? method in
# your solution.

array = [1, 2, 3]

def include?(array, value)
  !!array.find { |item| item == value }
end

p include?(array, 4)


# Write a method that takes a positive integer, n, as an argument, and displays a right triangle whose sides
# each have n stars. The hypotenuse of the triangle (the diagonal side in the images below) should have one end
# at the lower-left of the triangle, and the other end at the upper-right.

def triangle(num, vert_axe, orr_axe)
  if vert_axe == "up"
    counter = num
    num.times do
      case orr_axe
      when 'right' then puts ("*" * (counter)).rjust(num)
      when 'left' then puts ("*" * (counter)).ljust(num)
      else puts "The orrizontal parameter is wrong!"
      end
      counter -= 1
    end
  elsif vert_axe == "down"
    num.times do |index|
      case orr_axe
      when 'right' then puts ("*" * (index + 1)).rjust(num)
      when 'left' then puts ("*" * (index + 1)).ljust(num)
      else puts "The orrizontal parameter is wrong!"
      end
    end
  end
end

triangle(4, "up", "left")







