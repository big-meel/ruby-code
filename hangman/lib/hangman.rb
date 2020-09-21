require 'yaml'

dictionary = File.open('./words.txt', 'r')

class Hangman
  attr_reader :secret_word, :correct_guesses, :missed_guesses

  def initialize(dictionary, secret_word = '', correct_guesses = [], missed_guesses = [], wrong_guesses_left = 6 )
    unless dictionary == []
      @dictionary = dictionary.readlines.select { |word| (5..12).include?(word.split.first.length) } 
      @dictionary.map! { |word| word.split.first }
    end 
    if secret_word.empty?
      @secret_word = @dictionary[rand(@dictionary.length)] 
    else 
      @secret_word = secret_word
    end
    @correct_guesses = correct_guesses
    @missed_guesses = missed_guesses
    @wrong_guesses_left = wrong_guesses_left
  end

  def check_guess(guess)
    self.secret_word.downcase.include?(guess)
  end

  def guess_from_user
    puts "Make a guess!"
    puts ""
    puts "( Enter 'save' to save and exit game  )"
    puts ""
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

  def missed_guesses_display
    @missed_guesses.join(', ')
  end

  def remaining_guesses
    @wrong_guesses_left
  end

  # Save to yml file
  
  # Load progress from yml file 

end

def game_loop(dictionary)

  def save_to_yaml(game)
    YAML.dump({
      secret_word:  game.secret_word,
      remaining_guesses:  game.remaining_guesses,
      correct_guesses: game.correct_guesses,
      missed_guesses: game.missed_guesses
    })
  end

  def load_from_yaml(string)
    data = YAML.load_file string
    Hangman.new([], data[:secret_word], data[:correct_guesses], data[:missed_guesses], data[:remaining_guesses])
  end

  
  if File.exists?('hangman_save.yml')
    puts "Would you like to load  file?: (y/n)"
    continue = gets.chomp
  end

  if continue == 'y'
    game = load_from_yaml('hangman_save.yml')
    puts "Game Loaded!"
  else
    game = Hangman.new(dictionary)
  end
  
  until game.remaining_guesses == 0 || game.secret_word == game.show_word


    # game.show_word
    puts ""
    puts game.wrong_guesses_left
    puts ""
    unless game.missed_guesses_display.empty?
      puts "Wrong guesses #{game.missed_guesses_display}"
      puts ""
    end

    guess = game.guess_from_user

    if guess == 'save'
      game_save = save_to_yaml(game)
      File.open("hangman_save.yml", "w"){ |file| file.puts game_save }
      puts "Game Saved"
      return
    end
      

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

