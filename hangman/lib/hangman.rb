require 'byebug'

dictionary = File.open('./words.txt', 'r')

class Hangman
  attr_reader :dictionary, :secret_word

  def initialize(dictionary)
    @dictionary = dictionary.readlines.select { |word| (5..12).include?(word.split.first.length) }
    @dictionary.map! { |word| word.split.first }
    @secret_word = @dictionary[rand(@dictionary.length)]
    @correct_guesses = []
    @missed_guesses = []
    @wrong_guesses_left = 6
  end

  def check_guess(guess)
    self.secret_word.downcase.include?(guess)
  end

  def guess_from_user
    puts "Make a guess!"
    guess = gets.chomp.downcase
  end

  def wrong!(guess)
    puts "Try again!"
    @wrong_guesses_left -= 1
    @missed_guesses << guess
  end 

  def correct!(guess)
    puts "Nice Job"
    @correct_guesses << guess
  end

  def show_word
    hidden_word = self.secret_word.split('')
    hidden_word.map! { |letter| @correct_guesses.include?(letter) ? letter : '_'}
    puts hidden_word.join(' ')
    hidden_word = hidden_word.join('')
  end

  def wrong_guesses_left
    puts "You have #{@wrong_guesses_left} wrong guesses remaining"
  end

  def missed_guesses
    @missed_guesses.join(', ')
  end

  def remaining_guesses
    @wrong_guesses_left
  end
end

def game_loop(dictionary)
  game = Hangman.new(dictionary)

  record = ""

  until game.remaining_guesses == 0 || game.secret_word == game.show_word

    # game.show_word
    puts ""
    puts game.wrong_guesses_left
    puts ""
    unless game.missed_guesses.empty?
      puts "Wrong guesses #{game.missed_guesses}"
      puts ""
    end

    guess = game.guess_from_user

    game.check_guess(guess) ? game.correct!(guess) : game.wrong!(guess)

    puts ""
  end

  puts game.secret_word.downcase
  puts ""
  unless game.remaining_guesses > 0
    puts 'Game Over'
  else
    puts 'You Won!'
  end
end


game_loop(dictionary)