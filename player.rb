# frozen_string_literal: true

# Класс игрока
class Player
  # создание геттеров
  attr_reader :name, :hand
  # создание геттеров и сеттеров
  attr_accessor :bank

  # метод-конструктор
  def initialize(name)
    @bank = 100
    @name = name
    @hand = Hand.new
  end
end
