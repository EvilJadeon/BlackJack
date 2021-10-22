# frozen_string_literal: true

# класс для ввода-вывода всей информации
class Interface
  attr_reader :choose

  @choose = 0
  # метод для добавления карты игроку
  def add_card_player(hand, deck)
    hand.add_card(deck.delete_card)
    sleep 1.5
  end

  # метод для добавления карты дилеру
  def add_card_dealer(hand, deck)
    hand.add_card(deck.delete_card)
    sleep 1.5
  end

  # метод пропуска хода игроком
  def player_skip
    puts 'Вы пропускате ход'
    sleep 1.5
  end

  # метод пропуска хода дилером
  def dealer_skip(points, hand, deck)
    points >= 17 ? puts('Дилер пропускает ход') : add_card_dealer(hand, deck) && puts('Дилер взял карту')
    sleep 1.5
  end

  # метод, показывающий карты игрока
  def show_player_cards(cards, points, bank)
    puts 'Ваши карты:'
    cards.each { |card| puts "  #{card.name}#{card.suit}" }
    puts 'Ваши очки:'
    puts "  #{points}"
    puts 'Ваш банк:'
    puts "  #{bank}"
    puts
    sleep 1.5
  end

  # метод, показывающий карты дилера со *
  def show_dealer_cards_hide(cards)
    puts 'Карты дилера:'
    cards.each do |card|
      puts "  #{card.name.gsub(/\w/, '*')}#{card.suit.gsub(/./, '*')}"
    end
    puts
    sleep 1.5
  end

  # метод, показывающий карты дилера
  def show_dealer_cards(cards, points, bank)
    puts 'Карты дилера:'
    cards.each { |card| puts "  #{card.name}#{card.suit}" }
    puts 'Очки дилера:'
    puts "  #{points}"
    puts
    puts 'Банк дилера:'
    puts "  #{bank}"
    puts
    sleep 1.5
  end

  # метод отрисовки меню
  def draw
    puts
    puts
    @actions = {
      1 => 'Пропустить ход (ход переходит к дилеру)',
      2 => 'Добавить карту (если у вас не более двух карт в руках)',
      3 => 'Открыть все карты и посчитать результаты',
      4 => 'Ещё одна игра и всё', 5 => 'Выход из игры'
    }

    @actions.each { |key, value| puts "#{key} - #{value}" }

    @choose = gets.to_i
  end

  # метод победы игрока
  def player_won(player_bank, dealer_bank)
    player_bank += 20
    puts 'Вы победили'
    puts
    puts "Ваш банк: #{player_bank}$"
    puts
    puts "Банк дилера: #{dealer_bank}$"
  end

  # метод проигрыша игрока
  def player_loss(player_bank, dealer_bank)
    dealer_bank += 20
    puts 'Вы проиграли'
    puts "Ваш банк: #{player_bank}$"
    puts
    puts "Банк дилера: #{dealer_bank}$"
  end

  # метод ничьей
  def tie(player_bank, dealer_bank)
    player_bank += 10
    dealer_bank += 10
    puts 'Ничья'
    puts "Ваш банк: #{player_bank}$"
    puts
    puts "Банк дилера: #{dealer_bank}$"
  end
end
