# Create game class with predefined rounds
class Mastermind
	@@game_colors = ["red", "blue", "green", "yellow", "purple", "orange" ]
	# Feedback symbols
	@@feedback_symbols = { "correct order"=> "r", "wrong order"=> "w", "not in code"=>"x"  }

  def initialize(rounds = 1, code_maker, code_breaker)
		@turns = 12
		@rounds = rounds
		@code = Hash.new
		@code_maker = code_maker
		@code_breaker = code_breaker
	end
	
	# Get starting combination from code maker
	def set_code
		4.times do |i|
			puts "Choose your combination of colors by"
			puts "selecting the coulor: #{ @@game_colors } with each position"
			@code[i] = gets.chomp
		end
	end

	def random_code
		random = @@game_colors.shuffle
		4.times do |i|
			@code[i] = random[i]
		end
	end

	# Accepts the user's guess at the maker's code
	def guess
		guess = Hash.new
		4.times do |i|
			puts "Try to crack the code: "
			guess[i] = gets.chomp
		end
		code_breaker.guess = guess
	end

	# Compare guess with code and return feedback on accuracy
	def compare_guess
		feedback = []
		if @code == code_breaker.guess
			feedback = ["r", "r", "r", "r"]
		else
			code_breaker.guess.each do |k,v|
				# Need to check for exact key location for "r" symbol
				@code.values.include?(v) ? @code.key(v) == k ? feedback << "r" : feedback << 'w' :  feedback << 'x'
			end
		end
	end
end
 
# Player class  
class Player
	attr_accessor :guess, :score

	def initialize(role)
		@role = role
	end
end

# Computer player
class Computer < Player

end
