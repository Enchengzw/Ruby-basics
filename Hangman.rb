# frozen_string_literal: true

require 'yaml'

class Game
  attr_accessor :guess, :answer, :count

  def initialize(guess = [], answer = [], count = 7)
    @guess = guess
    @answer = answer
    @count = count
  end

  def to_yaml
    YAML.dump({
                guess: @guess,
                answer: @answer,
                count: @count
              })
  end

  def choose_word(dictionary)
    word = ''
    word = dictionary[rand(0..999)].chomp until word.length.between?(5, 12)
    word
  end

  def guess_array(word)
    @guess = Array.new(word.length, '_')
    p @guess
  end

  def answer_array(word)
    @answer = word.split('')
    p @answer
  end

  def character_guess
    gets.chomp
  end

  def comparison(character, answer_array, guess_array)
    if answer_array.include?(character)
      answer_array.each_with_index do |answer_character, index|
        guess_array[index] = character if answer_character == character
      end
    end
    guess_array
  end

  def new_game(dictionary)
    word = choose_word(dictionary)
    guess_array(word)
    answer_array(word)
    @count = 7
    while count.positive?
      puts 'Choose a character'
      choice = character_guess
      if answer.include?(choice)
        comparison(choice, answer, guess)
      else
        count -= 1
      end
      print guess
      print "\n"
      puts "You have #{count} tries remaining"
      break if guess == answer
    end
  end

  def load_game(save_file)
    save = YAML.load(save_file)
    initialize(save[:guess], save[:answer], save[:count])
    while count.positive?
      puts 'Choose a character'
      choice = character_guess
      if answer.include?(choice)
        comparison(choice, answer, guess)
      else
        count -= 1
      end
      print guess
      print "\n"
      puts "You have #{count} tries remaining"
      break if guess == answer
    end
  end
end

dictionary = File.readlines('google-10000-english-no-swears.txt')
x = Game.new
word = x.choose_word(dictionary)
x.guess_array(word)
x.answer_array(word)
save = x.to_yaml
x.load_game(save)

