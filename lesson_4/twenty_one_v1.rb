# spades, hearts, diamonds, clubs
SUITS_SYMBOLS = %W(\u2660 \u2661 \u2662 \u2663).freeze
TARGET_SCORE = 21
DEALER_STAY_SCORE = 17

def prompt(message)
  puts "=> #{message}"
end

def prompt_to_continue(request)
  prompt request
  gets.chomp
end

def clear_screen
  system('clear') || system('cls')
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

def burst?(sum_cards, player)
  sum_cards[player] > TARGET_SCORE
end

def stay?(move)
  move == "stay"
end

# update and display score

def update_score!(sum_cards, score)
  if sum_cards[:user] > sum_cards[:dealer]
    score[:user] += 1
  elsif sum_cards[:user] < sum_cards[:dealer]
    score[:dealer] += 1
  end
end

def display_score(score)
  puts "SCORE:  user => #{score[:user]}   dealer => #{score[:dealer]}."
  puts "=" * 34
end

# total value of player's card

def single_card_value(card)
  case card[1].strip
  when "2".."10" then card[1].to_i
  when "J", "Q", "K" then 10
  when "A" then 11
  end
end

def total_cards_value!(player, sum_cards, players_cards)
  sum_cards[player] = 0
  players_cards[player].each do |card|
    sum_cards[player] += single_card_value(card)
  end
  players_cards[player].select { |val| val[1].strip == "A" }.count.times do
    sum_cards[player] -= 10 if sum_cards[player] > TARGET_SCORE
  end
end

# formatting and displaying cards on screen

def formatting_card_details!(card_details)
  card_details.each do |val|
    case val
    when "2".."9" then card_details[1] = " #{val} "
    when "10" then card_details[1] = "#{val} "
    when "A", "J", "K", "Q" then card_details[1] = " #{val} "
    end
  end
end

def formatting_single_card(suit, value)
  ["   --------- ", "  |         |", "  |    #{suit}    |"] +
    ["  |   #{value}   |", "  |    #{suit}    |", "  |         |"] +
    ["   --------- "]
end

def add_formatted_card!(format_cards, new_card)
  format_cards.each_with_index do |_, index|
    format_cards[index] += "    " + new_card[index]
  end
end

def formatting_two_cards(players_cards, player)
  player_cards = players_cards[player]

  card_1_details = formatting_card_details!(player_cards[0])
  card_2_details = formatting_card_details!(player_cards[1])

  cards = formatting_single_card(card_1_details[0], card_1_details[1])
  new_card = formatting_single_card(card_2_details[0], card_2_details[1])

  add_formatted_card!(cards, new_card)
  cards
end

def formatting_one_card(players_cards, player)
  player_cards = players_cards[player]

  card_1_details = formatting_card_details!(player_cards[0])

  cards = formatting_single_card(card_1_details[0], card_1_details[1])
  hidden_card = ["   --------- ", "  |         |"] +
                ["  | HIDDEN  |", "  |         |"] +
                ["  |  CARD   |", "  |         |", "   --------- "]

  add_formatted_card!(cards, hidden_card)
  cards
end

def new_formatted_card!(player, cards_format, players_cards)
  new_card = players_cards[player].last
  new_card_details = formatting_card_details!(new_card)

  last_card = formatting_single_card(new_card_details[0], new_card_details[1])
  add_formatted_card!(cards_format, last_card)
end

def display_cards(cards)
  cards.each { |line| puts line }
end

def display_players_card(players_cards, sum_cards)
  clear_screen
  puts "USER'S CARD".center(34)
  display_cards(players_cards[:user])
  puts "Current points user: #{sum_cards[:user]}"
  puts "=" * 34
  puts "DEALER'S CARD".center(34)
  display_cards(players_cards[:dealer])
  puts "Current points dealer: #{sum_cards[:dealer]}"
  puts "=" * 34
end

# Initialize game and manage game's steps

def initialize_deck
  new_deck = {}
  SUITS_SYMBOLS.each do |suit|
    new_deck[suit] = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  end
  new_deck
end

def initialize_game!(deck, game_vars)
  format_cards = game_vars[:format_cards]
  players_cards = game_vars[:players_cards]
  sum_cards = game_vars[:sum_cards]

  2.times do
    dealing_card!(:user, deck, players_cards)
    dealing_card!(:dealer, deck, players_cards)
  end

  total_cards_value!(:user, sum_cards, players_cards)
  sum_cards[:dealer] = single_card_value(players_cards[:dealer][0])

  format_cards[:user] = formatting_two_cards(players_cards, :user)
  format_cards[:dealer] = formatting_one_card(players_cards, :dealer)
end

def initialize_dealer_turn!(game_vars)
  format_cards = game_vars[:format_cards]
  sum_cards = game_vars[:sum_cards]
  players_cards = game_vars[:players_cards]

  format_cards[:dealer] = formatting_two_cards(players_cards, :dealer)
  sum_cards[:dealer] += single_card_value(players_cards[:dealer][1])
end

def select_player_move(player, sum_cards)
  if player == :user
    prompt "Would you like to (h)it or (s)tay?"
    loop do
      case gets.chomp.downcase
      when "h", "hit" then return "hit"
      when "s", "stay" then return "stay"
      else puts "Enter a valid action: (h)it or (s)tay"
      end
    end
  elsif player == :dealer
    sum_cards[:dealer] < DEALER_STAY_SCORE ? "hit" : "stay"
  end
end

def dealing_card!(player, deck, players_cards)
  current_suit = SUITS_SYMBOLS.sample
  current_value = deck[current_suit].sample
  players_cards[player] << [current_suit, current_value]
  deck[current_suit].delete(current_value)
end

def managing_player_hit(game_vars, player, deck)
  format_cards = game_vars[:format_cards]
  sum_cards = game_vars[:sum_cards]
  players_cards = game_vars[:players_cards]

  dealing_card!(player, deck, players_cards)
  new_formatted_card!(player, format_cards[player], players_cards)
  total_cards_value!(player, sum_cards, players_cards)
end

def managing_player_moves(game_vars, player, deck, score)
  loop do
    format_cards = game_vars[:format_cards]
    sum_cards = game_vars[:sum_cards]

    display_players_card(format_cards, sum_cards)
    display_score(score)
    player_move = select_player_move(player, sum_cards)
    prompt "#{player.capitalize} will #{player_move}!"

    managing_player_hit(game_vars, player, deck) if player_move == "hit"

    prompt_to_continue("Press enter to continue the game")
    return player_move if stay?(player_move) || burst?(sum_cards, player)
  end
end

# manage result

def compare_players_cards(sum_cards)
  if sum_cards[:user] > sum_cards[:dealer]
    "THE USER WON!".center(34)
  elsif sum_cards[:user] < sum_cards[:dealer]
    "THE DEALER WON!".center(34)
  else
    "IT'S A TIE!".center(34)
  end
end

def declare_winner(score)
  clear_screen
  puts "=" * 34
  display_score(score)
  puts ""
  if score[:user] == 5
    puts "USER WON!".center(34)
  else
    puts "DEALER WON!".center(34)
  end
end

def prompt_burst(winner, game_vars, score)
  format_cards = game_vars[:format_cards]
  sum_cards = game_vars[:sum_cards]

  display_players_card(format_cards, sum_cards)
  display_score(score)
  score[winner] += 1
  if winner == :user
    puts "DEALER BURST! YOU WON!".center(34)
  elsif winner == :dealer
    puts "USER BURST! THE DEALER WON!".center(34)
  end
end

clear_screen
prompt <<-WELCOME
  Welcome to #{TARGET_SCORE}!
  Here the rules of the game:
  - both the player will receive two cards
  - you can see both of your cards, but only one of the other player's
    (called the dealer)
  - depending on cards, both players may choose to hit (receive another card)
    or stay
  - The player who goes over #{TARGET_SCORE} bursts and lose the game
  - When both players stay, the player whose hand is closest to #{TARGET_SCORE} wins
  - The first to win 5 hands wins the game.
WELCOME

prompt_to_continue("Press enter to start the game")
loop do
  game_score = { user: 0, dealer: 0 }
  loop do
    deck = initialize_deck
    game_vars = { players_cards: { user: [], dealer: [] },
                  sum_cards: { user: 0, dealer: 0 },
                  format_cards: { user: [], dealer: [] } }
    initialize_game!(deck, game_vars)
    user_move = managing_player_moves(game_vars, :user, deck, game_score)
    if user_move == "stay"
      initialize_dealer_turn!(game_vars)
      dealer_move = managing_player_moves(game_vars, :dealer, deck, game_score)
      if dealer_move == "stay"
        update_score!(game_vars[:sum_cards], game_score)
        puts compare_players_cards(game_vars[:sum_cards])
      else
        prompt_burst(:user, game_vars, game_score)
      end
    else
      prompt_burst(:dealer, game_vars, game_score)
    end
    prompt_to_continue("Press enter to continue the game")
    break if game_score.values.include?(5)
  end
  declare_winner(game_score)
  break unless play_again?
end
prompt "Thanks for playing #{TARGET_SCORE}. Goodbye!"
