require 'yaml'
MESSAGES = YAML.load_file('calculator_message.yml')
LANGUAGE = "en"

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(message)
  puts "=> " + message
end

def valid_number?(number)
  number.to_i.to_s == number
end

def operation_to_message(op)
  case op
  when "1"
    "Adding"
  when "2"
    "Subtracting"
  when "3"
    "Multiplying"
  when "4"
    "Dividing"
  end
end

prompt messages('welcome', LANGUAGE)

name = ''
loop do
  name = gets.chomp

  if name.empty?
    prompt messages('valid_name', LANGUAGE)
  else
    break
  end
end

prompt "Hi #{name}"

loop do
  number1 = ''
  loop do
    prompt messages('first_number', LANGUAGE)
    number1 = gets.chomp

    if valid_number? number1
      break
    else
      prompt messages('valid_number', LANGUAGE)
    end
  end

  number2 = ''
  loop do
    prompt messages('second_number', LANGUAGE)
    number2 = gets.chomp

    if valid_number? number2
      break
    else
      prompt messages('valid_number', LANGUAGE)
    end
  end

  prompt messages('operator_prompt', LANGUAGE)

  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include?(operator)
      result =  case operator
                when "1"
                  number1.to_i + number2.to_i
                when "2"
                  number1.to_i - number2.to_i
                when "3"
                  number1.to_i * number2.to_i
                when "4"
                  number1.to_f / number2.to_f
                end

      prompt "#{operation_to_message operator} the two numbers..."
      prompt "The result is #{result}"
      break
    else
      prompt messages('valid_operator', LANGUAGE)
    end
  end

  prompt messages('another_calculation', LANGUAGE)
  answer = gets.chomp

  break unless answer.downcase.start_with?("y")
end
