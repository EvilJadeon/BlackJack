module DealerTurn
  # метод выдачи карт дилеру
  def issuing_card_to_dealer
    @dealer.cards << @deck.deck[-1]
    @dealer.cards << @deck.deck[-2]
    2.times { @deck.delete_card }
  end
  # метод, показывающий карты дилера со *
  def show_dealer_cards_hide
    @dealer.cards.each do |card|
      print " #{card.name.gsub(/\w/, '*')}#{card.suit.gsub(/./, '*')} "
    end
  end
  # метод, показывающий карты дилера
  def show_dealer_cards
    @dealer.cards.each do |card|
      print " #{card.name}#{card.suit} "
    end
  end
  # метод подсчета суммы очков дилера
  def add_dealer_points
    @dealer.cards.each do |card|
      if card.name == 'A'
        card.name == 'A' && @dealer_points + 11 < 21 ? @dealer_points += 11 : @dealer_points += 1
      else
        card.name.to_i.zero? ? @dealer_points += 10 : @dealer_points += card.name.to_i
      end
    end
  end
  # метод добавления карты дилеру
  def add_card_to_dealer
    @dealer.cards << @deck.issuing_card
    @dealer_points = 0
    add_dealer_points
    puts 'Карты дилера:'
    puts
    show_dealer_cards_hide
    puts
  end
  # метод пропуска хода дилером
  def dealer_skip
    @dealer_points >= 17 ? puts('Дилер пропускает ход') : add_card_to_dealer && puts('Дилер взял карту')
  end
end