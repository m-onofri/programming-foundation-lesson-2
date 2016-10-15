def prompt(string)
  puts "=>> #{string}"
end

def float?(string)
  /\d/.match(string) && /^\d*\.?\d*$/.match(string)
end

def integer?(string)
  /^\d+$/.match(string)
end

def valid_number?(string)
  float?(string) || integer?(string)
end

# info must be a string (es. "loan amount")
def ask_info(info)
  value = ''
  loop do
    value = gets.chomp
    if (valid_number? value) && (value.to_f > 0)
      break
    else
      prompt "The #{info} is not valid. Enter a valid #{info}:"
    end
  end
  value
end

def ask_duration_unit
  duration_unit = ''
  loop do
    duration_unit = gets.chomp
    if duration_unit == "years" || duration_unit == "months"
      break
    else
      puts "You must choose between years or months. Please enter your choice:"
    end
  end
  duration_unit
end

def validate_answer
  answer = ''
  loop do
    answer = gets.chomp
    if answer == "yes" || answer == "no"
      break
    else
      puts "Your answer is not correct; please enter yes or no:"
    end
  end
  answer
end

def from_float_to_array(string)
  custom = {}
  if string.include?(".")
    custom[:positive] = string.split(".")[0].split(//)
    custom[:negative] = string.split(".")[1]
  else
    custom[:positive] = string.split(//)
    custom[:negative] = ''
  end
  custom
end

def add_commas(array, i = 1, output_array = [])
  until array.empty?
    if (i % 4).zero?
      output_array.unshift(",")
    else
      output_array.unshift(array.last)
      array.pop
    end
    i += 1
  end
  output_array
end

def loan_amount_format(string)
  custom = from_float_to_array string
  output_array = add_commas custom[:positive]
  output_array.join + "." + custom[:negative]
end

prompt "Welcome to the Mortgage Calculator!"
prompt "To calculate your montly payment, we need to know some information."
puts
loop do
  loan_amount   = ''
  interest_rate = ''
  duration_unit = ''
  duration_loan = ''

  loop do
    prompt "Please enter your loan amount in euro (example: 100.55):"
    loan_amount = ask_info "loan amount"
    puts
    prompt "Please enter your interest rate (example: 2.5 for 2.5%):"
    interest_rate = ask_info "interest rate"
    puts
    prompt "Will you be entering the duration of your loan " \
           "in months or years? (months/years)"
    duration_unit = ask_duration_unit
    puts
    prompt "Enter your loan duration, in number of #{duration_unit}:"
    duration_loan = ask_info "loan duration"
    puts
    puts "Loan amount: ".ljust(20) +
         "#{loan_amount_format(format('%02.2f', loan_amount))}€".rjust(20)
    puts "Interest rate: ".ljust(20) +
         "#{format('%02.2f', interest_rate)}%".rjust(20)
    puts "Loan duration:".ljust(20) +
         "#{format('%02.1f', duration_loan)} #{duration_unit}".rjust(20)
    puts
    prompt "Do you confirm these information? (yes/no)"
    answer1 = validate_answer
    break if answer1 == "yes"
  end # End inner loop

  interest_per_month = interest_rate.to_f / 100 / 12

  total_months = if duration_unit == "years"
                   duration_loan.to_f * 12
                 else
                   duration_loan.to_f
                 end

  montly_payment = loan_amount.to_f *
                   (interest_per_month /
                   (1 - (1 + interest_per_month)**-total_months))
  puts
  puts "MONTLY PAYMENT:".ljust(20) +
       "#{format('%02.2f', montly_payment)}€".rjust(20)
  puts
  prompt "Would you like to perform another calculation? (yes/no)"
  answer2 = validate_answer
  break if answer2 == "no"
end # End outer loop
puts
prompt "Thank you for using the Mortgage Calculator!"
prompt "Good bye!"
