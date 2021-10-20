# подключение дргих классов
require_relative 'card'
require_relative 'dealer'
require_relative 'deck'
require_relative 'player'
require_relative 'validation'
require_relative 'player_turn'
require_relative 'dealer_turn'
require_relative 'results'
# Класс для основной логики игры
class Game
  # подключение необходимых модулей
  include PlayerTurn
  include DealerTurn
  include Results
  # создание геттеров и сеттеров
  attr_accessor :player_points, :dealer_points
  # объявление необходимых переменных
  $bank = 0
  # создание константы для действий
  ACTIONS = {
    1 => :player_skip, 2 => :add_card_to_player, 3 => :show_all_cards,
    4 => :one_more_game, 5 => :exit
  }
  # метод начала игры
  def initialize
    # запрос имени игрока и его создание
    print 'Введите ваше имя: '
    player_name = gets
    @player = Player.new(player_name)
    sleep 1
    puts
    puts 'Игра начинается!'
    puts
    @dealer = Dealer.new
    @deck = Deck.new
    @player_points = 0
    @dealer_points = 0
    $bank += 20
    @player.bank -= 10
    @dealer.bank -= 10
    sleep 1
    start_game
  end 
  # главный метод игры, где все взаимодействует
  def start_game
    puts 'Сделаны ставки по 10$ от игрока и дилера'
    sleep 1
    puts
    puts "Банк игры: #{$bank}$"
    sleep 1
    puts
    puts 'Раздача карт'
    issuing_card_to_player
    issuing_card_to_dealer
    add_player_points
    add_dealer_points
    sleep 1
    puts
    puts 'Ваши карты:'
    show_player_cards
    sleep 1
    puts
    puts 'Карты дилера:'
    show_dealer_cards_hide
    sleep 1
    puts
    puts 'Выберите действие:'

    actions = {
      1 => 'Пропустить ход (ход переходит к дилеру)',
      2 => 'Добавить карту (если у вас не более двух карт в руках)',
      3 => 'Открыть все карты и посчитать результаты',
      4 => 'Ещё одну партию и всё!', 5 => 'Выход из игры'
    }

    actions.each {|key, value| puts "#{key} - #{value}"}

    loop do
      menu = gets.to_i
      send(ACTIONS[menu])
    end
  end
end