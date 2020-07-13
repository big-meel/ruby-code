def multiples 
    range = (0..1000)
    sum = 0
    range.each do |range|
        if range % 3 == 0 || range % 5 == 0 
           sum += range 
        end
    end
    sum
end

puts multiples