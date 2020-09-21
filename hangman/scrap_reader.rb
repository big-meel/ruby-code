require 'open-uri'

puts "This program will download and create the library of words found at 'https://www.scrapmaker.com/data/wordlists/twelve-dicts/5desk.txt' and save it to 'words.txt'"

url = 'https://www.scrapmaker.com/data/wordlists/twelve-dicts/5desk.txt'

File.open('words.txt', 'w'){ |file| file.write(open(url).read) }

puts "Done."

