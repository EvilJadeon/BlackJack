# frozen_string_literal: true

# объявление класса Card
class Card
  # создание геттеров
  attr_reader :name, :suit

  # создание констант
  NAME = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUIT = %w[♣ ♥ ♠ ♦].freeze

  # метод - конструктор
  def initialize(name, suit)
    @name = name
    @suit = suit
  end
end
