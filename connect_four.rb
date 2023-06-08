class Connectfour

    attr_accessor :player1, :player2, :gameover, :current_player, :board

    def initialize()
        @player1 = "🔴"
        @player2 = "🟡"
        @board = Array.new(6) {Array.new(7)}
        @gameover = false
        @current_player = @player1
    end
    
    def print_board()
        @board.each do |arr|
            arr.each_index do |i|
            print "| #{arr[i]} |"
        end
        print"\n"
        puts "----------------------------"
        end
    end

    def play_game()
        puts "Welcome to connect four! Player1 is #{player1} and Player2 is #{player2}"
        until @gameover == true
            print_board
            place_piece
        end
        print_board
    end

    def get_move()
        loop do
            user_input = gets.chomp()
            verified_num = verify_input(1,7,user_input.to_i) if user_input.match?(/^\d+$/)
            return verified_num if verified_num

            puts "Error, please select a row between 1-7!"
        end
    end

    def place_piece()
        puts "It is currently #{current_player}'s turn."
        puts "Please select a column to place your piece."
        input = get_move()
        row = 5
        while row > -1 do
            if @board[row][input-1] == nil
                @board[row][input-1] = @current_player
                break
            end
            row -= 1
        end
        if row == -1
            return
        end
        check_winner(current_player)
        switch_turn()
    end

    def check_winner(player)
        if check_cols(player) || check_rows(player) || check_diag(player) == true
            puts "#{current_player} has connected four in a row, they win!"
            @gameover = true
        elsif board_full?()
            puts "Niether player managed to get 4 in a row, it's a tie."
            @gameover = true
        end
        gameover
    end

    def check_cols(player)
        count = 0
        col = 0
        if player == "🔴"
            while col <= 6 do
                for i in 0..5
                    if @board[i][col] == "🔴"
                        count += 1
                    else
                        count = 0
                    end
                    if count == 4
                        return true
                    end
                end
                count = 0
                col += 1
            end
        end
        if player == "🟡"
            while col <= 6 do
                for i in 0..5
                    if @board[i][col] == "🟡"
                        count += 1
                    else
                        count = 0
                    end
                    if count == 4
                        return true
                    end
                end
                count = 0
                col += 1
            end
        end
        return false
    end

    def check_rows(player)
        count = 0
        row = 0
        if player == "🔴"
            while row <= 5 do
                for i in 0..6
                    if @board[row][i] == "🔴"
                        count += 1
                    else
                        count = 0
                    end
                    if count == 4
                        return true
                    end
                end
                count = 0
                row += 1
            end
        end
        if player == "🟡"
            while row <= 5 do
                for i in 0..6
                    if @board[row][i] == "🟡"
                        count += 1
                    else
                        count = 0
                    end
                    if count == 4
                        return true
                    end
                end
                count = 0
                row += 1
            end
        end
        return false
    end

    def check_diag(player)
        count = 0 # for row 0, go down left for each column up to 4.        
        down_right_diagonals = [ [@board[0][0],@board[1][1],@board[2][2],@board[3][3],@board[4][4],@board[5][5]],
                                 [@board[0][1],@board[1][2],@board[2][3],@board[3][4],@board[4][5],@board[5][6]],
                                 [@board[0][2],@board[1][3],@board[2][4],@board[3][5],@board[4][6]],
                                 [@board[0][3],@board[1][4],@board[2][5],@board[3][6]]
                               ]
        down_left_diagonals = [ [@board[0][4],@board[1][3],@board[2][2],@board[3][1],@board[4][0]],
                                [@board[0][5],@board[1][4],@board[2][3],@board[3][2],@board[4][1],@board[5][0]],
                                [@board[0][6],@board[1][5],@board[2][4],@board[3][3],@board[4][2],@board[5][1]]
                              ]
        up_right_diagonals = [ [@board[5][0],@board[4][1],@board[3][2],@board[2][3],@board[1][4],@board[0][5]],
                               [@board[5][1],@board[4][2],@board[3][3],@board[2][4],@board[1][5],@board[0][6]],
                               [@board[5][2],@board[4][3],@board[3][4],@board[2][5],@board[1][6]],
                               [@board[5][3],@board[4][4],@board[3][5],@board[2][6]]
                             ]
        up_left_diagonals = [[@board[5][6],@board[4][5],@board[3][4],@board[2][3],@board[1][2],@board[0][1]],
                             [@board[5][5],@board[4][4],@board[3][3],@board[2][2],@board[1][1],@board[0][0]],
                             [@board[5][4],@board[4][3],@board[3][2],@board[2][1],@board[1][0]],
                             [@board[5][3],@board[4][2],@board[3][1],@board[2][0]]
                            ]
        if player == "🔴"
            down_right_diagonals.each do |arr|
                arr.each_index do |idx|
                    if arr[idx] == "🔴"
                        count += 1
                    else
                        count = 0
                    end
                    if count == 4
                        return true
                    end
                end
            end
            count = 0
            down_left_diagonals.each do |arr|
                arr.each_index do |idx|
                    if arr[idx] == "🔴"
                        count += 1
                    else
                        count = 0
                    end
                    if count == 4
                        return true
                    end
                end
            end
            count = 0
            up_right_diagonals.each do |arr|
                arr.each_index do |idx|
                    if arr[idx] == "🔴"
                        count += 1
                    else
                        count = 0
                    end
                    if count == 4
                        return true
                    end
                end
            end
            count = 0
            up_left_diagonals.each do |arr|
                arr.each_index do |idx|
                    if arr[idx] == "🔴"
                        count += 1
                    else
                        count = 0
                    end
                    if count == 4
                        return true
                    end
                end
            end
        end
        if player == "🟡"
            down_right_diagonals.each do |arr|
                arr.each_index do |idx|
                    if arr[idx] == "🟡"
                        count += 1
                    else
                        count = 0
                    end
                    if count == 4
                        return true
                    end
                end
            end
            count = 0
            down_left_diagonals.each do |arr|
                arr.each_index do |idx|
                    if arr[idx] == "🟡"
                        count += 1
                    else
                        count = 0
                    end
                    if count == 4
                        return true
                    end
                end
            end
            count = 0
            up_right_diagonals.each do |arr|
                arr.each_index do |idx|
                    if arr[idx] == "🟡"
                        count += 1
                    else
                        count = 0
                    end
                    if count == 4
                        return true
                    end
                end
            end
            count = 0
            up_left_diagonals.each do |arr|
                arr.each_index do |idx|
                    if arr[idx] == "🟡"
                        count += 1
                    else
                        count = 0
                    end
                    if count == 4
                        return true
                    end
                end
            end
        end
        return false
    end


    def board_full?()
        count = 0
        @board.each do |arr|
            arr.each_index do |idx|
                if arr[idx] != nil 
                count += 1
                end
            end
        end
        return count == 42
    end

    def switch_turn()
        @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
    end

    def verify_input(min, max, input)
        return input if input.between?(min, max)
    end

end

c = Connectfour.new()
c.play_game
