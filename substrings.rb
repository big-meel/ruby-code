def substrings(word, dictionary)
  sub_string = {}
  dictionary.each do |word|
    sum = 0
    word.split(" ").each do |w|
      sum += 1 if w.include? word
    end
    sub_string[word] = sum 
  end
  sub_string.reject! { |k,v| v < 1 } 
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

p substrings("below", dictionary)
p substrings("Howdy partner, sit down! How's it going?", dictionary)