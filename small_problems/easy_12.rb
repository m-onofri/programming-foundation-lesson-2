# Make a madlibs program that reads in some text from a text file that you have created, and then plugs in 
# a selection of randomized nouns, verbs, adjectives, and adverbs into that text and prints it. You can build 
# your lists of nouns, verbs, adjectives, and adverbs directly into your program, but the text data should come 
# from a file or other external source. Your program should read this text, and for each line, it should place 
# random words of the appropriate types into the text, and print the result.

ADJECTIVES = %w(quick, lazy, sleepy, ugly).freeze
NOUNS = %w(fox dog head leg).freeze
VERBS = %w(jumps lifts bites licks).freeze
ADVERBS = %w(easily lazily noisily excitedly).freeze

File.open('new_text.txt') do |file|
  file.each do |line|
    puts format(line, adjective:  ADJECTIVES.sample,
                      noun:       NOUNS.sample,
                      verb:       VERBS.sample,
                      adverb:     ADVERBS.sample )
  end
end

# Write a method that displays an 8-pointed star in an nxn grid, where n is an odd integer that is supplied as 
# an argument to the method. The smallest such star you need to handle is a 7x7 grid.

def star(num)
  j = (num - 3) / 2 
  loop do
    string = "*" + (" " * j) + "*" + (" " * j) + "*"
    j -= 1
    puts string.center(num)
    break if string.size <= 3
  end
  puts "*" * num
  i = 0
  loop do
    string = "*" + (" " * i) + "*" + (" " * i) + "*"
    break if string.size > num
    i += 1
    puts string.center(num)
  end
end

star(9)


# Write a method that takes a 3 x 3 matrix in Array of Arrays format and returns the transpose of the 
# original matrix. Note that there is a Array#transpose method that does this -- you may not use it 
# for this exercise. You also are not allowed to use the Matrix class from the standard library. 
# Your task is to do this yourself.

# Take care not to modify the original matrix: you must produce a new matrix and leave the original 
# matrix unchanged.

def transpose(array)
  result = []
  (0...array[0].size).each do |sub_array|
    new_line = []
    (0...array.size).each do |index|
      new_line << array[index][sub_array]   
    end
    result << new_line
  end
  result
end

matrix = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

new_matrix = transpose(matrix)

p new_matrix #== [[1, 4, 3], [5, 7, 9], [8, 2, 6]]
p matrix #== [[1, 5, 8], [4, 7, 2], [3, 9, 6]]
p transpose([[1, 2, 3, 4]]) #== [[1], [2], [3], [4]]
p transpose([[1], [2], [3], [4]]) #== [[1, 2, 3, 4]]
p transpose([[1, 2, 3, 4, 5], [4, 3, 2, 1, 0], [3, 7, 8, 6, 2]]) #==
  [[1, 4, 3], [2, 3, 7], [3, 2, 8], [4, 1, 6], [5, 0, 2]]
p transpose([[1]]) #== [[1]]


# Write a method that takes an arbitrary matrix and rotates it 90 degrees clockwise as shown above.

def rotate90(array)
  result = []
  (0...array[0].size).each do |sub_array|
    new_line = []
    (0...array.size).each do |index|
      new_line.unshift(array[index][sub_array])
    end
    result << new_line
  end
  result
end

matrix1 = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

matrix2 = [
  [3, 7, 4, 2],
  [5, 1, 0, 8]
]

new_matrix1 = rotate90(matrix1)
new_matrix2 = rotate90(matrix2)
new_matrix3 = rotate90(rotate90(rotate90(rotate90(matrix2))))

p new_matrix1 #== [[3, 4, 1], [9, 7, 5], [6, 2, 8]]
p new_matrix2 #== [[5, 3], [1, 7], [0, 4], [8, 2]]
p new_matrix3 #== matrix2


# Write a method that takes an Array, and returns an Array of Arrays that represent the permutations of the 
# original Array. The order of the permutations does not matter. You may not use the Array#permutations 
# method nor any other standard method that is meant to generate permutations -- please devise your own way 
# of generating the permutations.

# For simplicity, you may assume that each element of the array has a unique value.

def permutations(array)

end

p permutations([2])
# -> [[2]]

p permutations([1, 2])
# -> [[1, 2], [2, 1]]

p permutations([1, 2, 3])
# -> [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]

p permutations([1, 2, 3, 4])
# -> [[1, 2, 3, 4], [1, 2, 4, 3], [1, 3, 2, 4],
#     [1, 3, 4, 2], [1, 4, 2, 3], [1, 4, 3, 2],
#     [2, 1, 3, 4], [2, 1, 4, 3], [2, 3, 1, 4],
#     [2, 3, 4, 1], [2, 4, 1, 3], [2, 4, 3, 1],
#     [3, 1, 2, 4], [3, 1, 4, 2], [3, 2, 1, 4],
#     [3, 2, 4, 1], [3, 4, 1, 2], [3, 4, 2, 1],
#     [4, 1, 2, 3], [4, 1, 3, 2], [4, 2, 1, 3],
#     [4, 2, 3, 1], [4, 3, 1, 2], [4, 3, 2, 1]]

puts "=" * 50

def my_method(array)
  if array.empty?
    []
  elsif array.size > 1
    array.map do |value|
      value * value
    end
  else
    [7 * array.first]
  end
end

p my_method([])
p my_method([3])
p my_method([3, 4])
p my_method([5, 6, 7])

#[]
#[21]
#[9, 16]
#[25, 36, 49]


# Write a method that takes two sorted Arrays as arguments, and returns a new Array that contains all elements
# from both arguments in sorted order.

# You may not provide any solution that requires you to sort the result array. You must build the result array
# one element at a time in the proper order.

# Your solution should not mutate the input arrays.

# def merge(array1, array2)
#   result = []
#   count_1 = 0
#   count_2 = 0

#   return array2 if array1.empty?
#   return array1 if array2.empty?
#   max_value = array1.max > array2.max ? array1.max : array2.max
#   while result.size < (array1.size + array2.size)
#     if array1.fetch(count_1, max_value) <= array2.fetch(count_2, max_value)
#       result << array1[count_1]
#       count_1 += 1 unless count_1 > (array1.size - 1) 
#     else
#       result << array2[count_2]
#       count_2 += 1 unless count_2 > (array2.size - 1)
#     end
#   end
#   result
# end

def merge(array1, array2)
  index2 = 0
  result = []

  array1.each do |value|
    while index2 < array2.size && array2[index2] <= value
      result << array2[index2]
      index2 += 1
    end
    result << value
  end

  result.concat(array2[index2..-1])
end

p merge([1, 5, 9], [2, 6, 8]) #== [1, 2, 5, 6, 8, 9]
p merge([1, 1, 3], [2, 2]) #== [1, 1, 2, 2, 3]
p merge([], [1, 4, 5]) #== [1, 4, 5]
p merge([1, 4, 5], []) #== [1, 4, 5]


def merge_sort(array)
  return array if array.size == 1

  sub_array_1 = array[0...array.size / 2]
  sub_array_2 = array[array.size / 2...array.size]

  sub_array_1 = merge_sort(sub_array_1)
  sub_array_2 = merge_sort(sub_array_2)

  merge(sub_array_1, sub_array_2)
end


p merge_sort([9, 5, 7, 1]) == [1, 5, 7, 9]
p merge_sort([5, 3]) == [3, 5]
p merge_sort([6, 2, 7, 1, 4]) == [1, 2, 4, 6, 7]
p merge_sort(%w(Sue Pete Alice Tyler Rachel Kim Bonnie)) == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)
p merge_sort([7, 3, 9, 15, 23, 1, 6, 51, 22, 37, 54, 43, 5, 25, 35, 18, 46]) == [1, 3, 5, 6, 7, 9, 15, 18, 22, 23, 25, 35, 37, 43, 46, 51, 54]





