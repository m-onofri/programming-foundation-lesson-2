# Methods

# This method return true when num has ONE or TWO digits max after the point
def float?(num)
  /^\d*\.\d{1,2}$/.match(num)
end

# This method return true when num is formed by ONE or MORE digits
def integer?(num)
  /^\d+$/.match(num)
end


# Program

puts "Welcome to the Mortgage Calculator!"

puts "Please, enter your name:"
user_name = ""
loop do
  user_name = gets.chomp

  if user_name.empty?
    "You must enter a valid name"
  else
    break
  end
end

puts "Hi #{user_name}. To calculate your montly payment, we need to know some information."

loop do # ùin this loop I perform the calculation for the montly payment
    loan_amount   = ''
    interest_rate = ''
    duration_unit = ''
    duration_loan = ''

  loop do # In this loop I collect the information to calculate the montly payment
    
    puts "What's the loan amount?"
    loop do
      loan_amount = gets.chomp

      # loan_amount must be:
      # a float number (that is 100.00) or an integer number (that is 100)
      # greater than zero
      if float?(loan_amount) || integer?(loan_amount)
        if loan_amount.to_f > 0
          break
        else
          puts "The loan amount can't be zero or lower. Please, enter a valid loan amount:"
        end
      else
        puts "The loan amount is not valid. Enter a valid loan amount"
      end
    end

    puts "What is the interest rate?\n(Example: 5 for 5% or 2.5 for 2.5%)"
    loop do
      interest_rate = gets.chomp

      # interest_rate must be:
      # a float number (that is 2.23) or an integer number
      # greater than zero
      if float?(interest_rate) || integer?(interest_rate)
        if interest_rate.to_f > 0
          break
        else
          puts "The interest rate can't be zero or lower. Please, enter a valid interest rate:"
        end
      else
        puts "The interest rate is not valid. Enter a valid interest rate"
      end
    end

    puts "Now we need to know the duration of the loan; please choose between this two option: years or months"
    
    loop do
      duration_unit = gets.chomp

      if duration_unit.downcase.start_with('y') || duration_unit.downcase.start_with('m')
        break
      else
        puts "You must choose between years or months. Please enter your choice:"
      end
    end

    puts "What is the duration of the loan (in #{duration_unit})?"
    loop do
      duration_loan = gets.chomp

      # duration_loan must be:
      # a float number (that is 1.5 years) or an integer number
      # greater than zero
      if float?(duration_loan)
        if duration_loan.to_f > 0
          break
        else
          puts "The loan duration can't be zero or lower. Please, enter a valid loan duration:"
        end
      else
        puts "The loan duration is not valid. Enter a valid loan duration"
      end
    end

    puts "Loan amount: #{loan_amount} €\ninterest rate: #{interest_rate}%\nLoan duration: #{duration_loan} #{duration_unit}"
    puts "Do you confirm these information? (enter yes to conferm)"
    answer1 = gets.chomp
    if answer1 == "yes"
      break
    end
  end

  interest_per_year = interest_rate.to_f / 100
  interest_per_month = interest_per_year / 12

  if duration_unit == "years"
    total_months = duration_loan.to_f * 12
  else
    total_months = duration_loan.to_f
  end

  montly_payment = (loan_amount.to_f * (interest_per_month / (1 - (1 + interest_per_month)**-total_months))).round(2)

  puts "Your monthly payment is: #{montly_payment} €"

  puts "Would you like to perform another calculation? (enter yes to conferm)"
  answer2 = gets.chomp

  break unless answer2 == "yes"
end

puts "Thank you for using the Mortgage Calculator!"
puts "Good bye!"

# Write method for check input value
# Put the strings in YAML file











  
