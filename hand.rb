# frozen_string_literal: true

# класс "руки"
class Hand
  # создание геттеров и сеттеров
  attr_accessor :cards

  # метод конструктор
  def initialize
    @cards = []
  end

  # метод подсчета суммы очков
  def counting_points
    points = 0
    cards.each do |card|
      points += if card.name == 'A'
                  card.name == 'A' && points + 11 <= 21 ? 11 : 1
                else
                  card.name.to_i.zero? ? 10 : card.name.to_i
                end
    end
    points
  end

  # метод добавления карты
  def add_card(card)
    @cards << card
    counting_points
  end
end
