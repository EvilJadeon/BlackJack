# подключение дргих классов
require_relative 'interface'
# Класс для основной логики игры
class Game
  def start
    @interface = Interface.new
    # некоторые действия
    puts 'Ваши карты:'
    @interface.show_player_cards
    puts
    puts 'Ваши очки:'
    puts "#{@interface.player.hand.points}"
    puts 'Карты дилера:'
    @interface.show_dealer_cards_hide
    puts
    puts 'Выберите действие:'
    puts
    # создание списка действий
    @actions = {
      1 => 'Пропустить ход (ход переходит к дилеру)',
      2 => 'Добавить карту (если у вас не более двух карт в руках)',
      3 => 'Открыть все карты и посчитать результаты',
      4 => 'Ещё одна игра и всё', 5 => 'Выход из игры'
    }

    @actions.each {|key, value| puts "#{key} - #{value}"}
    
    loop do

      choose = gets.to_i

      case choose
      when 1
        @interface.player_skip
      when 2
        @interface.add_card_to_player
      when 3
        @interface.show_all_cards
      when 4
        @interface.one_more_game
      when 5
        exit
      end
    end
  end
end

@game = Game.new
@game.start