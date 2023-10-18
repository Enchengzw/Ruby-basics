class Game
  @@color = ['red','blue','yellow','black','white','']
  attr_accessor :player
  attr_accessor :computer

  def initialize
    @player = Array.new(4)
    @computer = Array.new(4)
    @clues = Array.new(4)
  end
  
  def computer_choice
    4.times do  |i|  
      @computer.push(@@color[rand(0..5)])
    end
  end

  def player_choice
    4.times do |i| 
      puts 'Enter red, blue, yellow, black, white or blank'
      @player.push(gets.chomp)
    end
  end

  def compare_feedback
    if @coder == 1
      @code = @player
      @guess = @computer
    elsif @coder == 0
      @code = @computer
      @guess = @player
    end
    4.times do |i| 
      if @guess[i] == @code[i]
        puts "Guess #{i} was correct"
        @clues.push("Correct")
      elsif @code.include?(@guess[i])
        puts "Color #{i} is in the wrong place"
        @clues.push("Included")
      else
        @clues.push("Not included")
      end
    end
    print @clues
    print " \n"
  end

  def player_decode
    i = 0
    computer_choice
    until i >= 12 do
      @player = []
      @clues = []
      player_choice
      compare_feedback
      i += 1
      if @player == @computer
        i = 12
        puts 'You have broken the code'
      end
    end
  end

  def computer_decode
    player_choice
    4.times do |num|
      @guess = Hash.new(6, @@color[num])
      compare_feedback
      4.times do |i|
        if @clues[i] == "Correct"
          @computer[i] = @@color[num]
        end
      end
    end
  end

  def start
    puts 'Choose 1 to be the coder or 0 to be the code_breaker'
    @coder = gets.chomp
    if @coder == 1 
      computer_decode
    elsif @coder == 0
      player_decode
    end
  end
end

x = Game.new
x.start

