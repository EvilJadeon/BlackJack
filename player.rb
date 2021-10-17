# Класс игрока
class Player
  # создание геттеров и сеттеров
  attr_accessor :bank
  # создание геттеров
  attr_reader :name
  # метод-конструктор
  def initialize(name)
    @bank = 100
    @name = name
    @cards = []
    @cards << choose_card(2)
  end
  # метод пропуска хода
  def skip

  end
  # метод добавления карты
  def add_card
    # если на руках 2 карты - добавляется одна
    @cards << choose_card(1) if @cards.size == 2
  end
  # метод, открывающий карты
  def show_cards
    print "Карты #{name}:\n"
    print @cards
    puts "Сумма очков: #{sum_of_points}"
  end
  # сумма очков игрока
  def sum_of_points

  end
  # ход игрока
  def player_turn
    
  end
end