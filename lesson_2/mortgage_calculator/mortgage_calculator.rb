# Methods

def prompt(message)
  puts "=>> #{message}"
end

def ask_name
  prompt "Please, enter your name:"
  user_name = ""
  loop do
    user_name = gets.chomp
    if user_name.empty?
      puts "You must enter a valid name:"
    else
      break
    end
  end
  user_name
end

def float? string
  /\d/.match(string) && /^\d*\.?\d*$/.match(string)
end

def integer? string
  /^\d+$/.match(string)
end

def valid_number? string
  float?(string) || integer?(string)
end

def ask_info info, request
  prompt request
  value = ''
  loop do
    value = gets.chomp
    if valid_number? value
      if value.to_f > 0
        break
      else
        puts "The #{info} can't be zero or lower. Please, enter a valid #{info}:"
      end
    else
      puts "The #{info} is not valid. Enter a valid #{info}:"
    end
  end
  value
end

def set_duration_unit
  prompt "Will you be entering the duration of your loan in months or years? (months/years)")
  duration_unit = ''
  loop do
    duration_unit = gets.chomp
    if duration_unit.downcase == "years" || duration_unit.downcase == "months"
      break
    else
      puts "You must choose between years or months. Please enter your choice:"
    end
  end
  duration_unit
end

def correct_answer 
  answer = ''
  loop do
    answer = gets.chomp
    if answer.downcase == "yes" || answer.downcase == "no"
      break
    else
      puts "Your answer is not correct; please enter yes or no:"
    end
  end
  answer
end

def loan_amount_format string
  if string.include?(".")
    positive = string.split(".")[0].split(//)
    negative = string.split(".")[1]
  else
    positive = string.split(//)
    negative = ''
  end
  output_array = [] 
  i = 1
  while !positive.empty?
    if i % 4 == 0
      output_array.unshift(",")
      i = 1
    else
      output_array.unshift(positive.last)
      positive.pop
      i += 1
    end
  end
  result = output_array.join + "." + negative
end

# Program
puts "Welcome to the Mortgage Calculator!"

user_name = ask_name

puts "Hi #{user_name}. To calculate your montly payment, we need to know some information."

loop do 
  loan_amount   = ''
  interest_rate = ''
  duration_unit = ''
  duration_loan = ''

  loop do 
    loan_amount = ask_info "loan amount", "Please enter your loan amount (in euro):"
    interest_rate = ask_info "interest rate", "Please enter your interest rate (example: 2.5 for 2.5%)"
    duration_unit = set_duration_unit
    duration_loan = ask_info "loan duration", "Please enter your loan duration, in number of #{duration_unit}:"

    puts "Loan amount: #{loan_amount_format(format('%02.2f', loan_amount))}€\ninterest rate: #{format('%02.2f', interest_rate)}%\nLoan duration: #{format('%02.1f', duration_loan)} #{duration_unit}"
    puts "Do you confirm these information? (yes/no)"
    answer1 = correct_answer
    if answer1 == "yes"
      break
    end
  end # End inner loop

  interest_per_month = interest_rate.to_f / 100 / 12

  if duration_unit == "years"
    total_months = duration_loan.to_f * 12
  else
    total_months = duration_loan.to_f
  end

  montly_payment = loan_amount.to_f * (interest_per_month / (1 - (1 + interest_per_month)**-total_months))

  puts "Your monthly payment is: #{format('%02.2f', montly_payment)}€"

  puts "Would you like to perform another calculation? (yes/no)"
  answer2 = correct_answer
  if answer2 == "no"
    break
  end
end # End outer loop

puts "Thank you #{user_name} for using the Mortgage Calculator!"
puts "Good bye!"

#Refactor the resume part
#Eliminate the user_name part?














  
