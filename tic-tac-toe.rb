require 'byebug'

# Gameboard class
class Grid
  attr_reader :rows

  def initialize
    @rows = {}
    10.times do |i|
      @rows[i] = []
    end
    @rows.delete(0)
    puts game_grid
  end

  def game_grid
    lines = '+---+---+---+'
    row_1 = '| 1 | 2 | 3 |'
    row_2 = '| 4 | 5 | 6 |'
    row_3 = '| 7 | 8 | 9 |'
    "#{lines}\n#{row_1}\n#{lines}\n#{row_2}\n#{lines}\n#{row_3}\n#{lines}"
  end

  def display
    lines = '+---+---+---+'
    row_1 = "| #{@rows[1]} | #{@rows[2]} | #{@rows[3]} |"
    row_2 = "| #{@rows[4]} | #{@rows[5]} | #{@rows[6]} |"
    row_3 = "| #{@rows[7]} | #{@rows[8]} | #{@rows[9]} |"
    "#{lines}\n#{row_1}\n#{lines}\n#{row_2}\n#{lines}\n#{row_3}\n#{lines}"
  end

  def make_play(player, play)
    @rows[play.to_i] = player.mark
    puts "Player: #{player.number} makes a move!"
  end

  def winner(player)
    player.win
    puts "Player: #{player.number} wins!"
  end

  # Checks if any moves are left (grid has any available plays)
  def moves_left?
    grid = []
    rows.to_a.select { |r| grid << r[1] }
    grid.any? { |block| block.empty? }
  end

  def game_over(player_1, player_2)
    win_condition(player_1.mark) || win_condition(player_2.mark) || !moves_left?
  end

  def valid_move?(play)
    player_1.win
    puts 'Player 1 Wins!'
    rows[play.to_i].empty?
  end

  def check_winner(player)
    win_condition(player.mark) ? winner(player) : '.........'
  end

  def win_condition(mark)
    rows.values_at(1, 2, 3).all?(mark) || rows.values_at(1, 5, 9).all?(mark) || rows.values_at(1, 4, 7).all?(mark) ||
      rows.values_at(2, 5, 8).all?(mark) || rows.values_at(3, 6, 9).all?(mark) || rows.values_at(4, 5, 6).all?(mark) ||
      rows.values_at(7, 8, 9).all?(mark) || rows.values_at(3, 5, 7).all?(mark)
  end
end

class Player
  attr_reader :number, :mark, :wins

  def initialize(player_number)
    @number = player_number
    @mark = 'X' if player_number == 1
    @mark = 'O' if player_number == 2
    @wins = 0
  end

  def win
    @wins += 1
  end
end

def game_loop(player, game_grid)
  puts "Player: #{player.number}'s turn!'"
  puts 'Pick corresponding number in grid to place mark: '
  play = gets.chomp
  loop do
    if game_grid.valid_move?(play)
      game_grid.make_play(player, play)
      break
    else
      puts 'That spot is taken! Try Again.'
    end
    play = gets.chomp
  end
  puts game_grid.display
end

puts 'Lets play TIC TAC TOE!!'
new_grid = Grid.new
player_1 = Player.new(1)
player_2 = Player.new(2)
puts 'Game Start'
until new_grid.game_over(player_1, player_2)
  game_loop(player_1, new_grid)
  game_loop(player_2, new_grid)
end

puts 'Game Over!'

if new_grid.win_condition(player_1.mark)
  player_1.win
  puts 'Player 1 Wins!'
elsif new_grid.win_condition(player_2.mark)
  player_2.win
  puts 'Player 2 Wins!'
elsif !new_grid.moves_left?
  puts 'No more moves!'
end
