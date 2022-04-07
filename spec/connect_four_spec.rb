require './lib/connect_four'
describe ConnectFour do
  describe '#place' do
    it 'places a piece at the start of the selected row' do
      exp_board = Array.new(7) { Array.new(6) }
      exp_board[0][0] = 'Y'
      expect { subject.place(0) }.to change { subject.board }.to(exp_board)
    end
    it 'places R after place has been run once' do
      exp_board = Array.new(7) { Array.new(6) }
      exp_board[0][0] = 'Y'
      exp_board[0][1] = 'R'
      expect { subject.place(0) && subject.place(0) }.to change { subject.board }.to(exp_board)
    end
  end
end