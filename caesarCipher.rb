require 'pry-byebug'
def caesar_cipher(word, shift)
    min_upper = 65
    max_upper = 90
    min_lower = 97
    max_lower = 122
    word = word.split("")
    word.map! do |letter|
        #binding.pry
        if(letter.ord + shift).between?(min_upper, max_upper) || (letter.ord + shift).between?(min_lower, max_lower)
            (letter.ord + shift).chr
        elsif (letter.ord) < min_upper || (letter.ord) > max_lower
            letter
        elsif (letter.ord + shift) > max_upper || (letter.ord + shift) > max_lower
            ((letter.ord + shift) - 26).chr
        elsif (letter.ord + shift) < min_upper || (letter.ord + shift) < min_lower
            ((letter.ord + shift) + 26).chr
        end
    end
    word.join("")
end
    
caesar_cipher("I fucking did it!!", 5)
puts caesar_cipher("What a string!", 5)

