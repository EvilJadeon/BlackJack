# подключение классов
require_relative 'card'
# Класс карточной колоды
class Deck
  # объявление геттеров
  attr_reader :deck  
  # метод - конструктор
  def initialize
    @deck = []
    add_and_shuffle!
  end
  # метод для заполнения и перемешивания колоды
  def add_and_shuffle!
    # заполнение колоды
    Card::NAME.each do |name|
      Card::SUIT.each do |suit|
        @deck << Card.new(name, suit)
      end
    end
    # перемешивание колоды
    @deck.shuffle!.reverse!.shuffle!.reverse!.shuffle!
  end
  # метод выдачи карты из колоды
  def issuing_card
    @deck[-1]
    delete_card
  end
  # метод удаления карты из колоды
  def delete_card
    @deck.pop
  end
end