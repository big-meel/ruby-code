require 'byebug'
# Create game class with predefined rounds
class Mastermind
	attr_reader :code_breaker, :code_maker, :rounds, :turns
	
	@@game_colors = ["red", "blue", "green", "yellow", "purple", "orange" ]
	# Feedback symbols
	@@feedback_symbols = { "correct order"=> "r", "wrong order"=> "w", "not in code"=>"x"  }

	def initialize(code_maker, code_breaker, rounds = 1)
		@feedback = []
		@turns = 12
		@rounds = rounds
		@code = Hash.new
		@code_maker = code_maker
		@code_breaker = code_breaker
		@game_over = false
		puts "Choose your role "
		puts "1: Code Maker \n\n 2: Code Breaker"
		puts "Enter number of role: "
		choice = gets.chomp
		if choice.to_i == 1 
			 @code_maker = code_breaker
			 @code_breaker = code_maker
		end 
	end

	def code
		self.display_code(@code)
	end
	
	# Get starting combination from code maker
	def set_code
		4.times do |i|
			puts "Choose your combination of colors by"
			puts "selecting the coulor: #{ @@game_colors } with each position"
			@code[i] = gets.chomp
		end
	end

	# Random code is generated
	def random_code
		random = @@game_colors.shuffle
		4.times do |i|
			@code[i] = random[i]
		end
	end

	# Accepts the user's guess at the maker's code
	def guess
		guess = Hash.new
		puts "Try to crack the code: "
		4.times do |i|
			puts "#{i}: "
			guess[i] = gets.chomp
		end
		@code_breaker.guess = guess
	end

	# Compare guess with code and return feedback on accuracy
	def compare_guess
		feedback = []
		if @code == @code_breaker.guess
			feedback = ["r", "r", "r", "r"]
		else
			@code_breaker.guess.each do |k,v|
				return_symbol(k, v, feedback)
			end
		end
		@feedback = feedback
		display_code(feedback.shuffle)
	end

	# For the user Enter feedback when they are the Code Maker
	def manual_feedback
		feedback = []
		puts "Based on Code Breaker's input place clues: "
		puts "Code Breaker's Input:"
		puts display_code(@code_breaker.guess)
		puts
		puts "Key: "
		@@feedback_symbols.each { |k,v| puts "#{k}: #{v}"}
		puts "[#{gets.chomp}][#{gets.chomp}][#{gets.chomp}][#{gets.chomp}]"
	end

	def game_over
		if @feedback == ["r", "r", "r", "r"]
			self.code_maker.score = 12 - self.turns 
			true
		elsif self.turns == 0 
			true
		else
			false
		end
	end

	def update_board
		@turns -= 1
	end

	private

	def display_code(code)
		if code.is_a? Array
			puts "[#{code.join("][")}]"
		else
			puts "[#{code.values.join("][")}]"
		end
	end

	def return_symbol(key, val, arr)
		if @code.values.include?(val)
			arr << "w"
			@code.each do |k, v|
				if v == val && k == key
					arr.pop
					arr << "r"
				end
			end
		else 
			arr << "x" 
		end
	end
end
 
# Player class  
class Player
	attr_accessor :guess, :score

	def initialize
	end

	def display
			puts "[#{self.guess.values.join("][")}]"
	end
end

# Computer player
class Computer < Player
	
	def initialize
		@potential_guess = []
		self.guess = {0=>"red", 1=>"red", 2=>"blue", 3=>"blue"}
	end

	# process feedback (if there are 2 'r's then both 1 and 2 has a digit in the correct slot, 
	# if the result has 1 r, then only one digit (1 or 2)is in the correct slot. 
	# if there are 2 w'sthen 1 and 2 are in incorrect slots 
	# if there is 1 w then  1 or 2 is in incorrect slots

	def guess_with_repetition
	end


	def guess_without_repetition
	end

	def process_feedback(feedback, turns_left)
		if turns_left == 12
			if feedback.count("r") == 2
				@potential_guess[0] = "red"
				@potential_guess[2] = "blue"
			elsif feedback.count("r") == 1

			end
		end
	end

	def potential_guess

	end

end


computer = Computer.new
code_breaker = Player.new


new_game = Mastermind.new(computer, code_breaker)

# Game Loop
new_game.rounds.times do
	if new_game.code_maker.is_a?(Computer)
		new_game.random_code
		until new_game.game_over do
			new_game.guess
			new_game.compare_guess
			new_game.update_board
			# byebug
		end
		puts "GAME OVER!"
		puts "#{new_game.code} #{new_game.code_breaker.guess}"
		puts "Score: #{new_game.code_maker.score}"
	end
end

