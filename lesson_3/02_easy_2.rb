# Question n° 1

# In this hash of people and their age,

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# see if "Spot" is present.

spot_presence = ages.key?("Spot")

puts spot_presence

# What are two other hash methods 
# that would work just as well for this solution?

spot_presence_1 = ages.member?("Spot")
spot_presence_2 = ages.include?("Spot")

puts spot_presence_1
puts spot_presence_2

##########################################################################

# Question n° 2

# Add up all of the ages from our current Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

sum = ages.values.reduce(:+)

sum_1 = ages.values.inject(:+)

puts sum

puts sum_1

########################################################################

# Question n° 3

# In the age hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# throw out the really old people (age 100 or older).

ages.keep_if{|k, v| v >= 100}

p ages

#########################################################################

# Question n° 4

# Starting with this string:

munsters_description = "The Munsters are creepy in a good way."

# Convert the string in the following ways 
# (code will be executed on original munsters_description above):

"The munsters are creepy in a good way."
"tHE mUNSTERS ARE CREEPY IN A GOOD WAY."
"the munsters are creepy in a good way."
"THE MUNSTERS ARE CREEPY IN A GOOD WAY."

munsters_description.capitalize!
munsters_description.swapcase!
munsters_description.downcase!
munsters_description.upcase!

########################################################################

# Question n° 5

# We have most of the Munster family in our age hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }

# add ages for Marilyn and Spot to the existing hash

additional_ages = { "Marilyn" => 22, "Spot" => 237 }

ages.merge!(additional_ages)

p ages

#########################################################################

# Question n° 6

# Pick out the minimum age from our current Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }




