# Write a method that takes an Array of numbers and then returns the sum of the sums of each leading subsequence
# for that Array. You may assume that the Array always contains at least one number.

def sum_of_sums(array)
  sum = 0
  array.length.times do |index|
    sum += array[0, index + 1].reduce(&:+)
  end
  sum
end

puts sum_of_sums([3, 5, 2]) == (3) + (3 + 5) + (3 + 5 + 2) # -> (21)
puts sum_of_sums([1, 5, 7, 3]) == (1) + (1 + 5) + (1 + 5 + 7) + (1 + 5 + 7 + 3) # -> (36)
puts sum_of_sums([4]) == 4
puts sum_of_sums([1, 2, 3, 4, 5]) == 35


# Mad libs are a simple game where you create a story template with blanks for words. You, or another player,
# then construct a list of words and place them into the story, creating an often silly or funny story as a result.

# Create a simple mad-lib program that prompts for a noun, a verb, an adverb, and an adjective and injects those
# into a story that you create.

def mad_lib
  user_inputs = []
  required_data = %w(noun verb adjective adverb)
  required_data.each do |question|
    puts "Enter a #{question}:"
    user_inputs << gets.chomp
  end
  puts "Do you #{user_inputs[1]} your #{user_inputs[2]} #{user_inputs[0]} #{user_inputs[3]}? That's hilarious!"
end

# mad_lib

# Write a method that returns a list of all substrings of a string that start at the beginning of the original
# string. The return value should be arranged in order from shortest to longest substring.

def substrings_at_start(string)
  result = []
  string.size.times do |index|
    result << string.split(//).slice(0, index + 1).join
  end
  result
end

puts substrings_at_start('abc') == ['a', 'ab', 'abc']
puts substrings_at_start('a') == ['a']
puts substrings_at_start('xyzzy') == ['x', 'xy', 'xyz', 'xyzz', 'xyzzy']


# Write a method that returns a list of all substrings of a string. The returned list should be ordered by where
# in the string the substring begins. This means that all substrings that start at position 0 should come first,
# then all substrings that start at position 1, and so on. Since multiple substrings will occur at each position,
# the substrings at a given position should be returned in order from shortest to longest.

# You may (and should) use the substrings_at_start method you wrote in the previous exercise:

def substrings(string)
  result = []
  string.size.times do |index|
    result << substrings_at_start(string[index..-1])
  end
  result.flatten
end

p substrings("hello")


# Write a method that returns a list of all substrings of a string that are palindromic. That is, each
# substring must consist of the same sequence of characters forwards as it does backwards. The return value should
# be arranged in the same sequence as the substrings appear in the string. Duplicate palindromes should be
# included multiple times.

def palindromes(string)
  result = []
  all_substrings = substrings(string)
  all_substrings.each do |item|
    result << item if item.size > 1 && item == item.reverse
  end
  result
end

p palindromes("madam")


# Write a method that takes two arguments: the first is the starting number, and the second is the ending number.
# Print out all numbers between the two numbers, except if a number is divisible by 3, print "Fizz", if a number
# is divisible by 5, print "Buzz", and finally if a number is divisible by 3 and 5, print "FizzBuzz".

def fizzbuzz(starting, ending)
  result = []
  (starting..ending).each do |num|
    if num % 3 == 0 && num % 5 == 0
      result << "FizzBuzz"
    elsif num % 3 == 0
      result << "Fizz"
    elsif num % 5 == 0
      result << "Buzz"
    else
      result << num
    end
  end
  puts result.join(", ")
end

fizzbuzz(10, 20)


# Write a method that takes a string, and returns a new string in which every character is doubled.

def repeater(string)
  string.split(//).map {|char| char * 2 }.join
end

p repeater("hello")


# Write a method that takes a string, and returns a new string in which every consonant character
# is doubled. Vowels (a,e,i,o,u), digits, punctuation, and whitespace should not be doubled.

def double_consonants(string)
  result = string.split(//).map do |char|
    char =~ /[b-df-hj-np-tv-z]/i ? char * 2 : char
  end
  result.join
end

p double_consonants("Hello-World!")


# Write a method that takes a positive integer as an argument and returns that number with its digits
# reversed. Examples:

def reversed_number(num)
  num.to_s.split(//).reverse.join.to_i
end

p reversed_number(12000) #== 54321


# Write a method that takes a non-empty string argument, and returns the middle character or characters 
# of the argument. If the argument has an odd length, you should return exactly one character. If the 
# argument has an even length, you should return exactly two characters.

def center_of(string)
  half_size = string.size / 2
  case 
  when string.size.odd? then string[half_size]
  when string.size.even? then string[half_size - 1, 2]  
  end
end

p center_of('I love ruby!') #== 'e'






