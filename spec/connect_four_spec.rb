require './connect_four.rb'
describe Connectfour do
    describe '#get_move' do
    subject(:game) { described_class.new() }

    context 'when a user gives valid input' do
        before do
            valid_input = '3'
            allow(game).to receive(:gets).and_return(valid_input)
        end

        it 'stops the loop with no error message displayed' do
            error_message = "Error, please select a row between 1-7!"
            expect(game).not_to receive(:puts).with(error_message)
            game.get_move()
        end
    end
    context 'when a user gives an invalid input then a valid input' do
        before do
            valid = '5'
            invalid = 'i'
            allow(game).to receive(:gets).and_return(invalid, valid)
        end

        it 'displays the error message once then stops the loop' do
            error_message = "Error, please select a row between 1-7!"
            expect(game).to receive(:puts).with(error_message).once
            game.get_move()
        end
    end
    end
    describe '#place_piece' do
        subject(:game) { described_class.new() }
        context 'when the board is empty and player1 selects column 3' do
            before do
                allow(game).to receive(:gets).and_return('3')
            end
            it 'should place R in column 3' do
                game.place_piece
                board = game.board[5][2]
                expect(board).to eq("🔴")
            end
        end

        context 'when the user selects a column that has a piece in the first row' do
            before do
                allow(game).to receive(:gets).and_return('3', '3')
            end
            it 'it should place the piece on top of the current piece' do
                game.place_piece #its R's turn
                game.place_piece #its currently Y's turn when getting the input
                board = game.board[4][2]
                expect(board).to eq("🟡") #therefore, we check to make sure the value is "🟡"
            end
        end

        context 'when the user selects a column that is full' do
            before do
                allow(game).to receive(:gets).and_return('3','3','3','3','3','3')
            end
            it 'should\'nt do anything' do
                game.place_piece 
                game.place_piece 
                game.place_piece 
                game.place_piece 
                game.place_piece 
                game.place_piece 
                expect(game.place_piece).to be_nil
            end
        end
                
    end

    describe '#verify_input' do
        subject(:game) { described_class.new() }

        context 'when user gives incorrect input' do
            it 'returns nil' do
                verified = game.verify_input(1,7,9)
                expect(verified).to be_nil
            end
        end
        
        context 'when user gives correct input' do
            it 'returns the valid input' do
                verified = game.verify_input(1,7,5)
                expect(verified).to eq(5)
            end 
        end
    end

    describe '#switch_turn' do
        subject(:game) { described_class.new() }

        context 'when it is player1\'s turn' do
            it 'should switch to player2\'s turn' do
                player = game.switch_turn
                expect(player).to eq(game.player2)
            end
        end

        context 'when it is player2\'s turn' do
            it 'should switch to player1\'s turn' do
                game.switch_turn
                player = game.switch_turn
                expect(player).to eq(game.player1)
            end
        end
    end

    describe '#check_winner' do
        subject(:game) { described_class.new() }
        context 'when player1 has 4 in a row' do
            before do
                winning_board = Array.new(6) {Array.new(7)}
                for i in 0..3
                    winning_board[0][i] = "🔴"
                end
                game.board = winning_board
            end
            it 'should return true' do
                over = game.check_winner(game.current_player)
                expect(over).to be(true)
            end
        end

        context 'when player2 has 4 in a row' do
            before do
                winning_board = Array.new(6) {Array.new(7)}
                for i in 0..3
                    winning_board[i][0] = "🟡"
                end
                game.board = winning_board
                game.switch_turn
            end
            it 'should return true' do
                over = game.check_winner(game.current_player)
                expect(over).to be(true)
            end
        end

        context 'when player1 does not have 4 in a row' do
            before do
                losing_board = Array.new(6) {Array.new(7)}
                for i in 0..2
                    losing_board[0][i] = "🔴"
                end
                losing_board[0][3] = "🟡"
                game.board = losing_board
            end
            it 'should return true' do
                over = game.check_winner(game.current_player)
                expect(over).to be(false)
            end
        end

        context 'when player2 does not have 4 in a row' do
            before do
                losing_board = Array.new(6) {Array.new(7)}
                for i in 0..2
                    losing_board[0][i] = "🟡"
                end
                losing_board[0][3] = "🔴"
                game.board = losing_board
            end
            it 'should return true' do
                over = game.check_winner(game.current_player)
                expect(over).to be(false)
            end
        end

        context 'when the board is full' do
            before do
                full_board = Array.new(6) {Array.new(7, "X")} #doesn't matter the value
                game.board = full_board                       #as this will only be checked if there is no winner
            end 
            it 'should return true because the game is a tie' do
                game.check_winner(game.current_player)
                tie = game.gameover
                expect(tie).to be(true)
            end
        end
    end

    describe '#board_full?' do
        subject(:game) { described_class.new() }
        context 'when the board is not full' do
            it 'should return false' do
                full = game.board_full?
                expect(full).to be(false)
            end
        end

        context 'when the board is full and neither player has connected four in a row' do
            before do
                full_board = Array.new(6) {Array.new(7, "X")} #doesn't matter the value
                game.board = full_board                       #as this will only be checked if there is no winner
            end                                               #this function exists to act as a flag to check to see if the game is over in the form of a tie.
            it 'should return true' do
                full = game.board_full?
                expect(full).to be(true)
            end
        end
    end

    describe '#check_cols' do
        subject(:game) { described_class.new() }
        
        context 'when player1 has 4 in a row column wise' do
            
            before do
                col_victory = Array.new(6) {Array.new(7)}
                for i in 2..5 do
                    col_victory[i][4] = "🔴"
                end
                game.board = col_victory
            end

            it 'should return true' do
                victory = game.check_cols(game.current_player)
                expect(victory).to be (true)
            end
        end

        context 'when player2 has 4 in a row column wise' do
            
            before do
                col_victory = Array.new(6) {Array.new(7)}
                for i in 2..5 do
                    col_victory[i][6] = "🟡"
                end
                game.board = col_victory
                game.switch_turn()
            end

            it 'should return true' do
                victory = game.check_cols(game.current_player)
                expect(victory).to be (true)
            end
        end

        context 'when player1 does not have 4 in a row column wise' do
            before do
                col_victory = Array.new(6) {Array.new(7)}
                for i in 1..3 do
                    col_victory[i][0] = "🔴"
                end
                col_victory[0][0] = "🟡"
                col_victory[4][0] = "🟡"
                col_victory[5][0] = "🔴"
                game.board = col_victory
            end
            
            it 'should return false' do
                no_victory = game.check_cols(game.current_player)
                expect(no_victory).to be(false)
            end
        end
        
        context 'when player2 does not have 4 in a row column wise' do
            before do
                col_victory = Array.new(6) {Array.new(7)}
                for i in 1..3 do
                    col_victory[i][0] = "🟡"
                end
                col_victory[0][0] = "🔴"
                col_victory[4][0] = "🔴"
                col_victory[5][0] = "🟡"
                game.board = col_victory
                game.switch_turn()
            end
            
            it 'should return false' do
                no_victory = game.check_cols(game.current_player)
                expect(no_victory).to be(false)
            end
        end
    end

    describe '#check_rows' do
        subject(:game) { described_class.new() }
        
        context 'when player1 has 4 in a row row wise' do
            
            before do
                row_victory = Array.new(6) {Array.new(7)}
                for i in 3..6 do
                    row_victory[4][i] = "🔴"
                end
                game.board = row_victory
            end

            it 'should return true' do
                victory = game.check_rows(game.current_player)
                expect(victory).to be (true)
            end
        end

        context 'when player2 has 4 in a row row wise' do
            
            before do
                row_victory = Array.new(6) {Array.new(7)}
                for i in 1..4 do
                    row_victory[2][i] = "🟡"
                end
                game.board = row_victory
                game.switch_turn()
            end

            it 'should return true' do
                victory = game.check_rows(game.current_player)
                expect(victory).to be (true)
            end
        end

        context 'when player1 does not have 4 in a row row wise' do
            before do
                row_victory = Array.new(6) {Array.new(7)}
                for i in 0..2 do
                    row_victory[3][i] = "🔴"
                end
                row_victory[3][3] = "🟡"
                row_victory[3][4] = "🔴"
                row_victory[3][5] = "🔴"
                row_victory[3][6] = "🔴"
                game.board = row_victory
            end
            
            it 'should return false' do
                no_victory = game.check_rows(game.current_player)
                expect(no_victory).to be(false)
            end
        end
        
        context 'when player2 does not have 4 in a row row wise' do
            before do
                row_victory = Array.new(6) {Array.new(7)}
                for i in 1..3 do
                    row_victory[5][i] = "🟡"
                end
                row_victory[5][0] = "🔴"
                row_victory[5][4] = "🔴"
                row_victory[5][5] = "🟡"
                row_victory[5][6] = "🟡"
                game.board = row_victory
                game.switch_turn()
            end
            
            it 'should return false' do
                no_victory = game.check_rows(game.current_player)
                expect(no_victory).to be(false)
            end
        end
    end

    describe '#check_diag' do
        subject(:game) { described_class.new() }

        context 'when player1 has 4 in a row diagonal wise' do
            before do
                diag_victory = Array.new(6) {Array.new(7)}
                diag_victory[2][4] = "🔴"
                diag_victory[3][3] = "🔴"
                diag_victory[4][2] = "🔴"
                diag_victory[5][1] = "🔴"
                game.board = diag_victory
            end
            it 'should return true' do
                victory = game.check_diag(game.current_player)
                expect(victory).to be(true)
            end
        end

        context 'when player2 has 4 in a row diagonal wise' do
            before do
                diag_victory = Array.new(6) {Array.new(7)}
                diag_victory[1][5] = "🟡"
                diag_victory[2][4] = "🟡"
                diag_victory[3][3] = "🟡"
                diag_victory[4][2] = "🟡"
                game.board = diag_victory
                game.switch_turn
            end
            it 'should return true' do
                victory = game.check_diag(game.current_player)
                expect(victory).to be(true)
            end
        end
        
        context 'when player1 does not have 4 in a row diagonal wise' do
            before do
                diag_victory = Array.new(6) {Array.new(7)}
                diag_victory[1][5] = "🔴"
                diag_victory[2][4] = "🟡"
                diag_victory[3][3] = "🔴"
                diag_victory[4][2] = "🔴"
                diag_victory[5][1] = "🔴"
                game.board = diag_victory
            end
            
            it 'should return false' do
                no_victory = game.check_rows(game.current_player)
                expect(no_victory).to be(false)
            end
        end
        
        context 'when player2 does not have 4 in a row diagonal wise' do
            before do
                diag_victory = Array.new(6) {Array.new(7)}
                diag_victory[5][6] = "🟡"
                diag_victory[4][5] = "🔴"
                diag_victory[3][4] = "🟡"
                diag_victory[2][3] = "🟡"
                diag_victory[1][2] = "🟡"
                game.board = diag_victory
                game.switch_turn()
            end
            
            it 'should return false' do
                no_victory = game.check_rows(game.current_player)
                expect(no_victory).to be(false)
            end
        end
    end
end

