module WinCondition
  def game_won?(board)
    row_won?(board) || column_won?(board) || diagonal_won?(board)
  end

  private

  def diagonal_won?(board)
    first_diagonal = diagonals(board)
    second_diagonal = diagonals(board.reverse)

    row_won?([first_diagonal, second_diagonal].flatten(1))
  end

  def column_won?(board)
    row_won?(board.transpose)
  end

  def row_won?(board)
    board.each do |row|
      row.each_cons(4) do |section|
        return true if winning_line?(section)
      end
    end
    false
  end

  def winning_line?(row)
    row.all? { |cell| !cell.nil? && cell == row.first }
  end

  def diagonals(board)
    # Right to left by default. Left to right if you reverse the board
    board[0...-1].each_with_object([]).with_index do |(row, diagonals), row_idx|
      row.each_with_index do |cell, cell_idx|
        diagonals_for_this_cell = [cell]
        board[row_idx + 1..-1].each do |these_rows|
          break if cell_idx < 1

          cell_idx -= 1
          diagonals_for_this_cell << these_rows[cell_idx]
        end
        diagonals << diagonals_for_this_cell
      end
    end.select { |diagonal| diagonal.size >= 4 }
  end
end
