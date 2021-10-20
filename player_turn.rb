module PlayerTurn
  # метод выдачи карт игроку
  def issuing_card_to_player
    @player.cards << @deck.deck[-1]
    @player.cards << @deck.deck[-2]
    2.times { @deck.delete_card }
  end
  # метод, показывающий карты игрока
  def show_player_cards
    @player.cards.each {|card| print " #{card.name}#{card.suit} "}
  end
  # метод подсчета суммы очков игрока
  def add_player_points
    @player.cards.each do |card|
      if card.name == 'A'
        card.name == 'A' && @player_points + 11 < 21 ? @player_points += 11 : @player_points += 1
      else
        card.name.to_i.zero? ? @player_points += 10 : @player_points += card.name.to_i
      end
    end
  end
  # метод добавления карты игроку
  def add_card_to_player
    @player.cards << @deck.issuing_card
    @player_points = 0
    add_player_points
    puts 'Вы взяли карту'
    puts
    puts 'Ваши карты:'
    puts
    show_player_cards
    puts
    dealer_skip
  end
  # метод пропуска хода игроком
  def player_skip
    puts 'Вы пропускате ход'
    dealer_skip
  end
end