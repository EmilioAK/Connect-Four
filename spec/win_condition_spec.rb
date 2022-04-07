require './lib/win_condition'
describe WinCondition do
  subject { Class.new { extend WinCondition } }
  let(:exp_board) { Array.new(7) { Array.new(6) } }
  describe '#game_won?' do
    context 'when a row is won' do
      it 'returns true when a row has 4 identical non nil placements' do
        exp_board[0][0] = 'Y'
        exp_board[0][1] = 'Y'
        exp_board[0][2] = 'Y'
        exp_board[0][3] = 'Y'
        expect(subject.game_won?(exp_board)).to be true
      end
    end
    context 'when a column is won' do
      it 'returns true when four are in a row in columns' do
        exp_board[0][0] = 'Y'
        exp_board[1][0] = 'Y'
        exp_board[2][0] = 'Y'
        exp_board[3][0] = 'Y'
        expect(subject.game_won?(exp_board)).to be true
      end
    end
    context 'when a diagonal is won' do
      it 'returns true when four are in a row in the diagonals' do
        exp_board[0][0] = 'Y'
        exp_board[1][1] = 'Y'
        exp_board[2][2] = 'Y'
        exp_board[3][3] = 'Y'
        expect(subject.game_won?(exp_board)).to be true
      end
      it 'returns false when diagonal exists but not with the same value' do
        exp_board[0][0] = 'Y'
        exp_board[1][1] = 'Y'
        exp_board[2][2] = 'Y'
        exp_board[3][3] = 'R'
        expect(subject.game_won?(exp_board)).to be false
      end
      it 'returns true for a diagonal left to right' do
        exp_board[0][-1] = 'Y'
        exp_board[1][-2] = 'Y'
        exp_board[2][-3] = 'Y'
        exp_board[3][-4] = 'Y'
        expect(subject.game_won?(exp_board)).to be true
      end
      it 'returns false when left to right diagonal exists but not with the same value' do
        exp_board[0][-1] = 'Y'
        exp_board[1][-2] = 'Y'
        exp_board[2][-3] = 'Y'
        exp_board[3][-4] = 'R'
        expect(subject.game_won?(exp_board)).to be false
      end
    end
  end
end