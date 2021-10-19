# Класс дилера (за него играет компьютер)
class Dealer
  # создание геттеров и сеттеров
  attr_accessor :bank, :cards
  # метод - конструктор
  def initialize
    @bank = 100
    @cards = []
  end
end