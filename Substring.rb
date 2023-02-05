def substrings (string, initial_array)
  hash = Hash.new(0)
  array = initial_array.dup
  
  string = string.gsub(/[^\w\s]/,'')
  string_array = string.downcase.split(" ")
  print string_array
  
  string_array.each do |word|
    
    for character_index in 0..word.length
      
      array.each_with_index do |dictionary_word, dictionary_index|
        
        if dictionary_word == word[character_index..-1]
          hash[dictionary_word] += 1
          array.delete_at(dictionary_index)
        elsif dictionary_word == word[0..-character_index]
          hash[dictionary_word] += 1
          array.delete_at(dictionary_index)
        end
        
      end
      
    end
  array = initial_array.dup
  end
hash
end

dictionary = 
["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

print substrings("Howdy partner, sit down! How's it going?", dictionary)