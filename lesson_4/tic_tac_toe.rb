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

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  puts ""
  puts " 1   |2    |3    "
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts " 4   |5    |6    "
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts " 7   |8    |9    "
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
  puts "     |     |     "
  puts ""
end
# rubocop:enable Metrics/AbcSize

def joinor(array, sep = ", ", last_sep = " or ")
  last_item = array.pop.to_s
  final_str = array.join(sep)
  array.length == 0 ? final_str << last_item : final_str << last_sep + last_item
  final_str
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

def ask_max_points(max_points = 5)
  prompt "Please enter how many points players have to reach to win the game:"
  loop do
    max_points = gets.chomp
    break if integer?(max_points) && max_points.to_i > 0
    prompt "Please enter a valid number of points:"
  end
  max_points
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = EMPTY_SQUARE }
  new_board
end

def update_board!(brd, square, player)
  if player == "user"
    brd[square] = USER_MARKER
  elsif player == "computer"
    brd[square] = COMPUTER_MARKER
  end
end

def available_squares(brd)
  brd.keys.select { |square| brd[square] == EMPTY_SQUARE }
end

def board_full?(brd)
  available_squares(brd).empty?
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

def the_winner_is(brd)
  WINNING_ROWS.each do |value|
    return 'user' if value.all? { |square| brd[square] == USER_MARKER }
    return 'computer' if value.all? { |square| brd[square] == COMPUTER_MARKER }
  end
  nil
end

def someone_won?(brd)
  !!the_winner_is(brd)
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

def display_game_score(game_score, user_name, max_points)
  puts "Game score (max points = #{max_points})"
  puts "#{user_name} (X):     #{game_score[:user]}"
  puts "Computer (O):     #{game_score[:computer]}"
  puts ""
end

def show_game_situation(brd, game_score, username, max_points)
  display_board(brd)
  display_game_score(game_score, username, max_points)
end

def final_game_winner(game_score, user_name, max_points)
  winner = game_score.key(max_points.to_i)
  if winner == :user
    ("#{user_name.upcase} WON!").center(15)
  else
    ("COMPUTER WON!").center(15)
  end
end

def increment_score(game_score, brd)
  game_score[:user] += 1 if the_winner_is(brd) == "user"
  game_score[:computer] += 1 if the_winner_is(brd) == "computer"
end

def prompt_to_continue(request)
  prompt request
  gets.chomp
  clear_screen
end

def play_again?
  prompt "Do you want to play again? (yes/no)"
  loop do
    case gets.chomp.downcase
    when "yes", "y" then return true
    when "no", "n" then return false
    else prompt "Please enter yes or no"
    end
  end
end

user_name = ask_user_name
loop do
  max_points = ask_max_points
  game_score = { user: 0, computer: 0 }
  loop do
    board = initialize_board
    loop do
      clear_screen
      show_game_situation(board, game_score, user_name, max_points)

      user_choice = ask_choice(board)
      update_board!(board, user_choice, "user")
      break if someone_won?(board) || board_full?(board)

      computer_choice = available_squares(board).sample
      update_board!(board, computer_choice, "computer")
      break if someone_won?(board)
    end
    clear_screen
    increment_score(game_score, board)
    show_game_situation(board, game_score, user_name, max_points)
    prompt_result_declaration(board, user_name)
    prompt_to_continue "Press enter to continue the game"
    break if game_score.values.include?(max_points.to_i)
  end
  display_game_score(game_score, user_name, max_points)
  puts final_game_winner(game_score, user_name, max_points)
  break unless play_again?
end
prompt "Thanks for playing Tic Tac Toe. Goodbye!"
