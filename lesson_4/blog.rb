def add_string(string)
     puts "Object_id before adding '!' is #{string.object_id}"
     string += "!"
     puts string
     puts "Object_id after adding '!' is #{string.object_id}"
end

def append_string(string)
     puts "Object_id before append '!' is #{string.object_id}"
     string << "!"
     puts string
     puts "Object_id after append '!' is #{string.object_id}"
end

string_1 = "Ciao"
puts "The object_id of string outside method is #{string_1.object_id}"
add_string(string_1)

string_2 = "Hello"
puts "The object_id of string outside method is #{string_2.object_id}"
add_string(string_2)


array = [1, 2, 3, 4, 5]

# select odd values
def select_odd_numbers(array)
  # odd_numbers = []
  # array.each do |number|
  #   odd_numbers << number if number % 2 == 1
  # end
  # odd_numbers
  array.select { |number| number % 2 == 1 }
end

# multiply all items by 2

def multiply_by_two(array)
  # double_numbers = []
  # array.each do |number|
  #   double_numbers << number * 2
  # end
  # double_numbers
  array.map { |number| number * 2 }
end

# sum of all items

def sum_items(array)
  # total = 0
  # array.each do |number|
  #   total += number
  # end
  # total
  array.inject { |sum, num| sum + num }
end

p select_odd_numbers(array)
p multiply_by_two(array)
p sum_items(array)


array = [1, 2, 3, 4]

loop do
  new_array = []
  new_array << array.pop
  a = 15
  break if array.empty?
end

if false
  a = 15
end

p a





