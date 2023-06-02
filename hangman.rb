require 'json'
require 'pry-byebug'
class Hangman

    @dictionary
    # @answer
    # @guess
    # @gameover
    # @turns
    # @player_guesses

    attr_accessor :answer, :guess, :gameover, :player_guesses, :turns

    def initialize(answer, guess, gameover, player_guesses, turns)
        #self.load_game()
        @dictionary = File.readlines('google-10000-english-no-swears.txt')
        @answer = answer
        @guess = guess
        @gameover = gameover
        @player_guesses = player_guesses
        @turns = turns
    end

    def to_json(*args)
        {
            JSON.create_id => self.class.name,
            'answer' => @answer,
            'guess' => @guess,
            'turns' => @turns,
            'gameover' => @gameover,
            'player_guesses' => @player_guesses
        }.to_json(*args)
    end

    def self.json_create(object)
        new(object['answer'], object['guess'], object['turns'], object['gameover'], object['player_guesses'])
    end

    def create_display_strings()
        while @answer.length == 0 do
            random_word = @dictionary[rand(9999)] #choose a random word from the dictionary that is at least 5 chars
            if random_word.length.between?(6,12)
                @answer.concat(random_word).chop! #concat this random word to guess and chop off the newline "\n" char
                break
            end
        end

        @guess = @answer.gsub("","_").chop() #add an _ for each char in the answer string
        @guess.each_char {|char| @guess.gsub!(char, "")  if char != "_"} #remove the letters from the guess string so the user can't tell what the answer is but will be the same lenght as the answer
        @answer = @answer.split("") #split the answer into an array of chars to make it easier to compare user input to the answer.
    end

    def print_guess()
        @guess.each_char do |char| #print out the letter guesses in a readable format
            print "#{char} "
        end
        print "\n"
    end

    def get_player_guess()
        save_game()
        #p @answer
        puts "Turns remaining: #{@turns}"
        puts "Please enter a letter: "
        player_guess = gets.chomp().downcase()
        until player_guess.length == 1 && !@player_guesses.include?(player_guess) #validate that the player is guessing a single letter that they haven't guessed already
            if player_guess.length != 1
                puts "Please enter a single letter only."
            elsif @player_guesses.include?(player_guess)
                puts "You have already guessed that letter, try another letter you haven't guessed yet."
            end
            player_guess = gets.chomp()
        end
        @player_guesses.push(player_guess)
        if @answer.include?(player_guess) #if the player guess is within the answer array, iterate over the answer array and make the same index of the guess array equal to that character
            @answer.each_with_index do |chr, index|
                if chr == player_guess
                    @guess[index] = chr
                end
            end
        else
            puts "incorrect guess, you lose a turn"
            @turns -= 1
        end
    end

    def check_victory()
        if @answer.join("") == @guess
            puts "You correctly guessed the answer, which was #{@answer.join("")}!\nYou got it, you win!"
            @gameover = true
            return @gameover
        elsif turns == 0
            puts "You ran out of turns and didn't guess the word, which was #{@answer.join("")}, you lose!"
            @gameover = true
            return @gameover
        else
            return @gameover
        end
    end

    private
    
    def save_game()
        puts "Would you like to save your current game? [Y/N]"
        save = gets().chomp().downcase()
        until save == "y" || save == "n"
            puts "Would you like to save your current game? [Y/N]"
            save = gets().chomp().downcase()
        end
        if save == "y"
            gamestate = JSON.generate(self)
            File.open("savedgame.txt", "w") {|f| f.write(gamestate)}
        end
    end
    
end

def main()
    puts "Welcome to Hangman! Would you like to continue from a saved game? [Y/N]"
    g = gets().chomp().downcase()
        until g == "y" || g == "n"
            puts "Welcome to Hangman! Would you like to continue from a saved game? [Y/N]"
            g = gets().chomp().downcase()
        end
    saved_game = File.read("savedgame.txt")
    loaded_game = JSON.parse(saved_game)
    if g == "y"
        h = Hangman.new(loaded_game["answer"], loaded_game["guess"], loaded_game["gameover"], loaded_game["player_guesses"], loaded_game["turns"])
        until h.gameover
            h.print_guess()
            h.get_player_guess()
            h.check_victory()
        end
    else
        h = Hangman.new("", "", false, [], 8)
        h.create_display_strings()
        until h.gameover
            h.print_guess()
            h.get_player_guess()
            h.check_victory()
        end
    end
end
main()
    
        
    