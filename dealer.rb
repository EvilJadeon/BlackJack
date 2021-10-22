# frozen_string_literal: true

# Класс дилера (за него играет компьютер)
class Dealer
  # создание геттеров и сеттеров
  attr_accessor :bank
  # создание геттеров
  attr_reader :hand

  # метод - конструктор
  def initialize
    @bank = 100
    @hand = Hand.new
  end
end
