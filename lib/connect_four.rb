require 'win_condition'
require 'json'

class ConnectFour
  include WinCondition
  attr_reader :board, :player, :winner

  def initialize(save_file = '../savefile.json')
    @board = Array.new(7) { Array.new(6) }
    @player = 'Y'
    @winner = nil
    @save_file = save_file
  end

  def place(row)
    @board[row] = fill_first_nil(@board[row], @player) unless filled?(@board[row])
    game_over
  end

  def save
    File.open(@save_file, 'w') do |f|
      save = {
        'board' => @board,
        'player' => @player
      }
      f.write(JSON.generate(save))
    end
  end

  def load(file = @save_file)
    File.open(file, 'r') do |f|
      save = JSON.parse(f.read)
      @board = save['board']
      @player = save['player']
    end
  end

  private

  def game_over
    if tie?
      @winner = 'Tie'
    elsif game_won?(@board)
      @winner = @whos_turn
    else
      increment_turn
    end
  end

  def tie?
    @board.all? { |row| filled?(row) } && !game_won?(@board)
  end

  def fill_first_nil(arr, elm)
    arr[arr.index(&:nil?)] = elm
    arr
  end

  def filled?(row)
    row.none?(&:nil?)
  end

  def increment_turn
    @player = @player == 'Y' ? 'R' : 'Y'
  end
end

