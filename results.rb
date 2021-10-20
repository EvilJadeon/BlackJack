module Results
   # метод подсчета результатов
   def calculation_of_results
    # Выигрывает игрок, у которого сумма очков ближе к 21
    # Если у игрока сумма очков больше 21, то он проиграл
    # Если сумма очков у игрока и дилера одинаковая, то объявляется ничья и деньги из банка возвращаются игрокам
    # Сумма из банка игры переходит к выигравшему
    if @player_points == @dealer_points
      $bank = 0
      @player.bank += 10
      @dealer.bank += 10
      puts
      puts 'Ничья'
    elsif @player_points > @dealer_points && @player_points <= 21
      @player.bank += $bank
      $bank = 0
      puts
      puts "Победил #{@player.name}"
    elsif @player_points < @dealer_points && @dealer_points <= 21
      @dealer.bank += $bank
      $bank = 0
      puts
      puts 'Победил дилер'
    elsif @player_points > @dealer_points && @player_points > 21
      @dealer.bank += $bank
      $bank = 0
      puts
      puts 'Победил дилер'
    elsif @player_points < @dealer_points && @dealer_points > 21
      @player.bank += $bank
      $bank = 0
      puts
      puts "Победил #{@player.name}"
    end
  end
  # метод открытия всех карт и подсчета очков
  def show_all_cards
    puts 'Ваши карты:'
    show_player_cards
    puts ", очки: #{@player_points}, банк: #{@player.bank}$"
    sleep 2
    puts 'Карты дилера:'
    show_dealer_cards
    puts ", очки: #{@dealer_points}, банк: #{@dealer.bank}$"
    sleep 2
    calculation_of_results
    puts
    sleep 2
    puts "Ваш банк: #{@player.bank}$, банк дилера: #{@dealer.bank}$"
  end
  # метод для "ещё одной игры"
  def one_more_game
    $bank = 20
    @dealer.bank -= 10
    @player.bank -= 10
    @player.cards = []
    @dealer.cards = []
    @player_points = 0
    @dealer_points = 0
    sleep 2
    start_game
  end
end