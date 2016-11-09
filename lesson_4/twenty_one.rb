# spades, hearts, diamonds, clubs
SUITS_SYMBOLS = %W(\u2660 \u2661 \u2662 \u2663).freeze

def prompt(message)
  puts "=> #{message}"
end

def clear_screen
  system('clear') || system('cls')
end

def initialize_deck
  new_deck = {}
  SUITS_SYMBOLS.each do |suit|
    new_deck[suit] = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  end
  new_deck
end

def dealing_cards!(player, deck, players_cards)
  current_suit = nil
  loop do
    current_suit = SUITS_SYMBOLS.sample
    break unless current_suit.nil?
  end
  current_value = deck[current_suit].sample
  current_card = [current_suit, current_value]
  deck[current_suit].delete(current_value)
  players_cards[player] << current_card
end

def formatting_single_card(suit, value)
  ["   --------- ", "  |         |", "  |    #{suit}    |"] +
    ["  |   #{value}   |", "  |    #{suit}    |", "  |         |"] +
    ["   --------- "]
end

def formatting_cards_player!(cards, new_card)
  cards.each_with_index do |_, index|
    cards[index] += "    " + new_card[index]
  end
end

def formatting_card_details!(card_details)
  card_details.each do |val|
    case val
    when "2".."9" then card_details[1] = " #{val} "
    when "10" then card_details[1] = "#{val} "
    when "A", "J", "K", "Q" then card_details[1] = " #{val} "
    end
  end
end

def display_cards(cards)
  cards.each { |line| puts line }
end

def initialize_two_cards(players_cards, player)
  player_cards = players_cards[player]
  card_1_details = formatting_card_details!(player_cards[0])
  card_2_details = formatting_card_details!(player_cards[1])

  cards = formatting_single_card(card_1_details[0], card_1_details[1])
  new_card = formatting_single_card(card_2_details[0], card_2_details[1])

  formatting_cards_player!(cards, new_card)
  cards
end

def initialize_one_card(players_cards, player)
  player_cards = players_cards[player]
  card_1_details = formatting_card_details!(player_cards[0])

  cards = formatting_single_card(card_1_details[0], card_1_details[1])
  hidden_card = ["   --------- ", "  |         |"] +
                ["  | HIDDEN  |", "  |         |"] +
                ["  |         |", "  |  CARD   |", "   --------- "]

  formatting_cards_player!(cards, hidden_card)
  cards
end

def add_new_card_on_screen!(player, cards_format, players_cards)
  new_card = players_cards[player].last
  new_card_details = formatting_card_details!(new_card)

  new_card = formatting_single_card(new_card_details[0], new_card_details[1])

  formatting_cards_player!(cards_format, new_card)
end

def single_card_value(card)
  case card[1].strip
  when "2".."10" then card[1].to_i
  when "J", "Q", "K" then 10
  when "A" then 11
  end
end

def total_cards_value!(player, total_cards_value, players_cards)
  total_cards_value[player] = 0
  players_cards[player].each do |card|
    total_cards_value[player] += single_card_value(card)
  end
  players_cards[player].select { |val| val[1].strip == "A" }.count.times do
    total_cards_value[player] -= 10 if total_cards_value[player] > 21
  end
end

def ask_user_move
  prompt "Would you like to (h)it or (s)tay?"
  loop do
    case gets.chomp.downcase
    when "h", "hit" then return "hit"
    when "s", "stay" then return "stay"
    else puts "Enter a valid action: (h)it or (s)tay"
    end
  end
end

def burst?(total_cards_values, player)
  total_cards_values[player] > 21
end

def stay?(move)
  move == "stay"
end

def dealer_choice(total_cards_values)
  total_cards_values[:dealer] < 17 ? "hit" : "stay"
end

def compare_players_cards(total_cards_value)
  if total_cards_value[:user] > total_cards_value[:dealer]
    "The user won!"
  elsif total_cards_value[:user] < total_cards_value[:dealer]
    "The dealer won!"
  else
    "It's a tie!"
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

def first_two_cards!(deck, players_cards)
  2.times do
    dealing_cards!(:user, deck, players_cards)
    dealing_cards!(:dealer, deck, players_cards)
  end
end

def display_players_card(user_cards, dealer_cards, total_cards_value)
  clear_screen
  puts "=" * 34
  puts "USER'S CARD".center(34)
  display_cards(user_cards)
  puts "Current points user: #{total_cards_value[:user]}"
  puts "=" * 34
  puts "DEALER'S CARD".center(34)
  display_cards(dealer_cards)
  puts "Current points dealer: #{total_cards_value[:dealer]}"
  puts "=" * 34
end

def initialize_score!(total_cards_value, players_cards)
  total_cards_value!(:user, total_cards_value, players_cards)
  total_cards_value[:dealer] = single_card_value(players_cards[:dealer][0])
end

def hit_move!(deck, players_cards, cards, player)
  dealing_cards!(player, deck, players_cards)
  add_new_card_on_screen!(player, cards, players_cards)
end

def prompt_to_continue(request)
  prompt request
  gets.chomp
end

def initialize_game(deck, players_cards, total_cards_value)
  first_two_cards!(deck, players_cards)
  user_cards = initialize_two_cards(players_cards, :user)
  dealer_cards = initialize_one_card(players_cards, :dealer)
  initialize_score!(total_cards_value, players_cards)
  return user_cards, dealer_cards
end

def prompt_burst(winner, user_cards, dealer_cards, total_cards_value)
  display_players_card(user_cards, dealer_cards, total_cards_value)
  if winner == "user"
    prompt "Wow, the dealer burst! You won!"
  elsif winner == "dealer"
    prompt "Oh no, you burst! The dealer won!"
  end  
end

loop do
  deck = initialize_deck
  players_cards = { user: [], dealer: [] }
  total_cards_value = { user: 0, dealer: 0 }
  user_move = ''
  dealer_move = ''
  user_cards, dealer_cards = initialize_game(deck, players_cards,
                                              total_cards_value)
  loop do
    display_players_card(user_cards, dealer_cards, total_cards_value)
    prompt "Your current point is #{total_cards_value[:user]}."
    user_move = ask_user_move
    prompt "You choose to #{user_move}!"

    if user_move == "hit"
      hit_move!(deck, players_cards, user_cards, :user)
      total_cards_value!(:user, total_cards_value, players_cards)
    end

    prompt_to_continue("Press enter to continue the game")
    break if stay?(user_move) || burst?(total_cards_value, :user)
  end

  if user_move == "stay"
    dealer_cards = initialize_two_cards(players_cards, :dealer)
    total_cards_value[:dealer] += single_card_value(players_cards[:dealer][1])
    loop do
      display_players_card(user_cards, dealer_cards, total_cards_value)
      prompt "Dealer current point is #{total_cards_value[:dealer]}."
      dealer_move = dealer_choice(total_cards_value)
      prompt "Dealer choose to #{dealer_move}!"

      if dealer_move == "hit"
        hit_move!(deck, players_cards, dealer_cards, :dealer)
        total_cards_value!(:dealer, total_cards_value, players_cards)
      end

      prompt_to_continue("Press enter to continue the game")
      break if stay?(dealer_move) || burst?(total_cards_value, :dealer)
    end

    if dealer_move == "stay"
      puts compare_players_cards(total_cards_value)
    else
      prompt_burst("user", user_cards, dealer_cards, total_cards_value)
    end
  else
    prompt_burst("dealer", user_cards, dealer_cards, total_cards_value)
  end
  break unless play_again?
end
