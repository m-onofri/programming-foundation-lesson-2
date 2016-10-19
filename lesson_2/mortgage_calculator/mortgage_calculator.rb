def prompt(string)
  puts "=>> #{string}"
end

def float?(string)
  /^\d*\.?\d+$/.match(string)
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
    break if (valid_number? value) && (value.to_f > 0)
    prompt "The #{info} is not valid. Enter a valid #{info}:"
  end
  value
end

def ask_duration_unit
  duration_unit = ''
  loop do
    duration_unit = gets.chomp
    break if duration_unit == "years" || duration_unit == "months"
    puts "You must choose between years or months. Please enter your choice:"
  end
  duration_unit
end

def validate_answer
  answer = ''
  loop do
    answer = gets.chomp
    break if answer == "yes" || answer == "no"
    puts "Your answer is not correct; please enter yes or no:"
  end
  answer
end

# for '23.55' returns {:integer_part => ['2', '3'], :decimal_part => ['5', '5']}
def split_float(string)
  custom = {}
  if string.include?(".")
    custom[:integer_part] = string.split(".")[0].split(//)
    custom[:decimal_part] = string.split(".")[1]
  else
    custom[:integer_part] = string.split(//)
    custom[:decimal_part] = ''
  end
  custom
end

# for ['1', '0', '0', '0'] the method returns ['1', ',', '0', '0', '0']
def add_commas(array, i = 1)
  output_array = []
  until i > array.length
    if (i % 3).zero?
      output_array.unshift("," + array[array.length - i])
    else
      output_array.unshift(array[array.length - i])
    end
    i += 1
  end
  output_array
end

# Add commas to a float number (for "1000.55" the method returns "1,000.55")
def float_format(string)
  custom = split_float string
  output_array = add_commas custom[:integer_part]
  output_array.join + "." + custom[:decimal_part]
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
    system 'clear'
    prompt "Please enter your loan amount in euro (example: 100.55):"
    loan_amount = ask_info "loan amount"
    system 'clear'
    prompt "Please enter your interest rate (example: 2.5 for 2.5%):"
    interest_rate = ask_info "interest rate"
    system 'clear'
    prompt "Will you be entering the duration of your loan " \
           "in months or years? (months/years)"
    duration_unit = ask_duration_unit
    system 'clear'
    prompt "Enter your loan duration, in number of #{duration_unit}:"
    duration_loan = ask_info "loan duration"
    system 'clear'
    puts "Loan amount: ".ljust(20) +
         "#{float_format(format('%02.2f', loan_amount))}€".rjust(20)
    puts "Interest rate: ".ljust(20) +
         "#{format('%02.2f', interest_rate)}%".rjust(20)
    puts "Loan duration:".ljust(20) +
         "#{format('%02.1f', duration_loan)} #{duration_unit}".rjust(20)
    puts
    prompt "Do you confirm these information? (yes/no)"
    answer1 = validate_answer
    break if answer1 == "yes"
  end

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
       "#{float_format(format('%02.2f', montly_payment))}€".rjust(20)
  puts
  prompt "Would you like to perform another calculation? (yes/no)"
  answer2 = validate_answer
  break if answer2 == "no"
end
puts
prompt "Thank you for using the Mortgage Calculator!"
prompt "Good bye!"
