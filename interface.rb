# подключение дргих классов
require_relative 'card'
require_relative 'dealer'
require_relative 'deck'
require_relative 'player'
require_relative 'hand'

class Interface
  attr_reader :player, :dealer
  
  # объявление переменной для игрового банка
  $bank = 0
  
  def initialize
    # запрос имени игрока и его создание
    print 'Введите ваше имя: '
    name = gets
    @player = Player.new(name)
    # создание дилера и колоды
    @dealer = Dealer.new
    @deck = Deck.new
    # установка очков игрока и дилера в 0
    @player.hand.points = 0
    @dealer.hand.points = 0
    # увеличение банка игры за счет депозитов игрока и дилера
    $bank += 20
    @player.bank -= 10
    @dealer.bank -= 10
    # добавление по 2 карты игроку и дилеру и пересчет их очков
    2.times {@player.hand.add_card(@deck.issuing_card)}
    @player.hand.counting_points(@player)
    2.times {@dealer.hand.add_card(@deck.issuing_card)}
    @dealer.hand.counting_points(@dealer)
  end
  # метод добавления карты игроку
  def add_card_to_player
    @player.hand.add_card(@deck.issuing_card)
    @player.hand.counting_points(@player)
    puts
    show_player_cards
    puts "Ваши очки: #{@player.hand.points}"
    puts
    dealer_skip
  end
  # метод добавления карты дилеру
  def add_card_to_dealer
    @dealer.hand.add_card(@deck.issuing_card)
    @dealer.hand.counting_points(@dealer)
  end
  # метод, показывающий карты игрока
  def show_player_cards
    @player.hand.cards.each {|card| print " #{card.name}#{card.suit} "}
  end
  # метод пропуска хода игроком
  def player_skip
    puts 'Вы пропускате ход'
    dealer_skip
  end
  # метод, показывающий карты дилера со *
  def show_dealer_cards_hide
    @dealer.hand.cards.each do |card|
      print " #{card.name.gsub(/\w/, '*')}#{card.suit.gsub(/./, '*')} "
    end
  end
  # метод, показывающий карты дилера
  def show_dealer_cards
    @dealer.hand.cards.each do |card|
      print " #{card.name}#{card.suit} "
    end
  end
  # метод пропуска хода дилером
  def dealer_skip
    @dealer.hand.points >= 17 ? puts('Дилер пропускает ход') : @dealer.hand.add_card(@deck.issuing_card) && puts('Дилер взял карту')
    @dealer.hand.points = 0
    @dealer.hand.counting_points(@dealer)
    puts
    puts "Карты дилера: "
    show_dealer_cards_hide
    puts
  end
  # метод подсчета результатов
  def calculation_of_results
    # Выигрывает игрок, у которого сумма очков ближе к 21
    # Если у игрока сумма очков больше 21, то он проиграл
    # Если сумма очков у игрока и дилера одинаковая, то объявляется ничья и деньги из банка возвращаются игрокам
    # Сумма из банка игры переходит к выигравшему
    if @player.hand.points == @dealer.hand.points
      $bank = 0
      @player.bank += 10
      @dealer.bank += 10
      puts
      puts 'Ничья'
    elsif @player.hand.points > @dealer.hand.points && @player.hand.points <= 21
      @player.bank += $bank
      $bank = 0
      puts
      puts "Победил #{@player.name}"
    elsif @player.hand.points < @dealer.hand.points && @dealer.hand.points <= 21
      @dealer.bank += $bank
      $bank = 0
      puts
      puts 'Победил дилер'
    elsif @player.hand.points > @dealer.hand.points && @player.hand.points > 21
      @dealer.bank += $bank
      $bank = 0
      puts
      puts 'Победил дилер'
    elsif @player.hand.points < @dealer.hand.points && @dealer.hand.points > 21
      @player.bank += $bank
      $bank = 0
      puts
      puts "Победил #{@player.name}"
    end
  end
  # метод открытия всех карт и подсчета очков
  def show_all_cards
    puts 'Ваши карты:'
    show_player_cards
    puts ", очки: #{@player.hand.points}, банк: #{@player.bank}$"
    sleep 2
    puts 'Карты дилера:'
    show_dealer_cards
    puts ", очки: #{@dealer.hand.points}, банк: #{@dealer.bank}$"
    sleep 2
    calculation_of_results
    puts
    sleep 2
    puts "Ваш банк: #{@player.bank}$, банк дилера: #{@dealer.bank}$"
  end
  # метод для "ещё одной игры"
  def one_more_game
    $bank = 20
    @dealer.bank -= 10
    @player.bank -= 10
    @player.hand.cards = []
    @dealer.hand.cards = []
    @player.hand.points = 0
    @dealer.hand.points = 0
    @deck = Deck.new
    2.times {@player.hand.add_card(@deck.issuing_card)}
    @player.hand.counting_points(@player)
    2.times {@dealer.hand.add_card(@deck.issuing_card)}
    @dealer.hand.counting_points(@dealer)
    
  end
end
