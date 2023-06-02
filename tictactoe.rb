class Tictactoe
    #instance variables
    @board
    @current_player
    @player1
    @player2
    @gameover
    #getters/setters
<<<<<<< HEAD
    attr_accessor :player1, :player2, :gameover, :current_player
=======
    attr_accessor :player1, :player2, :gameover, :is_player1_turn, :current_player
>>>>>>> 01e48522089721df64f14aedceb483e7779e1e62
    #constructor
    def initialize()
        @board = Array.new(3) {Array.new(3)}
        case rand(2)
        when 0
            @player1 = "X"
            @player2 = "O"
        when 1
            @player1 = "O"
            @player2 = "X"
        else
        end
        @current_player = @player1
        puts "The current player is: #{@current_player}"
        @gameover = false
    end
    #print the board in an easily readable format.
    def print_board()
        @board.each_index do |i|
            @board.each_index do |j|
                print"| #{@board[i][j]} |"
            end
            print"\n"
            puts"------------"
        end
    end

    def get_move()
        puts "Please enter a number between 1-9 to make your move: "
        move = gets.chomp.to_i
        if current_player == @player1 #check if its player 1's turn or not before asking user for their input
            until move.between?(1,9) && valid_move?(move) #make sure that the user input is a valid slot and a valid move as well.
                puts "That is an invalid move, please enter a number between 1-9 or choose an empty slot."
                move = gets.chomp.to_i                
            end
            if @player1 == "X"
                case move #switch case to determine where to place the player's symbol based on their input
                    when 1
                        @board[0][0] = "X"
                    when 2
                        @board[0][1] = "X"
                    when 3
                        @board[0][2] = "X"
                    when 4
                        @board[1][0] = "X"
                    when 5
                        @board[1][1] = "X"
                    when 6
                        @board[1][2] = "X"
                    when 7
                        @board[2][0] = "X"
                    when 8
                        @board[2][1] = "X"
                    when 9
                        @board[2][2] = "X"
                    else
                end
            elsif @player1 == "O"
                case move
                    when 1
                        @board[0][0] = "O"
                    when 2
                        @board[0][1] = "O"
                    when 3
                        @board[0][2] = "O"
                    when 4
                        @board[1][0] = "O"
                    when 5
                        @board[1][1] = "O"
                    when 6
                        @board[1][2] = "O"
                    when 7
                        @board[2][0] = "O"
                    when 8
                        @board[2][1] = "O"
                    when 9
                        @board[2][2] = "O"
                    else
                end
            end
        else
            until move.between?(1,9) && valid_move?(move) 
                puts "That is an invalid move, please enter a number between 1-9 or choose an empty slot."
                move = gets.chomp.to_i                
            end
            if @player2 == "X"
                case move
                    when 1
                        @board[0][0] = "X"
                    when 2
                        @board[0][1] = "X"
                    when 3
                        @board[0][2] = "X"
                    when 4
                        @board[1][0] = "X"
                    when 5
                        @board[1][1] = "X"
                    when 6
                        @board[1][2] = "X"
                    when 7
                        @board[2][0] = "X"
                    when 8
                        @board[2][1] = "X"
                    when 9
                        @board[2][2] = "X"
                    else
                end
            elsif @player2 == "O"
                case move
                    when 1
                        @board[0][0] = "O"
                    when 2
                        @board[0][1] = "O"
                    when 3
                        @board[0][2] = "O"
                    when 4
                        @board[1][0] = "O"
                    when 5
                        @board[1][1] = "O"
                    when 6
                        @board[1][2] = "O"
                    when 7
                        @board[2][0] = "O"
                    when 8
                        @board[2][1] = "O"
                    when 9
                        @board[2][2] = "O"
                    else
                end
            end
        end
    end
    
    def check_winner(player)
        #if the player has an "X" or and "O" in any diagonal, any row or any column, set the game to be over and print a victory message.
        if check_cols(player) || check_diag(player) || check_rows(player) == true
            @gameover = true
            self.print_board()
            puts "Congratulations #{player}, you win!"
            return @gameover
        elsif check_tie() == true
            @gameover = true
            self.print_board()
            puts "Game over, it's a tie!"
            return @gameover
        end
        switch_player()
        puts "current player is: #{@current_player}"
        @gameover
    end
    
    private #private methods that should only be accessed by public methods to avoid manipulating game state

    def switch_player() #change the current player to the other based on who the current player is
        @current_player == @player1 ? (@current_player = @player2) : (@current_player = @player1)
    end

    def valid_move?(num)
        case num        #check to see if the slot a user picked for their move already has a character
        when 1
            return @board[0][0] == nil ? true : false
        when 2
            return @board[0][1] == nil ? true : false
        when 3
            return @board[0][2] == nil ? true : false
        when 4
            return @board[1][0] == nil ? true : false
        when 5
            return @board[1][1] == nil ? true : false
        when 6
            return @board[1][2] == nil ? true : false
        when 7
            return @board[2][0] == nil ? true : false
        when 8
            return @board[2][1] == nil ? true : false
        when 9
            return @board[2][2] == nil ? true : false
        else
        end


    end

    def check_tie()
        count = 0
        @board.each_index do |rows|
            @board.each_index do |cols|
                if @board[rows][cols] != nil
                    count += 1
                end
            end
        end
        if count == 9
            return true
        end
        false
    end

    def check_rows(player)
        count = 0
        if player == "X" #loop through each row and see if the count of X characters is 3, if so we have a win on rows
        @board.each_index do |row|
            @board.each_index do |col|
            if @board[row][col] == "X"
                count += 1
            else
                count = 0
            end
            end
            count == 3 ? (return true) : next
        end 
        end
        if player == "O" #loop through each row and see if the count of O characters is 3, if so we have a win on rows
        @board.each_index do |row|
            @board.each_index do |col|
            if @board[row][col] == "O"
                count += 1
            else 
                count = 0
            end
            end
            count == 3 ? (return true) : next
        end
        end
        false
    end

    def check_cols(player)
        if player == "X" #check if every column combo equals X if the player is X
            if (@board[0][0] == "X" && @board[1][0] == "X" && @board[2][0] == "X")
                    return true
            elsif (@board[0][1] == "X" && @board[1][1] == "X" && @board[2][1] == "X")
                    return true
            elsif (@board[0][2] == "X" && @board[1][2] == "X" && @board[2][2] == "X")
                    return true
            end 
        end
        if player == "O" #check if every column combo equals O if the player is O
            if (@board[0][0] == "O" && @board[1][0] == "O" && @board[2][0] == "O")
                    return true
            elsif (@board[0][1] == "O" && @board[1][1] == "O" && @board[2][1] == "O")
                    return true
            elsif (@board[0][2] == "O" && @board[1][2] == "O" && @board[2][2] == "O")
                    return true
            end  
        end
        false
    end
    
    def check_diag(player)
        if player == "X" #check if the diagonal combos all equal X if the player is X
            if (@board[0][0] == "X" && @board[1][1] == "X" && @board[2][2] == "X")
                return true
            elsif (@board[0][2] == "X" && @board[1][1] == "X" && @board[2][0] == "X")
                return true
            end
        end
        if player == "O" #check if the diagonal combos all equal O if the player is O
            if (@board[0][0] == "O" && @board[1][1] == "O" && @board[2][2] == "O")  
                return true
            elsif (@board[0][2] == "O" && @board[1][1] == "O" && @board[2][0] == "O")
                return true
            end
        end
        false
    end

end
<<<<<<< HEAD

=======
>>>>>>> 01e48522089721df64f14aedceb483e7779e1e62
t = Tictactoe.new()

puts "Welcome to tic-tac-toe!\nPlayer 1 is #{t.player1} and Player 2 is #{t.player2}"
until t.gameover
    t.print_board()
    t.get_move()
    t.check_winner(t.current_player)
end
