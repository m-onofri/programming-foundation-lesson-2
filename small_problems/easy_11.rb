require 'pry'

a = IO.read("example.txt")

# [[sentence, length], ...]
sentences = []
current_sentence = []
a.split.each do |word|
  if word.include?(".") || word.include?("?") || word.include?("!")
    current_sentence << word
    sentences << current_sentence
    current_sentence = []
  else
    current_sentence << word
  end
end

longest_sentence = sentences.max_by { |sentence| sentence.size }

p longest_sentence.join(' ')

# A collection of spelling blocks has two letters per block, as shown in this list:

# This limits the words you can spell with the blocks to just those words that do not use both letters 
# from any given block. Each block can only be used once.

# Write a method that returns true if the word passed in as an argument can be spelled from this set of blocks, 
# false otherwise.

BLOCKS = %w(BO XK DQ CP NA GT RE FS JW HU VI LY ZM)

def block_word?(string)
  used_blocks = []
  string.upcase.chars.each do |char|
    BLOCKS.each do |block|
      used_blocks << block if block.include?(char)
    end
  end
  used_blocks.uniq.size == string.size
end

p block_word?('BATCH') == true
p block_word?('BUTCH') == false
p block_word?('jest') == true


# In the easy exercises, we worked on a problem where we had to count the number of uppercase and lowercase 
# characters, as well as characters that were neither of those two. Now we want to go one step further.

# Write a method that takes a string, and then returns a hash that contains 3 entries: one represents the 
# percentage of characters in the string that are lowercase letters, one the percentage of characters that 
# are uppercase letters, and one the percentage of characters that are neither.

# You may assume that the string will always contain at least one character.

def letter_percentages(string)
  chars_number = string.size
  result = string.chars.inject(Hash.new(0)) do |hash, char|
    case char
    when /[a-z]/ then hash[:lowercase] += 1
    when /[A-Z]/ then hash[:uppercase] += 1
    when /[^a-z]/i then hash[:neither] += 1
    end
    hash
  end
  result.each { |key, value| result[key] = (format("%.2f", (value.to_f / chars_number.to_f * 100))).to_f }
end

p letter_percentages('abCdef 123')


# Write a method that takes a string as argument, and returns true if all parentheses in the string are properly 
# balanced, false otherwise. To be properly balanced, parentheses must occur in matching '(' and ')' pairs.

def balanced?(string)
  new_array = string.chars.grep(/(\(|\))/) { |par| par == "(" ? 1 : -1 }
  #return false unless new_array.reduce(0) { |tot, item| tot += item; tot } == 0
  counter = 0
  new_array.each do |item|
    counter += item
    return false if counter < 0
  end
  counter.zero?
end

p balanced?('What (is) this?') == true
p balanced?('What is) this?') == false
p balanced?('What (is this?') == false
p balanced?('((What) (is this))?') == true
p balanced?('((What)) (is this))?') == false
p balanced?('Hey!') == true
p balanced?(')Hey!(') == false
p balanced?('What ((is))) up(') == false
p "=" * 50


# Write a method that takes the lengths of the 3 sides of a triangle as arguments, and returns a symbol 
# :equilateral, :isosceles, :scalene, or :invalid depending on whether the triangle is equilateral, isosceles, 
# scalene, or invalid.

def triangle_s(side1, side2, side3)
  tngl = [side1, side2, side3]
  longer_side = tngl.max
  sum_short_sides = tngl.min(2).reduce(&:+)
  return :invalid if (longer_side > sum_short_sides) || tngl.index(0)
  case tngl.uniq.size
  when 1 then :equilateral
  when 2 then :isosceles
  when 3 then :scalene
  end
end

p triangle_s(3, 3, 3) == :equilateral
p triangle_s(3, 3, 1.5) == :isosceles
p triangle_s(3, 4, 5) == :scalene
p triangle_s(0, 3, 3) == :invalid
p triangle_s(3, 1, 1) == :invalid


# Write a method that takes the 3 angles of a triangle as arguments, and returns a symbol :right, :acute, 
# :obtuse, or :invalid depending on whether the triangle is a right, acute, obtuse, or invalid triangle.

# You may assume integer valued angles so you don't have to worry about floating point errors. You may also 
# assume that the arguments are specified in degrees.

def triangle_a(angle_1, angle_2, angle_3)
  tngl = [angle_1, angle_2, angle_3]
  sum_angles = tngl.reduce(&:+)
  return :invalid if sum_angles != 180 || tngl.index(0)
  case tngl.max <=> 90
  when 1 then :obtuse
  when 0 then :right
  when -1 then :acute
  end
end

p triangle_a(60, 70, 50) #== :acute
p triangle_a(30, 90, 60) #== :right
p triangle_a(120, 50, 10) #== :obtuse
p triangle_a(0, 90, 90) #== :invalid
p triangle_a(50, 50, 50) #== :invalid


# Write a method that returns the number of Friday the 13ths in the year passed in as an argument. 
# You may assume that the year is greater than 1752 (when the modern Gregorian Calendar was adopted 
# by the United Kingdom), and you may assume that the same calendar will remain in use for the foreseeable future.

def friday_13th?(year)
  counter = 0
  (1..12).each do |month|
    counter += 1 if Time.utc(year, month, 13).friday?
  end
  counter
end

p friday_13th?(2015) == 3
p friday_13th?(1986) == 1
p friday_13th?(2019) == 2


# A featured number (something unique to this exercise) is an odd number that is a multiple of 7, and whose 
# digits occur exactly once each. So, for example, 49 is a featured number, but 98 is not (it is not odd), 
# 97 is not (it is not a multiple of 7), and 133 is not (the digit 3 appears twice).

# Write a method that takes a single integer as an argument, and returns the next featured number that is 
# greater than the argument. Issue an error message if there is no next featured number.

def featured_num?(num)
  num % 7 == 0 && num % 2 == 1 && num.to_s.chars.uniq.size == num.to_s.size
end

def featured(num)
  loop do
    num = num + 1
    return num if featured_num?(num)
    break if num >= 9_876_543_210
  end
  "There is no possible number that fulfills those requirements"
end


# p featured(12) #== 21
# p featured(20) #== 21
# p featured(21) #== 35
# p featured(997) #== 1029
# p featured(1029) #== 1043
# p featured(999_999) #== 1_023_547
# p featured(999_999_987) #== 1_023_456_987

# p featured(9_999_999_999) # -> There is no possible number that fulfills those requirements


# Write a method that takes an Array as an argument, and sorts that Array using the bubble sort algorithm 
# as just described. Note that your sort will be "in-place"; that is, you will mutate the Array passed as 
# an argument. You may assume that the Array contains at least 2 elements.

def bubble_sort!(array)
  swap = true
  loop do
    (0..array.size - 2).each do |index|
      if array[index] > array[index + 1]
        array[index], array[index + 1] = array[index + 1], array[index]
        swap = true
      end
    end
    break if swap == false
    swap = false
  end
end

array = [5, 3]
bubble_sort!(array)
p array == [3, 5]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
p array == [1, 2, 4, 6, 7]

array = %w(Sue Pete Alice Tyler Rachel Kim Bonnie)
bubble_sort!(array)
p array == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)


# Write a method that computes the difference between the square of the sum of the first n positive integers 
# and the sum of the squares of the first n positive integers.

def sum_square_difference(num)
  square_sum = (1..num).reduce(&:+) ** 2
  sum_squares = (1..num).map { |item| item ** 2 }.reduce(&:+)
  square_sum - sum_squares
end

p sum_square_difference(3) == 22
   # -> (1 + 2 + 3)**2 - (1**2 + 2**2 + 3**2)
p sum_square_difference(10) == 2640
p sum_square_difference(1) == 0
p sum_square_difference(100) == 25164150













