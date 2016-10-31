EMPTY_SQUARE = ' '
USER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_ROWS = ['123', '456', '789', '147', '258', '369', '159', '357']

def clear_screen
  system('clear') || system('cls')
end

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
  puts "user -> X   computer -> O"
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = EMPTY_SQUARE }
  new_board
end

def update_board!(brd, square, player)
  if player == "user"
    brd[square.to_i] = USER_MARKER
  elsif player == "computer"
    brd[square.to_i] = COMPUTER_MARKER
  end
end

def available_squares(brd)
  brd.keys.select { |square| brd[square] == EMPTY_SQUARE }
end

def board_full?(brd)
  available_squares(brd).empty?
end

def valid_choice?(choice, brd)
  squares_available = available_squares(brd)
  ('1'..'9').cover?(choice) && squares_available.include?(choice.to_i)
end

def ask_choice(brd)
  user_choice = ''
  loop do
    puts "Please mark a free square (#{available_squares(brd).join(', ')})"
    user_choice = gets.chomp
    break if valid_choice?(user_choice, brd)
  end
  user_choice
end

def players_choices(brd)
  choices_collection = { user: [], computer: [] }
  brd.each do |square, value|
    choices_collection[:user] << square if value == "X"
    choices_collection[:computer] << square if value == "O"
  end
  choices_collection
end

def the_winner?(player, brd)
  WINNING_ROWS.each do |value|
    return true if value.chars.all? do |word|
      players_choices(brd)[player].join.include?(word)
    end
  end
  false
end

def someone_won?(brd)
  the_winner?(:user, brd) || the_winner?(:computer, brd)
end

def result_declaration(brd)
  if the_winner?(:user, brd)
    puts "User won!"
  elsif the_winner?(:computer, brd)
    puts "Computer won!"
  else
    puts "It's a tie!"
  end
end

def play_again?
  puts "Do you want to play again? (yes/no)"
  loop do
    case gets.chomp.downcase
    when "yes", "y" then return true
    when "no", "n" then return false
    else puts "Please enter yes or no"
    end
  end
end

loop do
  board = initialize_board
  loop do
    clear_screen
    display_board(board)
    user_choice = ask_choice(board)
    update_board!(board, user_choice, "user")
    break if someone_won?(board) || board_full?(board)
    computer_choice = available_squares(board).sample
    update_board!(board, computer_choice, "computer")
    break if someone_won?(board)
  end
  clear_screen
  display_board(board)
  result_declaration(board)
  break unless play_again?
end
puts "Thanks for playing Tic Tac Toe. Goodbye!"
