# Класс карточной колоды
class Deck
  # объявление геттеров и сеттеров
  attr_accessor :deck_of_cards
  # создание изначальной карточной колоды
  @deck_of_cards = [
    '2♣', '3♣', '4♣', '5♣', '6♣', '7♣', '8♣', '9♣', '10♣', 'J♣', 'Q♣', 'K♣', 'A♣',
    '2♥', '3♥', '4♥', '5♥', '6♥', '7♥', '8♥', '9♥', '10♥', 'J♥', 'Q♥', 'K♥', 'A♥',
    '2♠', '3♠', '4♠', '5♠', '6♠', '7♠', '8♠', '9♠', '10♠', 'J♠', 'Q♠', 'K♠', 'A♠',
    '2♦', '3♦', '4♦', '5♦', '6♦', '7♦', '8♦', '9♦', '10♦', 'J♦', 'Q♦', 'K♦', 'A♦'
  ]
  # метод - конструктор
  def initialize
    shuffle_deck
  end
  # метод для перемешивания колоды
  def shuffle_deck
    @deck_of_cards.shuffle.reverse.shuffle.reverse.shuffle
  end
  # метод выбора карты (в скобках - количество)
  def choose_card(qty)
    qty.times do
       puts @deck_of_cards[rand(0..51)]
    end
    # после выбора карт - обязательно удалить их из колоды
    @deck_of_cards.delete()
  end
end