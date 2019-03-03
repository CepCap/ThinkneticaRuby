vowels = ["A", "E", "I", "U", "O", "Y"]
vowels_hash = {}
position = 0
("A".."Z").each do |letter| 
  position += 1
  vowels_hash[letter] = position if vowels.include? letter
end
