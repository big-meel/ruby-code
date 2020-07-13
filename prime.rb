def prime_factors num
    require 'prime'
    def is_prime n
       n if n == 2 || n == 3 || n % 2 == 1 && n % 3 != 0
    end

    range = (0..num)
    arr = Array.new
    range.each do |r|
        if is_prime r
            
        end
    end
    arr
end
