# Write a method that determines and returns the ASCII string value of a string that is passed in as an argument.
# The ASCII string value is the sum of the ASCII values of every character in the string.
# (You may use String#ord to determine the ASCII value of a character.)

def ascii_value(string)
  string.split(//).reduce(0) { |tot, char| tot += char.ord }
end

puts ascii_value('Four score')


# The time of day can be represented as the number of minutes before or after midnight.
# If the number of minutes is positive, the time is after midnight. If the number of minutes is negative,
# the time is before midnight.

# Write a method that takes a time using this minute-based format and returns the time of day in 24 hour
# format (hh:mm). Your method should work with any integer input.

def time_of_day(integer) # 1000
  hours, minutes = integer.abs.divmod(60)
  days, right_hours = hours.divmod(24)
  case integer <=> 0
  when 1 then format('%02d:%02d', right_hours, minutes) 
  when -1 then format('%02d:%02d', 23 - right_hours, 60 - minutes)
  else "00:00"
  end
end

puts time_of_day(0)


# Write two methods that each take a time of day in 24 hour format, and return the number of minutes before
# and after midnight, respectively. Both methods should return a value in the range 0..1439.

MINUTES_PER_DAY = 1440

def total_minutes(string)
  hours = (string[0] + string[1]).to_i
  minutes = (string[3] + string[4]).to_i
  hours * 60 + minutes
end

def after_midnight(string)
  tot_minutes = total_minutes(string)
  (0...MINUTES_PER_DAY) === tot_minutes ? tot_minutes : 0
end

def before_midnight(string)
  tot_minutes = total_minutes(string)
  delta_minutes = MINUTES_PER_DAY - tot_minutes
  (0...MINUTES_PER_DAY) === delta_minutes ? delta_minutes : 0
end

puts after_midnight('00:00') == 0
puts before_midnight('00:00') == 0
puts after_midnight('12:34') == 754
puts before_midnight('12:34') == 686
puts after_midnight('24:00') == 0
puts before_midnight('24:00') == 0

# Given a string of words separated by spaces, write a method that takes this string of words and returns a
# string in which the first and last letters of every word is swapped.

def swap(string)
  swap_array = []
  words_array = string.split
  words_array.each do |word|
    word[0], word[-1] = word[-1], word[0]
    swap_array << word
  end
  swap_array.join(" ")
end

puts swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
puts swap('Abcde') == 'ebcdA'
puts swap('a') == 'a'


# Given a string that consists of some words and an assortment of non-alphabetic characters, write a method
# that returns that string with all of the non-alphabetic characters replaced by spaces. If one or more
# non-alphabetic characters occur in a row, you should only have one space in the result (the result should
# never have consecutive spaces).

def cleanup(string)
  string.gsub(/[^a-z]/i, " ").squeeze(" ")
end

p cleanup("--Hello*World!!")


# Write a method that takes a string with one or more space separated words and returns a hash that shows
# the number of words of different sizes.

string = 'Hey diddle diddle, the cat and the fiddle!'

# def word_sizes(string)
#   string.split.inject(Hash.new(0)) { |hash, word| hash[word.size] += 1; hash }
# end


# Modify the word_sizes method from the previous exercise to exclude non-letters when determining word size.
# For instance, the length of "it's" is 3, not 4.

def word_sizes(string)
  string.split.inject(Hash.new(0)) do |hash, word| 
    hash[word.gsub(/[^a-z]/i, "").size] += 1; 
    hash 
  end
end

p word_sizes(string)


# Write a method that takes an Array of Integers between 0 and 19, and returns an Array of those Integers
# sorted based on the English words for each number:

INTEGER_WORDS = %w(zero one two three four five six seven eight nine ten eleven twelve
                 thirteen fourteen fifteen sixteen seventeen eighteen nineteen)

def alphabetic_number_sort(array)
  word_integers = array.map { |int| INTEGER_WORDS[int] }.sort
  word_integers.map { |int_word| INTEGER_WORDS.index(int_word)}
end

puts alphabetic_number_sort((0..19).to_a) == [
  8, 18, 11, 15, 5, 4, 14, 9, 19, 1, 7, 17,
  6, 16, 10, 13, 3, 12, 2, 0]


# Write a method that takes a string argument and returns a new string that contains the value of the
# original string with all consecutive duplicate characters collapsed into a single character.

def crunch(string)
  final_string = []
  last_char = ''
  string.split(//).each do |char|
    final_string << char unless char == last_char
    last_char = char
  end
  final_string.join
end

puts crunch('ddaaiillyy ddoouubbllee') == 'daily double'
puts crunch('4444abcabccba') == '4abcabcba'
puts crunch('ggggggggggggggg') == 'g'
puts crunch('a') == 'a'
puts crunch('') == ''


# Write a method that will take a short line of text, and print it within a box.

def print_in_box(string)
  box_length = string.size < 77 ? string.size : 76
  sub_string = []
  if string.size > 76
    loop do
      sub_string << string.slice!(0, 74) + "-"
      break if string.size < 77
    end
    sub_string << string
  else
    sub_string << string
  end
  puts "+-" + ("-" * box_length) + "-+"
  puts "| " + (" " * box_length) + " |"
  sub_string.each do |string| 
    puts "| #{string} |" if string.size == 76
    puts "| " + string + (" " * (box_length - string.size)) + " |"
  end
  puts "| " + (" " * box_length) + " |"
  puts "+-" + ("-" * box_length) + "-+"
end

print_in_box('To boldly go where no one has gone before.')
#+--------------------------------------------+
#|                                            |
#| To boldly go where no one has gone before. |
#|                                            |
#+--------------------------------------------+





