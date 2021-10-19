# подключение дргих классов
require_relative 'card'
require_relative 'dealer'
require_relative 'deck'
require_relative 'player'
require_relative 'validation'
# Класс для основной логики игры
class Game
  # создание геттеров и сеттеров
  attr_accessor :player_points, :dealer_points
  # объявление необходимых переменных класса
  @@bank = 0
  # создание константы для действий
  ACTIONS = {
    1 => :player_skip, 2 => :add_card_to_player, 3 => :show_all_cards,
    4 => :one_more_game, 5 => :exit
  }
  # метод начала игры
  def initialize
    # запрос имени игрока и его создание
    print 'Введите ваше имя: '
    player_name = gets
    @player = Player.new(player_name)
    sleep 1
    puts 'Игра начинается!'
    @dealer = Dealer.new
    @deck = Deck.new
    @player_points = 0
    @dealer_points = 0
    @@bank += 20
    @player.bank -= 10
    @dealer.bank -= 10
    sleep 1
    start_game
  end 
  # главный метод игры, где все взаимодействует
  def start_game
    puts 'Сделаны ставки по 10$ от игрока и дилера'
    sleep 1
    puts
    puts "Банк игры: #{@@bank}"
    sleep 1
    puts
    puts 'Раздача карт'
    issuing_card_to_player
    issuing_card_to_dealer
    add_player_points
    add_dealer_points
    sleep 1
    puts
    puts 'Ваши карты:'
    show_player_cards
    sleep 1
    puts
    puts 'Карты дилера:'
    show_dealer_cards_hide
    sleep 1
    puts
    puts 'Выберите действие:'

    actions = {
      1 => 'Пропустить ход (ход переходит к дилеру)',
      2 => 'Добавить карту (если у вас не более двух карт в руках)',
      3 => 'Открыть все карты и посчитать результаты',
      4 => 'Ещё одну партию и всё!', 5 => 'Выход из игры'
    }

    actions.each {|key, value| puts "#{key} - #{value}"}

    loop do
      menu = gets.to_i
      send(ACTIONS[menu])
    end
  end
  # метод выдачи карт игроку
  def issuing_card_to_player
    @player.cards << @deck.deck[-1]
    @player.cards << @deck.deck[-2]
    2.times { @deck.delete_card }
  end
  # метод выдачи карт дилеру
  def issuing_card_to_dealer
    @dealer.cards << @deck.deck[-1]
    @dealer.cards << @deck.deck[-2]
    2.times { @deck.delete_card }
  end
  # метод, показывающий карты игрока
  def show_player_cards
    @player.cards.each {|card| print "#{card.name}#{card.suit} "}
    puts
  end
  # метод, показывающий карты дилера со *
  def show_dealer_cards_hide
    @dealer.cards.each do |card|
      print "#{card.name.gsub(/\w/, '*')}#{card.suit.gsub(/./, '*')} "
      puts
    end
  end
  # метод, показывающий карты дилера
  def show_dealer_cards
    @dealer.cards.each do |card|
      print "#{card.name}#{card.suit} "
    end
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
  # метод подсчета результатов
  def calculation_of_results
    # Выигрывает игрок, у которого сумма очков ближе к 21
    # Если у игрока сумма очков больше 21, то он проиграл
    # Если сумма очков у игрока и дилера одинаковая, то объявляется ничья и деньги из банка возвращаются игрокам
    # Сумма из банка игры переходит к выигравшему
    if @player_points == @dealer_points
      @@bank = 0
      @player.bank += 10
      @dealer.bank += 10
      puts
      puts 'Ничья'
    elsif @player_points > @dealer_points && @player_points <= 21
      @player.bank += @@bank
      @@bank = 0
      puts
      puts "Победил #{@player.name}!"
    elsif @player_points < @dealer_points && @dealer_points <= 21
      @dealer.bank += @@bank
      @@bank = 0
      puts
      puts 'Победил дилер!'
    elsif @player_points > @dealer_points && @player_points > 21
      @dealer.bank += @@bank
      @@bank = 0
      puts
      puts 'Победил дилер!'
    elsif @player_points < @dealer_points && @dealer_points > 21
      @player.bank += @@bank
      @@bank = 0
      puts
      puts "Победил #{@player.name}!"
    end
  end
  # метод добавления карты игроку
  def add_card_to_player
    @player.cards << @deck.issuing_card
    @player_points = 0
    puts 'Ваши карты:'
    puts
    show_player_cards
    add_player_points
    puts
    dealer_skip
    puts
  end
  # метод добавления карты дилеру
  def add_card_to_dealer
    @dealer.cards << @deck.issuing_card
    @dealer_points = 0
    puts 'Карты дилера:'
    puts
    show_dealer_cards_hide
    add_dealer_points
    puts
  end
  # метод пропуска хода игроком
  def player_skip
    puts
    print "#{@player.name} пропускает ход"
    dealer_skip
  end
  # метод пропуска хода дилером
  def dealer_skip
    @dealer_points >= 17 ? puts('Дилер пропускает ход') : add_card_to_dealer && puts('Дилер взял карту')
    puts
    sleep 1
  end
  # метод открытия всех карт и подсчета очков
  def show_all_cards
    puts 'Ваши карты:'
    show_player_cards
    sleep 1
    puts
    puts "Ваши очки: #{@player_points}"
    sleep 1
    puts
    puts 'Карты дилера:'
    show_dealer_cards
    sleep 1
    puts
    puts "Очки дилера: #{@dealer_points}"
    calculation_of_results
    puts
    puts "Ваш банк: #{@player.bank}"
    puts
    puts "Банк дилера: #{@dealer.bank}"
    puts
  end
  # метод для "ещё одной игры"
  def one_more_game
    @@bank = 20
    @dealer.bank -= 10
    @player.bank -= 10
    @player.cards = []
    @dealer.cards = []
    @player_points = 0
    @dealer_points = 0
    puts "Ваш банк: #{@player.bank}"
    puts
    puts "Банк дилера: #{@dealer.bank}"
    puts
    sleep 2
    start_game
  end
end