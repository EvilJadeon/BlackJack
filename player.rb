# Класс игрока
class Player
  # создание геттеров
  attr_reader :name
  # создание геттеров и сеттеров
  attr_accessor :bank, :cards
  # метод-конструктор
  def initialize(name)
    @bank = 100
    @name = name
    @cards = []
  end
end