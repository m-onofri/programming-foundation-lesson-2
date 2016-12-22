# Build a program that randomly generates and prints Teddy's age. To get the age, you should generate a
# random number between 20 and 200.

age = (20..200).to_a.sample

puts "Teddy is #{age} years old!"

# Build a program that asks a user for the length and width of a room in meters and then displays the area of 
# the room in both square meters and square feet.

# SQMETERS_TO_SQFEET = 10.7639

# puts "Please enter the length of the room in meters"
# length = gets.chomp
# puts "Now enter the width of the room in meters"
# width = gets.chomp

# area_meters = length.to_f * width.to_f
# area_feets = area_meters * SQMETERS_TO_SQFEET 

# puts "The area of the room is #{area_meters} square meters (#{area_feets} square feet)."

# Create a simple tip calculator. The program should prompt for a bill amount and a tip rate. 
# The program must compute the tip and then display both the tip and the total amount of the bill.

# puts "What's the bill?"
# bill = gets.chomp.to_f
# puts "What's the tip percentage?"
# tip_percentage = gets.chomp.to_f

# tip = (bill / 100 * tip_percentage)
# total = (bill + tip)

# puts "The tip is $#{format("%.2f", tip)}"
# puts "The total is $#{format("%.2f", total)}"


# Build a program that displays when the user will retire and how many years she has to work till retirement.
# current_year = Time.now.year

# puts "What is your age?"
# age = gets.chomp.to_i
# puts "At what age would you like to retire?"
# age_retire = gets.chomp.to_i

# remaining_years = age_retire - age
# year_retire = current_year + remaining_years

# puts "It's #{current_year}. You will retire in #{year_retire}."
# puts "You have only #{remaining_years} years of work to go!"


# Write a program that will ask for user's name. The program will then greet the user. 
# If the user writes "name!" then the computer yells back to the user.

# puts "What is your name?"
# user_name = gets.chomp
# answer = user_name.match("!") ? "HELLO #{user_name.chop.upcase}. WHY ARE WE SCREAMING?" : "Hello #{user_name}"

# puts answer


# Print all odd numbers from 1 to 99, inclusive. All numbers should be printed on separate lines.

# (1..99).each { |number| puts number if number.odd? }

# puts (1..99).select { |number| number % 2 == 1 }


# Write a program that asks the user to enter an integer greater than 0, then asks if the user wants to determine
# the sum or product of all numbers between 1 and the entered integer.

def integer?(string)
  /^\d+$/.match(string)
end

def ask_valid_integer
  answer = ""
  loop do
    puts "Please enter an integer greater than 0:"
    answer = gets.chomp
    break if integer?(answer) && answer.to_i > 0
  end
  answer.to_i
end

def ask_valid_operation
  operation = ""
  puts "Enter 's' to compute the sum, 'p' to compute the product."
  loop do
    case gets.chomp.downcase
    when "s", "sum" then return "sum"
    when "p", "product" then return "product"
    else puts "Please, enter 's' or 'p'."
    end
  end
end

def perform_operation(operation, integer)
  case operation
  when "sum"
    operation = "sum"
    (1..integer).reduce(&:+)
  when "product" 
    operation = "product" 
    (1..integer).reduce(&:*)
  end
end


integer = ask_valid_integer
operation = ask_valid_operation
result = perform_operation(operation, integer)

puts "The #{operation} of the integers between 1 and #{integer} is #{result}."























