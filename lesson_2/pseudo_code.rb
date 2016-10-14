# write out pseudo-code (both casual and formal) that does the following:

#1) a method that returns the sum of two integers

  # Casual pseudo-code
  Given two integers.

  Check if the two values are integers:
    - if they are integers (both of them), execute the sum of the two integers, and save the result in a variable
    - otherwise, if at least one of them is not an integers, return a massage saying that the value is not an integer

  Print on the screen the result

  #Formal pseudo-code
  START

  # Given two values called num1 and num2

  IF num1 is an integer && num2 is an integer
    SET result = num1 + num2
  ELSE
    SET result = "One value or both of them are not integers!"

  PRINT result
  
  END  


  #2) a method that takes an array of strings, and returns a string that is all those strings concatenated together

  # Casual pseudo-code
  Given an array of strings 

  Create an empty variable that will contain the final string

  Iterate through the collection one by one
   - for each iteration, add the current string to the variable 

  After iterating through the collection, return the value saved in the variable

  #Formal pseudo-code
  START

  #Given an array of strings called "strings"

  SET result = empty string

  WHILE iterator < length of strings
    result = result value + value within strings collection at space "iterator"

  PRINT result

  END

  #3) a method that takes an array of integers, and returns a new array with every other element

  # Casual pseudo-code
  Given an array of integers

  Create a variable containing an empty array

  Iterate through the collection one by one
  - for each iteration, convert the current integer in a string
  - insert the new string in the variable containing the empty array

  After iterating through the collection, return the saved value

  #Formal pseudo-code
  START

  # Given an array of integers called "numbers"

  SET result = an empty array

  WHILE iterator < length of numbers
    convert the integer value within numbers collection at space "iterator" to a string value
    push the new string value in result

  PRINT result

  END







