# Класс дилера (за него играет компьютер)
class Dealer
  # создание геттеров и сеттеров
  attr_accessor :bank
  # создание геттеров
  attr_reader :name
  # метод - конструктор
  def initialize(name)
    @name = name
    @bank = 100
    @cards = []
    @cards << choose_card(2)
  end
  # метод пропуска хода
  def skip
    # если очков у дилера 17 и более
  end
  # метод добавления карты
  def add_card
    # может быть добавлена только одна карта
    # и если очков меньше 17
    @cards << choose_card(1) if @cards.size == 2 && sum_of_points < 17
  end
  # сумма очков дилера
  def sum_of_points

  end
  # ход дилера
  def dealer_turn
    
  end
end