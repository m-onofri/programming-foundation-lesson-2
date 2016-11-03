EMPTY_SQUARE = ' '.freeze
USER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
WINNING_ROWS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7],
                [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze

def clear_screen
  system('clear') || system('cls')
end

def prompt(message)
  puts "=> #{message}"
end

def integer?(string)
  /^\d+$/.match(string)
end

def ask_user_name
  user_name = ''
  prompt "Before starting the game, enter your name:"
  loop do
    user_name = gets.chomp
    break if user_name =~ /^[A-Za-z]+$/
    prompt "Please enter a valid name:"
  end
  user_name
end

def ask_max_points
  max_points = nil
  prompt "Please enter how many points players have to reach to win the game:"
  loop do
    max_points = gets.chomp
    break if integer?(max_points) && max_points.to_i.positive?
    prompt "Please enter a valid number of points:"
  end
  max_points
end

def coin_toss_result
  coin_toss_result = ["h", "t"].sample
  return "heads" if coin_toss_result == "h"
  return "tails" if coin_toss_result == "t"
end

def valid_coin_toss_choice
  prompt "To choose who will start the game, we toss a coin:" \
         " (h)eads or (t)ails?"
  loop do
    case gets.chomp.downcase
    when "heads", "h" then return "heads"
    when "tails", "t" then return "tails"
    else prompt "Please enter (h)eads or (t)ails."
    end
  end
end

def set_starting_player
  coin_toss = coin_toss_result
  user_choice = valid_coin_toss_choice
  prompt "You choose #{user_choice}."
  if user_choice == coin_toss
    prompt "The coin toss result is #{coin_toss}."
    prompt "You will start the game."
    return "user"
  else
    prompt "The coin toss results is #{coin_toss}."
    prompt "Computer will start the game."
    return "computer"
  end
end

def prompt_to_continue(request)
  prompt request
  gets.chomp
  clear_screen
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = EMPTY_SQUARE }
  new_board
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  puts ""
  puts " 1   |2    |3    ".center(50)
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  ".center(50)
  puts "     |     |     ".center(50)
  puts "-----+-----+-----".center(50)
  puts " 4   |5    |6    ".center(50)
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  ".center(50)
  puts "     |     |     ".center(50)
  puts "-----+-----+-----".center(50)
  puts " 7   |8    |9    ".center(50)
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  ".center(50)
  puts "     |     |     ".center(50)
  puts ""
end
# rubocop:enable Metrics/AbcSize

def display_game_score(game_score, user_name, max_points)
  user_score = "#{user_name} (X):".ljust(15) + game_score[:user].to_s.rjust(15)
  comp_score = "Computer (O):".ljust(15) + game_score[:computer].to_s.rjust(15)
  puts "Game score (max points = #{max_points})".center(50)
  puts user_score.center(50)
  puts comp_score.center(50)
  puts ""
end

def show_game_situation(brd, game_score, username, max_points)
  display_board(brd)
  display_game_score(game_score, username, max_points)
end

def joinor(array, sep = ", ", last_sep = " or ")
  last_item = array.pop.to_s
  final_str = array.join(sep)
  array.empty? ? final_str << last_item : final_str << last_sep + last_item
  final_str
end

def available_squares(brd)
  brd.keys.select { |square| brd[square] == EMPTY_SQUARE }
end

def computer_smart_move(brd, marker_checked)
  WINNING_ROWS.each do |value|
    next unless brd.values_at(*value).count(marker_checked) == 2
    value.each { |square| return square if brd[square] == EMPTY_SQUARE }
  end
  nil
end

def computer_smart_choice(brd)
  offensive_move = computer_smart_move(brd, COMPUTER_MARKER)
  return offensive_move unless offensive_move.nil?
  defensive_move = computer_smart_move(brd, USER_MARKER)
  return defensive_move unless defensive_move.nil?
  return 5 if brd[5] == EMPTY_SQUARE
  available_squares(brd).sample
end

def update_board!(brd, square, player)
  case player
  when "user" then brd[square] = USER_MARKER
  when "computer" then brd[square] = COMPUTER_MARKER
  end
end

def valid_choice?(choice, brd)
  (1..9).cover?(choice) && available_squares(brd).include?(choice)
end

def ask_choice(brd)
  user_choice = ''
  loop do
    prompt "Please mark a free square (#{joinor(available_squares(brd))})"
    user_choice = gets.chomp.to_i
    break if valid_choice?(user_choice, brd)
  end
  user_choice
end

def current_player_move!(brd, current_player)
  if current_player == "user"
    user_choice = ask_choice(brd)
    update_board!(brd, user_choice, "user")
  elsif current_player == "computer"
    computer_choice = computer_smart_choice(brd)
    update_board!(brd, computer_choice, "computer")
  end
end

def board_full?(brd)
  available_squares(brd).empty?
end

def someone_won?(brd)
  !!the_winner_is(brd)
end

def alternate_player(current_player)
  current_player == "user" ? "computer" : "user"
end

def increment_score!(game_score, brd)
  game_score[:user] += 1 if the_winner_is(brd) == "user"
  game_score[:computer] += 1 if the_winner_is(brd) == "computer"
end

def the_winner_is(brd)
  WINNING_ROWS.each do |value|
    return 'user' if value.all? { |square| brd[square] == USER_MARKER }
    return 'computer' if value.all? { |square| brd[square] == COMPUTER_MARKER }
  end
  nil
end

def prompt_result_declaration(brd, user_name)
  if someone_won?(brd)
    if the_winner_is(brd) == "user"
      prompt "#{user_name} won!"
    else
      prompt "Computer won!"
    end
  else
    prompt "It's a tie!"
  end
end

def prompt_final_game_winner(game_score, user_name, max_points)
  winner = game_score.key(max_points.to_i)
  if winner == :user
    puts "#{user_name.upcase} WON!".center(50)
  else
    puts "COMPUTER WON!".center(50)
  end
end

def play_again?
  puts ''
  prompt "Do you want to play again? (yes/no)"
  loop do
    case gets.chomp.downcase
    when "yes", "y" then return true
    when "no", "n" then return false
    else prompt "Please enter yes or no"
    end
  end
end

clear_screen

prompt "Welcome to the Tic Tac Toe game!"
user_name = ask_user_name
loop do
  game_score = { user: 0, computer: 0 }
  max_points = ask_max_points
  starting_player = set_starting_player

  prompt_to_continue "Press enter to continue the game"
  loop do
    board = initialize_board
    current_player = starting_player
    loop do
      clear_screen

      show_game_situation(board, game_score, user_name, max_points)
      current_player_move!(board, current_player)
      current_player = alternate_player(current_player)

      break if someone_won?(board) || board_full?(board)
    end
    clear_screen

    increment_score!(game_score, board)
    show_game_situation(board, game_score, user_name, max_points)
    prompt_result_declaration(board, user_name)
    starting_player = alternate_player(starting_player)

    prompt_to_continue "Press enter to continue the game"

    break if game_score.values.include?(max_points.to_i)
  end
  display_game_score(game_score, user_name, max_points)
  prompt_final_game_winner(game_score, user_name, max_points)

  break unless play_again?
end

prompt "Thanks for playing Tic Tac Toe. Goodbye!"
