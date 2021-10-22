# frozen_string_literal: true

# подключение дргих классов
require_relative 'card'
require_relative 'dealer'
require_relative 'deck'
require_relative 'player'
require_relative 'hand'
require_relative 'interface'
# Класс для основной логики игры
class Game
  # создание геттеров
  attr_reader :deck

  # метод-конструктор
  def initialize
    @interface = Interface.new
  end

  def start
    puts 'Введите ваше имя:'
    name = gets.chomp
    @player = Player.new(name)
    @dealer = Dealer.new

    make_bet
    start_turn
    show_cards
    play
  end

  private

  # метод действий для игрока и дилера
  def actions
    case @interface.choose
    when 1
      @interface.player_skip
      @interface.dealer_skip(score(@dealer), @dealer.hand, deck)
    when 2
      add_card(@player)
      @interface.show_player_cards(@player.hand.cards, score(@player), @player.bank)
      @interface.dealer_skip(score(@dealer), @dealer.hand, deck)
      @interface.show_dealer_cards_hide(@dealer.hand.cards)
    when 3
      @interface.show_player_cards(@player.hand.cards, score(@player), @player.bank)
      @interface.show_dealer_cards(@dealer.hand.cards, score(@dealer), @dealer.bank)
      winner
    when 4
      one_more_game
    when 5
      exit
    end
  end

  def play
    loop do
      @interface.draw

      actions

      break if @player.bank.zero? || @dealer.bank.zero?
    end
  end

  def one_more_game
    reset_hands!
    start_turn
    show_cards
  end

  def show_cards
    @interface.show_player_cards(@player.hand.cards, score(@player), @player.bank)
    @interface.show_dealer_cards_hide(@dealer.hand.cards)
  end

  def reset_hands!
    @player.hand.cards.clear
    @dealer.hand.cards.clear
  end

  def add_card(everyone)
    everyone.hand.add_card(@deck.delete_card)
  end

  def start_turn
    @deck = Deck.new
    2.times { add_card(@player) }
    2.times { add_card(@dealer) }
  end

  def score(everyone)
    everyone.hand.counting_points
  end

  def make_bet
    @player.bank -= 10
    @dealer.bank -= 10
  end

  def winner
    if score(@player) == score(@dealer)
      @interface.tie(@player.bank, @dealer.bank)
    elsif score(@player) > score(@dealer) && score(@player) <= 21
      @interface.player_won(@player.bank, @dealer.bank)
    elsif score(@player) > score(@dealer) && score(@player) > 21
      @interface.player_loss(@player.bank, @dealer.bank)
    elsif score(@player) < score(@dealer) && score(@dealer) <= 21
      @interface.player_loss(@player.bank, @dealer.bank)
    elsif score(@player) < score(@dealer) && score(@dealer) > 21
      @interface.player_won(@player.bank, @dealer.bank)
    end
  end
end

@game = Game.new
@game.start
