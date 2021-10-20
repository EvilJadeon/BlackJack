class Hand
  # создание геттеров и сеттеров
  attr_accessor :cards, :points
  # метод конструктор
  def initialize
    @cards = []
  end
  # метод подсчета суммы очков
  def counting_points(everyone)
    everyone.hand.cards.each do |card|
      if card.name == 'A'
        card.name == 'A' && everyone.hand.points + 11 < 21 ? everyone.hand.points += 11 : everyone.hand.points += 1
      else
        card.name.to_i.zero? ? everyone.hand.points += 10 : everyone.hand.points += card.name.to_i
      end
    end
  end
  # метод добавления карты
  def add_card(card)
    @cards << card
    @points = 0
  end
end