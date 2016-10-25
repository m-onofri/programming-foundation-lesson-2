# Question n° 1

# Show an easier way to write this array:

flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

########################################################################

# Question n° 2

# How can we add the family pet "Dino" to our usual array:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.push("Dino")

p flintstones

#######################################################################

# Question n° 3

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# In the previous exercise we added Dino to our array like this:

# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
# flintstones << "Dino"

# We could have used either Array#concat or Array#push to add Dino to the family.

# How can we add multiple items to our array? (Dino and Hoppy)

flintstones.concat(%w(Dino", Hoppy))

p flintstones

########################################################################

# Question n° 4

# Shorten this sentence:

advice = "Few things in life are as important as house training your pet dinosaur."

# ...remove everything starting from "house".

# Review the String#slice! documentation, and use that method to make 
# the return value "Few things in life are as important as ". 
# But leave the advice variable as "house training your pet dinosaur.".

# As a bonus, what happens if you use the String#slice method instead?

removed_advice = advice.slice!(0, advice.index("house"))

puts removed_advice
puts advice

# String#slice method returns the substring that matches with the
# argument, but don't remove it from the original string

#########################################################################

# Question n° 5

# Write a one-liner to count the number of lower-case 't' characters 
# in the following string:

statement = "The Flintstones Rock!"

t_number = statement.count("t")

puts t_number

##########################################################################

# Question n° 6

# Back in the stone age (before CSS) we used spaces to align things on
# the screen. If we had a 40 character wide table of Flintstone family
# members, how could we easily center that title above the table with spaces?

title = "Flintstone Family Members"

title.center(40)




