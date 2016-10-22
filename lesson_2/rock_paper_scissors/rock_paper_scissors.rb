VALID_CHOICES = { "r" => "ROCK",
                  "p" => "PAPER",
                  "s" => "SCISSORS",
                  "k" => "SPOCK",
                  "l" => "LIZARD" }

TIE_COMBINATIONS = %w(rr pp ss kk ll)

WINNING_COMBINATIONS = { "rl" => "Rock crush Lizard!",
                         "lk" => "Lizard poisons Spock!",
                         "ks" => "Spock smashes Scissors!",
                         "sp" => "Scissors cut Paper!",
                         "pr" => "Paper covers Rock!",
                         "rs" => "Rock crushes Scissors!",
                         "pk" => "Paper disproves Spock!",
                         "sl" => "Scissors decapitates Lizard!",
                         "kr" => "Spock vaporizes Rock!",
                         "lp" => "Lizard eats Paper!" }

def valid_choice?(choice)
  VALID_CHOICES.keys.include?(choice.downcase)
end

def win?(combination)
  WINNING_COMBINATIONS.keys.include?(combination)
end

def tie?(combination)
  TIE_COMBINATIONS.include?(combination)
end

def integer?(string)
  /^\d+$/.match(string)
end

def prompt(message)
  puts "=> #{message}"
end

def ask_user_name
  user_name = ''
  prompt "Before starting the game, enter your name:"
  loop do
    user_name = gets.chomp
    break unless user_name == ''
    prompt "Please enter a valid name:"
  end
  user_name
end

def ask_max_points(max_points = 5)
  prompt "Please enter how many points users have to reach to win the game:"
  loop do
    max_points = gets.chomp
    break if integer?(max_points) && max_points.to_i > 0
    prompt "Please enter a valid number of points:"
  end
  max_points
end

def ask_choice
  choice = ''
  loop do
    prompt "Choose one: (r)ock, (p)aper, (s)cissors, spoc(k), (l)izard"
    choice = gets.chomp
    break if valid_choice? choice
    prompt "That's not a valid choice."
  end
  system 'clear'
  choice
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

def display_result(user, computer)
  combination = user + computer
  if win?(combination)
    puts WINNING_COMBINATIONS[combination] + " You won!"
  elsif tie?(combination)
    puts "It's a tie!"
  else
    puts WINNING_COMBINATIONS[combination.reverse] + " Computer won!"
  end
end

def display_content(title, user, computer, user_name = "User")
  puts
  puts title.center(30)
  puts "#{user_name}:".ljust(15) + " #{user}".rjust(15)
  puts "Computer:".ljust(15) + " #{computer}".rjust(15)
  puts
end

def display_continue_request(request)
  prompt request
  gets.chomp
  system 'clear'
end

def increment_score(user, computer, score)
  combination = user + computer
  if win?(combination)
    score["User"] += 1
  elsif !tie?(combination) && !win?(combination)
    score["Computer"] += 1
  end
end

def game_winner(game_score, max_points, user_name)
  winner = game_score.key(max_points.to_i)
  if winner == "User"
    (user_name.upcase + " WON!").center(30)
  else
    (winner.upcase + " WON!").center(30)
  end
end

def display_game_winner(game_score, max_points, user_name)
  system 'clear'
  puts game_winner(game_score, max_points, user_name)
  display_content("Final score", game_score["User"],
                  game_score["Computer"], user_name)
end

system 'clear'
prompt "Welcome to the Rock-Paper-Scissors-Spock-Lizard game!"
puts <<-EOF
   This is a variation of the classic game "Rock-Paper-Scissors",
   with the addition of two other choices: "Spock" and "Lizard".
   Here the rules of the game:

   - Rock crush Lizard
   - Lizard poisons Spock
   - Spock smashes Scissors
   - Scissors cut Paper
   - Paper covers Rock
   - Rock crushes Scissors
   - Paper disproves Spock
   - Scissors decapitates Lizard
   - Spock vaporizes Rock
   - Lizard eats Paper

  EOF

user_name = ask_user_name
max_points = ask_max_points

display_continue_request "Press enter to start the game"
loop do
  game_score = { "User" => 0, "Computer" => 0 }

  loop do
    user_choice = ask_choice
    computer_choice = VALID_CHOICES.keys.sample

    increment_score(user_choice, computer_choice, game_score)

    display_content("Choices", VALID_CHOICES[user_choice],
                    VALID_CHOICES[computer_choice], user_name)
    display_result(user_choice, computer_choice)
    display_content("Score (max points = #{max_points})",
                    game_score["User"],
                    game_score["Computer"], user_name)

    display_continue_request "Press enter to continue the game"
    break if game_score.values.include?(max_points.to_i)
  end
  display_game_winner(game_score, max_points, user_name)

  prompt "Do you want to play one more time?"
  answer = validate_answer
  break if answer == "no"
end

prompt "Thank you for playing, #{user_name}. Good bye!"
