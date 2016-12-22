# Write a method that combines two Arrays passed in as arguments, and returns a new Array that contains all 
# elements from both Array arguments, with the elements taken in alternation.

# You may assume that both input Arrays are non-empty, and that they have the same number of elements.

def interleave(array_1, array_2)
  new_array = []
  array_1.each_with_index do |item, index|
    new_array << item << array_2[index]
  end
  new_array
end

p interleave([1, 2, 3], %w(a b c))


def interleave_alt(array_1, array_2)
  array_1.zip(array_2).flatten
end

p interleave_alt([1, 2, 3], %w(a b c))


# Write a method that takes a string, and then returns a hash that contains 3 entries: one represents the
# number of characters in the string that are lowercase letters, one the number of characters that are
# uppercase letters, and one the number of characters that are neither.

def letter_case_count(string)
  string.chars.inject({lowercase: 0, uppercase: 0, neither: 0}) do |hash, char|
    if /[a-z]/.match(char)
      hash[:lowercase] += 1
    elsif /[A-Z]/.match(char)
      hash[:uppercase] += 1
    else
      hash[:neither] += 1
    end
    hash
  end
end

puts letter_case_count('abCdef 123') == { lowercase: 5, uppercase: 1, neither: 4 }
puts letter_case_count('AbCd +Ef') == { lowercase: 3, uppercase: 3, neither: 2 }
puts letter_case_count('123') == { lowercase: 0, uppercase: 0, neither: 3 }
puts letter_case_count('') == { lowercase: 0, uppercase: 0, neither: 0 }

# Write a method that takes a single String argument and returns a new string that contains the original 
# value of the argument, but the first letter of every word is now capitalized.

# You may assume that words are any sequence of non-blank characters, and that only the first character of 
# each word must be considered.

def word_cap(string)
  string.split.map(&:capitalize).join(' ')
end

puts word_cap('four score and seven') == 'Four Score And Seven'
puts word_cap('the javaScript language') == 'The Javascript Language'
puts word_cap('this is a "quoted" word') == 'This Is A "quoted" Word'

def word_cap_alt(string)
  result = string.downcase.split.map do |word|
    word[0]= word[0].upcase
    word
  end
  result.join(" ")
end

puts word_cap_alt('this is a "quoted" word')


# Write a method that takes a string as an argument and returns a new string in which every uppercase 
# letter is replaced by its lowercase version, and every lowercase letter by its uppercase version. 
# All other characters should be unchanged.

# You may not use String#swapcase; write your own version of this method.

def swapcase(string)
  result = string.split(//).map do |char|
    /[a-z]/.match(char) ? char.upcase : char.downcase
  end
  result.join
end

puts swapcase('CamelCase') == 'cAMELcASE'
puts swapcase('Tonight on XYZ-TV') == 'tONIGHT ON xyz-tv'


# Write a method that takes a String as an argument, and returns a new String that contains the original 
# value using a staggered capitalization scheme in which every other character is capitalized, and the
# remaining characters are lowercase. Characters that are not letters should not be changed, but count as
# characters when switching between upper and lowercase.

def staggered_case(string, first_case = "upper")
  result = string.downcase.split(//).map.with_index do |char, index|
    case first_case
    when "upper" then index % 2 == 0 ? char.upcase : char.downcase
    when "lower" then index % 2 == 0 ? char.downcase : char.upcase
    end
  end
  result.join
end

puts staggered_case('I Love Launch School!') == 'I LoVe lAuNcH ScHoOl!'
puts staggered_case('ALL_CAPS') == 'AlL_CaPs'
puts staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 NuMbErS'

puts staggered_case('I Love Launch School!', "lower")
puts staggered_case('ALL_CAPS', "lower")
puts staggered_case('ignore 77 the 444 numbers', "lower")


# Modify the method from the previous exercise so it ignores non-alphabetic characters when determining
# whether it should uppercase or lowercase each letter. The non-alphabetic characters should still be
# included in the return value; they just don't count when toggling the desired case. 

def staggered_case_alt(string, first_case = "upper")
  need_upper = first_case == "upper" ? true : false
  result = string.downcase.split(//).map do |char|
    if char =~ /[A-Za-z]/
      need_upper ? char.upcase! : char.downcase!
    end
    need_upper = !need_upper
    char
  end
  result.join
end

puts staggered_case_alt('ignore 77 the 444 numbers', "lower")


# Write a method that takes an Array of integers as input, multiplies all of the numbers together,
# divides the result by the number of entries in the Array, and then prints the result rounded to 3
# decimal places.

def show_multiplicative_average(array)
  result = format("%.3f", array.reduce(&:*).to_f / array.size)
  puts "The result is #{result}"
end

show_multiplicative_average([3, 5])


show_multiplicative_average([2, 5, 7, 11, 13, 17])


# Write a method that takes two Array arguments in which each Array contains a list of numbers, and 
# returns a new Array that contains the product of each pair of numbers from the arguments that have 
# the same index. You may assume that the arguments contain the same number of elements.

def multiply_list(array_1, array_2)
  array_1.zip(array_2).map { |arr| arr.first * arr.last}
end

puts multiply_list([3, 5, 7], [9, 10, 11]) == [27, 50, 77]


# Write a method that takes two Array arguments in which each Array contains a list of numbers, and 
# returns a new Array that contains the product of every pair of numbers that can be formed between 
# the elements of the two Arrays. The results should be sorted by increasing value.

# You may assume that neither argument is an empty Array.

def multiply_all_pairs(array_1, array_2)
  result = []
  array_1.each do |num_1|
    array_2.each do |num_2|
      result << num_1 * num_2
    end
  end
  result.sort
end

puts multiply_all_pairs([2, 4], [4, 3, 1, 2]) == [2, 4, 4, 6, 8, 8, 12, 16]

def multiply_all_pairs_1(array_1, array_2)
  array_1.product(array_2).map { |num1, num2| num1 * num2 }.sort
end

p multiply_all_pairs_1([2, 4], [4, 3, 1, 2])


# Write a method that returns the next to last word in the String passed to it as an argument.
# Words are any sequence of non-blank characters.
# You may assume that the input String will always contain at least two words.

def penultimate(string)
  string.split[-2]
end

puts penultimate('last word') #== 'last'
puts penultimate('Launch School is great!') == 'is'








