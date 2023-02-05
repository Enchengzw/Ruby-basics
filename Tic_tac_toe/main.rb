class Game
  @@board = Array.new(3) { Array.new(3) }

  def board
    @@board
  end

  def p1_turn
    puts 'Player 1, input row number (1-3)'
    x = gets.to_i
    puts 'Player 1, input column number (1-3)'
    y = gets.to_i
    puts @@board
    if @@board [x][y].nil?
      @@board [x][y] = 1
      print "#{x}, #{y} has been filled"
    else
      print 'Location already filled, choose another one'
      player_1
    end
  end

  def p2_turn
    puts 'Input row number (1-3)'
    x = gets.to_i
    puts 'Input column number (1-3)'
    y = gets.to_i
    puts @@board
    if @@board [x][y].nil?
      @@board [x][y] = 2
      print "#{x}, #{y} has been filled"
    else
      print 'Location already filled, choose another one'
      player_2
    end
  end


end

A = Game.new
