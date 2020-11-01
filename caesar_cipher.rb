def caesar_cipher(str, shift)
    message = str.split("")
    encoded = [] 
    message.map do |character| 
        if is_upper?(character) 
            shifted = character.ord + shift%26
            encoded << cipher_shift((65..90), shifted)
        elsif is_lower?(character)
            shifted = character.ord + shift%26
            encoded << cipher_shift((97..122), shifted)
        else
            encoded << character
        end
    end
    encoded.join("")
end

def is_upper?(char)
    (65..90).include? char.ord
end

def is_lower?(char)
    (97..122).include? char.ord
end

def cipher_shift(range, shifted)
    if shifted > range.max 
        shifted = (shifted - range.max) + (range.min - 1)
        shifted.chr
    else 
        shifted.chr
    end
end


# p caesar_cipher("What a string!", 5)